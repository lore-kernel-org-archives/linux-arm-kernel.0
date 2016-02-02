From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  2 Feb 2016 18:27:37 +0800
Subject: [PATCH 04/11] regulator: axp20x: Remove voltage readout support for
 switch regulators
In-Reply-To: <1454408864-24112-1-git-send-email-wens@csie.org>
References: <1454408864-24112-1-git-send-email-wens@csie.org>
Message-ID: <1454408864-24112-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch-type regulators, such as DC1SW on AXP22X, are a secondary output
from DCDC1. They are just an on/off switch, and the driver should not
try to read its voltage directly from the DCDC1 control registers.

Instead, the core will pass down the voltage from the regulator supply
chain.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/regulator/axp20x-regulator.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index e86d1fc2d80b..f31d238e85e8 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -78,8 +78,7 @@
 		.ops		= &axp20x_ops,					\
 	}
 
-#define AXP_DESC_SW(_family, _id, _match, _supply, _min, _max, _step, _vreg,	\
-		    _vmask, _ereg, _emask) 					\
+#define AXP_DESC_SW(_family, _id, _match, _supply, _ereg, _emask)		\
 	[_family##_##_id] = {							\
 		.name		= #_id,						\
 		.supply_name	= (_supply),					\
@@ -87,12 +86,7 @@
 		.regulators_node = of_match_ptr("regulators"),			\
 		.type		= REGULATOR_VOLTAGE,				\
 		.id		= _family##_##_id,				\
-		.n_voltages	= (((_max) - (_min)) / (_step) + 1),		\
 		.owner		= THIS_MODULE,					\
-		.min_uV		= (_min) * 1000,				\
-		.uV_step	= (_step) * 1000,				\
-		.vsel_reg	= (_vreg),					\
-		.vsel_mask	= (_vmask),					\
 		.enable_reg	= (_ereg),					\
 		.enable_mask	= (_emask),					\
 		.ops		= &axp20x_ops_sw,				\
@@ -160,8 +154,6 @@ static struct regulator_ops axp20x_ops = {
 };
 
 static struct regulator_ops axp20x_ops_sw = {
-	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
-	.list_voltage		= regulator_list_voltage_linear,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.is_enabled		= regulator_is_enabled_regmap,
@@ -196,8 +188,8 @@ static const struct regulator_desc axp22x_regulators[] = {
 	AXP_DESC(AXP22X, DCDC5, "dcdc5", "vin5", 1000, 2550, 50,
 		 AXP22X_DCDC5_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL1, BIT(5)),
 	/* secondary switchable output of DCDC1 */
-	AXP_DESC_SW(AXP22X, DC1SW, "dc1sw", NULL, 1600, 3400, 100,
-		    AXP22X_DCDC1_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(7)),
+	AXP_DESC_SW(AXP22X, DC1SW, "dc1sw", NULL, AXP22X_PWR_OUT_CTRL2,
+		    BIT(7)),
 	/* LDO regulator internally chained to DCDC5 */
 	AXP_DESC(AXP22X, DC5LDO, "dc5ldo", NULL, 700, 1400, 100,
 		 AXP22X_DC5LDO_V_OUT, 0x7, AXP22X_PWR_OUT_CTRL1, BIT(0)),
-- 
2.7.0
