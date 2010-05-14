From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 14 May 2010 16:25:27 +0900
Subject: [PATCH v2 11/11] Input: s3c24xx_ts - Uses Feature field instead TYPE
	for Samsung SoCs
Message-ID: <1273821927-17585-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Naveen Krishna <ch.naveen@samsung.com>

This patch removes teh TYPE from touchscreen driver for Samsung SoCs
and uses a Feature bit field instead.

Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/input/touchscreen/s3c2410_ts.c |   23 +++++------------------
 1 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
index 8a970ea..aa43f93 100644
--- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -55,6 +55,8 @@
 			 S3C2410_ADCTSC_AUTO_PST | \
 			 S3C2410_ADCTSC_XY_PST(0))
 
+#define FEAT_PEN_IRQ	(1 << 0)	/* HAS ADCCLRINTPNDNUP */
+
 /* Per-touchscreen data. */
 
 /**
@@ -81,17 +83,11 @@ struct s3c2410ts {
 	int irq_tc;
 	int count;
 	int shift;
+	int feat;
 };
 
 static struct s3c2410ts ts;
 
-enum s3c_cpu_type {
-	TYPE_S3C2410,
-	TYPE_S3C2440,
-	TYPE_S3C64XX,	/* S3C64XX, S5P64XX Series */
-	TYPE_S5PV210,	/* S5PV210 */
-};
-
 /**
  * get_down - return the down state of the pen
  * @data0: The data read from ADCDAT0 register.
@@ -179,7 +175,7 @@ static irqreturn_t stylus_irq(int irq, void *dev_id)
 	else
 		dev_info(ts.dev, "%s: count=%d\n", __func__, ts.count);
 
-	if (platform_get_device_id(pdev)->driver_data >= TYPE_S3C64XX) {
+	if (ts.feat & FEAT_PEN_IRQ) {
 		/* Clear pen down/up interrupt */
 		writel(0x0, ts.io + S3C64XX_ADCCLRINTPNDNUP);
 	}
@@ -330,6 +326,7 @@ static int __devinit s3c2410ts_probe(struct platform_device *pdev)
 	ts.input->id.version = 0x0102;
 
 	ts.shift = info->oversampling_shift;
+	ts.feat	= info->feature;
 
 	ret = request_irq(ts.irq_tc, stylus_irq, IRQF_DISABLED,
 			  "s3c2410_ts_pen", ts.input);
@@ -415,15 +412,6 @@ static struct dev_pm_ops s3c_ts_pmops = {
 };
 #endif
 
-static struct platform_device_id s3cts_driver_ids[] = {
-	{ "s3c2410-ts", TYPE_S3C2410 },
-	{ "s3c2440-ts", TYPE_S3C2440 },
-	{ "s3c64xx-ts", TYPE_S3C64XX },
-	{ "s5pv210-ts", TYPE_S5PV210 },
-	{ }
-};
-MODULE_DEVICE_TABLE(platform, s3cts_driver_ids);
-
 static struct platform_driver s3c_ts_driver = {
 	.driver         = {
 		.name   = "samsung-ts",
@@ -432,7 +420,6 @@ static struct platform_driver s3c_ts_driver = {
 		.pm	= &s3c_ts_pmops,
 #endif
 	},
-	.id_table	= s3cts_driver_ids,
 	.probe		= s3c2410ts_probe,
 	.remove		= __devexit_p(s3c2410ts_remove),
 };
-- 
1.6.2.5
