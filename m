From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Mon,  4 Jun 2018 16:15:28 +0200
Subject: [PATCH 3/3] rtc: ftrtc010: let the core handle range
In-Reply-To: <20180604141528.15635-1-alexandre.belloni@bootlin.com>
References: <20180604141528.15635-1-alexandre.belloni@bootlin.com>
Message-ID: <20180604141528.15635-3-alexandre.belloni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current range handling is highly suspicious. Anyway, let the core
handle it.
The RTC has a 32 bit counter on top of days + hh:mm:ss registers.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ftrtc010.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
index 2cdc78ffeb17..61f798c6101f 100644
--- a/drivers/rtc/rtc-ftrtc010.c
+++ b/drivers/rtc/rtc-ftrtc010.c
@@ -95,9 +95,6 @@ static int ftrtc010_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	u32 sec, min, hour, day, offset;
 	timeu64_t time;
 
-	if (tm->tm_year >= 2148)	/* EPOCH Year + 179 */
-		return -EINVAL;
-
 	time = rtc_tm_to_time64(tm);
 
 	sec = readl(rtc->rtc_base + FTRTC010_RTC_SECOND);
@@ -120,6 +117,7 @@ static const struct rtc_class_ops ftrtc010_rtc_ops = {
 
 static int ftrtc010_rtc_probe(struct platform_device *pdev)
 {
+	u32 days, hour, min, sec;
 	struct ftrtc010_rtc *rtc;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
@@ -172,6 +170,15 @@ static int ftrtc010_rtc_probe(struct platform_device *pdev)
 
 	rtc->rtc_dev->ops = &ftrtc010_rtc_ops;
 
+	sec  = readl(rtc->rtc_base + FTRTC010_RTC_SECOND);
+	min  = readl(rtc->rtc_base + FTRTC010_RTC_MINUTE);
+	hour = readl(rtc->rtc_base + FTRTC010_RTC_HOUR);
+	days = readl(rtc->rtc_base + FTRTC010_RTC_DAYS);
+
+	rtc->rtc_dev->range_min = (u64)days * 86400 + hour * 3600 +
+				  min * 60 + sec;
+	rtc->rtc_dev->range_max = U32_MAX + rtc->rtc_dev->range_min;
+
 	ret = devm_request_irq(dev, rtc->rtc_irq, ftrtc010_rtc_interrupt,
 			       IRQF_SHARED, pdev->name, dev);
 	if (unlikely(ret))
-- 
2.17.1
