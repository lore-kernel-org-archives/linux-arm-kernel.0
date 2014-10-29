From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 29 Oct 2014 16:06:41 +0100
Subject: [PATCH v2 3/8] regulator: max77686: Remove support for board files
In-Reply-To: <1414595206-1437-1-git-send-email-k.kozlowski@samsung.com>
References: <1414595206-1437-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1414595206-1437-4-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver is used only on Exynos based boards with DTS support.
Convert the driver to DTS-only version. Parse all regulators at once,
not one-by-one. Remove dependency on data provided by max77686 MFD
driver.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/regulator/max77686.c | 84 +++++++++++++++++---------------------------
 1 file changed, 33 insertions(+), 51 deletions(-)

diff --git a/drivers/regulator/max77686.c b/drivers/regulator/max77686.c
index 27c5f4556044..7ec9b4e5b917 100644
--- a/drivers/regulator/max77686.c
+++ b/drivers/regulator/max77686.c
@@ -428,15 +428,14 @@ static const struct regulator_desc regulators[] = {
 	regulator_desc_buck(9),
 };
 
-#ifdef CONFIG_OF
-static int max77686_pmic_dt_parse_pdata(struct platform_device *pdev,
-					struct max77686_platform_data *pdata)
+static int max77686_pmic_dt_parse(struct platform_device *pdev,
+				struct of_regulator_match *rdata)
 {
 	struct max77686_dev *iodev = dev_get_drvdata(pdev->dev.parent);
 	struct device_node *pmic_np, *regulators_np;
-	struct max77686_regulator_data *rdata;
-	struct of_regulator_match rmatch;
-	unsigned int i;
+	int ret = 0;
+
+	BUILD_BUG_ON(MAX77686_REGULATORS != ARRAY_SIZE(regulators));
 
 	pmic_np = iodev->dev->of_node;
 	regulators_np = of_get_child_by_name(pmic_np, "voltage-regulators");
@@ -445,63 +444,31 @@ static int max77686_pmic_dt_parse_pdata(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
-	pdata->num_regulators = ARRAY_SIZE(regulators);
-	rdata = devm_kzalloc(&pdev->dev, sizeof(*rdata) *
-			     pdata->num_regulators, GFP_KERNEL);
-	if (!rdata) {
-		of_node_put(regulators_np);
-		return -ENOMEM;
-	}
 
-	for (i = 0; i < pdata->num_regulators; i++) {
-		rmatch.name = regulators[i].name;
-		rmatch.init_data = NULL;
-		rmatch.of_node = NULL;
-		of_regulator_match(&pdev->dev, regulators_np, &rmatch, 1);
-		rdata[i].initdata = rmatch.init_data;
-		rdata[i].of_node = rmatch.of_node;
+	ret = of_regulator_match(&pdev->dev, regulators_np, rdata,
+			MAX77686_REGULATORS);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "error parsing regulators data\n");
+		of_node_put(regulators_np);
+		return ret;
 	}
+	/* else: don't care how many regulators were parsed from DTS. */
 
-	pdata->regulators = rdata;
 	of_node_put(regulators_np);
 
 	return 0;
 }
-#else
-static int max77686_pmic_dt_parse_pdata(struct platform_device *pdev,
-					struct max77686_platform_data *pdata)
-{
-	return 0;
-}
-#endif /* CONFIG_OF */
 
 static int max77686_pmic_probe(struct platform_device *pdev)
 {
 	struct max77686_dev *iodev = dev_get_drvdata(pdev->dev.parent);
-	struct max77686_platform_data *pdata = dev_get_platdata(iodev->dev);
 	struct max77686_data *max77686;
 	int i, ret = 0;
 	struct regulator_config config = { };
+	struct of_regulator_match *rdata;
 
 	dev_dbg(&pdev->dev, "%s\n", __func__);
 
-	if (!pdata) {
-		dev_err(&pdev->dev, "no platform data found for regulator\n");
-		return -ENODEV;
-	}
-
-	if (iodev->dev->of_node) {
-		ret = max77686_pmic_dt_parse_pdata(pdev, pdata);
-		if (ret)
-			return ret;
-	}
-
-	if (pdata->num_regulators != MAX77686_REGULATORS) {
-		dev_err(&pdev->dev,
-			"Invalid initial data for regulator's initialiation\n");
-		return -EINVAL;
-	}
-
 	max77686 = devm_kzalloc(&pdev->dev, sizeof(struct max77686_data),
 				GFP_KERNEL);
 	if (!max77686)
@@ -512,25 +479,40 @@ static int max77686_pmic_probe(struct platform_device *pdev)
 	config.driver_data = max77686;
 	platform_set_drvdata(pdev, max77686);
 
+	rdata = kzalloc(sizeof(*rdata) * MAX77686_REGULATORS, GFP_KERNEL);
+	if (!rdata)
+		return -ENOMEM;
+
+	for (i = 0; i < MAX77686_REGULATORS; i++)
+		rdata[i].name = regulators[i].name;
+
+	ret = max77686_pmic_dt_parse(pdev, rdata);
+	if (ret)
+		goto out;
+
 	for (i = 0; i < MAX77686_REGULATORS; i++) {
 		struct regulator_dev *rdev;
 		int id = regulators[i].id;
 
-		config.init_data = pdata->regulators[i].initdata;
-		config.of_node = pdata->regulators[i].of_node;
+		config.init_data = rdata[i].init_data;
+		config.of_node = rdata[i].of_node;
 
 		max77686->opmode[id] = regulators[i].enable_mask >>
 						max77686_get_opmode_shift(id);
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
 
 static const struct platform_device_id max77686_pmic_id[] = {
-- 
1.9.1
