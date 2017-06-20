From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue, 20 Jun 2017 11:35:42 +0200
Subject: [PATCH 34/51] rtc: pl031: stop using rtc deprecated functions
In-Reply-To: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <1497951359-13334-35-git-send-email-benjamin.gaignard@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
rely on 32bits variables and that will make rtc break in y2038/2016.
Stop using those two functions to safer 64bits ones.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC: Linus Walleij <linus.walleij@linaro.org>
CC: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: rtc-linux at googlegroups.com
CC: linux-kernel at vger.kernel.org
CC: linux-arm-kernel at lists.infradead.org
---
 drivers/rtc/rtc-pl031.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index e1687e1..07f72b3 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -127,11 +127,11 @@ static int pl031_stv2_tm_to_time(struct device *dev,
 		return -EINVAL;
 	} else if (wday == -1) {
 		/* wday is not provided, calculate it here */
-		unsigned long time;
+		unsigned long long time;
 		struct rtc_time calc_tm;
 
-		rtc_tm_to_time(tm, &time);
-		rtc_time_to_tm(time, &calc_tm);
+		time = rtc_tm_to_time64(tm);
+		rtc_time64_to_tm(time, &calc_tm);
 		wday = calc_tm.tm_wday;
 	}
 
@@ -252,30 +252,27 @@ static int pl031_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct pl031_local *ldata = dev_get_drvdata(dev);
 
-	rtc_time_to_tm(readl(ldata->base + RTC_DR), tm);
+	rtc_time64_to_tm(readl(ldata->base + RTC_DR), tm);
 
 	return 0;
 }
 
 static int pl031_set_time(struct device *dev, struct rtc_time *tm)
 {
-	unsigned long time;
+	unsigned long long time;
 	struct pl031_local *ldata = dev_get_drvdata(dev);
-	int ret;
-
-	ret = rtc_tm_to_time(tm, &time);
 
-	if (ret == 0)
-		writel(time, ldata->base + RTC_LR);
+	time = rtc_tm_to_time64(tm);
+	writel(time, ldata->base + RTC_LR);
 
-	return ret;
+	return 0;
 }
 
 static int pl031_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
 	struct pl031_local *ldata = dev_get_drvdata(dev);
 
-	rtc_time_to_tm(readl(ldata->base + RTC_MR), &alarm->time);
+	rtc_time64_to_tm(readl(ldata->base + RTC_MR), &alarm->time);
 
 	alarm->pending = readl(ldata->base + RTC_RIS) & RTC_BIT_AI;
 	alarm->enabled = readl(ldata->base + RTC_IMSC) & RTC_BIT_AI;
@@ -286,17 +283,15 @@ static int pl031_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 static int pl031_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
 	struct pl031_local *ldata = dev_get_drvdata(dev);
-	unsigned long time;
+	unsigned long long time;
 	int ret;
 
 	/* At the moment, we can only deal with non-wildcarded alarm times. */
 	ret = rtc_valid_tm(&alarm->time);
 	if (ret == 0) {
-		ret = rtc_tm_to_time(&alarm->time, &time);
-		if (ret == 0) {
-			writel(time, ldata->base + RTC_MR);
-			pl031_alarm_irq_enable(dev, alarm->enabled);
-		}
+		time = rtc_tm_to_time64(&alarm->time);
+		writel(time, ldata->base + RTC_MR);
+		pl031_alarm_irq_enable(dev, alarm->enabled);
 	}
 
 	return ret;
-- 
1.9.1
