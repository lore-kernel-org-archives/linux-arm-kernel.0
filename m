From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 25 May 2011 12:56:50 +0200
Subject: [PATCH V2 2/5] rtc: stmp3xxx: port stmp-functions to mxs-equivalents
In-Reply-To: <1306321013-28364-1-git-send-email-w.sang@pengutronix.de>
References: <1306321013-28364-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1306321013-28364-3-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

plat-stmp has been removed meanwhile since it is compatible to mach-mxs.
Use the apropriate mxs-functions for transition. The accessors will be
converted to readl/writel in a later patch.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Tested-by: Shawn Guo <shawn.guo@freescale.com>
---
 drivers/rtc/Kconfig        |    6 +++---
 drivers/rtc/rtc-stmp3xxx.c |   28 ++++++++++++++--------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 4289172..67f0e5a 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -929,11 +929,11 @@ config RTC_DRV_COH901331
 
 
 config RTC_DRV_STMP
-	tristate "Freescale STMP3xxx RTC"
-	depends on ARCH_STMP3XXX
+	tristate "Freescale STMP3xxx/i.MX23/i.MX28 RTC"
+	depends on ARCH_MXS
 	help
 	  If you say yes here you will get support for the onboard
-	  STMP3xxx RTC.
+	  STMP3xxx/i.MX23/i.MX28 RTC.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-stmp3xxx.
diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
index f50213f..44e2202 100644
--- a/drivers/rtc/rtc-stmp3xxx.c
+++ b/drivers/rtc/rtc-stmp3xxx.c
@@ -24,8 +24,8 @@
 #include <linux/rtc.h>
 #include <linux/slab.h>
 
-#include <mach/platform.h>
-#include <mach/stmp3xxx.h>
+#include <mach/common.h>
+#include <mach/mxs.h>
 
 #define STMP3XXX_RTC_CTRL		0x0
 #define STMP3XXX_RTC_CTRL_ALARM_IRQ_EN		0x00000001
@@ -95,13 +95,13 @@ static irqreturn_t stmp3xxx_rtc_interrupt(int irq, void *dev_id)
 			(STMP3XXX_RTC_CTRL_ALARM_IRQ | STMP3XXX_RTC_CTRL_ONEMSEC_IRQ);
 
 	if (status & STMP3XXX_RTC_CTRL_ALARM_IRQ) {
-		stmp3xxx_clearl(STMP3XXX_RTC_CTRL_ALARM_IRQ,
+		__mxs_clrl(STMP3XXX_RTC_CTRL_ALARM_IRQ,
 				rtc_data->io + STMP3XXX_RTC_CTRL);
 		events |= RTC_AF | RTC_IRQF;
 	}
 
 	if (status & STMP3XXX_RTC_CTRL_ONEMSEC_IRQ) {
-		stmp3xxx_clearl(STMP3XXX_RTC_CTRL_ONEMSEC_IRQ,
+		__mxs_clrl(STMP3XXX_RTC_CTRL_ONEMSEC_IRQ,
 				rtc_data->io + STMP3XXX_RTC_CTRL);
 		if (++rtc_data->irq_count % 1000 == 0) {
 			events |= RTC_UF | RTC_IRQF;
@@ -122,13 +122,13 @@ static int stmp3xxx_alarm_irq_enable(struct device *dev, unsigned int enabled)
 		     *ctl = rtc_data->io + STMP3XXX_RTC_CTRL;
 
 	if (enabled) {
-		stmp3xxx_setl(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
+		__mxs_setl(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
 			      STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN, p);
-		stmp3xxx_setl(STMP3XXX_RTC_CTRL_ALARM_IRQ_EN, ctl);
+		__mxs_setl(STMP3XXX_RTC_CTRL_ALARM_IRQ_EN, ctl);
 	} else {
-		stmp3xxx_clearl(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
+		__mxs_clrl(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
 			      STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN, p);
-		stmp3xxx_clearl(STMP3XXX_RTC_CTRL_ALARM_IRQ_EN, ctl);
+		__mxs_clrl(STMP3XXX_RTC_CTRL_ALARM_IRQ_EN, ctl);
 	}
 	return 0;
 }
@@ -167,7 +167,7 @@ static int stmp3xxx_rtc_remove(struct platform_device *pdev)
 	if (!rtc_data)
 		return 0;
 
-	stmp3xxx_clearl(STMP3XXX_RTC_CTRL_ONEMSEC_IRQ_EN | STMP3XXX_RTC_CTRL_ALARM_IRQ_EN,
+	__mxs_clrl(STMP3XXX_RTC_CTRL_ONEMSEC_IRQ_EN | STMP3XXX_RTC_CTRL_ALARM_IRQ_EN,
 			rtc_data->io + STMP3XXX_RTC_CTRL);
 	free_irq(rtc_data->irq_alarm, &pdev->dev);
 	free_irq(rtc_data->irq_1msec, &pdev->dev);
@@ -212,8 +212,8 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
 		goto out_remap;
 	}
 
-	stmp3xxx_reset_block(rtc_data->io, true);
-	stmp3xxx_clearl(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
+	mxs_reset_block(rtc_data->io);
+	__mxs_clrl(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
 			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN |
 			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE,
 			rtc_data->io + STMP3XXX_RTC_PERSISTENT0);
@@ -247,7 +247,7 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
 out_irq1:
 	free_irq(rtc_data->irq_alarm, &pdev->dev);
 out_irq_alarm:
-	stmp3xxx_clearl(STMP3XXX_RTC_CTRL_ONEMSEC_IRQ_EN | STMP3XXX_RTC_CTRL_ALARM_IRQ_EN,
+	__mxs_clrl(STMP3XXX_RTC_CTRL_ONEMSEC_IRQ_EN | STMP3XXX_RTC_CTRL_ALARM_IRQ_EN,
 			rtc_data->io + STMP3XXX_RTC_CTRL);
 	rtc_device_unregister(rtc_data->rtc);
 out_remap:
@@ -267,8 +267,8 @@ static int stmp3xxx_rtc_resume(struct platform_device *dev)
 {
 	struct stmp3xxx_rtc_data *rtc_data = platform_get_drvdata(dev);
 
-	stmp3xxx_reset_block(rtc_data->io, true);
-	stmp3xxx_clearl(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
+	mxs_reset_block(rtc_data->io);
+	__mxs_clrl(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
 			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN |
 			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE,
 			rtc_data->io + STMP3XXX_RTC_PERSISTENT0);
-- 
1.7.2.5
