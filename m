From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 16 Nov 2011 11:47:39 +0100
Subject: [PATCH 3/3] rtc: stmp3xxx: use global stmp_device functionality
In-Reply-To: <1321440459-4527-1-git-send-email-w.sang@pengutronix.de>
References: <1321440459-4527-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1321440459-4527-4-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The former mach specific reset_block function has been converted to a global
one. Use the new one to remove mach dependency from the driver. Also simplify
code using the new STMP_REG_* macros.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/rtc/Kconfig        |    1 +
 drivers/rtc/rtc-stmp3xxx.c |   29 ++++++++++-------------------
 2 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 53eb4e5..babdd5d 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -983,6 +983,7 @@ config RTC_DRV_COH901331
 config RTC_DRV_STMP
 	tristate "Freescale STMP3xxx/i.MX23/i.MX28 RTC"
 	depends on ARCH_MXS
+	select STMP_DEVICE
 	help
 	  If you say yes here you will get support for the onboard
 	  STMP3xxx/i.MX23/i.MX28 RTC.
diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
index 7315068..23db0ed 100644
--- a/drivers/rtc/rtc-stmp3xxx.c
+++ b/drivers/rtc/rtc-stmp3xxx.c
@@ -25,11 +25,9 @@
 #include <linux/interrupt.h>
 #include <linux/rtc.h>
 #include <linux/slab.h>
-
-#include <mach/common.h>
+#include <linux/stmp_device.h>
 
 #define STMP3XXX_RTC_CTRL			0x0
-#define STMP3XXX_RTC_CTRL_SET			0x4
 #define STMP3XXX_RTC_CTRL_CLR			0x8
 #define STMP3XXX_RTC_CTRL_ALARM_IRQ_EN		0x00000001
 #define STMP3XXX_RTC_CTRL_ONEMSEC_IRQ_EN	0x00000002
@@ -44,7 +42,6 @@
 #define STMP3XXX_RTC_ALARM			0x40
 
 #define STMP3XXX_RTC_PERSISTENT0		0x60
-#define STMP3XXX_RTC_PERSISTENT0_SET		0x64
 #define STMP3XXX_RTC_PERSISTENT0_CLR		0x68
 #define STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN	0x00000002
 #define STMP3XXX_RTC_PERSISTENT0_ALARM_EN	0x00000004
@@ -106,20 +103,14 @@ static irqreturn_t stmp3xxx_rtc_interrupt(int irq, void *dev_id)
 static int stmp3xxx_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
 	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
+	u32 set_clr_offset = enabled ? STMP_SET_ADDR : STMP_CLR_ADDR;
+
+	writel(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
+		STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN,
+		rtc_data->io + STMP3XXX_RTC_PERSISTENT0 + set_clr_offset);
+	writel(STMP3XXX_RTC_CTRL_ALARM_IRQ_EN,
+		rtc_data->io + STMP3XXX_RTC_CTRL + set_clr_offset);
 
-	if (enabled) {
-		writel(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
-				STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN,
-				rtc_data->io + STMP3XXX_RTC_PERSISTENT0_SET);
-		writel(STMP3XXX_RTC_CTRL_ALARM_IRQ_EN,
-				rtc_data->io + STMP3XXX_RTC_CTRL_SET);
-	} else {
-		writel(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
-				STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN,
-				rtc_data->io + STMP3XXX_RTC_PERSISTENT0_CLR);
-		writel(STMP3XXX_RTC_CTRL_ALARM_IRQ_EN,
-				rtc_data->io + STMP3XXX_RTC_CTRL_CLR);
-	}
 	return 0;
 }
 
@@ -206,7 +197,7 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, rtc_data);
 
-	mxs_reset_block(rtc_data->io);
+	stmp_reset_block(rtc_data->io);
 	writel(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
 			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN |
 			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE,
@@ -253,7 +244,7 @@ static int stmp3xxx_rtc_resume(struct platform_device *dev)
 {
 	struct stmp3xxx_rtc_data *rtc_data = platform_get_drvdata(dev);
 
-	mxs_reset_block(rtc_data->io);
+	stmp_reset_block(rtc_data->io);
 	writel(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
 			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN |
 			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE,
-- 
1.7.7.1
