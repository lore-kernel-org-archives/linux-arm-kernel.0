From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  2 Feb 2016 18:27:38 +0800
Subject: [PATCH 05/11] regulator: axp20x: Use linear voltage ranges for AXP20X
 LDO4
In-Reply-To: <1454408864-24112-1-git-send-email-wens@csie.org>
References: <1454408864-24112-1-git-send-email-wens@csie.org>
Message-ID: <1454408864-24112-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AXP20X datasheet lists the possible voltage settings for LDO4, so
it was implemented using a voltage table. Upon closer examination,
the valid voltages can be mapped into 3 linear ranges.

Move AXP20X LDO4 to use linear ranges. The supporting code can be
reused with later AXP8xx PMICs, which have a number of regulators
that have 2 linear ranges.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/regulator/axp20x-regulator.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index f31d238e85e8..81f25383f2d5 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -106,8 +106,8 @@
 		.ops		= &axp20x_ops_fixed				\
 	}
 
-#define AXP_DESC_TABLE(_family, _id, _match, _supply, _table, _vreg, _vmask,	\
-		       _ereg, _emask)						\
+#define AXP_DESC_RANGES(_family, _id, _match, _supply, _ranges, _n_voltages,	\
+			_vreg, _vmask, _ereg, _emask)				\
 	[_family##_##_id] = {							\
 		.name		= #_id,						\
 		.supply_name	= (_supply),					\
@@ -115,30 +115,25 @@
 		.regulators_node = of_match_ptr("regulators"),			\
 		.type		= REGULATOR_VOLTAGE,				\
 		.id		= _family##_##_id,				\
-		.n_voltages	= ARRAY_SIZE(_table),				\
+		.n_voltages	= (_n_voltages),				\
 		.owner		= THIS_MODULE,					\
 		.vsel_reg	= (_vreg),					\
 		.vsel_mask	= (_vmask),					\
 		.enable_reg	= (_ereg),					\
 		.enable_mask	= (_emask),					\
-		.volt_table	= (_table),					\
-		.ops		= &axp20x_ops_table,				\
+		.linear_ranges	= (_ranges),					\
+		.n_linear_ranges = ARRAY_SIZE(_ranges),				\
+		.ops		= &axp20x_ops_range,				\
 	}
 
-static const int axp20x_ldo4_data[] = { 1250000, 1300000, 1400000, 1500000, 1600000,
-					1700000, 1800000, 1900000, 2000000, 2500000,
-					2700000, 2800000, 3000000, 3100000, 3200000,
-					3300000 };
-
 static struct regulator_ops axp20x_ops_fixed = {
 	.list_voltage		= regulator_list_voltage_linear,
 };
 
-static struct regulator_ops axp20x_ops_table = {
+static struct regulator_ops axp20x_ops_range = {
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
-	.list_voltage		= regulator_list_voltage_table,
-	.map_voltage		= regulator_map_voltage_ascend,
+	.list_voltage		= regulator_list_voltage_linear_range,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.is_enabled		= regulator_is_enabled_regmap,
@@ -159,6 +154,12 @@ static struct regulator_ops axp20x_ops_sw = {
 	.is_enabled		= regulator_is_enabled_regmap,
 };
 
+static const struct regulator_linear_range axp20x_ldo4_ranges[] = {
+	REGULATOR_LINEAR_RANGE(1250000, 0x0, 0x0, 0),
+	REGULATOR_LINEAR_RANGE(1300000, 0x1, 0x8, 100000),
+	REGULATOR_LINEAR_RANGE(2500000, 0x9, 0xf, 100000),
+};
+
 static const struct regulator_desc axp20x_regulators[] = {
 	AXP_DESC(AXP20X, DCDC2, "dcdc2", "vin2", 700, 2275, 25,
 		 AXP20X_DCDC2_V_OUT, 0x3f, AXP20X_PWR_OUT_CTRL, 0x10),
@@ -169,8 +170,9 @@ static const struct regulator_desc axp20x_regulators[] = {
 		 AXP20X_LDO24_V_OUT, 0xf0, AXP20X_PWR_OUT_CTRL, 0x04),
 	AXP_DESC(AXP20X, LDO3, "ldo3", "ldo3in", 700, 3500, 25,
 		 AXP20X_LDO3_V_OUT, 0x7f, AXP20X_PWR_OUT_CTRL, 0x40),
-	AXP_DESC_TABLE(AXP20X, LDO4, "ldo4", "ldo24in", axp20x_ldo4_data,
-		       AXP20X_LDO24_V_OUT, 0x0f, AXP20X_PWR_OUT_CTRL, 0x08),
+	AXP_DESC_RANGES(AXP20X, LDO4, "ldo4", "ldo24in", axp20x_ldo4_ranges,
+			16, AXP20X_LDO24_V_OUT, 0x0f, AXP20X_PWR_OUT_CTRL,
+			0x08),
 	AXP_DESC_IO(AXP20X, LDO5, "ldo5", "ldo5in", 1800, 3300, 100,
 		    AXP20X_LDO5_V_OUT, 0xf0, AXP20X_GPIO0_CTRL, 0x07,
 		    AXP20X_IO_ENABLED, AXP20X_IO_DISABLED),
-- 
2.7.0
