From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu,  8 Mar 2012 15:51:23 +0100
Subject: [PATCH 03/11] regulator: fixed: Support driver probe deferral
In-Reply-To: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1331218291-16119-4-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the specified GPIO is not found, return -EPROBE_DEFER. This will
cause the driver to be probed again later when the required GPIO may
have become available.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 drivers/regulator/fixed.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index 40f3803..35cec44 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -58,12 +58,19 @@ of_get_fixed_voltage_config(struct device *dev)
 	struct device_node *np = dev->of_node;
 	const __be32 *delay;
 	struct regulator_init_data *init_data;
+	int gpio;
+
+	gpio = of_get_named_gpio(np, "gpio", 0);
+	if (gpio < 0)
+		return ERR_PTR(-EPROBE_DEFER);
 
 	config = devm_kzalloc(dev, sizeof(struct fixed_voltage_config),
 								 GFP_KERNEL);
 	if (!config)
 		return NULL;
 
+	config->gpio = gpio;
+
 	config->init_data = of_get_regulator_init_data(dev, dev->of_node);
 	if (!config->init_data)
 		return NULL;
@@ -83,7 +90,6 @@ of_get_fixed_voltage_config(struct device *dev)
 	if (init_data->constraints.boot_on)
 		config->enabled_at_boot = true;
 
-	config->gpio = of_get_named_gpio(np, "gpio", 0);
 	delay = of_get_property(np, "startup-delay-us", NULL);
 	if (delay)
 		config->startup_delay = be32_to_cpu(*delay);
@@ -168,9 +174,11 @@ static int __devinit reg_fixed_voltage_probe(struct platform_device *pdev)
 	struct fixed_voltage_data *drvdata;
 	int ret;
 
-	if (pdev->dev.of_node)
+	if (pdev->dev.of_node) {
 		config = of_get_fixed_voltage_config(&pdev->dev);
-	else
+		if (IS_ERR(config))
+			return PTR_ERR(config);
+	} else
 		config = pdev->dev.platform_data;
 
 	if (!config)
-- 
1.7.9.3
