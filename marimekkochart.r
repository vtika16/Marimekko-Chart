df <- data.frame(segment = c("A", "B", "C", "D"),
                 segpct = c(40,30,20,10), Alpha = c(60,40,30,25),
                 Beta = c(25, 30, 30, 25), Gamma = c(10,20,20,25),
                 Delta = c(5,10,20, 25))

df$xmax <- cumsum(df$segpct)
df$xmin <- df$xmax - df$segpct
df$segpct <- NULL

###library for ggplot2###

install.packages("ggplot2")
library(ggplot2)

dfm <- melt(df, id = c("segment", "xmin", "xmax"))
head(dfm)


dfm1 <- ddply(dfm, .(segment), transform, ymax = cumsum(value))
dfm1 <- ddply(dfm1, .(segment), transform,
              ymin = ymax - value)


dfm1$xtext <- with(dfm1, xmin + (xmax - xmin)/2)
dfm1$ytext <- with(dfm1, ymin + (ymax - ymin)/2)


p <- ggplot(dfm1, aes(ymin = ymin, ymax = ymax,
                        xmin = xmin, xmax = xmax, fill = variable))

p1 <- p + geom_rect(colour = I("grey"))
