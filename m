From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 10 Jan 2015 00:23:43 +0800
Subject: [PATCH 1/2] regulator: axp20x: Fill regulators_node and of_match
 descriptor fields
In-Reply-To: <1420820624-10275-1-git-send-email-wens@csie.org>
References: <1420820624-10275-1-git-send-email-wens@csie.org>
Message-ID: <1420820624-10275-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fills the DT related fields in the regulator descriptors,
which can then be used by the regulator core's simplified DT code.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

This patch still has many lines over 80 characters. However I would like
to separate reformatting and functional changes. I can do another patch
over this one if line length is an issue.

---
 drivers/regulator/axp20x-regulator.c | 49 +++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index f23d7e1f2ee7..441ae01123dd 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -32,11 +32,13 @@
 
 #define AXP20X_FREQ_DCDC_MASK		0x0f
 
-#define AXP20X_DESC_IO(_id, _supply, _min, _max, _step, _vreg, _vmask, _ereg,   \
-		       _emask, _enable_val, _disable_val)			\
+#define AXP20X_DESC_IO(_id, _match, _supply, _min, _max, _step, _vreg, _vmask,	\
+		       _ereg, _emask, _enable_val, _disable_val)		\
 	[AXP20X_##_id] = {							\
 		.name		= #_id,						\
 		.supply_name	= (_supply),					\
+		.of_match	= of_match_ptr(_match),				\
+		.regulators_node = of_match_ptr("regulators"),			\
 		.type		= REGULATOR_VOLTAGE,				\
 		.id		= AXP20X_##_id,					\
 		.n_voltages	= (((_max) - (_min)) / (_step) + 1),		\
@@ -52,11 +54,13 @@
 		.ops		= &axp20x_ops,					\
 	}
 
-#define AXP20X_DESC(_id, _supply, _min, _max, _step, _vreg, _vmask, _ereg,	\
-		    _emask) 							\
+#define AXP20X_DESC(_id, _match, _supply, _min, _max, _step, _vreg, _vmask,	\
+		    _ereg, _emask)						\
 	[AXP20X_##_id] = {							\
 		.name		= #_id,						\
 		.supply_name	= (_supply),					\
+		.of_match	= of_match_ptr(_match),				\
+		.regulators_node = of_match_ptr("regulators"),			\
 		.type		= REGULATOR_VOLTAGE,				\
 		.id		= AXP20X_##_id,					\
 		.n_voltages	= (((_max) - (_min)) / (_step) + 1),		\
@@ -70,10 +74,12 @@
 		.ops		= &axp20x_ops,					\
 	}
 
-#define AXP20X_DESC_FIXED(_id, _supply, _volt)					\
+#define AXP20X_DESC_FIXED(_id, _match, _supply, _volt)				\
 	[AXP20X_##_id] = {							\
 		.name		= #_id,						\
 		.supply_name	= (_supply),					\
+		.of_match	= of_match_ptr(_match),				\
+		.regulators_node = of_match_ptr("regulators"),			\
 		.type		= REGULATOR_VOLTAGE,				\
 		.id		= AXP20X_##_id,					\
 		.n_voltages	= 1,						\
@@ -82,10 +88,13 @@
 		.ops		= &axp20x_ops_fixed				\
 	}
 
-#define AXP20X_DESC_TABLE(_id, _supply, _table, _vreg, _vmask, _ereg, _emask)	\
+#define AXP20X_DESC_TABLE(_id, _match, _supply, _table, _vreg, _vmask, _ereg,	\
+			  _emask)						\
 	[AXP20X_##_id] = {							\
 		.name		= #_id,						\
 		.supply_name	= (_supply),					\
+		.of_match	= of_match_ptr(_match),				\
+		.regulators_node = of_match_ptr("regulators"),			\
 		.type		= REGULATOR_VOLTAGE,				\
 		.id		= AXP20X_##_id,					\
 		.n_voltages	= ARRAY_SIZE(_table),				\
@@ -127,20 +136,20 @@ static struct regulator_ops axp20x_ops = {
 };
 
 static const struct regulator_desc axp20x_regulators[] = {
-	AXP20X_DESC(DCDC2, "vin2", 700, 2275, 25, AXP20X_DCDC2_V_OUT, 0x3f,
-		    AXP20X_PWR_OUT_CTRL, 0x10),
-	AXP20X_DESC(DCDC3, "vin3", 700, 3500, 25, AXP20X_DCDC3_V_OUT, 0x7f,
-		    AXP20X_PWR_OUT_CTRL, 0x02),
-	AXP20X_DESC_FIXED(LDO1, "acin", 1300),
-	AXP20X_DESC(LDO2, "ldo24in", 1800, 3300, 100, AXP20X_LDO24_V_OUT, 0xf0,
-		    AXP20X_PWR_OUT_CTRL, 0x04),
-	AXP20X_DESC(LDO3, "ldo3in", 700, 3500, 25, AXP20X_LDO3_V_OUT, 0x7f,
-		    AXP20X_PWR_OUT_CTRL, 0x40),
-	AXP20X_DESC_TABLE(LDO4, "ldo24in", axp20x_ldo4_data, AXP20X_LDO24_V_OUT, 0x0f,
-			  AXP20X_PWR_OUT_CTRL, 0x08),
-	AXP20X_DESC_IO(LDO5, "ldo5in", 1800, 3300, 100, AXP20X_LDO5_V_OUT, 0xf0,
-		       AXP20X_GPIO0_CTRL, 0x07, AXP20X_IO_ENABLED,
-		       AXP20X_IO_DISABLED),
+	AXP20X_DESC(DCDC2, "dcdc2", "vin2", 700, 2275, 25, AXP20X_DCDC2_V_OUT,
+		    0x3f, AXP20X_PWR_OUT_CTRL, 0x10),
+	AXP20X_DESC(DCDC3, "dcdc3", "vin3", 700, 3500, 25, AXP20X_DCDC3_V_OUT,
+		    0x7f, AXP20X_PWR_OUT_CTRL, 0x02),
+	AXP20X_DESC_FIXED(LDO1, "ldo1", "acin", 1300),
+	AXP20X_DESC(LDO2, "ldo2", "ldo24in", 1800, 3300, 100,
+		    AXP20X_LDO24_V_OUT, 0xf0, AXP20X_PWR_OUT_CTRL, 0x04),
+	AXP20X_DESC(LDO3, "ldo3", "ldo3in", 700, 3500, 25, AXP20X_LDO3_V_OUT,
+		    0x7f, AXP20X_PWR_OUT_CTRL, 0x40),
+	AXP20X_DESC_TABLE(LDO4, "ldo4", "ldo24in", axp20x_ldo4_data,
+			  AXP20X_LDO24_V_OUT, 0x0f, AXP20X_PWR_OUT_CTRL, 0x08),
+	AXP20X_DESC_IO(LDO5, "ldo5", "ldo5in", 1800, 3300, 100,
+		       AXP20X_LDO5_V_OUT, 0xf0, AXP20X_GPIO0_CTRL, 0x07,
+		       AXP20X_IO_ENABLED, AXP20X_IO_DISABLED),
 };
 
 #define AXP_MATCH(_name, _id) \
-- 
2.1.4
