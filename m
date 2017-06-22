From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 22 Jun 2017 12:08:30 +0800
Subject: [PATCH 3/6] mfd: axp20x: Add support for AXP813 PMIC
In-Reply-To: <20170622040833.15329-1-wens@csie.org>
References: <20170622040833.15329-1-wens@csie.org>
Message-ID: <20170622040833.15329-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The X-Powers AXP813 PMIC is normally used with Allwinner's A83T SoC.
It has the same range of functions as other X-Powers PMICs, such as
DC-DC buck converter and linear regulator outputs, AC-IN and VBUS
power supplies, power button trigger, GPIOs, ADCs, and a battery
charger.

Note that the IRQ table given in the datasheet is incorrect: in IRQ
enable/status registers 1, there are separate IRQs for ACIN and VBUS,
instead of bits [7:5] being the same as bits [4:2]. So it shares the
same IRQs as the AXP803, rather than the AXP288.

This patch adds basic mfd support for it, with only the power button
enabled.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mfd/axp20x-rsb.c   |  1 +
 drivers/mfd/axp20x.c       | 22 ++++++++++++++++++++++
 include/linux/mfd/axp20x.h | 29 +++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/drivers/mfd/axp20x-rsb.c b/drivers/mfd/axp20x-rsb.c
index fd5c7267b136..7ddbd9e8dd03 100644
--- a/drivers/mfd/axp20x-rsb.c
+++ b/drivers/mfd/axp20x-rsb.c
@@ -64,6 +64,7 @@ static const struct of_device_id axp20x_rsb_of_match[] = {
 	{ .compatible = "x-powers,axp803", .data = (void *)AXP803_ID },
 	{ .compatible = "x-powers,axp806", .data = (void *)AXP806_ID },
 	{ .compatible = "x-powers,axp809", .data = (void *)AXP809_ID },
+	{ .compatible = "x-powers,axp813", .data = (void *)AXP813_ID },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, axp20x_rsb_of_match);
diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 917b6ddc4f15..ec4271ca065c 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -44,6 +44,7 @@ static const char * const axp20x_model_names[] = {
 	"AXP803",
 	"AXP806",
 	"AXP809",
+	"AXP813",
 };
 
 static const struct regmap_range axp152_writeable_ranges[] = {
@@ -870,6 +871,14 @@ static struct mfd_cell axp809_cells[] = {
 	},
 };
 
+static struct mfd_cell axp813_cells[] = {
+	{
+		.name			= "axp20x-pek",
+		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
+		.resources		= axp803_pek_resources,
+	}
+};
+
 static struct axp20x_dev *axp20x_pm_power_off;
 static void axp20x_power_off(void)
 {
@@ -956,6 +965,19 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
 		axp20x->regmap_cfg = &axp22x_regmap_config;
 		axp20x->regmap_irq_chip = &axp809_regmap_irq_chip;
 		break;
+	case AXP813_ID:
+		axp20x->nr_cells = ARRAY_SIZE(axp813_cells);
+		axp20x->cells = axp813_cells;
+		axp20x->regmap_cfg = &axp288_regmap_config;
+		/*
+		 * The IRQ table given in the datasheet is incorrect.
+		 * In IRQ enable/status registers 1, there are separate
+		 * IRQs for ACIN and VBUS, instead of bits [7:5] being
+		 * the same as bits [4:2]. So it shares the same IRQs
+		 * as the AXP803, rather than the AXP288.
+		 */
+		axp20x->regmap_irq_chip = &axp803_regmap_irq_chip;
+		break;
 	default:
 		dev_err(dev, "unsupported AXP20X ID %lu\n", axp20x->variant);
 		return -EINVAL;
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 965b027e31b3..e9c908c4fba8 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -23,6 +23,7 @@ enum axp20x_variants {
 	AXP803_ID,
 	AXP806_ID,
 	AXP809_ID,
+	AXP813_ID,
 	NR_AXP20X_VARIANTS,
 };
 
@@ -387,6 +388,34 @@ enum {
 	AXP803_REG_ID_MAX,
 };
 
+enum {
+	AXP813_DCDC1 = 0,
+	AXP813_DCDC2,
+	AXP813_DCDC3,
+	AXP813_DCDC4,
+	AXP813_DCDC5,
+	AXP813_DCDC6,
+	AXP813_DCDC7,
+	AXP813_ALDO1,
+	AXP813_ALDO2,
+	AXP813_ALDO3,
+	AXP813_DLDO1,
+	AXP813_DLDO2,
+	AXP813_DLDO3,
+	AXP813_DLDO4,
+	AXP813_ELDO1,
+	AXP813_ELDO2,
+	AXP813_ELDO3,
+	AXP813_FLDO1,
+	AXP813_FLDO2,
+	AXP813_FLDO3,
+	AXP813_RTC_LDO,
+	AXP813_LDO_IO0,
+	AXP813_LDO_IO1,
+	AXP813_SW,
+	AXP813_REG_ID_MAX,
+};
+
 /* IRQs */
 enum {
 	AXP152_IRQ_LDO0IN_CONNECT = 1,
-- 
2.11.0
