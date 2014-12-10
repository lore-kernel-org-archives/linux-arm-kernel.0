From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 10 Dec 2014 16:48:33 +0100
Subject: [RFC 15/15] drm/panel/ld9040: convert to restrack API
In-Reply-To: <1418226513-14105-1-git-send-email-a.hajda@samsung.com>
References: <1418226513-14105-1-git-send-email-a.hajda@samsung.com>
Message-ID: <1418226513-14105-16-git-send-email-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert ld9040 panel driver to use restrack API.
As a result driver have following advantages:
- correctly handles removal of resources,
- do not need to defer probing, so as a result the panel
  becomes available as soon as possible, in case of deferred
  probing it was late_initcall,
- simplified initialization.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/gpu/drm/panel/panel-ld9040.c | 41 ++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ld9040.c b/drivers/gpu/drm/panel/panel-ld9040.c
index 3337f30..619610e 100644
--- a/drivers/gpu/drm/panel/panel-ld9040.c
+++ b/drivers/gpu/drm/panel/panel-ld9040.c
@@ -17,6 +17,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
+#include <linux/restrack.h>
 
 #include <video/mipi_display.h>
 #include <video/of_videomode.h>
@@ -310,9 +311,22 @@ static int ld9040_parse_dt(struct ld9040 *ctx)
 	return 0;
 }
 
+void ld9040_restrack_cb(struct device *dev, int ret)
+{
+	struct ld9040 *ctx = dev_get_drvdata(dev);
+
+	if (ret == 0)
+		drm_panel_add(&ctx->panel);
+	else if (ret == -EPROBE_DEFER)
+		drm_panel_remove(&ctx->panel);
+	else
+		dev_err(dev, "restrack error %d\n", ret);
+}
+
 static int ld9040_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
+	struct restrack_ctx *rtrack;
 	struct ld9040 *ctx;
 	int ret;
 
@@ -331,17 +345,6 @@ static int ld9040_probe(struct spi_device *spi)
 
 	ctx->supplies[0].supply = "vdd3";
 	ctx->supplies[1].supply = "vci";
-	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies),
-				      ctx->supplies);
-	if (ret < 0)
-		return ret;
-
-	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(ctx->reset_gpio)) {
-		dev_err(dev, "cannot get reset-gpios %ld\n",
-			PTR_ERR(ctx->reset_gpio));
-		return PTR_ERR(ctx->reset_gpio);
-	}
 
 	spi->bits_per_word = 9;
 	ret = spi_setup(spi);
@@ -354,16 +357,13 @@ static int ld9040_probe(struct spi_device *spi)
 	ctx->panel.dev = dev;
 	ctx->panel.funcs = &ld9040_drm_funcs;
 
-	return drm_panel_add(&ctx->panel);
-}
-
-static int ld9040_remove(struct spi_device *spi)
-{
-	struct ld9040 *ctx = spi_get_drvdata(spi);
-
-	drm_panel_remove(&ctx->panel);
+	rtrack = devm_restrack_register(ctx->dev, ld9040_restrack_cb,
+		regulator_bulk_restrack_desc(&ctx->supplies[0]),
+		regulator_bulk_restrack_desc(&ctx->supplies[1]),
+		gpiod_restrack_desc(&ctx->reset_gpio, "reset", GPIOD_OUT_HIGH),
+	);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(rtrack);
 }
 
 static struct of_device_id ld9040_of_match[] = {
@@ -374,7 +374,6 @@ MODULE_DEVICE_TABLE(of, ld9040_of_match);
 
 static struct spi_driver ld9040_driver = {
 	.probe		= ld9040_probe,
-	.remove		= ld9040_remove,
 	.driver = {
 		.name	= "ld9040",
 		.owner	= THIS_MODULE,
-- 
1.9.1
