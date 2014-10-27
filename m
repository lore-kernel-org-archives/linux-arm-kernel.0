From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 27 Oct 2014 16:03:44 +0100
Subject: [PATCH 6/8] regulator: max77686: Add external GPIO control
In-Reply-To: <1414422226-10948-1-git-send-email-k.kozlowski@samsung.com>
References: <1414422226-10948-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1414422226-10948-7-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add control over GPIO for regulators supporting this: LDO20, LDO21,
LDO22, buck8 and buck9.

This is needed for proper (and full) configuration of the Maxim 77686
PMIC without creating redundant 'regulator-fixed' entries.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/regulator/max77686.c | 101 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 96 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/max77686.c b/drivers/regulator/max77686.c
index e5738c363f07..c54a8603f5b2 100644
--- a/drivers/regulator/max77686.c
+++ b/drivers/regulator/max77686.c
@@ -26,6 +26,7 @@
 #include <linux/bug.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
+#include <linux/of_gpio.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
@@ -46,6 +47,11 @@
 #define MAX77686_DVS_UVSTEP	12500
 
 /*
+ * Value for configuring buck[89] and LDO{20,21,22} as external control.
+ * It is the same as 'off' for other regulators.
+ */
+#define MAX77686_EXT_CONTROL		0x0
+/*
  * Values used for configuring LDOs and bucks.
  * Forcing low power mode: LDO1, 3-5, 9, 13, 17-26
  */
@@ -85,6 +91,9 @@ struct max77686_data {
 	struct max77686_regulator_data *regulators;
 	int num_regulators;
 
+	/* Array of size num_regulators with GPIOs for external control. */
+	int *ext_control_gpio;
+
 	unsigned int opmode[MAX77686_REGULATORS];
 };
 
@@ -102,6 +111,28 @@ static unsigned int max77686_get_opmode_shift(int id)
 	}
 }
 
+/*
+ * When regulator is configured for external control then it
+ * replaces "normal" mode. Any change from low power mode to normal
+ * should actually change to external control.
+ * Map normal mode to proper value for such regulators.
+ */
+static int max77686_map_normal_mode(struct max77686_data *max77686, int id)
+{
+	switch (id) {
+	case MAX77686_BUCK8:
+	case MAX77686_BUCK9:
+		if (gpio_is_valid(max77686->ext_control_gpio[id]))
+			return MAX77686_EXT_CONTROL;
+
+	case MAX77686_LDO20 ... MAX77686_LDO22:
+		if (gpio_is_valid(max77686->ext_control_gpio[id]))
+			return MAX77686_EXT_CONTROL;
+	}
+
+	return MAX77686_NORMAL;
+}
+
 /* Some BUCKs and LDOs supports Normal[ON/OFF] mode during suspend */
 static int max77686_set_suspend_disable(struct regulator_dev *rdev)
 {
@@ -138,7 +169,7 @@ static int max77686_set_suspend_mode(struct regulator_dev *rdev,
 		val = MAX77686_LDO_LOWPOWER_PWRREQ;
 		break;
 	case REGULATOR_MODE_NORMAL:			/* ON in Normal Mode */
-		val = MAX77686_NORMAL;
+		val = max77686_map_normal_mode(max77686, id);
 		break;
 	default:
 		pr_warn("%s: regulator_suspend_mode : 0x%x not supported\n",
@@ -162,7 +193,7 @@ static int max77686_ldo_set_suspend_mode(struct regulator_dev *rdev,
 {
 	unsigned int val;
 	struct max77686_data *max77686 = rdev_get_drvdata(rdev);
-	int ret;
+	int ret, id = rdev_get_id(rdev);
 
 	switch (mode) {
 	case REGULATOR_MODE_STANDBY:			/* switch off */
@@ -172,7 +203,7 @@ static int max77686_ldo_set_suspend_mode(struct regulator_dev *rdev,
 		val = MAX77686_LDO_LOWPOWER_PWRREQ;
 		break;
 	case REGULATOR_MODE_NORMAL:			/* ON in Normal Mode */
-		val = MAX77686_NORMAL;
+		val = max77686_map_normal_mode(max77686, id);
 		break;
 	default:
 		pr_warn("%s: regulator_suspend_mode : 0x%x not supported\n",
@@ -186,7 +217,7 @@ static int max77686_ldo_set_suspend_mode(struct regulator_dev *rdev,
 	if (ret)
 		return ret;
 
-	max77686->opmode[rdev_get_id(rdev)] = val;
+	max77686->opmode[id] = val;
 	return 0;
 }
 
@@ -199,7 +230,7 @@ static int max77686_enable(struct regulator_dev *rdev)
 	shift = max77686_get_opmode_shift(id);
 
 	if (max77686->opmode[id] == MAX77686_OFF_PWRREQ)
-		max77686->opmode[id] = MAX77686_NORMAL;
+		max77686->opmode[id] = max77686_map_normal_mode(max77686, id);
 
 	return regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
 				  rdev->desc->enable_mask,
@@ -433,6 +464,42 @@ static const struct regulator_desc regulators[] = {
 	regulator_desc_buck(9),
 };
 
+static int max77686_enable_ext_control(struct regulator_dev *rdev)
+{
+	return regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
+					rdev->desc->enable_mask,
+					MAX77686_EXT_CONTROL);
+}
+
+static void max77686_pmic_dt_parse_ext_control_gpio(struct platform_device *pdev,
+		struct max77686_regulator_data *rdata,
+		struct max77686_data *max77686)
+{
+	int *gpio = max77686->ext_control_gpio;
+	unsigned int i;
+	unsigned int valid_regulators[5] = { MAX77686_LDO20, MAX77686_LDO21,
+		MAX77686_LDO22, MAX77686_BUCK8, MAX77686_BUCK9 };
+
+	/*
+	 * 0 is a valid GPIO so initialize all GPIOs to negative value
+	 * to indicate that external control won't be used for this regulator.
+	 */
+	for (i = 0; i < max77686->num_regulators; i++)
+		max77686->ext_control_gpio[i] = -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(valid_regulators); i++) {
+		unsigned int reg = valid_regulators[i];
+
+		if (!rdata[reg].initdata || !rdata[reg].of_node)
+			continue;
+
+		gpio[reg] = of_get_named_gpio(rdata[reg].of_node, "gpio", 0);
+		if (gpio_is_valid(gpio[reg]))
+			dev_dbg(&pdev->dev, "Using GPIO %d for ext-control over %d/%s\n",
+				gpio[reg], reg, rdata[reg].of_node->name);
+	}
+}
+
 static int max77686_pmic_dt_parse(struct platform_device *pdev,
 					struct max77686_data *max77686)
 {
@@ -457,6 +524,14 @@ static int max77686_pmic_dt_parse(struct platform_device *pdev,
 		return -ENOMEM;
 	}
 
+	max77686->ext_control_gpio = devm_kmalloc_array(&pdev->dev,
+			max77686->num_regulators,
+			sizeof(*max77686->ext_control_gpio), GFP_KERNEL);
+	if (!max77686->ext_control_gpio) {
+		of_node_put(regulators_np);
+		return -ENOMEM;
+	}
+
 	for (i = 0; i < max77686->num_regulators; i++) {
 		rmatch.name = regulators[i].name;
 		rmatch.init_data = NULL;
@@ -466,7 +541,9 @@ static int max77686_pmic_dt_parse(struct platform_device *pdev,
 		rdata[i].of_node = rmatch.of_node;
 	}
 
+	max77686_pmic_dt_parse_ext_control_gpio(pdev, rdata, max77686);
 	max77686->regulators = rdata;
+
 	of_node_put(regulators_np);
 
 	return 0;
@@ -499,6 +576,7 @@ static int max77686_pmic_probe(struct platform_device *pdev)
 	config.dev = &pdev->dev;
 	config.regmap = iodev->regmap;
 	config.driver_data = max77686;
+	config.ena_gpio_flags = GPIOF_OUT_INIT_HIGH;
 	platform_set_drvdata(pdev, max77686);
 
 	for (i = 0; i < MAX77686_REGULATORS; i++) {
@@ -506,6 +584,8 @@ static int max77686_pmic_probe(struct platform_device *pdev)
 
 		config.init_data = max77686->regulators[i].initdata;
 		config.of_node = max77686->regulators[i].of_node;
+		config.ena_gpio = max77686->ext_control_gpio[i];
+		config.ena_gpio_initialized = true;
 
 		max77686->opmode[i] = MAX77686_NORMAL;
 
@@ -516,6 +596,17 @@ static int max77686_pmic_probe(struct platform_device *pdev)
 				"regulator init failed for %d\n", i);
 			return PTR_ERR(rdev);
 		}
+
+		if (gpio_is_valid(config.ena_gpio)) {
+			ret = max77686_enable_ext_control(rdev);
+
+			if (ret < 0) {
+				dev_err(&pdev->dev,
+					"regulator enable ext control failed for %d\n",
+					i);
+				return ret;
+			}
+		}
 	}
 
 	return 0;
-- 
1.9.1
