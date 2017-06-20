From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue, 20 Jun 2017 11:35:37 +0200
Subject: [PATCH 29/51] rtc: lpc32xx: stop using rtc deprecated functions
In-Reply-To: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <1497951359-13334-30-git-send-email-benjamin.gaignard@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
rely on 32bits variables and that will make rtc break in y2038/2016.
Stop using those two functions to safer 64bits ones.

For the same reasons use set_mmss64 callback instead of set_mmss

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC: Vladimir Zapolskiy <vz@mleia.com>
CC: Sylvain Lemieux <slemieux.tyco@gmail.com>
CC: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: rtc-linux at googlegroups.com
CC: linux-kernel at vger.kernel.org
CC: linux-arm-kernel at lists.infradead.org
---
 drivers/rtc/rtc-lpc32xx.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-lpc32xx.c b/drivers/rtc/rtc-lpc32xx.c
index 887871c..a3f5233 100644
--- a/drivers/rtc/rtc-lpc32xx.c
+++ b/drivers/rtc/rtc-lpc32xx.c
@@ -64,16 +64,16 @@ struct lpc32xx_rtc {
 
 static int lpc32xx_rtc_read_time(struct device *dev, struct rtc_time *time)
 {
-	unsigned long elapsed_sec;
+	unsigned long long elapsed_sec;
 	struct lpc32xx_rtc *rtc = dev_get_drvdata(dev);
 
 	elapsed_sec = rtc_readl(rtc, LPC32XX_RTC_UCOUNT);
-	rtc_time_to_tm(elapsed_sec, time);
+	rtc_time64_to_tm(elapsed_sec, time);
 
 	return rtc_valid_tm(time);
 }
 
-static int lpc32xx_rtc_set_mmss(struct device *dev, unsigned long secs)
+static int lpc32xx_rtc_set_mmss64(struct device *dev, time64_t secs)
 {
 	struct lpc32xx_rtc *rtc = dev_get_drvdata(dev);
 	u32 tmp;
@@ -97,7 +97,7 @@ static int lpc32xx_rtc_read_alarm(struct device *dev,
 {
 	struct lpc32xx_rtc *rtc = dev_get_drvdata(dev);
 
-	rtc_time_to_tm(rtc_readl(rtc, LPC32XX_RTC_MATCH0), &wkalrm->time);
+	rtc_time64_to_tm(rtc_readl(rtc, LPC32XX_RTC_MATCH0), &wkalrm->time);
 	wkalrm->enabled = rtc->alarm_enabled;
 	wkalrm->pending = !!(rtc_readl(rtc, LPC32XX_RTC_INTSTAT) &
 		LPC32XX_RTC_INTSTAT_MATCH0);
@@ -109,15 +109,10 @@ static int lpc32xx_rtc_set_alarm(struct device *dev,
 	struct rtc_wkalrm *wkalrm)
 {
 	struct lpc32xx_rtc *rtc = dev_get_drvdata(dev);
-	unsigned long alarmsecs;
+	unsigned long long alarmsecs;
 	u32 tmp;
-	int ret;
 
-	ret = rtc_tm_to_time(&wkalrm->time, &alarmsecs);
-	if (ret < 0) {
-		dev_warn(dev, "Failed to convert time: %d\n", ret);
-		return ret;
-	}
+	alarmsecs = rtc_tm_to_time64(&wkalrm->time);
 
 	spin_lock_irq(&rtc->lock);
 
@@ -191,7 +186,7 @@ static irqreturn_t lpc32xx_rtc_alarm_interrupt(int irq, void *dev)
 
 static const struct rtc_class_ops lpc32xx_rtc_ops = {
 	.read_time		= lpc32xx_rtc_read_time,
-	.set_mmss		= lpc32xx_rtc_set_mmss,
+	.set_mmss64		= lpc32xx_rtc_set_mmss64,
 	.read_alarm		= lpc32xx_rtc_read_alarm,
 	.set_alarm		= lpc32xx_rtc_set_alarm,
 	.alarm_irq_enable	= lpc32xx_rtc_alarm_irq_enable,
-- 
1.9.1
