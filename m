From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  8 Dec 2016 18:10:09 +0100
Subject: [PATCH 2/3] rtc: armada38x: Convert to time64_t
In-Reply-To: <20161208171010.29446-1-gregory.clement@free-electrons.com>
References: <20161208171010.29446-1-gregory.clement@free-electrons.com>
Message-ID: <20161208171010.29446-3-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is one more step to remove the deprecated functions rtc_time_to_tm
and rtc_tm_to_time.

And as bonus it simplifies a little the driver.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/rtc/rtc-armada38x.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
index a0859286a4c4..b8a74ffaae80 100644
--- a/drivers/rtc/rtc-armada38x.c
+++ b/drivers/rtc/rtc-armada38x.c
@@ -128,13 +128,14 @@ static unsigned long read_rtc_register_wa(struct armada38x_rtc *rtc, u8 rtc_reg)
 static int armada38x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct armada38x_rtc *rtc = dev_get_drvdata(dev);
-	unsigned long time, flags;
+	unsigned long flags;
+	time64_t time;
 
 	spin_lock_irqsave(&rtc->lock, flags);
-	time = read_rtc_register_wa(rtc, RTC_TIME);
+	time = (time64_t)read_rtc_register_wa(rtc, RTC_TIME);
 	spin_unlock_irqrestore(&rtc->lock, flags);
 
-	rtc_time_to_tm(time, tm);
+	rtc_time64_to_tm(time, tm);
 
 	return 0;
 }
@@ -142,37 +143,34 @@ static int armada38x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 static int armada38x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct armada38x_rtc *rtc = dev_get_drvdata(dev);
-	int ret = 0;
-	unsigned long time, flags;
-
-	ret = rtc_tm_to_time(tm, &time);
+	unsigned long flags;
+	time64_t time;
 
-	if (ret)
-		goto out;
+	time = rtc_tm_to_time64(tm);
 
 	spin_lock_irqsave(&rtc->lock, flags);
-	rtc_delayed_write(time, rtc, RTC_TIME);
+	rtc_delayed_write((u32)time, rtc, RTC_TIME);
 	spin_unlock_irqrestore(&rtc->lock, flags);
 
-out:
-	return ret;
+	return 0;
 }
 
 static int armada38x_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct armada38x_rtc *rtc = dev_get_drvdata(dev);
-	unsigned long time, flags;
+	unsigned long flags;
+	time64_t time;
 	u32 val;
 
 	spin_lock_irqsave(&rtc->lock, flags);
 
-	time = read_rtc_register_wa(rtc, RTC_ALARM1);
+	time = (time64_t)read_rtc_register_wa(rtc, RTC_ALARM1);
 	val = read_rtc_register_wa(rtc, RTC_IRQ1_CONF) & RTC_IRQ1_AL_EN;
 
 	spin_unlock_irqrestore(&rtc->lock, flags);
 
 	alrm->enabled = val ? 1 : 0;
-	rtc_time_to_tm(time,  &alrm->time);
+	rtc_time64_to_tm(time,  &alrm->time);
 
 	return 0;
 }
@@ -180,18 +178,15 @@ static int armada38x_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 static int armada38x_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct armada38x_rtc *rtc = dev_get_drvdata(dev);
-	unsigned long time, flags;
-	int ret = 0;
+	unsigned long flags;
+	time64_t time;
 	u32 val;
 
-	ret = rtc_tm_to_time(&alrm->time, &time);
-
-	if (ret)
-		goto out;
+	time = rtc_tm_to_time64(&alrm->time);
 
 	spin_lock_irqsave(&rtc->lock, flags);
 
-	rtc_delayed_write(time, rtc, RTC_ALARM1);
+	rtc_delayed_write((u32)time, rtc, RTC_ALARM1);
 
 	if (alrm->enabled) {
 			rtc_delayed_write(RTC_IRQ1_AL_EN, rtc, RTC_IRQ1_CONF);
@@ -202,8 +197,7 @@ static int armada38x_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	spin_unlock_irqrestore(&rtc->lock, flags);
 
-out:
-	return ret;
+	return 0;
 }
 
 static int armada38x_rtc_alarm_irq_enable(struct device *dev,
-- 
2.10.2
