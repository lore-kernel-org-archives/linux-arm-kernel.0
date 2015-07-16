From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu, 16 Jul 2015 23:46:57 +0530
Subject: [PATCH 4/5] regulator: 88pm800: Add 88pm860 regulator support
In-Reply-To: <1437070618-21330-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1437070618-21330-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1437070618-21330-5-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

88PM860 falls under 88pm800 family of devices, with
additional feature enhancements, like,
  - 88pm860 had additional BUCK regulator (BUCK6 and BUCK1B)
  - Additional LDO (LDO20)
  - different voltage and current capability

This patch adds 88PM860 related buck/ldo voltage/current data to
the driver, and creates the regulator_desc table.

With addition of new device to the driver, couple of unavoidable
changes,

  - The table gets referenced using regulator ID (PM800_ID_xxx),
    so table also needs to be created using ID.

   - The naming convention of voltage tables would no longer be
     mapped to respective ldos/bucks, so this patch also renames
     to more generic name.

TODO:
  - Validation on 88PM800 device, looking for some help here, as I do
    not have any platform with 88PM800 device.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/regulator/88pm800.c | 125 ++++++++++++++++++++++++++++++--------------
 include/linux/mfd/88pm80x.h |   3 ++
 2 files changed, 90 insertions(+), 38 deletions(-)

diff --git a/drivers/regulator/88pm800.c b/drivers/regulator/88pm800.c
index 26c277f..e846e4c 100644
--- a/drivers/regulator/88pm800.c
+++ b/drivers/regulator/88pm800.c
@@ -44,6 +44,7 @@
 #define PM800_LDO17_VOUT	(0x1A)
 #define PM800_LDO18_VOUT	(0x1B)
 #define PM800_LDO19_VOUT	(0x1C)
+#define PM800_LDO20_VOUT	(0x1D)
 
 /* BUCK1 with DVC[0..3] */
 #define PM800_BUCK1		(0x3C)
@@ -57,6 +58,8 @@
 #define PM800_BUCK4_2		(0x44)
 #define PM800_BUCK4_3		(0x45)
 #define PM800_BUCK5		(0x46)
+#define PM800_BUCK6		(0x4A)
+#define PM800_BUCK1B		(0x4B)
 
 #define PM800_BUCK_ENA		(0x50)
 #define PM800_LDO_ENA1_1	(0x51)
@@ -92,7 +95,7 @@ struct pm800_regulators {
  * n_volt - Number of available selectors
  */
 #define PM800_BUCK(match, vreg, ereg, ebit, amax, volt_ranges, n_volt)	\
-{									\
+[PM800_ID_##vreg] = {							\
 	.desc	= {							\
 		.name			= #vreg,			\
 		.of_match		= of_match_ptr(#match),		\
@@ -122,7 +125,7 @@ struct pm800_regulators {
  * simpler and faster.
  */
 #define PM800_LDO(match, vreg, ereg, ebit, amax, ldo_volt_table)	\
-{									\
+[PM800_ID_##vreg] = {							\
 	.desc	= {							\
 		.name			= #vreg,			\
 		.of_match		= of_match_ptr(#match),		\
@@ -142,34 +145,36 @@ struct pm800_regulators {
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
 
@@ -204,31 +209,62 @@ static struct regulator_ops pm800_volt_table_ops = {
 
 /* The array is indexed by id(PM800_ID_XXX) */
 static struct pm800_regulator_info pm800_regulator_info[] = {
-	PM800_BUCK(buck1, BUCK1, BUCK_ENA, 0, 3000000, buck1_volt_range, 0x55),
-	PM800_BUCK(buck2, BUCK2, BUCK_ENA, 1, 1200000, buck2_5_volt_range, 0x73),
-	PM800_BUCK(buck3, BUCK3, BUCK_ENA, 2, 1200000, buck2_5_volt_range, 0x73),
-	PM800_BUCK(buck4, BUCK4, BUCK_ENA, 3, 1200000, buck2_5_volt_range, 0x73),
-	PM800_BUCK(buck5, BUCK5, BUCK_ENA, 4, 1200000, buck2_5_volt_range, 0x73),
-
-	PM800_LDO(ldo1, LDO1, LDO_ENA1_1, 0, 200000, ldo1_volt_table),
-	PM800_LDO(ldo2, LDO2, LDO_ENA1_1, 1, 10000, ldo2_volt_table),
-	PM800_LDO(ldo3, LDO3, LDO_ENA1_1, 2, 300000, ldo3_17_volt_table),
-	PM800_LDO(ldo4, LDO4, LDO_ENA1_1, 3, 300000, ldo3_17_volt_table),
-	PM800_LDO(ldo5, LDO5, LDO_ENA1_1, 4, 300000, ldo3_17_volt_table),
-	PM800_LDO(ldo6, LDO6, LDO_ENA1_1, 5, 300000, ldo3_17_volt_table),
-	PM800_LDO(ldo7, LDO7, LDO_ENA1_1, 6, 300000, ldo3_17_volt_table),
-	PM800_LDO(ldo8, LDO8, LDO_ENA1_1, 7, 300000, ldo3_17_volt_table),
-	PM800_LDO(ldo9, LDO9, LDO_ENA1_2, 0, 300000, ldo3_17_volt_table),
-	PM800_LDO(ldo10, LDO10, LDO_ENA1_2, 1, 300000, ldo3_17_volt_table),
-	PM800_LDO(ldo11, LDO11, LDO_ENA1_2, 2, 300000, ldo3_17_volt_table),
-	PM800_LDO(ldo12, LDO12, LDO_ENA1_2, 3, 300000, ldo3_17_volt_table),
-	PM800_LDO(ldo13, LDO13, LDO_ENA1_2, 4, 300000, ldo3_17_volt_table),
-	PM800_LDO(ldo14, LDO14, LDO_ENA1_2, 5, 300000, ldo3_17_volt_table),
-	PM800_LDO(ldo15, LDO15, LDO_ENA1_2, 6, 300000, ldo3_17_volt_table),
-	PM800_LDO(ldo16, LDO16, LDO_ENA1_2, 7, 300000, ldo3_17_volt_table),
-	PM800_LDO(ldo17, LDO17, LDO_ENA1_3, 0, 300000, ldo3_17_volt_table),
-	PM800_LDO(ldo18, LDO18, LDO_ENA1_3, 1, 200000, ldo18_19_volt_table),
-	PM800_LDO(ldo19, LDO19, LDO_ENA1_3, 2, 200000, ldo18_19_volt_table),
+	PM800_BUCK(buck1, BUCK1, BUCK_ENA, 0, 3000000, buck_volt_range1, 0x55),
+	PM800_BUCK(buck2, BUCK2, BUCK_ENA, 1, 1200000, buck_volt_range2, 0x73),
+	PM800_BUCK(buck3, BUCK3, BUCK_ENA, 2, 1200000, buck_volt_range2, 0x73),
+	PM800_BUCK(buck4, BUCK4, BUCK_ENA, 3, 1200000, buck_volt_range2, 0x73),
+	PM800_BUCK(buck5, BUCK5, BUCK_ENA, 4, 1200000, buck_volt_range2, 0x73),
+
+	PM800_LDO(ldo1, LDO1, LDO_ENA1_1, 0, 200000, ldo_volt_table1),
+	PM800_LDO(ldo2, LDO2, LDO_ENA1_1, 1, 10000, ldo_volt_table2),
+	PM800_LDO(ldo3, LDO3, LDO_ENA1_1, 2, 300000, ldo_volt_table3),
+	PM800_LDO(ldo4, LDO4, LDO_ENA1_1, 3, 300000, ldo_volt_table3),
+	PM800_LDO(ldo5, LDO5, LDO_ENA1_1, 4, 300000, ldo_volt_table3),
+	PM800_LDO(ldo6, LDO6, LDO_ENA1_1, 5, 300000, ldo_volt_table3),
+	PM800_LDO(ldo7, LDO7, LDO_ENA1_1, 6, 300000, ldo_volt_table3),
+	PM800_LDO(ldo8, LDO8, LDO_ENA1_1, 7, 300000, ldo_volt_table3),
+	PM800_LDO(ldo9, LDO9, LDO_ENA1_2, 0, 300000, ldo_volt_table3),
+	PM800_LDO(ldo10, LDO10, LDO_ENA1_2, 1, 300000, ldo_volt_table3),
+	PM800_LDO(ldo11, LDO11, LDO_ENA1_2, 2, 300000, ldo_volt_table3),
+	PM800_LDO(ldo12, LDO12, LDO_ENA1_2, 3, 300000, ldo_volt_table3),
+	PM800_LDO(ldo13, LDO13, LDO_ENA1_2, 4, 300000, ldo_volt_table3),
+	PM800_LDO(ldo14, LDO14, LDO_ENA1_2, 5, 300000, ldo_volt_table3),
+	PM800_LDO(ldo15, LDO15, LDO_ENA1_2, 6, 300000, ldo_volt_table3),
+	PM800_LDO(ldo16, LDO16, LDO_ENA1_2, 7, 300000, ldo_volt_table3),
+	PM800_LDO(ldo17, LDO17, LDO_ENA1_3, 0, 300000, ldo_volt_table3),
+	PM800_LDO(ldo18, LDO18, LDO_ENA1_3, 1, 200000, ldo_volt_table4),
+	PM800_LDO(ldo19, LDO19, LDO_ENA1_3, 2, 200000, ldo_volt_table4),
+};
+
+static struct pm800_regulator_info pm860_regulator_info[] = {
+	PM800_BUCK(buck1, BUCK1, BUCK_ENA, 0, 3000000, buck_volt_range1, 0x55),
+	PM800_BUCK(buck2, BUCK2, BUCK_ENA, 1, 750000, buck_volt_range2, 0x73),
+	PM800_BUCK(buck3, BUCK3, BUCK_ENA, 2, 1500000, buck_volt_range2, 0x73),
+	PM800_BUCK(buck4, BUCK4, BUCK_ENA, 3, 750000, buck_volt_range2, 0x73),
+	PM800_BUCK(buck5, BUCK5, BUCK_ENA, 4, 1500000, buck_volt_range2, 0x73),
+	PM800_BUCK(buck6, BUCK6, BUCK_ENA, 5, 800000, buck_volt_range2, 0x73),
+	PM800_BUCK(buck1b, BUCK1B, BUCK_ENA, 6, 3000000, buck_volt_range2, 0x55),
+
+	PM800_LDO(ldo1, LDO1, LDO_ENA1_1, 0, 100000, ldo_volt_table4),
+	PM800_LDO(ldo2, LDO2, LDO_ENA1_1, 1, 100000, ldo_volt_table4),
+	PM800_LDO(ldo3, LDO3, LDO_ENA1_1, 2, 100000, ldo_volt_table4),
+	PM800_LDO(ldo4, LDO4, LDO_ENA1_1, 3, 400000, ldo_volt_table3),
+	PM800_LDO(ldo5, LDO5, LDO_ENA1_1, 4, 400000, ldo_volt_table3),
+	PM800_LDO(ldo6, LDO6, LDO_ENA1_1, 5, 400000, ldo_volt_table3),
+	PM800_LDO(ldo7, LDO7, LDO_ENA1_1, 6, 400000, ldo_volt_table3),
+	PM800_LDO(ldo8, LDO8, LDO_ENA1_1, 7, 400000, ldo_volt_table3),
+	PM800_LDO(ldo9, LDO9, LDO_ENA1_2, 0, 400000, ldo_volt_table3),
+	PM800_LDO(ldo10, LDO10, LDO_ENA1_2, 1, 200000, ldo_volt_table3),
+	PM800_LDO(ldo11, LDO11, LDO_ENA1_2, 2, 200000, ldo_volt_table3),
+	PM800_LDO(ldo12, LDO12, LDO_ENA1_2, 3, 200000, ldo_volt_table3),
+	PM800_LDO(ldo13, LDO13, LDO_ENA1_2, 4, 200000, ldo_volt_table3),
+	PM800_LDO(ldo14, LDO14, LDO_ENA1_2, 5, 200000, ldo_volt_table3),
+	PM800_LDO(ldo15, LDO15, LDO_ENA1_2, 6, 200000, ldo_volt_table3),
+	PM800_LDO(ldo16, LDO16, LDO_ENA1_2, 7, 200000, ldo_volt_table3),
+	PM800_LDO(ldo17, LDO17, LDO_ENA1_3, 0, 200000, ldo_volt_table3),
+	PM800_LDO(ldo18, LDO18, LDO_ENA1_3, 1, 200000, ldo_volt_table3),
+	PM800_LDO(ldo19, LDO19, LDO_ENA1_3, 2, 400000, ldo_volt_table1),
+	PM800_LDO(ldo20, LDO20, LDO_ENA1_3, 3, 10000, ldo_volt_table2),
 };
 
 static int pm800_regulator_probe(struct platform_device *pdev)
@@ -238,6 +274,7 @@ static int pm800_regulator_probe(struct platform_device *pdev)
 	struct pm800_regulators *pm800_data;
 	struct regulator_config config = { };
 	struct regulator_init_data *init_data;
+	struct pm800_regulator_info *info = NULL;
 	int i, ret;
 
 	if (pdata && pdata->num_regulators) {
@@ -262,6 +299,18 @@ static int pm800_regulator_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pm800_data);
 
+	switch (chip->type) {
+	case CHIP_PM800:
+	case CHIP_PM805:
+		info = pm800_regulator_info;
+		break;
+	case CHIP_PM860:
+		info = pm860_regulator_info;
+		break;
+	default:
+		return -ENODEV;
+	}
+
 	config.dev = chip->dev;
 	config.regmap = pm800_data->map;
 	for (i = 0; i < PM800_ID_RG_MAX; i++) {
@@ -275,14 +324,14 @@ static int pm800_regulator_probe(struct platform_device *pdev)
 			config.init_data = init_data;
 		}
 
-		config.driver_data = &pm800_regulator_info[i];
+		config.driver_data = &info[i];
 
 		regulator = devm_regulator_register(&pdev->dev,
-				&pm800_regulator_info[i].desc, &config);
+				&info[i].desc, &config);
 		if (IS_ERR(regulator)) {
 			ret = PTR_ERR(regulator);
 			dev_err(&pdev->dev, "Failed to register %s\n",
-					pm800_regulator_info[i].desc.name);
+					info[i].desc.name);
 			return ret;
 		}
 	}
diff --git a/include/linux/mfd/88pm80x.h b/include/linux/mfd/88pm80x.h
index 2ef62af..a92d173 100644
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
