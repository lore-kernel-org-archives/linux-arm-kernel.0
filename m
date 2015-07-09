From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu,  9 Jul 2015 18:11:30 +0530
Subject: [PATCH 1/3] regulator: 88pm800: Add 88pm860 regulator support
In-Reply-To: <1436445692-10656-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1436445692-10656-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1436445692-10656-2-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

88PM860 falls under 88pm800 family of devices, with additional feature
enhancements, like,
 - 88pm860 had additional BUCK regulator (BUCK6 and BUCK1B)
 - Additional LDO (LDO20)
 - different voltage and current capability

This patch adds 88PM860 related buck/ldo voltage/current data to
the driver, and creates the regulator match table.

In order to keep the indexes of table in sync, added dummy fields and
table to existing 88pm800 match table.

Also, with the addition of 88pm860 device, the naming convention of
voltage tables would no longer be mapped to respective ldos/bucks,
so this patch also renames to more generic name.

TODO:
  - Validation on 88PM800 device, looking for some help here, as I do
    not have any platform with 88PM800 device.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Signed-off-by: Hongyan Song <hysong@marvell.com>
---
 drivers/regulator/88pm800.c | 194 ++++++++++++++++++++++++++++++++++----------
 include/linux/mfd/88pm80x.h |   3 +
 2 files changed, 154 insertions(+), 43 deletions(-)

diff --git a/drivers/regulator/88pm800.c b/drivers/regulator/88pm800.c
index 832932b..d22a098 100644
--- a/drivers/regulator/88pm800.c
+++ b/drivers/regulator/88pm800.c
@@ -44,6 +44,7 @@
 #define PM800_LDO17_VOUT	(0x1A)
 #define PM800_LDO18_VOUT	(0x1B)
 #define PM800_LDO19_VOUT	(0x1C)
+#define PM800_LDO20_VOUT	(0x1D)
 
 /* BUCK1 with DVC[0..3] */
 #define PM800_BUCK1		(0x3C)
@@ -57,8 +58,12 @@
 #define PM800_BUCK4_2		(0x44)
 #define PM800_BUCK4_3		(0x45)
 #define PM800_BUCK5		(0x46)
+#define PM800_BUCK6		(0x4A)
+#define PM800_BUCK1B		(0x4B)
 
 #define PM800_BUCK_ENA		(0x50)
+#define PM800_BUCK_ENA_DUMMY	(0xFF)
+
 #define PM800_LDO_ENA1_1	(0x51)
 #define PM800_LDO_ENA1_2	(0x52)
 #define PM800_LDO_ENA1_3	(0x53)
@@ -67,6 +72,8 @@
 #define PM800_LDO_ENA2_2	(0x57)
 #define PM800_LDO_ENA2_3	(0x58)
 
+#define PM800_LDO_ENA_DUMMY	(0xFF)
+
 #define PM800_BUCK1_MISC1	(0x78)
 #define PM800_BUCK3_MISC1	(0x7E)
 #define PM800_BUCK4_MISC1	(0x81)
@@ -139,37 +146,49 @@ struct pm800_regulators {
 }
 
 /* Ranges are sorted in ascending order. */
-static const struct regulator_linear_range buck1_volt_range[] = {
+static const struct regulator_linear_range buck_volt_range1[] = {
 	REGULATOR_LINEAR_RANGE(600000, 0, 0x4f, 12500),
 	REGULATOR_LINEAR_RANGE(1600000, 0x50, 0x54, 50000),
 };
 
 /* BUCK 2~5 have same ranges. */
-static const struct regulator_linear_range buck2_5_volt_range[] = {
+static const struct regulator_linear_range buck_volt_range2[] = {
 	REGULATOR_LINEAR_RANGE(600000, 0, 0x4f, 12500),
 	REGULATOR_LINEAR_RANGE(1600000, 0x50, 0x72, 50000),
 };
 
-static const unsigned int ldo1_volt_table[] = {
+/* dummy table */
+static const struct regulator_linear_range buck_volt_range_dummy[] = {
+};
+
+
+/* 88pm800: LDO1, 88pm860: LDO19  */
+static const unsigned int ldo_volt_table1[] = {
 	600000,  650000,  700000,  750000,  800000,  850000,  900000,  950000,
 	1000000, 1050000, 1100000, 1150000, 1200000, 1300000, 1400000, 1500000,
 };
 
-static const unsigned int ldo2_volt_table[] = {
+/* 88pm800: LDO2, 88pm860: LDO20 */
+static const unsigned int ldo_volt_table2[] = {
 	1700000, 1800000, 1900000, 2000000, 2100000, 2500000, 2700000, 2800000,
 };
 
-/* LDO 3~17 have same voltage table. */
-static const unsigned int ldo3_17_volt_table[] = {
+/* 88pm800: LDO 3~17, 88pm860: LDO 4~18 */
+static const unsigned int ldo_volt_table3[] = {
 	1200000, 1250000, 1700000, 1800000, 1850000, 1900000, 2500000, 2600000,
 	2700000, 2750000, 2800000, 2850000, 2900000, 3000000, 3100000, 3300000,
 };
 
-/* LDO 18~19 have same voltage table. */
-static const unsigned int ldo18_19_volt_table[] = {
+/* LDO 18~19, 88pm860: 1~3 */
+static const unsigned int ldo_volt_table4[] = {
 	1700000, 1800000, 1900000, 2500000, 2800000, 2900000, 3100000, 3300000,
 };
 
+/* dummy table */
+static const unsigned int ldo_volt_table_dummy[] = {
+};
+
+
 static int pm800_get_current_limit(struct regulator_dev *rdev)
 {
 	struct pm800_regulator_info *info = rdev_get_drvdata(rdev);
@@ -201,31 +220,65 @@ static struct regulator_ops pm800_volt_table_ops = {
 
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
+	PM800_BUCK(BUCK1, BUCK_ENA, 0, 3000000, buck_volt_range1, 0x55),
+	PM800_BUCK(BUCK2, BUCK_ENA, 1, 1200000, buck_volt_range2, 0x73),
+	PM800_BUCK(BUCK3, BUCK_ENA, 2, 1200000, buck_volt_range2, 0x73),
+	PM800_BUCK(BUCK4, BUCK_ENA, 3, 1200000, buck_volt_range2, 0x73),
+	PM800_BUCK(BUCK5, BUCK_ENA, 4, 1200000, buck_volt_range2, 0x73),
+	PM800_BUCK(BUCK6, BUCK_ENA_DUMMY, 0, 0, buck_volt_range_dummy, 0),
+	PM800_BUCK(BUCK1B, BUCK_ENA_DUMMY, 0, 0, buck_volt_range_dummy, 0),
+
+	PM800_LDO(LDO1, LDO_ENA1_1, 0, 200000, ldo_volt_table1),
+	PM800_LDO(LDO2, LDO_ENA1_1, 1, 10000, ldo_volt_table2),
+	PM800_LDO(LDO3, LDO_ENA1_1, 2, 300000, ldo_volt_table3),
+	PM800_LDO(LDO4, LDO_ENA1_1, 3, 300000, ldo_volt_table3),
+	PM800_LDO(LDO5, LDO_ENA1_1, 4, 300000, ldo_volt_table3),
+	PM800_LDO(LDO6, LDO_ENA1_1, 5, 300000, ldo_volt_table3),
+	PM800_LDO(LDO7, LDO_ENA1_1, 6, 300000, ldo_volt_table3),
+	PM800_LDO(LDO8, LDO_ENA1_1, 7, 300000, ldo_volt_table3),
+	PM800_LDO(LDO9, LDO_ENA1_2, 0, 300000, ldo_volt_table3),
+	PM800_LDO(LDO10, LDO_ENA1_2, 1, 300000, ldo_volt_table3),
+	PM800_LDO(LDO11, LDO_ENA1_2, 2, 300000, ldo_volt_table3),
+	PM800_LDO(LDO12, LDO_ENA1_2, 3, 300000, ldo_volt_table3),
+	PM800_LDO(LDO13, LDO_ENA1_2, 4, 300000, ldo_volt_table3),
+	PM800_LDO(LDO14, LDO_ENA1_2, 5, 300000, ldo_volt_table3),
+	PM800_LDO(LDO15, LDO_ENA1_2, 6, 300000, ldo_volt_table3),
+	PM800_LDO(LDO16, LDO_ENA1_2, 7, 300000, ldo_volt_table3),
+	PM800_LDO(LDO17, LDO_ENA1_3, 0, 300000, ldo_volt_table3),
+	PM800_LDO(LDO18, LDO_ENA1_3, 1, 200000, ldo_volt_table4),
+	PM800_LDO(LDO19, LDO_ENA1_3, 2, 200000, ldo_volt_table4),
+	PM800_LDO(LDO20, LDO_ENA_DUMMY, 0, 0, ldo_volt_table_dummy),
+};
+
+static struct pm800_regulator_info pm860_regulator_info[] = {
+	PM800_BUCK(BUCK1, BUCK_ENA, 0, 3000000, buck_volt_range1, 0x55),
+	PM800_BUCK(BUCK2, BUCK_ENA, 1, 750000, buck_volt_range2, 0x73),
+	PM800_BUCK(BUCK3, BUCK_ENA, 2, 1500000, buck_volt_range2, 0x73),
+	PM800_BUCK(BUCK4, BUCK_ENA, 3, 750000, buck_volt_range2, 0x73),
+	PM800_BUCK(BUCK5, BUCK_ENA, 4, 1500000, buck_volt_range2, 0x73),
+	PM800_BUCK(BUCK6, BUCK_ENA, 5, 800000, buck_volt_range2, 0x73),
+	PM800_BUCK(BUCK1B, BUCK_ENA, 6, 3000000, buck_volt_range2, 0x55),
+
+	PM800_LDO(LDO1, LDO_ENA1_1, 0, 100000, ldo_volt_table4),
+	PM800_LDO(LDO2, LDO_ENA1_1, 1, 100000, ldo_volt_table4),
+	PM800_LDO(LDO3, LDO_ENA1_1, 2, 100000, ldo_volt_table4),
+	PM800_LDO(LDO4, LDO_ENA1_1, 3, 400000, ldo_volt_table3),
+	PM800_LDO(LDO5, LDO_ENA1_1, 4, 400000, ldo_volt_table3),
+	PM800_LDO(LDO6, LDO_ENA1_1, 5, 400000, ldo_volt_table3),
+	PM800_LDO(LDO7, LDO_ENA1_1, 6, 400000, ldo_volt_table3),
+	PM800_LDO(LDO8, LDO_ENA1_1, 7, 400000, ldo_volt_table3),
+	PM800_LDO(LDO9, LDO_ENA1_2, 0, 400000, ldo_volt_table3),
+	PM800_LDO(LDO10, LDO_ENA1_2, 1, 200000, ldo_volt_table3),
+	PM800_LDO(LDO11, LDO_ENA1_2, 2, 200000, ldo_volt_table3),
+	PM800_LDO(LDO12, LDO_ENA1_2, 3, 200000, ldo_volt_table3),
+	PM800_LDO(LDO13, LDO_ENA1_2, 4, 200000, ldo_volt_table3),
+	PM800_LDO(LDO14, LDO_ENA1_2, 5, 200000, ldo_volt_table3),
+	PM800_LDO(LDO15, LDO_ENA1_2, 6, 200000, ldo_volt_table3),
+	PM800_LDO(LDO16, LDO_ENA1_2, 7, 200000, ldo_volt_table3),
+	PM800_LDO(LDO17, LDO_ENA1_3, 0, 200000, ldo_volt_table3),
+	PM800_LDO(LDO18, LDO_ENA1_3, 1, 200000, ldo_volt_table3),
+	PM800_LDO(LDO19, LDO_ENA1_3, 2, 400000, ldo_volt_table1),
+	PM800_LDO(LDO20, LDO_ENA1_3, 3, 10000, ldo_volt_table2),
 };
 
 #define PM800_REGULATOR_OF_MATCH(_name, _id)				\
@@ -261,18 +314,72 @@ static struct of_regulator_match pm800_regulator_matches[] = {
 	PM800_REGULATOR_OF_MATCH(ldo19, LDO19),
 };
 
-static int pm800_regulator_dt_init(struct platform_device *pdev)
+#define PM86X_REGULATOR_OF_MATCH(_name, _id)				\
+	[PM800_ID_##_id] = {						\
+		.name = #_name,						\
+		.driver_data = &pm860_regulator_info[PM800_ID_##_id],	\
+	}
+
+static struct of_regulator_match pm860_regulator_matches[] = {
+	PM86X_REGULATOR_OF_MATCH(buck1, BUCK1),
+	PM86X_REGULATOR_OF_MATCH(buck2, BUCK2),
+	PM86X_REGULATOR_OF_MATCH(buck3, BUCK3),
+	PM86X_REGULATOR_OF_MATCH(buck4, BUCK4),
+	PM86X_REGULATOR_OF_MATCH(buck5, BUCK5),
+	PM86X_REGULATOR_OF_MATCH(buck6, BUCK6),
+	PM86X_REGULATOR_OF_MATCH(buck1b, BUCK1B),
+	PM86X_REGULATOR_OF_MATCH(ldo1, LDO1),
+	PM86X_REGULATOR_OF_MATCH(ldo2, LDO2),
+	PM86X_REGULATOR_OF_MATCH(ldo3, LDO3),
+	PM86X_REGULATOR_OF_MATCH(ldo4, LDO4),
+	PM86X_REGULATOR_OF_MATCH(ldo5, LDO5),
+	PM86X_REGULATOR_OF_MATCH(ldo6, LDO6),
+	PM86X_REGULATOR_OF_MATCH(ldo7, LDO7),
+	PM86X_REGULATOR_OF_MATCH(ldo8, LDO8),
+	PM86X_REGULATOR_OF_MATCH(ldo9, LDO9),
+	PM86X_REGULATOR_OF_MATCH(ldo10, LDO10),
+	PM86X_REGULATOR_OF_MATCH(ldo11, LDO11),
+	PM86X_REGULATOR_OF_MATCH(ldo12, LDO12),
+	PM86X_REGULATOR_OF_MATCH(ldo13, LDO13),
+	PM86X_REGULATOR_OF_MATCH(ldo14, LDO14),
+	PM86X_REGULATOR_OF_MATCH(ldo15, LDO15),
+	PM86X_REGULATOR_OF_MATCH(ldo16, LDO16),
+	PM86X_REGULATOR_OF_MATCH(ldo17, LDO17),
+	PM86X_REGULATOR_OF_MATCH(ldo18, LDO18),
+	PM86X_REGULATOR_OF_MATCH(ldo19, LDO19),
+	PM86X_REGULATOR_OF_MATCH(ldo20, LDO20),
+};
+
+
+static int pm800_regulator_dt_init(struct platform_device *pdev,
+				struct of_regulator_match **regulator_matches)
 {
+	struct pm80x_chip *chip = dev_get_drvdata(pdev->dev.parent);
 	struct device_node *np = pdev->dev.of_node;
-	int ret;
+	int ret, range = 0;
+
+	switch (chip->type) {
+	case CHIP_PM800:
+	case CHIP_PM805:
+		*regulator_matches = pm800_regulator_matches;
+		range = ARRAY_SIZE(pm800_regulator_matches);
+		break;
+	case CHIP_PM860:
+		*regulator_matches = pm860_regulator_matches;
+		range = ARRAY_SIZE(pm860_regulator_matches);
+		break;
+	default:
+		return -ENODEV;
+	}
 
-	ret = of_regulator_match(&pdev->dev, np,
-				 pm800_regulator_matches,
-				 ARRAY_SIZE(pm800_regulator_matches));
-	if (ret < 0)
+	ret = of_regulator_match(&pdev->dev, np, *regulator_matches, range);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Error parsing regulator init data: %d\n", ret);
 		return ret;
+	}
 
 	return 0;
+
 }
 
 static int pm800_regulator_probe(struct platform_device *pdev)
@@ -283,11 +390,12 @@ static int pm800_regulator_probe(struct platform_device *pdev)
 	struct pm800_regulator_info *info;
 	struct regulator_config config = { };
 	struct regulator_init_data *init_data;
+	struct of_regulator_match *regulator_matches = NULL;
 	int i, ret;
 
 	if (!pdata || pdata->num_regulators == 0) {
 		if (IS_ENABLED(CONFIG_OF)) {
-			ret = pm800_regulator_dt_init(pdev);
+			ret = pm800_regulator_dt_init(pdev, &regulator_matches);
 			if (ret)
 				return ret;
 		} else {
@@ -319,17 +427,17 @@ static int pm800_regulator_probe(struct platform_device *pdev)
 
 	for (i = 0; i < PM800_ID_RG_MAX; i++) {
 		if (!pdata || pdata->num_regulators == 0)
-			init_data = pm800_regulator_matches[i].init_data;
+			init_data = regulator_matches[i].init_data;
 		else
 			init_data = pdata->regulators[i];
 		if (!init_data)
 			continue;
-		info = pm800_regulator_matches[i].driver_data;
+		info = regulator_matches[i].driver_data;
 		config.dev = &pdev->dev;
 		config.init_data = init_data;
 		config.driver_data = info;
 		config.regmap = pm800_data->map;
-		config.of_node = pm800_regulator_matches[i].of_node;
+		config.of_node = regulator_matches[i].of_node;
 
 		pm800_data->regulators[i] =
 				regulator_register(&info->desc, &config);
diff --git a/include/linux/mfd/88pm80x.h b/include/linux/mfd/88pm80x.h
index 4509643..759e232 100644
--- a/include/linux/mfd/88pm80x.h
+++ b/include/linux/mfd/88pm80x.h
@@ -31,6 +31,8 @@ enum {
 	PM800_ID_BUCK3,
 	PM800_ID_BUCK4,
 	PM800_ID_BUCK5,
+	PM800_ID_BUCK6,
+	PM800_ID_BUCK1B,
 
 	PM800_ID_LDO1,
 	PM800_ID_LDO2,
@@ -51,6 +53,7 @@ enum {
 	PM800_ID_LDO17,
 	PM800_ID_LDO18,
 	PM800_ID_LDO19,
+	PM800_ID_LDO20,
 
 	PM800_ID_RG_MAX,
 };
-- 
1.9.1
