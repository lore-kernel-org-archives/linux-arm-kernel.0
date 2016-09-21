From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 21 Sep 2016 20:20:43 +0200
Subject: [PATCH 3/3] regulator: axp20x: simplify device access
In-Reply-To: <cover.1474616699.git.moinejf@free.fr>
References: <cover.1474616699.git.moinejf@free.fr>
Message-ID: <d3078ed4eefd4de48e4b5666a64f6123f8d72483.1474616699.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the pointer to the main regulator device instead of the pointer
to the child platform device.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/regulator/axp20x-regulator.c | 45 ++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 7405f5b..244ddc3 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -347,9 +347,9 @@ static const struct regulator_desc axp809_regulators[] = {
 	AXP_DESC_SW(AXP809, SW, "sw", "swin", AXP22X_PWR_OUT_CTRL2, BIT(6)),
 };
 
-static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
+static int axp20x_set_dcdc_freq(struct device *dev, u32 dcdcfreq)
 {
-	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
+	struct axp20x_dev *axp20x = dev_get_drvdata(dev);
 	unsigned int reg = AXP20X_DCDC_FREQ;
 	u32 min, max, def, step;
 
@@ -378,7 +378,7 @@ static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
 		step = 150;
 		break;
 	default:
-		dev_err(&pdev->dev,
+		dev_err(dev,
 			"Setting DCDC frequency for unsupported AXP variant\n");
 		return -EINVAL;
 	}
@@ -388,13 +388,13 @@ static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
 
 	if (dcdcfreq < min) {
 		dcdcfreq = min;
-		dev_warn(&pdev->dev, "DCDC frequency too low. Set to %ukHz\n",
+		dev_warn(dev, "DCDC frequency too low. Set to %ukHz\n",
 			 min);
 	}
 
 	if (dcdcfreq > max) {
 		dcdcfreq = max;
-		dev_warn(&pdev->dev, "DCDC frequency too high. Set to %ukHz\n",
+		dev_warn(dev, "DCDC frequency too high. Set to %ukHz\n",
 			 max);
 	}
 
@@ -404,24 +404,24 @@ static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
 				  AXP20X_FREQ_DCDC_MASK, dcdcfreq);
 }
 
-static int axp20x_regulator_parse_dt(struct platform_device *pdev)
+static int axp20x_regulator_parse_dt(struct device *dev)
 {
 	struct device_node *np, *regulators;
 	int ret;
 	u32 dcdcfreq = 0;
 
-	np = of_node_get(pdev->dev.parent->of_node);
+	np = of_node_get(dev->of_node);
 	if (!np)
 		return 0;
 
 	regulators = of_get_child_by_name(np, "regulators");
 	if (!regulators) {
-		dev_warn(&pdev->dev, "regulators node not found\n");
+		dev_warn(dev, "regulators node not found\n");
 	} else {
 		of_property_read_u32(regulators, "x-powers,dcdc-freq", &dcdcfreq);
-		ret = axp20x_set_dcdc_freq(pdev, dcdcfreq);
+		ret = axp20x_set_dcdc_freq(dev, dcdcfreq);
 		if (ret < 0) {
-			dev_err(&pdev->dev, "Error setting dcdc frequency: %d\n", ret);
+			dev_err(dev, "Error setting dcdc frequency: %d\n", ret);
 			return ret;
 		}
 
@@ -499,11 +499,12 @@ static u32 axp20x_polyphase_slave(struct axp20x_dev *axp20x)
 
 static int axp20x_regulator_probe(struct platform_device *pdev)
 {
+	struct device *dev = pdev->dev.parent;
 	struct regulator_dev *rdev;
-	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
+	struct axp20x_dev *axp20x = dev_get_drvdata(dev);
 	const struct regulator_desc *regulators;
 	struct regulator_config config = {
-		.dev = pdev->dev.parent,
+		.dev = dev,
 		.regmap = axp20x->regmap,
 		.driver_data = axp20x,
 	};
@@ -532,7 +533,7 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		dcdc5_ix = AXP22X_DCDC5;
 		dc1sw_ix = AXP22X_DC1SW;
 		dc5ldo_ix = AXP22X_DC5LDO;
-		drivevbus = of_property_read_bool(pdev->dev.parent->of_node,
+		drivevbus = of_property_read_bool(dev->of_node,
 						  "x-powers,drive-vbus-en");
 		break;
 	case AXP806_ID:
@@ -555,13 +556,13 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		dc5ldo_ix = AXP809_DC5LDO;
 		break;
 	default:
-		dev_err(&pdev->dev, "Unsupported AXP variant: %ld\n",
+		dev_err(dev, "Unsupported AXP variant: %ld\n",
 			axp20x->variant);
 		return -EINVAL;
 	}
 
 	/* This only sets the dcdc freq. Ignore any errors */
-	axp20x_regulator_parse_dt(pdev);
+	axp20x_regulator_parse_dt(dev);
 
 	for (i = 0; i < nregulators; i++) {
 		const struct regulator_desc *desc = &regulators[i];
@@ -580,7 +581,7 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		 * name.
 		 */
 		if (i == dc1sw_ix && dcdc1_name) {
-			new_desc = devm_kzalloc(&pdev->dev, sizeof(*desc),
+			new_desc = devm_kzalloc(dev, sizeof(*desc),
 						GFP_KERNEL);
 			*new_desc = regulators[i];
 			new_desc->supply_name = dcdc1_name;
@@ -588,16 +589,16 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		}
 
 		if (i == dc5ldo_ix && dcdc5_name) {
-			new_desc = devm_kzalloc(&pdev->dev, sizeof(*desc),
+			new_desc = devm_kzalloc(dev, sizeof(*desc),
 						GFP_KERNEL);
 			*new_desc = regulators[i];
 			new_desc->supply_name = dcdc5_name;
 			desc = new_desc;
 		}
 
-		rdev = devm_regulator_register(&pdev->dev, desc, &config);
+		rdev = devm_regulator_register(dev, desc, &config);
 		if (IS_ERR(rdev)) {
-			dev_err(&pdev->dev, "Failed to register %s\n",
+			dev_err(dev, "Failed to register %s\n",
 				regulators[i].name);
 
 			return PTR_ERR(rdev);
@@ -608,7 +609,7 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 					   &workmode);
 		if (!ret) {
 			if (axp20x_set_dcdc_workmode(rdev, i, workmode))
-				dev_err(&pdev->dev, "Failed to set workmode on %s\n",
+				dev_err(dev, "Failed to set workmode on %s\n",
 					rdev->desc->name);
 		}
 
@@ -630,11 +631,11 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		/* Change N_VBUSEN sense pin to DRIVEVBUS output pin */
 		regmap_update_bits(axp20x->regmap, AXP20X_OVER_TMP,
 				   AXP22X_MISC_N_VBUSEN_FUNC, 0);
-		rdev = devm_regulator_register(&pdev->dev,
+		rdev = devm_regulator_register(dev,
 					       &axp22x_drivevbus_regulator,
 					       &config);
 		if (IS_ERR(rdev)) {
-			dev_err(&pdev->dev, "Failed to register drivevbus\n");
+			dev_err(dev, "Failed to register drivevbus\n");
 			return PTR_ERR(rdev);
 		}
 	}
-- 
2.10.0
