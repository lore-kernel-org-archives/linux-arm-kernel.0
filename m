From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Fri, 22 Jan 2010 23:47:17 +0100
Subject: [PATCH 4/4] ARM: S3C64XX: Add s3c64xx support to touchscreen driver
Message-ID: <b2e8f9f71001221447u550c9713l9f04aeec030c86db@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: S3C64XX: Add s3c64xx support to touchscreen driver

This ack's the extra interrupt s3c64xx platforms have in the touchscreen driver.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 drivers/input/touchscreen/Kconfig      |    6 +++---
 drivers/input/touchscreen/s3c2410_ts.c |   28 ++++++++++++++++++++++++----
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig
b/drivers/input/touchscreen/Kconfig
index dfafc76..0378b3d 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -146,11 +146,11 @@ config TOUCHSCREEN_FUJITSU
 	  module will be called fujitsu-ts.

 config TOUCHSCREEN_S3C2410
-	tristate "Samsung S3C2410 touchscreen input driver"
-	depends on ARCH_S3C2410
+	tristate "Samsung S3C touchscreen input driver"
+	depends on ARCH_S3C2410 || ARCH_S3C64XX
 	select S3C24XX_ADC
 	help
-	  Say Y here if you have the s3c2410 touchscreen.
+	  Say Y here if you have the s3c touchscreen.

 	  If unsure, say N.

diff --git a/drivers/input/touchscreen/s3c2410_ts.c
b/drivers/input/touchscreen/s3c2410_ts.c
index 3debbc2..7dfbc38 100644
--- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -40,7 +40,9 @@
 #include <plat/regs-adc.h>
 #include <plat/ts.h>

+#ifdef PLAT_S3C24XX
 #include <mach/regs-gpio.h>
+#endif

 #define TSC_SLEEP  (S3C2410_ADCTSC_PULL_UP_DISABLE | S3C2410_ADCTSC_XY_PST(0))

@@ -88,6 +90,12 @@ struct s3c2410ts {

 static struct s3c2410ts ts;

+enum s3c_cpu_type {
+	TYPE_S3C2410,
+	TYPE_S3C2440,
+	TYPE_S3C64XX,
+};
+
 /**
  * s3c2410_ts_connect - configure gpio for s3c2410 systems
  *
@@ -95,6 +103,7 @@ static struct s3c2410ts ts;
  * connected to the device (later systems such as the S3C2440 integrate
  * these into the device).
 */
+#ifdef PLAT_S3C24XX
 static inline void s3c2410_ts_connect(void)
 {
 	s3c2410_gpio_cfgpin(S3C2410_GPG(12), S3C2410_GPG12_XMON);
@@ -102,6 +111,7 @@ static inline void s3c2410_ts_connect(void)
 	s3c2410_gpio_cfgpin(S3C2410_GPG(14), S3C2410_GPG14_YMON);
 	s3c2410_gpio_cfgpin(S3C2410_GPG(15), S3C2410_GPG15_nYPON);
 }
+#endif

 /**
  * get_down - return the down state of the pen
@@ -169,6 +179,7 @@ static DEFINE_TIMER(touch_timer, touch_timer_fire, 0, 0);
  */
 static irqreturn_t stylus_irq(int irq, void *dev_id)
 {
+	struct platform_device *pdev = to_platform_device(ts.dev);
 	unsigned long data0;
 	unsigned long data1;
 	bool down;
@@ -187,6 +198,12 @@ static irqreturn_t stylus_irq(int irq, void *dev_id)
 	else
 		dev_info(ts.dev, "%s: count=%d\n", __func__, ts.count);

+
+	if (platform_get_device_id(pdev)->driver_data == TYPE_S3C64XX) {
+		/* Clear pen down/up interrupt */
+		writel(0x0, ts.io + S3C64XX_ADCCLRINTPNDNUP);
+	}
+
 	return IRQ_HANDLED;
 }

@@ -295,9 +312,11 @@ static int __devinit s3c2410ts_probe(struct
platform_device *pdev)
 		goto err_clk;
 	}

+#ifdef PLAT_S3C24XX
 	/* Configure the touchscreen external FETs on the S3C2410 */
-	if (!platform_get_device_id(pdev)->driver_data)
+	if (platform_get_device_id(pdev)->driver_data == TYPE_S3C2410)
 		s3c2410_ts_connect();
+#endif

 	ts.client = s3c_adc_register(pdev, s3c24xx_ts_select,
 				     s3c24xx_ts_conversion, 1);
@@ -418,15 +437,16 @@ static struct dev_pm_ops s3c_ts_pmops = {
 #endif

 static struct platform_device_id s3cts_driver_ids[] = {
-	{ "s3c2410-ts", 0 },
-	{ "s3c2440-ts", 1 },
+	{ "s3c2410-ts", TYPE_S3C2410 },
+	{ "s3c2440-ts", TYPE_S3C2440 },
+	{ "s3c64xx-ts", TYPE_S3C64XX },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, s3cts_driver_ids);

 static struct platform_driver s3c_ts_driver = {
 	.driver         = {
-		.name   = "s3c24xx-ts",
+		.name   = "s3c-ts",
 		.owner  = THIS_MODULE,
 #ifdef CONFIG_PM
 		.pm	= &s3c_ts_pmops,
-- 
1.6.6.1
