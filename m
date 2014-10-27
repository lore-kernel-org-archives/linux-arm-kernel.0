From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 27 Oct 2014 16:03:40 +0100
Subject: [PATCH 2/8] regulator: max77686: Remove support for board files
In-Reply-To: <1414422226-10948-1-git-send-email-k.kozlowski@samsung.com>
References: <1414422226-10948-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1414422226-10948-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver is used only on Exynos4 based boards with DTS support.
Convert the driver to DTS-only version.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/regulator/max77686.c | 51 +++++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 32 deletions(-)

diff --git a/drivers/regulator/max77686.c b/drivers/regulator/max77686.c
index c6bf6f79bd2a..04af7a2b0910 100644
--- a/drivers/regulator/max77686.c
+++ b/drivers/regulator/max77686.c
@@ -82,6 +82,9 @@ enum max77686_ramp_rate {
 };
 
 struct max77686_data {
+	struct max77686_regulator_data *regulators;
+	int num_regulators;
+
 	unsigned int opmode[MAX77686_REGULATORS];
 };
 
@@ -430,9 +433,8 @@ static struct regulator_desc regulators[] = {
 	regulator_desc_buck(9),
 };
 
-#ifdef CONFIG_OF
-static int max77686_pmic_dt_parse_pdata(struct platform_device *pdev,
-					struct max77686_platform_data *pdata)
+static int max77686_pmic_dt_parse(struct platform_device *pdev,
+					struct max77686_data *max77686)
 {
 	struct max77686_dev *iodev = dev_get_drvdata(pdev->dev.parent);
 	struct device_node *pmic_np, *regulators_np;
@@ -447,15 +449,15 @@ static int max77686_pmic_dt_parse_pdata(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
-	pdata->num_regulators = ARRAY_SIZE(regulators);
+	max77686->num_regulators = ARRAY_SIZE(regulators);
 	rdata = devm_kzalloc(&pdev->dev, sizeof(*rdata) *
-			     pdata->num_regulators, GFP_KERNEL);
+			     max77686->num_regulators, GFP_KERNEL);
 	if (!rdata) {
 		of_node_put(regulators_np);
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < pdata->num_regulators; i++) {
+	for (i = 0; i < max77686->num_regulators; i++) {
 		rmatch.name = regulators[i].name;
 		rmatch.init_data = NULL;
 		rmatch.of_node = NULL;
@@ -464,51 +466,36 @@ static int max77686_pmic_dt_parse_pdata(struct platform_device *pdev,
 		rdata[i].of_node = rmatch.of_node;
 	}
 
-	pdata->regulators = rdata;
+	max77686->regulators = rdata;
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
 
 	dev_dbg(&pdev->dev, "%s\n", __func__);
 
-	if (!pdata) {
-		dev_err(&pdev->dev, "no platform data found for regulator\n");
-		return -ENODEV;
-	}
+	max77686 = devm_kzalloc(&pdev->dev, sizeof(struct max77686_data),
+				GFP_KERNEL);
+	if (!max77686)
+		return -ENOMEM;
 
-	if (iodev->dev->of_node) {
-		ret = max77686_pmic_dt_parse_pdata(pdev, pdata);
-		if (ret)
-			return ret;
-	}
+	ret = max77686_pmic_dt_parse(pdev, max77686);
+	if (ret)
+		return ret;
 
-	if (pdata->num_regulators != MAX77686_REGULATORS) {
+	if (max77686->num_regulators != MAX77686_REGULATORS) {
 		dev_err(&pdev->dev,
 			"Invalid initial data for regulator's initialiation\n");
 		return -EINVAL;
 	}
 
-	max77686 = devm_kzalloc(&pdev->dev, sizeof(struct max77686_data),
-				GFP_KERNEL);
-	if (!max77686)
-		return -ENOMEM;
-
 	config.dev = &pdev->dev;
 	config.regmap = iodev->regmap;
 	config.driver_data = max77686;
@@ -517,8 +504,8 @@ static int max77686_pmic_probe(struct platform_device *pdev)
 	for (i = 0; i < MAX77686_REGULATORS; i++) {
 		struct regulator_dev *rdev;
 
-		config.init_data = pdata->regulators[i].initdata;
-		config.of_node = pdata->regulators[i].of_node;
+		config.init_data = max77686->regulators[i].initdata;
+		config.of_node = max77686->regulators[i].of_node;
 
 		max77686->opmode[i] = regulators[i].enable_mask >>
 						max77686_get_opmode_shift(i);
-- 
1.9.1
