### Read data
data <- read.csv('ReproducibleResearch/repdata%2Fdata%2FStormData.csv')

### Subset data
library(dplyr)
names(data)
data1 <- select(data, BGN_DATE, STATE, EVTYPE, FATALITIES, INJURIES, PROPDMG, CROPDMG)


### 1. Across the United States, which types of events (as indicated in the EVTYPE variable) are most harmful with respect to population health?
popharm <- group_by(data1, EVTYPE)
popharmfat <- arrange(summarise(popharm, fatalities = sum(FATALITIES, na.rm = TRUE)), desc(fatalities))[1:15,]
popharminj <-  arrange(summarise(popharm , injuries = sum(INJURIES, na.rm = TRUE)), desc(injuries))[1:15,]
popharmtotal <- arrange(summarise(popharm , total = (sum(INJURIES, na.rm = TRUE) + sum(FATALITIES, na.rm = TRUE))), desc(total))[1:15,]
popharmfatm <- arrange(summarise(popharm, fatalities = mean(FATALITIES, na.rm = TRUE)), desc(fatalities))[1:15,]


popharmfat
popharminj

par(mfrow=c(1,1), mar=c(11,4,4,4))
barplot(popharmfat$fatalities, names.arg = popharmfat$EVTYPE, ylim = c(0,10000), main = 'Fatalities', las=3)
barplot(popharminj$injuries, names.arg = popharminj$EVTYPE, ylim = c(0,10000), main = 'Injuries', las=3)
barplot(popharmtotal$total, names.arg = popharmtotal$EVTYPE, ylim = c(0,10000), main = 'Total', las=3)
par(mfrow=c(1,1), mar=c(13,4,4,4))
barplot(popharmfatm$fatalities, names.arg = popharmfatm$EVTYPE, main = 'Avg Fatalities', las=3)


### 2. Across the United States, which types of events have the greatest economic consequences?