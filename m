From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 10 Jan 2015 00:23:44 +0800
Subject: [PATCH 2/2] regulator: axp20x: Migrate to regulator core's simplified
 DT parsing code
In-Reply-To: <1420820624-10275-1-git-send-email-wens@csie.org>
References: <1420820624-10275-1-git-send-email-wens@csie.org>
Message-ID: <1420820624-10275-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A common simplified DT parsing code for regulators was introduced in
commit a0c7b164ad11 ("regulator: of: Provide simplified DT parsing
method"). This is very similar to our own code, so get rid of ours
and use the common code.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/regulator/axp20x-regulator.c | 44 +++++++-----------------------------
 1 file changed, 8 insertions(+), 36 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 441ae01123dd..e4331f5e5d7d 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -152,22 +152,6 @@ static const struct regulator_desc axp20x_regulators[] = {
 		       AXP20X_IO_ENABLED, AXP20X_IO_DISABLED),
 };
 
-#define AXP_MATCH(_name, _id) \
-	[AXP20X_##_id] = { \
-		.name		= #_name, \
-		.driver_data	= (void *) &axp20x_regulators[AXP20X_##_id], \
-	}
-
-static struct of_regulator_match axp20x_matches[] = {
-	AXP_MATCH(dcdc2, DCDC2),
-	AXP_MATCH(dcdc3, DCDC3),
-	AXP_MATCH(ldo1, LDO1),
-	AXP_MATCH(ldo2, LDO2),
-	AXP_MATCH(ldo3, LDO3),
-	AXP_MATCH(ldo4, LDO4),
-	AXP_MATCH(ldo5, LDO5),
-};
-
 static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
 {
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
@@ -202,13 +186,6 @@ static int axp20x_regulator_parse_dt(struct platform_device *pdev)
 	if (!regulators) {
 		dev_warn(&pdev->dev, "regulators node not found\n");
 	} else {
-		ret = of_regulator_match(&pdev->dev, regulators, axp20x_matches,
-					 ARRAY_SIZE(axp20x_matches));
-		if (ret < 0) {
-			dev_err(&pdev->dev, "Error parsing regulator init data: %d\n", ret);
-			return ret;
-		}
-
 		dcdcfreq = 1500;
 		of_property_read_u32(regulators, "x-powers,dcdc-freq", &dcdcfreq);
 		ret = axp20x_set_dcdc_freq(pdev, dcdcfreq);
@@ -242,23 +219,17 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 {
 	struct regulator_dev *rdev;
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
-	struct regulator_config config = { };
-	struct regulator_init_data *init_data;
+	struct regulator_config config = {
+		.dev = pdev->dev.parent,
+		.regmap = axp20x->regmap,
+	};
 	int ret, i;
 	u32 workmode;
 
-	ret = axp20x_regulator_parse_dt(pdev);
-	if (ret)
-		return ret;
+	/* This only sets the dcdc freq. Ignore any errors */
+	axp20x_regulator_parse_dt(pdev);
 
 	for (i = 0; i < AXP20X_REG_ID_MAX; i++) {
-		init_data = axp20x_matches[i].init_data;
-
-		config.dev = pdev->dev.parent;
-		config.init_data = init_data;
-		config.regmap = axp20x->regmap;
-		config.of_node = axp20x_matches[i].of_node;
-
 		rdev = devm_regulator_register(&pdev->dev, &axp20x_regulators[i],
 					       &config);
 		if (IS_ERR(rdev)) {
@@ -268,7 +239,8 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 			return PTR_ERR(rdev);
 		}
 
-		ret = of_property_read_u32(axp20x_matches[i].of_node, "x-powers,dcdc-workmode",
+		ret = of_property_read_u32(rdev->dev.of_node,
+					   "x-powers,dcdc-workmode",
 					   &workmode);
 		if (!ret) {
 			if (axp20x_set_dcdc_workmode(rdev, i, workmode))
-- 
2.1.4
