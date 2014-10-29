From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 29 Oct 2014 16:06:40 +0100
Subject: [RFT v2 2/8] regulator: max77802: Remove support for board files
In-Reply-To: <1414595206-1437-1-git-send-email-k.kozlowski@samsung.com>
References: <1414595206-1437-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1414595206-1437-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver is used only on Exynos based boards with DTS support.
Convert the driver to DTS-only version. Parse all regulators at once,
not one-by-one. Remove dependency on data provided by max77686 MFD
driver.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/regulator/max77802.c | 87 +++++++++++++++++---------------------------
 1 file changed, 34 insertions(+), 53 deletions(-)

diff --git a/drivers/regulator/max77802.c b/drivers/regulator/max77802.c
index b9958d927297..e3390c7db5ae 100644
--- a/drivers/regulator/max77802.c
+++ b/drivers/regulator/max77802.c
@@ -70,6 +70,7 @@ static unsigned int ramp_table_77802_4bit[] = {
 };
 
 struct max77802_regulator_prv {
+	/* Array indexed by regulator id */
 	unsigned int opmode[MAX77802_REG_MAX];
 };
 
@@ -513,15 +514,14 @@ static struct regulator_desc regulators[] = {
 	regulator_77802_desc_n_ldo(35, 2, 1),
 };
 
-#ifdef CONFIG_OF
-static int max77802_pmic_dt_parse_pdata(struct platform_device *pdev,
-					struct max77686_platform_data *pdata)
+static int max77802_pmic_dt_parse(struct platform_device *pdev,
+				struct of_regulator_match *rdata)
 {
 	struct max77686_dev *iodev = dev_get_drvdata(pdev->dev.parent);
 	struct device_node *pmic_np, *regulators_np;
-	struct max77686_regulator_data *rdata;
-	struct of_regulator_match rmatch;
-	unsigned int i;
+	int ret = 0;
+
+	BUILD_BUG_ON(MAX77802_REG_MAX != ARRAY_SIZE(regulators));
 
 	pmic_np = iodev->dev->of_node;
 	regulators_np = of_get_child_by_name(pmic_np, "regulators");
@@ -530,55 +530,27 @@ static int max77802_pmic_dt_parse_pdata(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
-	pdata->num_regulators = ARRAY_SIZE(regulators);
-	rdata = devm_kzalloc(&pdev->dev, sizeof(*rdata) *
-			     pdata->num_regulators, GFP_KERNEL);
-	if (!rdata) {
+	ret = of_regulator_match(&pdev->dev, regulators_np, rdata,
+			MAX77802_REG_MAX);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "error parsing regulators data\n");
 		of_node_put(regulators_np);
-		return -ENOMEM;
-	}
-
-	for (i = 0; i < pdata->num_regulators; i++) {
-		rmatch.name = regulators[i].name;
-		rmatch.init_data = NULL;
-		rmatch.of_node = NULL;
-		if (of_regulator_match(&pdev->dev, regulators_np, &rmatch,
-				       1) != 1) {
-			dev_warn(&pdev->dev, "No matching regulator for '%s'\n",
-				 rmatch.name);
-			continue;
-		}
-		rdata[i].initdata = rmatch.init_data;
-		rdata[i].of_node = rmatch.of_node;
-		rdata[i].id = regulators[i].id;
+		return ret;
 	}
+	/* else: don't care how many regulators were parsed from DTS. */
 
-	pdata->regulators = rdata;
 	of_node_put(regulators_np);
 
 	return 0;
 }
-#else
-static int max77802_pmic_dt_parse_pdata(struct platform_device *pdev,
-					struct max77686_platform_data *pdata)
-{
-	return 0;
-}
-#endif /* CONFIG_OF */
 
 static int max77802_pmic_probe(struct platform_device *pdev)
 {
 	struct max77686_dev *iodev = dev_get_drvdata(pdev->dev.parent);
-	struct max77686_platform_data *pdata = dev_get_platdata(iodev->dev);
 	struct max77802_regulator_prv *max77802;
 	int i, ret = 0, val;
 	struct regulator_config config = { };
-
-	/* This is allocated by the MFD driver */
-	if (!pdata) {
-		dev_err(&pdev->dev, "no platform data found for regulator\n");
-		return -ENODEV;
-	}
+	struct of_regulator_match *rdata;
 
 	max77802 = devm_kzalloc(&pdev->dev,
 				sizeof(struct max77802_regulator_prv),
@@ -586,24 +558,29 @@ static int max77802_pmic_probe(struct platform_device *pdev)
 	if (!max77802)
 		return -ENOMEM;
 
-	if (iodev->dev->of_node) {
-		ret = max77802_pmic_dt_parse_pdata(pdev, pdata);
-		if (ret)
-			return ret;
-	}
-
 	config.dev = iodev->dev;
 	config.regmap = iodev->regmap;
 	config.driver_data = max77802;
 	platform_set_drvdata(pdev, max77802);
 
+	rdata = kzalloc(sizeof(*rdata) * MAX77802_REG_MAX, GFP_KERNEL);
+	if (!rdata)
+		return -ENOMEM;
+
+	for (i = 0; i < MAX77802_REG_MAX; i++)
+		rdata[i].name = regulators[i].name;
+
+	ret = max77802_pmic_dt_parse(pdev, rdata);
+	if (ret)
+		goto out;
+
 	for (i = 0; i < MAX77802_REG_MAX; i++) {
 		struct regulator_dev *rdev;
-		int id = pdata->regulators[i].id;
+		int id = regulators[i].id;
 		int shift = max77802_get_opmode_shift(id);
 
-		config.init_data = pdata->regulators[i].initdata;
-		config.of_node = pdata->regulators[i].of_node;
+		config.init_data = rdata[i].init_data;
+		config.of_node = rdata[i].of_node;
 
 		ret = regmap_read(iodev->regmap, regulators[i].enable_reg, &val);
 		val = val >> shift & MAX77802_OPMODE_MASK;
@@ -621,13 +598,17 @@ static int max77802_pmic_probe(struct platform_device *pdev)
 		rdev = devm_regulator_register(&pdev->dev,
 					       &regulators[i], &config);
 		if (IS_ERR(rdev)) {
+			ret = PTR_ERR(rdev);
 			dev_err(&pdev->dev,
-				"regulator init failed for %d\n", i);
-			return PTR_ERR(rdev);
+				"regulator init failed for %d: %d\n", i, ret);
+			goto out;
 		}
 	}
 
-	return 0;
+out:
+	kfree(rdata);
+
+	return ret;
 }
 
 static const struct platform_device_id max77802_pmic_id[] = {
-- 
1.9.1
