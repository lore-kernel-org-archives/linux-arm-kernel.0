From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 12 Jul 2012 11:57:53 +0200
Subject: [PATCH 7/7] mfd/mc13xxx: add support for mc34708
In-Reply-To: <1342087073-3892-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1342087073-3892-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1342087073-3892-8-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/mfd/mc13xxx-core.c |   21 +++++++++++++++++++++
 drivers/mfd/mc13xxx-i2c.c  |    6 ++++++
 drivers/mfd/mc13xxx-spi.c  |    4 ++++
 drivers/mfd/mc13xxx.h      |    3 ++-
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index 7874711..4ce3e1f 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -119,6 +119,11 @@
 #define MC13XXX_REVISION_FAB		(0x03 << 11)
 #define MC13XXX_REVISION_ICIDCODE	(0x3f << 13)
 
+#define MC34708_REVISION_REVMETAL	(0x07 <<  0)
+#define MC34708_REVISION_REVFULL	(0x07 <<  3)
+#define MC34708_REVISION_FIN		(0x07 <<  6)
+#define MC34708_REVISION_FAB		(0x07 <<  9)
+
 #define MC13XXX_ADC1		44
 #define MC13XXX_ADC1_ADEN		(1 << 0)
 #define MC13XXX_ADC1_RAND		(1 << 1)
@@ -424,6 +429,16 @@ static void mc13xxx_print_revision(struct mc13xxx *mc13xxx, u32 revision)
 			maskval(revision, MC13XXX_REVISION_ICIDCODE));
 }
 
+static void mc34708_print_revision(struct mc13xxx *mc13xxx, u32 revision)
+{
+	dev_info(mc13xxx->dev, "%s: rev %d.%d, fin: %d, fab: %d\n",
+			mc13xxx->variant->name,
+			maskval(revision, MC34708_REVISION_REVFULL),
+			maskval(revision, MC34708_REVISION_REVMETAL),
+			maskval(revision, MC34708_REVISION_FIN),
+			maskval(revision, MC34708_REVISION_FAB));
+}
+
 /* These are only exported for mc13xxx-i2c and mc13xxx-spi */
 struct mc13xxx_variant mc13xxx_variant_mc13783 = {
 	.name = "mc13783",
@@ -437,6 +452,12 @@ struct mc13xxx_variant mc13xxx_variant_mc13892 = {
 };
 EXPORT_SYMBOL_GPL(mc13xxx_variant_mc13892);
 
+struct mc13xxx_variant mc13xxx_variant_mc34708 = {
+	.name = "mc34708",
+	.print_revision = mc34708_print_revision,
+};
+EXPORT_SYMBOL_GPL(mc13xxx_variant_mc34708);
+
 static const char *mc13xxx_get_chipname(struct mc13xxx *mc13xxx)
 {
 	return mc13xxx->variant->name;
diff --git a/drivers/mfd/mc13xxx-i2c.c b/drivers/mfd/mc13xxx-i2c.c
index 6c1598c..907abff 100644
--- a/drivers/mfd/mc13xxx-i2c.c
+++ b/drivers/mfd/mc13xxx-i2c.c
@@ -26,6 +26,9 @@ static const struct i2c_device_id mc13xxx_i2c_device_id[] = {
 		.name = "mc13892",
 		.driver_data = (kernel_ulong_t)&mc13xxx_variant_mc13892,
 	}, {
+		.name = "mc34708",
+		.driver_data = (kernel_ulong_t)&mc13xxx_variant_mc34708,
+	}, {
 		/* sentinel */
 	}
 };
@@ -36,6 +39,9 @@ static const struct of_device_id mc13xxx_dt_ids[] = {
 		.compatible = "fsl,mc13892",
 		.data = &mc13xxx_variant_mc13892,
 	}, {
+		.compatible = "fsl,mc34708",
+		.data = &mc13xxx_variant_mc34708,
+	}, {
 		/* sentinel */
 	}
 };
diff --git a/drivers/mfd/mc13xxx-spi.c b/drivers/mfd/mc13xxx-spi.c
index 75a00c4..08a3bd9 100644
--- a/drivers/mfd/mc13xxx-spi.c
+++ b/drivers/mfd/mc13xxx-spi.c
@@ -33,6 +33,9 @@ static const struct spi_device_id mc13xxx_device_id[] = {
 		.name = "mc13892",
 		.driver_data = (kernel_ulong_t)&mc13xxx_variant_mc13892,
 	}, {
+		.name = "mc34708",
+		.driver_data = (kernel_ulong_t)&mc13xxx_variant_mc34708,
+	}, {
 		/* sentinel */
 	}
 };
@@ -41,6 +44,7 @@ MODULE_DEVICE_TABLE(spi, mc13xxx_device_id);
 static const struct of_device_id mc13xxx_dt_ids[] = {
 	{ .compatible = "fsl,mc13783", .data = &mc13xxx_variant_mc13783, },
 	{ .compatible = "fsl,mc13892", .data = &mc13xxx_variant_mc13892, },
+	{ .compatible = "fsl,mc34708", .data = &mc13xxx_variant_mc34708, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mc13xxx_dt_ids);
diff --git a/drivers/mfd/mc13xxx.h b/drivers/mfd/mc13xxx.h
index 78bf4c3..460ec5c 100644
--- a/drivers/mfd/mc13xxx.h
+++ b/drivers/mfd/mc13xxx.h
@@ -24,7 +24,8 @@ struct mc13xxx_variant {
 
 extern struct mc13xxx_variant
 		mc13xxx_variant_mc13783,
-		mc13xxx_variant_mc13892;
+		mc13xxx_variant_mc13892,
+		mc13xxx_variant_mc34708;
 
 struct mc13xxx {
 	struct regmap *regmap;
-- 
1.7.10.4
