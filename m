From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 27 Nov 2014 12:20:51 +0100
Subject: [PATCH v4 5/7] regulator: max77686: Add GPIO control
In-Reply-To: <1417087253-12306-1-git-send-email-k.kozlowski@samsung.com>
References: <1417087253-12306-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1417087253-12306-6-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add enable control over GPIO for regulators supporting this: LDO20,
LDO21, LDO22, buck8 and buck9.

This is needed for proper (and full) configuration of the Maxim 77686
PMIC without creating redundant 'regulator-fixed' entries.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/regulator/max77686.c | 58 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/max77686.c b/drivers/regulator/max77686.c
index 10d206266ac2..0d6bddad0ef4 100644
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
+ * Value for configuring buck[89] and LDO{20,21,22} as GPIO control.
+ * It is the same as 'off' for other regulators.
+ */
+#define MAX77686_GPIO_CONTROL		0x0
+/*
  * Values used for configuring LDOs and bucks.
  * Forcing low power mode: LDO1, 3-5, 9, 13, 17-26
  */
@@ -82,6 +88,8 @@ enum max77686_ramp_rate {
 };
 
 struct max77686_data {
+	unsigned long long gpio_enabled:MAX77686_REGULATORS;
+
 	/* Array indexed by regulator id */
 	unsigned int opmode[MAX77686_REGULATORS];
 };
@@ -100,6 +108,26 @@ static unsigned int max77686_get_opmode_shift(int id)
 	}
 }
 
+/*
+ * When regulator is configured for GPIO control then it
+ * replaces "normal" mode. Any change from low power mode to normal
+ * should actually change to GPIO control.
+ * Map normal mode to proper value for such regulators.
+ */
+static unsigned int max77686_map_normal_mode(struct max77686_data *max77686,
+					     int id)
+{
+	switch (id) {
+	case MAX77686_BUCK8:
+	case MAX77686_BUCK9:
+	case MAX77686_LDO20 ... MAX77686_LDO22:
+		if (max77686->gpio_enabled & (1 << id))
+			return MAX77686_GPIO_CONTROL;
+	}
+
+	return MAX77686_NORMAL;
+}
+
 /* Some BUCKs and LDOs supports Normal[ON/OFF] mode during suspend */
 static int max77686_set_suspend_disable(struct regulator_dev *rdev)
 {
@@ -136,7 +164,7 @@ static int max77686_set_suspend_mode(struct regulator_dev *rdev,
 		val = MAX77686_LDO_LOWPOWER_PWRREQ;
 		break;
 	case REGULATOR_MODE_NORMAL:			/* ON in Normal Mode */
-		val = MAX77686_NORMAL;
+		val = max77686_map_normal_mode(max77686, id);
 		break;
 	default:
 		pr_warn("%s: regulator_suspend_mode : 0x%x not supported\n",
@@ -160,7 +188,7 @@ static int max77686_ldo_set_suspend_mode(struct regulator_dev *rdev,
 {
 	unsigned int val;
 	struct max77686_data *max77686 = rdev_get_drvdata(rdev);
-	int ret;
+	int ret, id = rdev_get_id(rdev);
 
 	switch (mode) {
 	case REGULATOR_MODE_STANDBY:			/* switch off */
@@ -170,7 +198,7 @@ static int max77686_ldo_set_suspend_mode(struct regulator_dev *rdev,
 		val = MAX77686_LDO_LOWPOWER_PWRREQ;
 		break;
 	case REGULATOR_MODE_NORMAL:			/* ON in Normal Mode */
-		val = MAX77686_NORMAL;
+		val = max77686_map_normal_mode(max77686, id);
 		break;
 	default:
 		pr_warn("%s: regulator_suspend_mode : 0x%x not supported\n",
@@ -184,7 +212,7 @@ static int max77686_ldo_set_suspend_mode(struct regulator_dev *rdev,
 	if (ret)
 		return ret;
 
-	max77686->opmode[rdev_get_id(rdev)] = val;
+	max77686->opmode[id] = val;
 	return 0;
 }
 
@@ -197,7 +225,7 @@ static int max77686_enable(struct regulator_dev *rdev)
 	shift = max77686_get_opmode_shift(id);
 
 	if (max77686->opmode[id] == MAX77686_OFF_PWRREQ)
-		max77686->opmode[id] = MAX77686_NORMAL;
+		max77686->opmode[id] = max77686_map_normal_mode(max77686, id);
 
 	return regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
 				  rdev->desc->enable_mask,
@@ -229,6 +257,25 @@ static int max77686_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
 				  MAX77686_RAMP_RATE_MASK, ramp_value << 6);
 }
 
+static int max77686_enable_gpio_control(struct regulator_dev *rdev)
+{
+	struct max77686_data *max77686 = rdev_get_drvdata(rdev);
+	int id = rdev_get_id(rdev);
+
+	switch (id) {
+	case MAX77686_BUCK8:
+	case MAX77686_BUCK9:
+	case MAX77686_LDO20 ... MAX77686_LDO22:
+		max77686->gpio_enabled |= (1 << id);
+
+		return regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
+					rdev->desc->enable_mask,
+					MAX77686_GPIO_CONTROL);
+	}
+
+	return -EINVAL;
+}
+
 static struct regulator_ops max77686_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
@@ -239,6 +286,7 @@ static struct regulator_ops max77686_ops = {
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
 	.set_suspend_mode	= max77686_set_suspend_mode,
+	.set_ena_gpio		= max77686_enable_gpio_control,
 };
 
 static struct regulator_ops max77686_ldo_ops = {
-- 
1.9.1
