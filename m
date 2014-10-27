From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 27 Oct 2014 13:11:48 +0100
Subject: [PATCH v5 2/4] regulator: max77686: Store opmode non-shifted
In-Reply-To: <1414411911-5539-1-git-send-email-k.kozlowski@samsung.com>
References: <1414411911-5539-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1414411911-5539-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce simple helper for calculating the shift for OPMODE field in
registers. This allows storing the current value of opmode in
non-shifted form and simplifies a little set_suspend_disable and enable
functions. Additionally this will allow adding support LDOs to the
existing set_suspend_disable function.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Suggested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/regulator/max77686.c | 49 ++++++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/regulator/max77686.c b/drivers/regulator/max77686.c
index c625a8a7940d..2ebc4257425b 100644
--- a/drivers/regulator/max77686.c
+++ b/drivers/regulator/max77686.c
@@ -85,20 +85,32 @@ struct max77686_data {
 	unsigned int opmode[MAX77686_REGULATORS];
 };
 
+static unsigned int max77686_get_opmode_shift(int id)
+{
+	switch (id) {
+	case MAX77686_BUCK1:
+	case MAX77686_BUCK5 ... MAX77686_BUCK9:
+		return 0;
+	case MAX77686_BUCK2 ... MAX77686_BUCK4:
+		return MAX77686_OPMODE_BUCK234_SHIFT;
+	default:
+		/* all LDOs */
+		return MAX77686_OPMODE_SHIFT;
+	}
+}
+
 /* Some BUCKS supports Normal[ON/OFF] mode during suspend */
 static int max77686_buck_set_suspend_disable(struct regulator_dev *rdev)
 {
-	unsigned int val;
+	unsigned int val, shift;
 	struct max77686_data *max77686 = rdev_get_drvdata(rdev);
 	int ret, id = rdev_get_id(rdev);
 
-	if (id == MAX77686_BUCK1)
-		val = MAX77686_OFF_PWRREQ;
-	else
-		val = MAX77686_OFF_PWRREQ << MAX77686_OPMODE_BUCK234_SHIFT;
+	shift = max77686_get_opmode_shift(id);
+	val = MAX77686_OFF_PWRREQ;
 
 	ret = regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
-				 rdev->desc->enable_mask, val);
+				 rdev->desc->enable_mask, val << shift);
 	if (ret)
 		return ret;
 
@@ -120,10 +132,10 @@ static int max77686_set_suspend_mode(struct regulator_dev *rdev,
 
 	switch (mode) {
 	case REGULATOR_MODE_IDLE:			/* ON in LP Mode */
-		val = MAX77686_LDO_LOWPOWER_PWRREQ << MAX77686_OPMODE_SHIFT;
+		val = MAX77686_LDO_LOWPOWER_PWRREQ;
 		break;
 	case REGULATOR_MODE_NORMAL:			/* ON in Normal Mode */
-		val = MAX77686_NORMAL << MAX77686_OPMODE_SHIFT;
+		val = MAX77686_NORMAL;
 		break;
 	default:
 		pr_warn("%s: regulator_suspend_mode : 0x%x not supported\n",
@@ -132,7 +144,8 @@ static int max77686_set_suspend_mode(struct regulator_dev *rdev,
 	}
 
 	ret = regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
-				  rdev->desc->enable_mask, val);
+				  rdev->desc->enable_mask,
+				  val << MAX77686_OPMODE_SHIFT);
 	if (ret)
 		return ret;
 
@@ -150,13 +163,13 @@ static int max77686_ldo_set_suspend_mode(struct regulator_dev *rdev,
 
 	switch (mode) {
 	case REGULATOR_MODE_STANDBY:			/* switch off */
-		val = MAX77686_OFF_PWRREQ << MAX77686_OPMODE_SHIFT;
+		val = MAX77686_OFF_PWRREQ;
 		break;
 	case REGULATOR_MODE_IDLE:			/* ON in LP Mode */
-		val = MAX77686_LDO_LOWPOWER_PWRREQ << MAX77686_OPMODE_SHIFT;
+		val = MAX77686_LDO_LOWPOWER_PWRREQ;
 		break;
 	case REGULATOR_MODE_NORMAL:			/* ON in Normal Mode */
-		val = MAX77686_NORMAL << MAX77686_OPMODE_SHIFT;
+		val = MAX77686_NORMAL;
 		break;
 	default:
 		pr_warn("%s: regulator_suspend_mode : 0x%x not supported\n",
@@ -165,7 +178,8 @@ static int max77686_ldo_set_suspend_mode(struct regulator_dev *rdev,
 	}
 
 	ret = regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
-				 rdev->desc->enable_mask, val);
+				 rdev->desc->enable_mask,
+				 val << MAX77686_OPMODE_SHIFT);
 	if (ret)
 		return ret;
 
@@ -176,10 +190,14 @@ static int max77686_ldo_set_suspend_mode(struct regulator_dev *rdev,
 static int max77686_enable(struct regulator_dev *rdev)
 {
 	struct max77686_data *max77686 = rdev_get_drvdata(rdev);
+	unsigned int shift;
+	int id = rdev_get_id(rdev);
+
+	shift = max77686_get_opmode_shift(id);
 
 	return regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
 				  rdev->desc->enable_mask,
-				  max77686->opmode[rdev_get_id(rdev)]);
+				  max77686->opmode[id] << shift);
 }
 
 static int max77686_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
@@ -495,7 +513,8 @@ static int max77686_pmic_probe(struct platform_device *pdev)
 		config.init_data = pdata->regulators[i].initdata;
 		config.of_node = pdata->regulators[i].of_node;
 
-		max77686->opmode[i] = regulators[i].enable_mask;
+		max77686->opmode[i] = regulators[i].enable_mask >>
+						max77686_get_opmode_shift(i);
 		rdev = devm_regulator_register(&pdev->dev,
 						&regulators[i], &config);
 		if (IS_ERR(rdev)) {
-- 
1.9.1
