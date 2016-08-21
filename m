From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 21 Aug 2016 10:11:20 +0800
Subject: [PATCH 4/9] regulator: axp20x: support AXP806 variant
In-Reply-To: <20160821021125.1521-1-wens@csie.org>
References: <20160821021125.1521-1-wens@csie.org>
Message-ID: <20160821021125.1521-5-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The X-Powers AXP806 PMIC has a new set of buck and LDO regulators, and
also a switch. The buck regulators support teaming into multi-phase
groups, with A+B, A+B+C, D+E groupings.

Some registers controlling DCDC converter work settings are at different
offsets. Deal with them as well.

Add support for this new variant.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/regulator/axp20x-regulator.c | 117 ++++++++++++++++++++++++++++++++---
 1 file changed, 110 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 6d9ac76a772f..ac5d97b78dce 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -244,16 +244,64 @@ static const struct regulator_desc axp22x_drivevbus_regulator = {
 	.ops		= &axp20x_ops_sw,
 };
 
-static const struct regulator_linear_range axp809_dcdc4_ranges[] = {
-	REGULATOR_LINEAR_RANGE(600000, 0x0, 0x2f, 20000),
-	REGULATOR_LINEAR_RANGE(1800000, 0x30, 0x38, 100000),
+static const struct regulator_linear_range axp806_dcdca_ranges[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0x0, 0x32, 10000),
+	REGULATOR_LINEAR_RANGE(1120000, 0x33, 0x47, 20000),
+};
+
+static const struct regulator_linear_range axp806_dcdcd_ranges[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0x0, 0x2d, 20000),
+	REGULATOR_LINEAR_RANGE(1600000, 0x2e, 0x3f, 100000),
 };
 
-static const struct regulator_linear_range axp809_dldo1_ranges[] = {
+static const struct regulator_linear_range axp806_cldo2_ranges[] = {
 	REGULATOR_LINEAR_RANGE(700000, 0x0, 0x1a, 100000),
 	REGULATOR_LINEAR_RANGE(3400000, 0x1b, 0x1f, 200000),
 };
 
+static const struct regulator_desc axp806_regulators[] = {
+	AXP_DESC_RANGES(AXP806, DCDCA, "dcdca", "vina", axp806_dcdca_ranges,
+			72, AXP806_DCDCA_V_CTRL, 0x7f, AXP806_PWR_OUT_CTRL1,
+			BIT(0)),
+	AXP_DESC(AXP806, DCDCB, "dcdcb", "vinb", 1000, 2550, 50,
+		 AXP806_DCDCB_V_CTRL, 0x1f, AXP806_PWR_OUT_CTRL1, BIT(1)),
+	AXP_DESC_RANGES(AXP806, DCDCC, "dcdcc", "vinc", axp806_dcdca_ranges,
+			72, AXP806_DCDCC_V_CTRL, 0x7f, AXP806_PWR_OUT_CTRL1,
+			BIT(2)),
+	AXP_DESC_RANGES(AXP806, DCDCD, "dcdcd", "vind", axp806_dcdcd_ranges,
+			64, AXP806_DCDCD_V_CTRL, 0x3f, AXP806_PWR_OUT_CTRL1,
+			BIT(3)),
+	AXP_DESC(AXP806, DCDCE, "dcdce", "vine", 1100, 3400, 100,
+		 AXP806_DCDCB_V_CTRL, 0x1f, AXP806_PWR_OUT_CTRL1, BIT(4)),
+	AXP_DESC(AXP806, ALDO1, "aldo1", "aldoin", 700, 3300, 100,
+		 AXP806_ALDO1_V_CTRL, 0x1f, AXP806_PWR_OUT_CTRL1, BIT(5)),
+	AXP_DESC(AXP806, ALDO2, "aldo2", "aldoin", 700, 3400, 100,
+		 AXP806_ALDO2_V_CTRL, 0x1f, AXP806_PWR_OUT_CTRL1, BIT(6)),
+	AXP_DESC(AXP806, ALDO3, "aldo3", "aldoin", 700, 3300, 100,
+		 AXP806_ALDO3_V_CTRL, 0x1f, AXP806_PWR_OUT_CTRL1, BIT(7)),
+	AXP_DESC(AXP806, BLDO1, "bldo1", "bldoin", 700, 1900, 100,
+		 AXP806_BLDO1_V_CTRL, 0x0f, AXP806_PWR_OUT_CTRL2, BIT(0)),
+	AXP_DESC(AXP806, BLDO2, "bldo2", "bldoin", 700, 1900, 100,
+		 AXP806_BLDO2_V_CTRL, 0x0f, AXP806_PWR_OUT_CTRL2, BIT(1)),
+	AXP_DESC(AXP806, BLDO3, "bldo3", "bldoin", 700, 1900, 100,
+		 AXP806_BLDO3_V_CTRL, 0x0f, AXP806_PWR_OUT_CTRL2, BIT(2)),
+	AXP_DESC(AXP806, BLDO4, "bldo4", "bldoin", 700, 1900, 100,
+		 AXP806_BLDO4_V_CTRL, 0x0f, AXP806_PWR_OUT_CTRL2, BIT(3)),
+	AXP_DESC(AXP806, CLDO1, "cldo1", "cldoin", 700, 3300, 100,
+		 AXP806_CLDO1_V_CTRL, 0x1f, AXP806_PWR_OUT_CTRL2, BIT(4)),
+	AXP_DESC_RANGES(AXP806, CLDO2, "cldo2", "cldoin", axp806_cldo2_ranges,
+			32, AXP806_CLDO2_V_CTRL, 0x1f, AXP806_PWR_OUT_CTRL2,
+			BIT(5)),
+	AXP_DESC(AXP806, CLDO3, "cldo3", "cldoin", 700, 3300, 100,
+		 AXP806_CLDO3_V_CTRL, 0x1f, AXP806_PWR_OUT_CTRL2, BIT(6)),
+	AXP_DESC_SW(AXP806, SW, "sw", "swin", AXP806_PWR_OUT_CTRL2, BIT(7)),
+};
+
+static const struct regulator_linear_range axp809_dcdc4_ranges[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0x0, 0x2f, 20000),
+	REGULATOR_LINEAR_RANGE(1800000, 0x30, 0x38, 100000),
+};
+
 static const struct regulator_desc axp809_regulators[] = {
 	AXP_DESC(AXP809, DCDC1, "dcdc1", "vin1", 1600, 3400, 100,
 		 AXP22X_DCDC1_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL1, BIT(1)),
@@ -278,7 +326,7 @@ static const struct regulator_desc axp809_regulators[] = {
 		 AXP22X_ALDO2_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL1, BIT(7)),
 	AXP_DESC(AXP809, ALDO3, "aldo3", "aldoin", 700, 3300, 100,
 		 AXP22X_ALDO3_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(5)),
-	AXP_DESC_RANGES(AXP809, DLDO1, "dldo1", "dldoin", axp809_dldo1_ranges,
+	AXP_DESC_RANGES(AXP809, DLDO1, "dldo1", "dldoin", axp806_cldo2_ranges,
 			32, AXP22X_DLDO1_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2,
 			BIT(3)),
 	AXP_DESC(AXP809, DLDO2, "dldo2", "dldoin", 700, 3300, 100,
@@ -302,6 +350,7 @@ static const struct regulator_desc axp809_regulators[] = {
 static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
 {
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
+	unsigned int reg = AXP20X_DCDC_FREQ;
 	u32 min, max, def, step;
 
 	switch (axp20x->variant) {
@@ -312,6 +361,14 @@ static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
 		def = 1500;
 		step = 75;
 		break;
+	case AXP806_ID:
+		/*
+		 * AXP806 DCDC work frequency setting has the same range and
+		 * step as AXP22X, but at a different register.
+		 * Fall through to the check below.
+		 * (See include/linux/mfd/axp20x.h)
+		 */
+		reg = AXP806_DCDC_FREQ_CTRL;
 	case AXP221_ID:
 	case AXP223_ID:
 	case AXP809_ID:
@@ -343,7 +400,7 @@ static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
 
 	dcdcfreq = (dcdcfreq - min) / step;
 
-	return regmap_update_bits(axp20x->regmap, AXP20X_DCDC_FREQ,
+	return regmap_update_bits(axp20x->regmap, reg,
 				  AXP20X_FREQ_DCDC_MASK, dcdcfreq);
 }
 
@@ -377,6 +434,7 @@ static int axp20x_regulator_parse_dt(struct platform_device *pdev)
 static int axp20x_set_dcdc_workmode(struct regulator_dev *rdev, int id, u32 workmode)
 {
 	struct axp20x_dev *axp20x = rdev_get_drvdata(rdev);
+	unsigned int reg = AXP20X_DCDC_MODE;
 	unsigned int mask;
 
 	switch (axp20x->variant) {
@@ -392,6 +450,13 @@ static int axp20x_set_dcdc_workmode(struct regulator_dev *rdev, int id, u32 work
 		workmode <<= ffs(mask) - 1;
 		break;
 
+	case AXP806_ID:
+		reg = AXP806_DCDC_MODE_CTRL2;
+		/*
+		 * AXP806 DCDC regulator IDs have the same range as AXP22X.
+		 * Fall through to the check below.
+		 * (See include/linux/mfd/axp20x.h)
+		 */
 	case AXP221_ID:
 	case AXP223_ID:
 	case AXP809_ID:
@@ -408,7 +473,33 @@ static int axp20x_set_dcdc_workmode(struct regulator_dev *rdev, int id, u32 work
 		return -EINVAL;
 	}
 
-	return regmap_update_bits(rdev->regmap, AXP20X_DCDC_MODE, mask, workmode);
+	return regmap_update_bits(rdev->regmap, reg, mask, workmode);
+}
+
+/*
+ * This function checks whether a regulator is part of a poly-phase
+ * output setup based on the registers settings. Returns true if it is.
+ */
+static bool axp20x_is_polyphase_slave(struct axp20x_dev *axp20x, int id)
+{
+	u32 reg = 0;
+
+	/* Only AXP806 has poly-phase outputs */
+	if (axp20x->variant != AXP806_ID)
+		return false;
+
+	regmap_read(axp20x->regmap, AXP806_DCDC_MODE_CTRL2, &reg);
+
+	if (id == AXP806_DCDCB) {
+		return (((reg & GENMASK(7, 6)) == BIT(6)) ||
+			((reg & GENMASK(7, 6)) == BIT(7)));
+	} else if (id == AXP806_DCDCC) {
+		return ((reg & GENMASK(7, 6)) == BIT(7));
+	} else if (id == AXP806_DCDCE) {
+		return !!(reg & BIT(5));
+	}
+
+	return false;
 }
 
 static int axp20x_regulator_probe(struct platform_device *pdev)
@@ -440,6 +531,10 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		drivevbus = of_property_read_bool(pdev->dev.parent->of_node,
 						  "x-powers,drive-vbus-en");
 		break;
+	case AXP806_ID:
+		regulators = axp806_regulators;
+		nregulators = AXP806_REG_ID_MAX;
+		break;
 	case AXP809_ID:
 		regulators = axp809_regulators;
 		nregulators = AXP809_REG_ID_MAX;
@@ -458,6 +553,14 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		struct regulator_desc *new_desc;
 
 		/*
+		 * If this regulator is a slave in a poly-phase setup,
+		 * skip it, as its controls are bound to the master
+		 * regulator and won't work.
+		 */
+		if (axp20x_is_polyphase_slave(axp20x, i))
+			continue;
+
+		/*
 		 * Regulators DC1SW and DC5LDO are connected internally,
 		 * so we have to handle their supply names separately.
 		 *
-- 
2.9.3
