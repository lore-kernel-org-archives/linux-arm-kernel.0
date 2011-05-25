From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 25 May 2011 12:56:49 +0200
Subject: [PATCH V2 1/5] rtc: stmp3xxx: get rid of platform-specific include
	for register names
In-Reply-To: <1306321013-28364-1-git-send-email-w.sang@pengutronix.de>
References: <1306321013-28364-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1306321013-28364-2-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the register names into the driver and rename them to kernel style.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Tested-by: Shawn Guo <shawn.guo@freescale.com>
---
 drivers/rtc/rtc-stmp3xxx.c |   92 ++++++++++++++++++++++++++------------------
 1 files changed, 55 insertions(+), 37 deletions(-)

diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
index 572e953..f50213f 100644
--- a/drivers/rtc/rtc-stmp3xxx.c
+++ b/drivers/rtc/rtc-stmp3xxx.c
@@ -26,7 +26,25 @@
 
 #include <mach/platform.h>
 #include <mach/stmp3xxx.h>
-#include <mach/regs-rtc.h>
+
+#define STMP3XXX_RTC_CTRL		0x0
+#define STMP3XXX_RTC_CTRL_ALARM_IRQ_EN		0x00000001
+#define STMP3XXX_RTC_CTRL_ONEMSEC_IRQ_EN	0x00000002
+#define STMP3XXX_RTC_CTRL_ALARM_IRQ		0x00000004
+#define STMP3XXX_RTC_CTRL_ONEMSEC_IRQ		0x00000008
+
+#define STMP3XXX_RTC_STAT		0x10
+#define STMP3XXX_RTC_STAT_STALE_SHIFT		16
+#define STMP3XXX_RTC_STAT_RTC_PRESENT		0x80000000
+
+#define STMP3XXX_RTC_SECONDS		0x30
+
+#define STMP3XXX_RTC_ALARM		0x40
+
+#define STMP3XXX_RTC_PERSISTENT0	0x60
+#define STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN	0x00000002
+#define STMP3XXX_RTC_PERSISTENT0_ALARM_EN	0x00000004
+#define STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE	0x00000080
 
 struct stmp3xxx_rtc_data {
 	struct rtc_device *rtc;
@@ -42,8 +60,8 @@ static void stmp3xxx_wait_time(struct stmp3xxx_rtc_data *rtc_data)
 	 * NEW_REGS/STALE_REGS bitfields go. In fact it's 0x1=P0,
 	 * 0x2=P1, .., 0x20=P5, 0x40=ALARM, 0x80=SECONDS
 	 */
-	while (__raw_readl(rtc_data->io + HW_RTC_STAT) &
-			BF(0x80, RTC_STAT_STALE_REGS))
+	while (__raw_readl(rtc_data->io + STMP3XXX_RTC_STAT) &
+			(0x80 << STMP3XXX_RTC_STAT_STALE_SHIFT))
 		cpu_relax();
 }
 
@@ -53,7 +71,7 @@ static int stmp3xxx_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
 	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
 
 	stmp3xxx_wait_time(rtc_data);
-	rtc_time_to_tm(__raw_readl(rtc_data->io + HW_RTC_SECONDS), rtc_tm);
+	rtc_time_to_tm(__raw_readl(rtc_data->io + STMP3XXX_RTC_SECONDS), rtc_tm);
 	return 0;
 }
 
@@ -61,7 +79,7 @@ static int stmp3xxx_rtc_set_mmss(struct device *dev, unsigned long t)
 {
 	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
 
-	__raw_writel(t, rtc_data->io + HW_RTC_SECONDS);
+	__raw_writel(t, rtc_data->io + STMP3XXX_RTC_SECONDS);
 	stmp3xxx_wait_time(rtc_data);
 	return 0;
 }
@@ -73,18 +91,18 @@ static irqreturn_t stmp3xxx_rtc_interrupt(int irq, void *dev_id)
 	u32 status;
 	u32 events = 0;
 
-	status = __raw_readl(rtc_data->io + HW_RTC_CTRL) &
-			(BM_RTC_CTRL_ALARM_IRQ | BM_RTC_CTRL_ONEMSEC_IRQ);
+	status = __raw_readl(rtc_data->io + STMP3XXX_RTC_CTRL) &
+			(STMP3XXX_RTC_CTRL_ALARM_IRQ | STMP3XXX_RTC_CTRL_ONEMSEC_IRQ);
 
-	if (status & BM_RTC_CTRL_ALARM_IRQ) {
-		stmp3xxx_clearl(BM_RTC_CTRL_ALARM_IRQ,
-				rtc_data->io + HW_RTC_CTRL);
+	if (status & STMP3XXX_RTC_CTRL_ALARM_IRQ) {
+		stmp3xxx_clearl(STMP3XXX_RTC_CTRL_ALARM_IRQ,
+				rtc_data->io + STMP3XXX_RTC_CTRL);
 		events |= RTC_AF | RTC_IRQF;
 	}
 
-	if (status & BM_RTC_CTRL_ONEMSEC_IRQ) {
-		stmp3xxx_clearl(BM_RTC_CTRL_ONEMSEC_IRQ,
-				rtc_data->io + HW_RTC_CTRL);
+	if (status & STMP3XXX_RTC_CTRL_ONEMSEC_IRQ) {
+		stmp3xxx_clearl(STMP3XXX_RTC_CTRL_ONEMSEC_IRQ,
+				rtc_data->io + STMP3XXX_RTC_CTRL);
 		if (++rtc_data->irq_count % 1000 == 0) {
 			events |= RTC_UF | RTC_IRQF;
 			rtc_data->irq_count = 0;
@@ -100,17 +118,17 @@ static irqreturn_t stmp3xxx_rtc_interrupt(int irq, void *dev_id)
 static int stmp3xxx_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
 	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
-	void __iomem *p = rtc_data->io + HW_RTC_PERSISTENT0,
-		     *ctl = rtc_data->io + HW_RTC_CTRL;
+	void __iomem *p = rtc_data->io + STMP3XXX_RTC_PERSISTENT0,
+		     *ctl = rtc_data->io + STMP3XXX_RTC_CTRL;
 
 	if (enabled) {
-		stmp3xxx_setl(BM_RTC_PERSISTENT0_ALARM_EN |
-			      BM_RTC_PERSISTENT0_ALARM_WAKE_EN, p);
-		stmp3xxx_setl(BM_RTC_CTRL_ALARM_IRQ_EN, ctl);
+		stmp3xxx_setl(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
+			      STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN, p);
+		stmp3xxx_setl(STMP3XXX_RTC_CTRL_ALARM_IRQ_EN, ctl);
 	} else {
-		stmp3xxx_clearl(BM_RTC_PERSISTENT0_ALARM_EN |
-			      BM_RTC_PERSISTENT0_ALARM_WAKE_EN, p);
-		stmp3xxx_clearl(BM_RTC_CTRL_ALARM_IRQ_EN, ctl);
+		stmp3xxx_clearl(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
+			      STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN, p);
+		stmp3xxx_clearl(STMP3XXX_RTC_CTRL_ALARM_IRQ_EN, ctl);
 	}
 	return 0;
 }
@@ -119,7 +137,7 @@ static int stmp3xxx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 {
 	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
 
-	rtc_time_to_tm(__raw_readl(rtc_data->io + HW_RTC_ALARM), &alm->time);
+	rtc_time_to_tm(__raw_readl(rtc_data->io + STMP3XXX_RTC_ALARM), &alm->time);
 	return 0;
 }
 
@@ -129,7 +147,7 @@ static int stmp3xxx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
 
 	rtc_tm_to_time(&alm->time, &t);
-	__raw_writel(t, rtc_data->io + HW_RTC_ALARM);
+	__raw_writel(t, rtc_data->io + STMP3XXX_RTC_ALARM);
 	return 0;
 }
 
@@ -149,8 +167,8 @@ static int stmp3xxx_rtc_remove(struct platform_device *pdev)
 	if (!rtc_data)
 		return 0;
 
-	stmp3xxx_clearl(BM_RTC_CTRL_ONEMSEC_IRQ_EN | BM_RTC_CTRL_ALARM_IRQ_EN,
-			rtc_data->io + HW_RTC_CTRL);
+	stmp3xxx_clearl(STMP3XXX_RTC_CTRL_ONEMSEC_IRQ_EN | STMP3XXX_RTC_CTRL_ALARM_IRQ_EN,
+			rtc_data->io + STMP3XXX_RTC_CTRL);
 	free_irq(rtc_data->irq_alarm, &pdev->dev);
 	free_irq(rtc_data->irq_1msec, &pdev->dev);
 	rtc_device_unregister(rtc_data->rtc);
@@ -187,18 +205,18 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
 	rtc_data->irq_alarm = platform_get_irq(pdev, 0);
 	rtc_data->irq_1msec = platform_get_irq(pdev, 1);
 
-	if (!(__raw_readl(HW_RTC_STAT + rtc_data->io) &
-			BM_RTC_STAT_RTC_PRESENT)) {
+	if (!(__raw_readl(STMP3XXX_RTC_STAT + rtc_data->io) &
+			STMP3XXX_RTC_STAT_RTC_PRESENT)) {
 		dev_err(&pdev->dev, "no device onboard\n");
 		err = -ENODEV;
 		goto out_remap;
 	}
 
 	stmp3xxx_reset_block(rtc_data->io, true);
-	stmp3xxx_clearl(BM_RTC_PERSISTENT0_ALARM_EN |
-			BM_RTC_PERSISTENT0_ALARM_WAKE_EN |
-			BM_RTC_PERSISTENT0_ALARM_WAKE,
-			rtc_data->io + HW_RTC_PERSISTENT0);
+	stmp3xxx_clearl(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
+			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN |
+			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE,
+			rtc_data->io + STMP3XXX_RTC_PERSISTENT0);
 	rtc_data->rtc = rtc_device_register(pdev->name, &pdev->dev,
 				&stmp3xxx_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc_data->rtc)) {
@@ -229,8 +247,8 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
 out_irq1:
 	free_irq(rtc_data->irq_alarm, &pdev->dev);
 out_irq_alarm:
-	stmp3xxx_clearl(BM_RTC_CTRL_ONEMSEC_IRQ_EN | BM_RTC_CTRL_ALARM_IRQ_EN,
-			rtc_data->io + HW_RTC_CTRL);
+	stmp3xxx_clearl(STMP3XXX_RTC_CTRL_ONEMSEC_IRQ_EN | STMP3XXX_RTC_CTRL_ALARM_IRQ_EN,
+			rtc_data->io + STMP3XXX_RTC_CTRL);
 	rtc_device_unregister(rtc_data->rtc);
 out_remap:
 	iounmap(rtc_data->io);
@@ -250,10 +268,10 @@ static int stmp3xxx_rtc_resume(struct platform_device *dev)
 	struct stmp3xxx_rtc_data *rtc_data = platform_get_drvdata(dev);
 
 	stmp3xxx_reset_block(rtc_data->io, true);
-	stmp3xxx_clearl(BM_RTC_PERSISTENT0_ALARM_EN |
-			BM_RTC_PERSISTENT0_ALARM_WAKE_EN |
-			BM_RTC_PERSISTENT0_ALARM_WAKE,
-			rtc_data->io + HW_RTC_PERSISTENT0);
+	stmp3xxx_clearl(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
+			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN |
+			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE,
+			rtc_data->io + STMP3XXX_RTC_PERSISTENT0);
 	return 0;
 }
 #else
-- 
1.7.2.5
