From: slash.tmp@free.fr (Mason)
Date: Tue, 28 Jun 2016 13:37:58 +0200
Subject: [RESEND PATCH v2] thermal: tango: add resume support
Message-ID: <57726196.5060909@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

When this platform is suspended, firmware powers the entire SoC down,
except a few hardware blocks waiting for wakeup events. And there is
no context to save for this particular block.

Therefore, there is nothing useful for the driver to do on suspend;
so we define a NULL suspend hook. On resume, the driver initializes
the block exactly as is done in the probe callback.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
Add Kevin's Reviewed-by tag.
Eduardo/Zhang, can you pick this patch up for 4.8?
---
 drivers/thermal/tango_thermal.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/tango_thermal.c b/drivers/thermal/tango_thermal.c
index 70e0d9f406e9..d571ce2f546d 100644
--- a/drivers/thermal/tango_thermal.c
+++ b/drivers/thermal/tango_thermal.c
@@ -64,6 +64,12 @@ static const struct thermal_zone_of_device_ops ops = {
 	.get_temp	= tango_get_temp,
 };
 
+static void tango_thermal_init(struct tango_thermal_priv *priv)
+{
+	writel(0, priv->base + TEMPSI_CFG);
+	writel(CMD_ON, priv->base + TEMPSI_CMD);
+}
+
 static int tango_thermal_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -79,14 +85,30 @@ static int tango_thermal_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
+	platform_set_drvdata(pdev, priv);
 	priv->thresh_idx = IDX_MIN;
-	writel(0, priv->base + TEMPSI_CFG);
-	writel(CMD_ON, priv->base + TEMPSI_CMD);
+	tango_thermal_init(priv);
 
 	tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, priv, &ops);
 	return PTR_ERR_OR_ZERO(tzdev);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int tango_thermal_resume(struct device *dev)
+{
+	struct tango_thermal_priv *priv = dev_get_drvdata(dev);
+	tango_thermal_init(priv);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(tango_thermal_pm, NULL, tango_thermal_resume);
+
+#define DEV_PM_OPS	&tango_thermal_pm
+#else
+#define DEV_PM_OPS	NULL
+#endif
+
 static const struct of_device_id tango_sensor_ids[] = {
 	{
 		.compatible = "sigma,smp8758-thermal",
@@ -99,6 +121,7 @@ static struct platform_driver tango_thermal_driver = {
 	.driver	= {
 		.name		= "tango-thermal",
 		.of_match_table	= tango_sensor_ids,
+		.pm		= DEV_PM_OPS,
 	},
 };
 
-- 
2.8.2
