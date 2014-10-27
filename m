From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 27 Oct 2014 16:03:39 +0100
Subject: [PATCH 1/8] regulator: max77802: Remove support for board files
In-Reply-To: <1414422226-10948-1-git-send-email-k.kozlowski@samsung.com>
References: <1414422226-10948-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1414422226-10948-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver is used only on Exynos based boards with DTS support.
Convert the driver to DTS-only version.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/regulator/max77802.c | 44 +++++++++++++++-----------------------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff --git a/drivers/regulator/max77802.c b/drivers/regulator/max77802.c
index 5839c4509e1f..61d03e9f8acf 100644
--- a/drivers/regulator/max77802.c
+++ b/drivers/regulator/max77802.c
@@ -70,6 +70,9 @@ static unsigned int ramp_table_77802_4bit[] = {
 };
 
 struct max77802_regulator_prv {
+	struct max77686_regulator_data *regulators;
+	int num_regulators;
+
 	unsigned int opmode[MAX77802_REG_MAX];
 };
 
@@ -517,9 +520,8 @@ static struct regulator_desc regulators[] = {
 	regulator_77802_desc_n_ldo(35, 2, 1),
 };
 
-#ifdef CONFIG_OF
-static int max77802_pmic_dt_parse_pdata(struct platform_device *pdev,
-					struct max77686_platform_data *pdata)
+static int max77802_pmic_dt_parse(struct platform_device *pdev,
+				struct max77802_regulator_prv *max77802)
 {
 	struct max77686_dev *iodev = dev_get_drvdata(pdev->dev.parent);
 	struct device_node *pmic_np, *regulators_np;
@@ -534,15 +536,15 @@ static int max77802_pmic_dt_parse_pdata(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
-	pdata->num_regulators = ARRAY_SIZE(regulators);
+	max77802->num_regulators = ARRAY_SIZE(regulators);
 	rdata = devm_kzalloc(&pdev->dev, sizeof(*rdata) *
-			     pdata->num_regulators, GFP_KERNEL);
+			     max77802->num_regulators, GFP_KERNEL);
 	if (!rdata) {
 		of_node_put(regulators_np);
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < pdata->num_regulators; i++) {
+	for (i = 0; i < max77802->num_regulators; i++) {
 		rmatch.name = regulators[i].name;
 		rmatch.init_data = NULL;
 		rmatch.of_node = NULL;
@@ -557,44 +559,28 @@ static int max77802_pmic_dt_parse_pdata(struct platform_device *pdev,
 		rdata[i].id = regulators[i].id;
 	}
 
-	pdata->regulators = rdata;
+	max77802->regulators = rdata;
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
 
-	/* This is allocated by the MFD driver */
-	if (!pdata) {
-		dev_err(&pdev->dev, "no platform data found for regulator\n");
-		return -ENODEV;
-	}
-
 	max77802 = devm_kzalloc(&pdev->dev,
 				sizeof(struct max77802_regulator_prv),
 				GFP_KERNEL);
 	if (!max77802)
 		return -ENOMEM;
 
-	if (iodev->dev->of_node) {
-		ret = max77802_pmic_dt_parse_pdata(pdev, pdata);
-		if (ret)
-			return ret;
-	}
+	ret = max77802_pmic_dt_parse(pdev, max77802);
+	if (ret)
+		return ret;
 
 	config.dev = iodev->dev;
 	config.regmap = iodev->regmap;
@@ -603,11 +589,11 @@ static int max77802_pmic_probe(struct platform_device *pdev)
 
 	for (i = 0; i < MAX77802_REG_MAX; i++) {
 		struct regulator_dev *rdev;
-		int id = pdata->regulators[i].id;
+		int id = max77802->regulators[i].id;
 		int shift = max77802_get_opmode_shift(id);
 
-		config.init_data = pdata->regulators[i].initdata;
-		config.of_node = pdata->regulators[i].of_node;
+		config.init_data = max77802->regulators[i].initdata;
+		config.of_node = max77802->regulators[i].of_node;
 
 		ret = regmap_read(iodev->regmap, regulators[i].enable_reg, &val);
 		val = val >> shift & MAX77802_OPMODE_MASK;
-- 
1.9.1
