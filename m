From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu, 16 Jul 2015 23:46:56 +0530
Subject: [PATCH 3/5] regulator: 88pm800: Use regulator_nodes/of_match in the
 descriptor
In-Reply-To: <1437070618-21330-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1437070618-21330-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1437070618-21330-4-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is add regulator_nodes/of_match in the regulator
descriptor for using information from DT instead of specific codes.

With this patch, driver gets simplified,

  - No need to maintain "struct of_regulator_match" table
    and call of_regulator_match() fn.
  - No need for pm800_regulator_dt_init() fn, as it was only
    used for of_regulator_match().
  - probe() fn got simplified around regulator_config and regulator_desc
    initialization.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/regulator/88pm800.c | 143 ++++++++++++++------------------------------
 1 file changed, 44 insertions(+), 99 deletions(-)

diff --git a/drivers/regulator/88pm800.c b/drivers/regulator/88pm800.c
index 3b37170..26c277f 100644
--- a/drivers/regulator/88pm800.c
+++ b/drivers/regulator/88pm800.c
@@ -91,10 +91,12 @@ struct pm800_regulators {
  * not the constant voltage table.
  * n_volt - Number of available selectors
  */
-#define PM800_BUCK(vreg, ereg, ebit, amax, volt_ranges, n_volt)		\
+#define PM800_BUCK(match, vreg, ereg, ebit, amax, volt_ranges, n_volt)	\
 {									\
 	.desc	= {							\
 		.name			= #vreg,			\
+		.of_match		= of_match_ptr(#match),		\
+		.regulators_node	= of_match_ptr("regulators"),	\
 		.ops			= &pm800_volt_range_ops,	\
 		.type			= REGULATOR_VOLTAGE,		\
 		.id			= PM800_ID_##vreg,		\
@@ -119,10 +121,12 @@ struct pm800_regulators {
  * For all the LDOes, there are too many ranges. Using volt_table will be
  * simpler and faster.
  */
-#define PM800_LDO(vreg, ereg, ebit, amax, ldo_volt_table)		\
+#define PM800_LDO(match, vreg, ereg, ebit, amax, ldo_volt_table)	\
 {									\
 	.desc	= {							\
 		.name			= #vreg,			\
+		.of_match		= of_match_ptr(#match),		\
+		.regulators_node	= of_match_ptr("regulators"),	\
 		.ops			= &pm800_volt_table_ops,	\
 		.type			= REGULATOR_VOLTAGE,		\
 		.id			= PM800_ID_##vreg,		\
@@ -200,99 +204,43 @@ static struct regulator_ops pm800_volt_table_ops = {
 
 /* The array is indexed by id(PM800_ID_XXX) */
 static struct pm800_regulator_info pm800_regulator_info[] = {
-	PM800_BUCK(BUCK1, BUCK_ENA, 0, 3000000, buck1_volt_range, 0x55),
-	PM800_BUCK(BUCK2, BUCK_ENA, 1, 1200000, buck2_5_volt_range, 0x73),
-	PM800_BUCK(BUCK3, BUCK_ENA, 2, 1200000, buck2_5_volt_range, 0x73),
-	PM800_BUCK(BUCK4, BUCK_ENA, 3, 1200000, buck2_5_volt_range, 0x73),
-	PM800_BUCK(BUCK5, BUCK_ENA, 4, 1200000, buck2_5_volt_range, 0x73),
-
-	PM800_LDO(LDO1, LDO_ENA1_1, 0, 200000, ldo1_volt_table),
-	PM800_LDO(LDO2, LDO_ENA1_1, 1, 10000, ldo2_volt_table),
-	PM800_LDO(LDO3, LDO_ENA1_1, 2, 300000, ldo3_17_volt_table),
-	PM800_LDO(LDO4, LDO_ENA1_1, 3, 300000, ldo3_17_volt_table),
-	PM800_LDO(LDO5, LDO_ENA1_1, 4, 300000, ldo3_17_volt_table),
-	PM800_LDO(LDO6, LDO_ENA1_1, 5, 300000, ldo3_17_volt_table),
-	PM800_LDO(LDO7, LDO_ENA1_1, 6, 300000, ldo3_17_volt_table),
-	PM800_LDO(LDO8, LDO_ENA1_1, 7, 300000, ldo3_17_volt_table),
-	PM800_LDO(LDO9, LDO_ENA1_2, 0, 300000, ldo3_17_volt_table),
-	PM800_LDO(LDO10, LDO_ENA1_2, 1, 300000, ldo3_17_volt_table),
-	PM800_LDO(LDO11, LDO_ENA1_2, 2, 300000, ldo3_17_volt_table),
-	PM800_LDO(LDO12, LDO_ENA1_2, 3, 300000, ldo3_17_volt_table),
-	PM800_LDO(LDO13, LDO_ENA1_2, 4, 300000, ldo3_17_volt_table),
-	PM800_LDO(LDO14, LDO_ENA1_2, 5, 300000, ldo3_17_volt_table),
-	PM800_LDO(LDO15, LDO_ENA1_2, 6, 300000, ldo3_17_volt_table),
-	PM800_LDO(LDO16, LDO_ENA1_2, 7, 300000, ldo3_17_volt_table),
-	PM800_LDO(LDO17, LDO_ENA1_3, 0, 300000, ldo3_17_volt_table),
-	PM800_LDO(LDO18, LDO_ENA1_3, 1, 200000, ldo18_19_volt_table),
-	PM800_LDO(LDO19, LDO_ENA1_3, 2, 200000, ldo18_19_volt_table),
+	PM800_BUCK(buck1, BUCK1, BUCK_ENA, 0, 3000000, buck1_volt_range, 0x55),
+	PM800_BUCK(buck2, BUCK2, BUCK_ENA, 1, 1200000, buck2_5_volt_range, 0x73),
+	PM800_BUCK(buck3, BUCK3, BUCK_ENA, 2, 1200000, buck2_5_volt_range, 0x73),
+	PM800_BUCK(buck4, BUCK4, BUCK_ENA, 3, 1200000, buck2_5_volt_range, 0x73),
+	PM800_BUCK(buck5, BUCK5, BUCK_ENA, 4, 1200000, buck2_5_volt_range, 0x73),
+
+	PM800_LDO(ldo1, LDO1, LDO_ENA1_1, 0, 200000, ldo1_volt_table),
+	PM800_LDO(ldo2, LDO2, LDO_ENA1_1, 1, 10000, ldo2_volt_table),
+	PM800_LDO(ldo3, LDO3, LDO_ENA1_1, 2, 300000, ldo3_17_volt_table),
+	PM800_LDO(ldo4, LDO4, LDO_ENA1_1, 3, 300000, ldo3_17_volt_table),
+	PM800_LDO(ldo5, LDO5, LDO_ENA1_1, 4, 300000, ldo3_17_volt_table),
+	PM800_LDO(ldo6, LDO6, LDO_ENA1_1, 5, 300000, ldo3_17_volt_table),
+	PM800_LDO(ldo7, LDO7, LDO_ENA1_1, 6, 300000, ldo3_17_volt_table),
+	PM800_LDO(ldo8, LDO8, LDO_ENA1_1, 7, 300000, ldo3_17_volt_table),
+	PM800_LDO(ldo9, LDO9, LDO_ENA1_2, 0, 300000, ldo3_17_volt_table),
+	PM800_LDO(ldo10, LDO10, LDO_ENA1_2, 1, 300000, ldo3_17_volt_table),
+	PM800_LDO(ldo11, LDO11, LDO_ENA1_2, 2, 300000, ldo3_17_volt_table),
+	PM800_LDO(ldo12, LDO12, LDO_ENA1_2, 3, 300000, ldo3_17_volt_table),
+	PM800_LDO(ldo13, LDO13, LDO_ENA1_2, 4, 300000, ldo3_17_volt_table),
+	PM800_LDO(ldo14, LDO14, LDO_ENA1_2, 5, 300000, ldo3_17_volt_table),
+	PM800_LDO(ldo15, LDO15, LDO_ENA1_2, 6, 300000, ldo3_17_volt_table),
+	PM800_LDO(ldo16, LDO16, LDO_ENA1_2, 7, 300000, ldo3_17_volt_table),
+	PM800_LDO(ldo17, LDO17, LDO_ENA1_3, 0, 300000, ldo3_17_volt_table),
+	PM800_LDO(ldo18, LDO18, LDO_ENA1_3, 1, 200000, ldo18_19_volt_table),
+	PM800_LDO(ldo19, LDO19, LDO_ENA1_3, 2, 200000, ldo18_19_volt_table),
 };
 
-#define PM800_REGULATOR_OF_MATCH(_name, _id)				\
-	[PM800_ID_##_id] = {						\
-		.name = #_name,						\
-		.driver_data = &pm800_regulator_info[PM800_ID_##_id],	\
-	}
-
-static struct of_regulator_match pm800_regulator_matches[] = {
-	PM800_REGULATOR_OF_MATCH(buck1, BUCK1),
-	PM800_REGULATOR_OF_MATCH(buck2, BUCK2),
-	PM800_REGULATOR_OF_MATCH(buck3, BUCK3),
-	PM800_REGULATOR_OF_MATCH(buck4, BUCK4),
-	PM800_REGULATOR_OF_MATCH(buck5, BUCK5),
-	PM800_REGULATOR_OF_MATCH(ldo1, LDO1),
-	PM800_REGULATOR_OF_MATCH(ldo2, LDO2),
-	PM800_REGULATOR_OF_MATCH(ldo3, LDO3),
-	PM800_REGULATOR_OF_MATCH(ldo4, LDO4),
-	PM800_REGULATOR_OF_MATCH(ldo5, LDO5),
-	PM800_REGULATOR_OF_MATCH(ldo6, LDO6),
-	PM800_REGULATOR_OF_MATCH(ldo7, LDO7),
-	PM800_REGULATOR_OF_MATCH(ldo8, LDO8),
-	PM800_REGULATOR_OF_MATCH(ldo9, LDO9),
-	PM800_REGULATOR_OF_MATCH(ldo10, LDO10),
-	PM800_REGULATOR_OF_MATCH(ldo11, LDO11),
-	PM800_REGULATOR_OF_MATCH(ldo12, LDO12),
-	PM800_REGULATOR_OF_MATCH(ldo13, LDO13),
-	PM800_REGULATOR_OF_MATCH(ldo14, LDO14),
-	PM800_REGULATOR_OF_MATCH(ldo15, LDO15),
-	PM800_REGULATOR_OF_MATCH(ldo16, LDO16),
-	PM800_REGULATOR_OF_MATCH(ldo17, LDO17),
-	PM800_REGULATOR_OF_MATCH(ldo18, LDO18),
-	PM800_REGULATOR_OF_MATCH(ldo19, LDO19),
-};
-
-static int pm800_regulator_dt_init(struct platform_device *pdev)
-{
-	struct device_node *np = pdev->dev.of_node;
-	int ret;
-
-	ret = of_regulator_match(&pdev->dev, np,
-				 pm800_regulator_matches,
-				 ARRAY_SIZE(pm800_regulator_matches));
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
 static int pm800_regulator_probe(struct platform_device *pdev)
 {
 	struct pm80x_chip *chip = dev_get_drvdata(pdev->dev.parent);
 	struct pm80x_platform_data *pdata = dev_get_platdata(pdev->dev.parent);
 	struct pm800_regulators *pm800_data;
-	struct pm800_regulator_info *info;
 	struct regulator_config config = { };
 	struct regulator_init_data *init_data;
 	int i, ret;
 
-	if (!pdata || pdata->num_regulators == 0) {
-		if (IS_ENABLED(CONFIG_OF)) {
-			ret = pm800_regulator_dt_init(pdev);
-			if (ret)
-				return ret;
-		} else {
-			return -ENODEV;
-		}
-	} else if (pdata->num_regulators) {
+	if (pdata && pdata->num_regulators) {
 		unsigned int count = 0;
 
 		/* Check whether num_regulator is valid. */
@@ -302,8 +250,6 @@ static int pm800_regulator_probe(struct platform_device *pdev)
 		}
 		if (count != pdata->num_regulators)
 			return -EINVAL;
-	} else {
-		return -EINVAL;
 	}
 
 	pm800_data = devm_kzalloc(&pdev->dev, sizeof(*pm800_data),
@@ -316,28 +262,27 @@ static int pm800_regulator_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pm800_data);
 
+	config.dev = chip->dev;
+	config.regmap = pm800_data->map;
 	for (i = 0; i < PM800_ID_RG_MAX; i++) {
 		struct regulator_dev *regulator;
 
-		if (!pdata || pdata->num_regulators == 0)
-			init_data = pm800_regulator_matches[i].init_data;
-		else
+		if (pdata && pdata->num_regulators) {
 			init_data = pdata->regulators[i];
-		if (!init_data)
-			continue;
-		info = pm800_regulator_matches[i].driver_data;
-		config.dev = &pdev->dev;
-		config.init_data = init_data;
-		config.driver_data = info;
-		config.regmap = pm800_data->map;
-		config.of_node = pm800_regulator_matches[i].of_node;
+			if (!init_data)
+				continue;
+
+			config.init_data = init_data;
+		}
+
+		config.driver_data = &pm800_regulator_info[i];
 
 		regulator = devm_regulator_register(&pdev->dev,
-					&info->desc, &config);
+				&pm800_regulator_info[i].desc, &config);
 		if (IS_ERR(regulator)) {
 			ret = PTR_ERR(regulator);
 			dev_err(&pdev->dev, "Failed to register %s\n",
-				info->desc.name);
+					pm800_regulator_info[i].desc.name);
 			return ret;
 		}
 	}
-- 
1.9.1
