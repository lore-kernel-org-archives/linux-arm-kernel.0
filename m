From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 13 May 2010 22:07:18 +0900
Subject: [PATCH v2 5/9] Input: s3c24xx_ts - Adds TYPE_S3C64XX into Samsung
	touchscreen driver
Message-ID: <1273756038-3164-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Naveen Krishna <ch.naveen@samsung.com>

This patch adds TYPE_S3C64XX to the ID table in Samsung touchscreen driver,
Which would help us configure the register bits based on the IP level changes.

Note: This TYPE_S3C64XX will support both S3C64XX and S5P64XX SoCs.

Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/input/touchscreen/Kconfig      |    3 ++-
 drivers/input/touchscreen/s3c2410_ts.c |   19 ++++++++++++++++---
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index a5dcdac..c82c1e1 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -159,7 +159,8 @@ config TOUCHSCREEN_FUJITSU
 
 config TOUCHSCREEN_S3C2410
 	tristate "Samsung S3C2410 touchscreen input driver"
-	depends on ARCH_S3C2410
+	depends on ARCH_S3C2410 || ARCH_S3C64XX || ARCH_S5P6440
+	select S3C_ADC
 	help
 	  Say Y here if you have the s3c2410 touchscreen.
 
diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
index 86086a4..7e7d368 100644
--- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -85,6 +85,12 @@ struct s3c2410ts {
 
 static struct s3c2410ts ts;
 
+enum s3c_cpu_type {
+	TYPE_S3C2410,
+	TYPE_S3C2440,
+	TYPE_S3C64XX,	/* S3C64XX, S5P64XX Series */
+};
+
 /**
  * get_down - return the down state of the pen
  * @data0: The data read from ADCDAT0 register.
@@ -153,6 +159,7 @@ static DEFINE_TIMER(touch_timer, touch_timer_fire, 0, 0);
  */
 static irqreturn_t stylus_irq(int irq, void *dev_id)
 {
+	struct platform_device *pdev = to_platform_device(ts.dev);
 	unsigned long data0;
 	unsigned long data1;
 	bool down;
@@ -171,6 +178,11 @@ static irqreturn_t stylus_irq(int irq, void *dev_id)
 	else
 		dev_info(ts.dev, "%s: count=%d\n", __func__, ts.count);
 
+	if (platform_get_device_id(pdev)->driver_data >= TYPE_S3C64XX) {
+		/* Clear pen down/up interrupt */
+		writel(0x0, ts.io + S3C64XX_ADCCLRINTPNDNUP);
+	}
+
 	return IRQ_HANDLED;
 }
 
@@ -403,15 +415,16 @@ static struct dev_pm_ops s3c_ts_pmops = {
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
+		.name	= "samsung-ts",
 		.owner  = THIS_MODULE,
 #ifdef CONFIG_PM
 		.pm	= &s3c_ts_pmops,
-- 
1.6.2.5
