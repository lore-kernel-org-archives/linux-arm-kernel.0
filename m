From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 21 Jul 2015 15:50:58 +0200
Subject: [RFC PATCH 16/16] fixed-regulator: Use devm_resource
In-Reply-To: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1437486658-28365-17-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

 drivers/regulator/fixed.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index ff62d69ba0be..4ece78c1260d 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -34,6 +34,7 @@
 struct fixed_voltage_data {
 	struct regulator_desc desc;
 	struct regulator_dev *dev;
+	struct gpio_desc *gpio;
 };
 
 
@@ -78,20 +79,6 @@ of_get_fixed_voltage_config(struct device *dev,
 	if (init_data->constraints.boot_on)
 		config->enabled_at_boot = true;
 
-	config->gpio = of_get_named_gpio(np, "gpio", 0);
-	/*
-	 * of_get_named_gpio() currently returns ENODEV rather than
-	 * EPROBE_DEFER. This code attempts to be compatible with both
-	 * for now; the ENODEV check can be removed once the API is fixed.
-	 * of_get_named_gpio() doesn't differentiate between a missing
-	 * property (which would be fine here, since the GPIO is optional)
-	 * and some other error. Patches have been posted for both issues.
-	 * Once they are check in, we should replace this with:
-	 * if (config->gpio < 0 && config->gpio != -ENOENT)
-	 */
-	if ((config->gpio == -ENODEV) || (config->gpio == -EPROBE_DEFER))
-		return ERR_PTR(-EPROBE_DEFER);
-
 	of_property_read_u32(np, "startup-delay-us", &config->startup_delay);
 
 	config->enable_high = of_property_read_bool(np, "enable-active-high");
@@ -110,20 +97,17 @@ static struct regulator_ops fixed_voltage_ops = {
 static int reg_fixed_voltage_probe(struct platform_device *pdev)
 {
 	struct fixed_voltage_config *config;
-	struct fixed_voltage_data *drvdata;
+	struct fixed_voltage_data *drvdata = platform_get_drvdata(pdev);
 	struct regulator_config cfg = { };
 	int ret;
 
-	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct fixed_voltage_data),
-			       GFP_KERNEL);
-	if (!drvdata)
-		return -ENOMEM;
-
 	if (pdev->dev.of_node) {
 		config = of_get_fixed_voltage_config(&pdev->dev,
 						     &drvdata->desc);
 		if (IS_ERR(config))
 			return PTR_ERR(config);
+
+		config->gpio = desc_to_gpio(drvdata->gpio);
 	} else {
 		config = dev_get_platdata(&pdev->dev);
 	}
@@ -193,8 +177,6 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, drvdata);
-
 	dev_dbg(&pdev->dev, "%s supplying %duV\n", drvdata->desc.name,
 		drvdata->desc.fixed_uV);
 
@@ -209,11 +191,18 @@ static const struct of_device_id fixed_of_match[] = {
 MODULE_DEVICE_TABLE(of, fixed_of_match);
 #endif
 
+static const struct devm_resource reg_fixed_resources[] = {
+	DEVM_ALLOC(fixed_voltage_data),
+	DEVM_GPIO_NAMED(fixed_voltage_data, gpio, NULL),
+	{},
+};
+
 static struct platform_driver regulator_fixed_voltage_driver = {
 	.probe		= reg_fixed_voltage_probe,
 	.driver		= {
 		.name		= "reg-fixed-voltage",
 		.of_match_table = of_match_ptr(fixed_of_match),
+		.resources = reg_fixed_resources,
 	},
 };
 
-- 
2.4.3
