From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu,  5 May 2011 12:22:20 +0200
Subject: [PATCH 5/6] rtc: stmp3xxx: get rid of mach-specific accessors
In-Reply-To: <1304590941-11813-1-git-send-email-w.sang@pengutronix.de>
References: <1304590941-11813-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1304590941-11813-6-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

And drop __raw_(read|write)l-accessors while we are here.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/rtc/rtc-stmp3xxx.c |   62 ++++++++++++++++++++++++--------------------
 1 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
index d3937eb..b4dd78b 100644
--- a/drivers/rtc/rtc-stmp3xxx.c
+++ b/drivers/rtc/rtc-stmp3xxx.c
@@ -18,6 +18,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/io.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
@@ -25,9 +26,10 @@
 #include <linux/slab.h>
 
 #include <mach/common.h>
-#include <mach/mxs.h>
 
 #define STMP3XXX_RTC_CTRL		0x0
+#define STMP3XXX_RTC_CTRL_SET		0x4
+#define STMP3XXX_RTC_CTRL_CLR		0x8
 #define STMP3XXX_RTC_CTRL_ALARM_IRQ_EN		0x00000001
 #define STMP3XXX_RTC_CTRL_ONEMSEC_IRQ_EN	0x00000002
 #define STMP3XXX_RTC_CTRL_ALARM_IRQ		0x00000004
@@ -42,6 +44,8 @@
 #define STMP3XXX_RTC_ALARM		0x40
 
 #define STMP3XXX_RTC_PERSISTENT0	0x60
+#define STMP3XXX_RTC_PERSISTENT0_SET	0x64
+#define STMP3XXX_RTC_PERSISTENT0_CLR	0x68
 #define STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN	0x00000002
 #define STMP3XXX_RTC_PERSISTENT0_ALARM_EN	0x00000004
 #define STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE	0x00000080
@@ -60,7 +64,7 @@ static void stmp3xxx_wait_time(struct stmp3xxx_rtc_data *rtc_data)
 	 * NEW_REGS/STALE_REGS bitfields go. In fact it's 0x1=P0,
 	 * 0x2=P1, .., 0x20=P5, 0x40=ALARM, 0x80=SECONDS
 	 */
-	while (__raw_readl(rtc_data->io + STMP3XXX_RTC_STAT) &
+	while (readl(rtc_data->io + STMP3XXX_RTC_STAT) &
 			(0x80 << STMP3XXX_RTC_STAT_STALE_SHIFT))
 		cpu_relax();
 }
@@ -71,7 +75,7 @@ static int stmp3xxx_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
 	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
 
 	stmp3xxx_wait_time(rtc_data);
-	rtc_time_to_tm(__raw_readl(rtc_data->io + STMP3XXX_RTC_SECONDS), rtc_tm);
+	rtc_time_to_tm(readl(rtc_data->io + STMP3XXX_RTC_SECONDS), rtc_tm);
 	return 0;
 }
 
@@ -79,7 +83,7 @@ static int stmp3xxx_rtc_set_mmss(struct device *dev, unsigned long t)
 {
 	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
 
-	__raw_writel(t, rtc_data->io + STMP3XXX_RTC_SECONDS);
+	writel(t, rtc_data->io + STMP3XXX_RTC_SECONDS);
 	stmp3xxx_wait_time(rtc_data);
 	return 0;
 }
@@ -91,18 +95,18 @@ static irqreturn_t stmp3xxx_rtc_interrupt(int irq, void *dev_id)
 	u32 status;
 	u32 events = 0;
 
-	status = __raw_readl(rtc_data->io + STMP3XXX_RTC_CTRL) &
+	status = readl(rtc_data->io + STMP3XXX_RTC_CTRL) &
 			(STMP3XXX_RTC_CTRL_ALARM_IRQ | STMP3XXX_RTC_CTRL_ONEMSEC_IRQ);
 
 	if (status & STMP3XXX_RTC_CTRL_ALARM_IRQ) {
-		__mxs_clrl(STMP3XXX_RTC_CTRL_ALARM_IRQ,
-				rtc_data->io + STMP3XXX_RTC_CTRL);
+		writel(STMP3XXX_RTC_CTRL_ALARM_IRQ,
+				rtc_data->io + STMP3XXX_RTC_CTRL_CLR);
 		events |= RTC_AF | RTC_IRQF;
 	}
 
 	if (status & STMP3XXX_RTC_CTRL_ONEMSEC_IRQ) {
-		__mxs_clrl(STMP3XXX_RTC_CTRL_ONEMSEC_IRQ,
-				rtc_data->io + STMP3XXX_RTC_CTRL);
+		writel(STMP3XXX_RTC_CTRL_ONEMSEC_IRQ,
+				rtc_data->io + STMP3XXX_RTC_CTRL_CLR);
 		if (++rtc_data->irq_count % 1000 == 0) {
 			events |= RTC_UF | RTC_IRQF;
 			rtc_data->irq_count = 0;
@@ -118,17 +122,19 @@ static irqreturn_t stmp3xxx_rtc_interrupt(int irq, void *dev_id)
 static int stmp3xxx_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
 	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
-	void __iomem *p = rtc_data->io + STMP3XXX_RTC_PERSISTENT0,
-		     *ctl = rtc_data->io + STMP3XXX_RTC_CTRL;
 
 	if (enabled) {
-		__mxs_setl(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
-			      STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN, p);
-		__mxs_setl(STMP3XXX_RTC_CTRL_ALARM_IRQ_EN, ctl);
+		writel(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
+				STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN,
+				rtc_data->io + STMP3XXX_RTC_PERSISTENT0_SET);
+		writel(STMP3XXX_RTC_CTRL_ALARM_IRQ_EN,
+				rtc_data->io + STMP3XXX_RTC_CTRL_SET);
 	} else {
-		__mxs_clrl(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
-			      STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN, p);
-		__mxs_clrl(STMP3XXX_RTC_CTRL_ALARM_IRQ_EN, ctl);
+		writel(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
+				STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN,
+				rtc_data->io + STMP3XXX_RTC_PERSISTENT0_CLR);
+		writel(STMP3XXX_RTC_CTRL_ALARM_IRQ_EN,
+				rtc_data->io + STMP3XXX_RTC_CTRL_CLR);
 	}
 	return 0;
 }
@@ -137,7 +143,7 @@ static int stmp3xxx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 {
 	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
 
-	rtc_time_to_tm(__raw_readl(rtc_data->io + STMP3XXX_RTC_ALARM), &alm->time);
+	rtc_time_to_tm(readl(rtc_data->io + STMP3XXX_RTC_ALARM), &alm->time);
 	return 0;
 }
 
@@ -147,7 +153,7 @@ static int stmp3xxx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
 
 	rtc_tm_to_time(&alm->time, &t);
-	__raw_writel(t, rtc_data->io + STMP3XXX_RTC_ALARM);
+	writel(t, rtc_data->io + STMP3XXX_RTC_ALARM);
 	return 0;
 }
 
@@ -167,8 +173,8 @@ static int stmp3xxx_rtc_remove(struct platform_device *pdev)
 	if (!rtc_data)
 		return 0;
 
-	__mxs_clrl(STMP3XXX_RTC_CTRL_ONEMSEC_IRQ_EN | STMP3XXX_RTC_CTRL_ALARM_IRQ_EN,
-			rtc_data->io + STMP3XXX_RTC_CTRL);
+	writel(STMP3XXX_RTC_CTRL_ONEMSEC_IRQ_EN | STMP3XXX_RTC_CTRL_ALARM_IRQ_EN,
+			rtc_data->io + STMP3XXX_RTC_CTRL_CLR);
 	free_irq(rtc_data->irq_alarm, &pdev->dev);
 	free_irq(rtc_data->irq_1msec, &pdev->dev);
 	rtc_device_unregister(rtc_data->rtc);
@@ -206,7 +212,7 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
 	rtc_data->irq_alarm = platform_get_irq(pdev, 0);
 	rtc_data->irq_1msec = platform_get_irq(pdev, 1);
 
-	if (!(__raw_readl(STMP3XXX_RTC_STAT + rtc_data->io) &
+	if (!(readl(STMP3XXX_RTC_STAT + rtc_data->io) &
 			STMP3XXX_RTC_STAT_RTC_PRESENT)) {
 		dev_err(&pdev->dev, "no device onboard\n");
 		err = -ENODEV;
@@ -216,10 +222,10 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, rtc_data);
 
 	mxs_reset_block(rtc_data->io);
-	__mxs_clrl(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
+	writel(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
 			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN |
 			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE,
-			rtc_data->io + STMP3XXX_RTC_PERSISTENT0);
+			rtc_data->io + STMP3XXX_RTC_PERSISTENT0_CLR);
 
 	rtc_data->rtc = rtc_device_register(pdev->name, &pdev->dev,
 				&stmp3xxx_rtc_ops, THIS_MODULE);
@@ -249,8 +255,8 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
 out_irq1:
 	free_irq(rtc_data->irq_alarm, &pdev->dev);
 out_irq_alarm:
-	__mxs_clrl(STMP3XXX_RTC_CTRL_ONEMSEC_IRQ_EN | STMP3XXX_RTC_CTRL_ALARM_IRQ_EN,
-			rtc_data->io + STMP3XXX_RTC_CTRL);
+	writel(STMP3XXX_RTC_CTRL_ONEMSEC_IRQ_EN | STMP3XXX_RTC_CTRL_ALARM_IRQ_EN,
+			rtc_data->io + STMP3XXX_RTC_CTRL_CLR);
 	rtc_device_unregister(rtc_data->rtc);
 out_remap:
 	platform_set_drvdata(pdev, NULL);
@@ -271,10 +277,10 @@ static int stmp3xxx_rtc_resume(struct platform_device *dev)
 	struct stmp3xxx_rtc_data *rtc_data = platform_get_drvdata(dev);
 
 	mxs_reset_block(rtc_data->io);
-	__mxs_clrl(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
+	writel(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
 			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN |
 			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE,
-			rtc_data->io + STMP3XXX_RTC_PERSISTENT0);
+			rtc_data->io + STMP3XXX_RTC_PERSISTENT0_CLR);
 	return 0;
 }
 #else
-- 
1.7.2.5
