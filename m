From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 13 Jul 2018 00:04:49 +0800
Subject: [PATCH v3 2/5] mfd: axp20x: Add self-working mode support for AXP806
In-Reply-To: <20180712160452.5516-1-wens@csie.org>
References: <20180712160452.5516-1-wens@csie.org>
Message-ID: <20180712160452.5516-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AXP806 can operate in a standalone "self-working" mode, in which it
is also responsible for power control of the overall system. This mode
is similar to the master mode, but the EN/PWRON pin functions as a power
button, instead of a level-triggered enable switch.

This patch adds code checking for the new "x-powers,self-working-mode"
property, and a separate mfd_cell list that includes the power button
(PEK) sub-device.

Reviewed-by: Icenowy Zheng <icenowy@aosc.io>
Tested-by: Icenowy Zheng <icenowy@aosc.io>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mfd/axp20x.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 9a2ef3d9b8f8..0be511dd93d0 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -221,6 +221,11 @@ static const struct resource axp803_pek_resources[] = {
 	DEFINE_RES_IRQ_NAMED(AXP803_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
 };
 
+static const struct resource axp806_pek_resources[] = {
+	DEFINE_RES_IRQ_NAMED(AXP806_IRQ_POK_RISE, "PEK_DBR"),
+	DEFINE_RES_IRQ_NAMED(AXP806_IRQ_POK_FALL, "PEK_DBF"),
+};
+
 static const struct resource axp809_pek_resources[] = {
 	DEFINE_RES_IRQ_NAMED(AXP809_IRQ_PEK_RIS_EDGE, "PEK_DBR"),
 	DEFINE_RES_IRQ_NAMED(AXP809_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
@@ -730,6 +735,15 @@ static const struct mfd_cell axp803_cells[] = {
 	{	.name			= "axp20x-regulator" },
 };
 
+static const struct mfd_cell axp806_self_working_cells[] = {
+	{
+		.name			= "axp221-pek",
+		.num_resources		= ARRAY_SIZE(axp806_pek_resources),
+		.resources		= axp806_pek_resources,
+	},
+	{	.name			= "axp20x-regulator" },
+};
+
 static const struct mfd_cell axp806_cells[] = {
 	{
 		.id			= 2,
@@ -842,8 +856,14 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
 		axp20x->regmap_irq_chip = &axp803_regmap_irq_chip;
 		break;
 	case AXP806_ID:
-		axp20x->nr_cells = ARRAY_SIZE(axp806_cells);
-		axp20x->cells = axp806_cells;
+		if (of_property_read_bool(axp20x->dev->of_node,
+					  "x-powers,self-working-mode")) {
+			axp20x->nr_cells = ARRAY_SIZE(axp806_self_working_cells);
+			axp20x->cells = axp806_self_working_cells;
+		} else {
+			axp20x->nr_cells = ARRAY_SIZE(axp806_cells);
+			axp20x->cells = axp806_cells;
+		}
 		axp20x->regmap_cfg = &axp806_regmap_config;
 		axp20x->regmap_irq_chip = &axp806_regmap_irq_chip;
 		break;
@@ -901,7 +921,9 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
 	 */
 	if (axp20x->variant == AXP806_ID) {
 		if (of_property_read_bool(axp20x->dev->of_node,
-					  "x-powers,master-mode"))
+					  "x-powers,master-mode") ||
+		    of_property_read_bool(axp20x->dev->of_node,
+					  "x-powers,self-working-mode"))
 			regmap_write(axp20x->regmap, AXP806_REG_ADDR_EXT,
 				     AXP806_REG_ADDR_EXT_ADDR_MASTER_MODE);
 		else
-- 
2.18.0
