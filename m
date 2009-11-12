From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 12 Nov 2009 08:13:07 +0100
Subject: [PATCH] Remove __raw_* accessors from PL031 RTC
Message-ID: <1258009987-11317-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This switches __raw_[read|write]l() for plain [read|write]l in
the PL031 RTC driver. The sister driver for PL030 use the simple
accessors as most PrimeCell drivers.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/rtc/rtc-pl031.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index f41873f..0264b11 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -51,10 +51,10 @@ static int pl031_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 
 	switch (cmd) {
 	case RTC_AIE_OFF:
-		__raw_writel(1, ldata->base + RTC_MIS);
+		writel(1, ldata->base + RTC_MIS);
 		return 0;
 	case RTC_AIE_ON:
-		__raw_writel(0, ldata->base + RTC_MIS);
+		writel(0, ldata->base + RTC_MIS);
 		return 0;
 	}
 
@@ -65,7 +65,7 @@ static int pl031_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct pl031_local *ldata = dev_get_drvdata(dev);
 
-	rtc_time_to_tm(__raw_readl(ldata->base + RTC_DR), tm);
+	rtc_time_to_tm(readl(ldata->base + RTC_DR), tm);
 
 	return 0;
 }
@@ -76,7 +76,7 @@ static int pl031_set_time(struct device *dev, struct rtc_time *tm)
 	struct pl031_local *ldata = dev_get_drvdata(dev);
 
 	rtc_tm_to_time(tm, &time);
-	__raw_writel(time, ldata->base + RTC_LR);
+	writel(time, ldata->base + RTC_LR);
 
 	return 0;
 }
@@ -85,9 +85,9 @@ static int pl031_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
 	struct pl031_local *ldata = dev_get_drvdata(dev);
 
-	rtc_time_to_tm(__raw_readl(ldata->base + RTC_MR), &alarm->time);
-	alarm->pending = __raw_readl(ldata->base + RTC_RIS);
-	alarm->enabled = __raw_readl(ldata->base + RTC_IMSC);
+	rtc_time_to_tm(readl(ldata->base + RTC_MR), &alarm->time);
+	alarm->pending = readl(ldata->base + RTC_RIS);
+	alarm->enabled = readl(ldata->base + RTC_IMSC);
 
 	return 0;
 }
@@ -99,8 +99,8 @@ static int pl031_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 
 	rtc_tm_to_time(&alarm->time, &time);
 
-	__raw_writel(time, ldata->base + RTC_MR);
-	__raw_writel(!alarm->enabled, ldata->base + RTC_MIS);
+	writel(time, ldata->base + RTC_MR);
+	writel(!alarm->enabled, ldata->base + RTC_MIS);
 
 	return 0;
 }
@@ -180,8 +180,9 @@ err_req:
 
 static struct amba_id pl031_ids[] __initdata = {
 	{
-		 .id = 0x00041031,
-	 	.mask = 0x000fffff, },
+		.id = 0x00041031,
+		.mask = 0x000fffff,
+	},
 	{0, 0},
 };
 
-- 
1.6.2.5
