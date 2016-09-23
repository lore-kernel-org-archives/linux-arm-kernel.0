From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 23 Sep 2016 09:22:41 +0200
Subject: [PATCH v3 4/4] regulator: axp20x: add the AXP813
In-Reply-To: <cover.1474621107.git.moinejf@free.fr>
References: <cover.1474621107.git.moinejf@free.fr>
Message-ID: <21ac1fd8ab33185ec2cdb436272f48571695ce54.1474621108.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The X-Powers AXP813 PMIC is close to the AXP803.
It is used in some Allwinner boards as the Sinovoip BananaPi M3+.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 Documentation/devicetree/bindings/mfd/axp20x.txt |   9 +-
 drivers/mfd/axp20x.c                             |   2 +
 drivers/regulator/Makefile                       |   2 +-
 drivers/regulator/axp813.c                       | 229 +++++++++++++++++++++++
 include/linux/mfd/axp20x.h                       |   1 +
 5 files changed, 239 insertions(+), 4 deletions(-)
 create mode 100644 drivers/regulator/axp813.c

diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
index 3332d02..62019fb 100644
--- a/Documentation/devicetree/bindings/mfd/axp20x.txt
+++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
@@ -8,11 +8,12 @@ axp221 (X-Powers)
 axp223 (X-Powers)
 axp803 (X-Powers)
 axp809 (X-Powers)
+axp813 (X-Powers)
 
 Required properties:
 - compatible: "x-powers,axp152", "x-powers,axp202", "x-powers,axp209",
 	      "x-powers,axp221", "x-powers,axp223", "x-powers,axp803",
-	      "x-powers,axp806", "x-powers,axp809"
+	      "x-powers,axp806", "x-powers,axp809", "x-powers,axp813"
 - reg: The I2C slave address or RSB hardware address for the AXP chip
 - interrupt-parent: The parent interrupt controller
 - interrupts: SoC NMI / GPIO interrupt connected to the PMIC's IRQ pin
@@ -87,7 +88,7 @@ LDO_IO1		: LDO		: ips-supply		: GPIO 1
 RTC_LDO		: LDO		: ips-supply		: always on
 DRIVEVBUS	: Enable output	: drivevbus-supply	: external regulator
 
-AXP803 regulators, type, and corresponding input supply names:
+AXP803/AXP813 regulators, type, and corresponding input supply names:
 
 Regulator	  Type		  Supply Name		  Notes
 ---------	  ----		  -----------		  -----
@@ -97,6 +98,7 @@ DCDC3		: DC-DC	buck	: vin3-supply
 DCDC4		: DC-DC	buck	: vin4-supply
 DCDC5		: DC-DC	buck	: vin5-supply
 DCDC6		: DC-DC	buck	: vin6-supply
+DCDC7		: DC-DC	buck	: vin7-supply	: (813 only)
 ALDO1		: LDO		: aldoin-supply	: shared supply
 ALDO2		: LDO		: aldoin-supply	: shared supply
 ALDO3		: LDO		: aldoin-supply	: shared supply
@@ -109,10 +111,11 @@ ELDO2		: LDO		: eldoin-supply	: shared supply
 ELDO3		: LDO		: eldoin-supply	: shared supply
 FLDO1		: LDO		: fldoin-supply	: shared supply
 FLDO2		: LDO		: fldoin-supply	: shared supply
+FLDO3		: LDO		: fldoin-supply	: shared supply (813 only)
 RTC_LDO		: LDO		: ips-supply	: always on
 LDO_IO0		: LDO		: ips-supply	: GPIO 0
 LDO_IO1		: LDO		: ips-supply	: GPIO 1
-DC1SW		: On/Off Switch	:		: DCDC1 secondary output
+DC1SW		: On/Off Switch	:		: DCDC1 secondary output (803 only)
 
 AXP806 regulators, type, and corresponding input supply names:
 
diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 7c90b12..4f2303d 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -41,6 +41,7 @@ static const char * const axp20x_model_names[] = {
 	"AXP803",
 	"AXP806",
 	"AXP809",
+	"AXP813",
 };
 
 static const struct regmap_range axp152_writeable_ranges[] = {
@@ -811,6 +812,7 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
 		axp20x->regmap_irq_chip = &axp288_regmap_irq_chip;
 		break;
 	case AXP803_ID:
+	case AXP813_ID:
 		axp20x->cells = axp803_cells;
 		axp20x->nr_cells = ARRAY_SIZE(axp803_cells);
 		break;
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 2cbb280..a678ba6 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -22,7 +22,7 @@ obj-$(CONFIG_REGULATOR_ARIZONA) += arizona-micsupp.o arizona-ldo1.o
 obj-$(CONFIG_REGULATOR_AS3711) += as3711-regulator.o
 obj-$(CONFIG_REGULATOR_AS3722) += as3722-regulator.o
 obj-$(CONFIG_REGULATOR_AXP20X) += axp20x-regulator.o axp-regulator.o \
-				axp803.o
+				axp803.o axp813.o
 obj-$(CONFIG_REGULATOR_BCM590XX) += bcm590xx-regulator.o
 obj-$(CONFIG_REGULATOR_DA903X)	+= da903x.o
 obj-$(CONFIG_REGULATOR_DA9052)	+= da9052-regulator.o
diff --git a/drivers/regulator/axp813.c b/drivers/regulator/axp813.c
new file mode 100644
index 0000000..99bfaaa
--- /dev/null
+++ b/drivers/regulator/axp813.c
@@ -0,0 +1,229 @@
+/*
+ * AXP813 regulator driver
+ *
+ * Copyright (C) 2016 Jean-Francois Moine <moinejf@free.fr>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/axp20x.h>
+#include <linux/regulator/driver.h>
+#include <linux/sunxi-rsb.h>
+
+#include "axp-regulator.h"
+
+enum {
+	AXP813_DLDO1 = 0,
+	AXP813_DLDO2,
+	AXP813_DLDO3,
+	AXP813_DLDO4,
+	AXP813_ELDO1,
+	AXP813_ELDO2,
+	AXP813_ELDO3,
+	AXP813_FLDO1,
+	AXP813_FLDO2,
+	AXP813_FLDO3,
+	AXP813_DCDC1,
+	AXP813_DCDC2,
+	AXP813_DCDC3,
+	AXP813_DCDC4,
+	AXP813_DCDC5,
+	AXP813_DCDC6,
+	AXP813_DCDC7,
+	AXP813_ALDO1,
+	AXP813_ALDO2,
+	AXP813_ALDO3,
+	AXP813_LDO_IO0,
+	AXP813_LDO_IO1,
+	AXP813_RTC_LDO,
+};
+
+/* AXP813 registers */
+#define AXP813_FLDO1_V_OUT		0x1c
+#define AXP813_FLDO2_V_OUT		0x1d
+#define AXP813_DCDC1_V_OUT		0x20
+#define AXP813_DCDC2_V_OUT		0x21
+#define AXP813_DCDC3_V_OUT		0x22
+#define AXP813_DCDC4_V_OUT		0x23
+#define AXP813_DCDC5_V_OUT		0x24
+#define AXP813_DCDC6_V_OUT		0x25
+#define AXP813_DCDC7_V_OUT		0x26
+
+static const struct regulator_linear_range axp813_dcdc2_4_ranges[] = {
+	REGULATOR_LINEAR_RANGE(500000, 0, 71, 10000),
+	REGULATOR_LINEAR_RANGE(1220000, 72, 76, 20000),
+};
+
+static const struct regulator_linear_range axp813_dcdc5_ranges[] = {
+	REGULATOR_LINEAR_RANGE(800000, 0, 33, 10000),
+	REGULATOR_LINEAR_RANGE(1140000, 34, 69, 20000),
+};
+
+static const struct regulator_linear_range axp813_dcdc6_7_ranges[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0, 51, 10000),
+	REGULATOR_LINEAR_RANGE(1120000, 52, 72, 20000),
+};
+
+static const struct regulator_linear_range axp813_dldo2_ranges[] = {
+	REGULATOR_LINEAR_RANGE(700000, 0, 26, 100000),
+	REGULATOR_LINEAR_RANGE(3400000, 27, 31, 200000),
+};
+
+static const struct regulator_desc axp813_regulators[] = {
+	AXP_DESC(AXP813, DLDO1, "dldo1", "dldoin", 700, 3300, 100,
+		 AXP22X_DLDO1_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(3)),
+	AXP_DESC_RANGES(AXP813, DLDO2, "dldo2", "dldoin", axp813_dldo2_ranges,
+			31, AXP22X_DLDO2_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2,
+			BIT(4)),
+	AXP_DESC(AXP813, DLDO3, "dldo3", "dldoin", 700, 3300, 100,
+		 AXP22X_DLDO3_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(5)),
+	AXP_DESC(AXP813, DLDO4, "dldo4", "dldoin", 700, 3300, 100,
+		 AXP22X_DLDO4_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(6)),
+	AXP_DESC(AXP813, ELDO1, "eldo1", "eldoin", 700, 1900, 50,
+		 AXP22X_ELDO1_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(0)),
+	AXP_DESC(AXP813, ELDO2, "eldo2", "eldoin", 700, 1900, 50,
+		 AXP22X_ELDO2_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(1)),
+	AXP_DESC(AXP813, ELDO3, "eldo3", "eldoin", 700, 1900, 50,
+		 AXP22X_ELDO3_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL2, BIT(2)),
+	AXP_DESC(AXP813, FLDO1, "fldo1", "fldoin", 700, 1450, 50,
+		 AXP813_FLDO1_V_OUT, 0x0f, AXP22X_PWR_OUT_CTRL3, BIT(2)),
+	AXP_DESC(AXP813, FLDO2, "fldo2", "fldoin", 700, 1450, 50,
+		 AXP813_FLDO2_V_OUT, 0x0f, AXP22X_PWR_OUT_CTRL3, BIT(3)),
+/*	FLDO3 not described (output = DCDC5/2 or FLDOIN/2 */
+	AXP_DESC(AXP813, DCDC1, "dcdc1", "vin1", 1600, 3400, 100,
+		 AXP813_DCDC1_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL1, BIT(0)),
+	AXP_DESC_RANGES(AXP813, DCDC2, "dcdc2", "vin2", axp813_dcdc2_4_ranges,
+			76, AXP813_DCDC2_V_OUT, 0x7f, AXP22X_PWR_OUT_CTRL1,
+			BIT(1)),
+	AXP_DESC_RANGES(AXP813, DCDC3, "dcdc3", "vin3", axp813_dcdc2_4_ranges,
+			76, AXP813_DCDC3_V_OUT, 0x7f, AXP22X_PWR_OUT_CTRL1,
+			BIT(2)),
+	AXP_DESC_RANGES(AXP813, DCDC4, "dcdc4", "vin4", axp813_dcdc2_4_ranges,
+			76, AXP813_DCDC4_V_OUT, 0x7f, AXP22X_PWR_OUT_CTRL1,
+			BIT(3)),
+	AXP_DESC_RANGES(AXP813, DCDC5, "dcdc5", "vin5", axp813_dcdc5_ranges,
+			69, AXP813_DCDC5_V_OUT, 0x7f, AXP22X_PWR_OUT_CTRL1,
+			BIT(4)),
+	AXP_DESC_RANGES(AXP813, DCDC6, "dcdc6", "vin6", axp813_dcdc6_7_ranges,
+			72, AXP813_DCDC6_V_OUT, 0x7f, AXP22X_PWR_OUT_CTRL1,
+			BIT(5)),
+	AXP_DESC_RANGES(AXP813, DCDC7, "dcdc7", "vin7", axp813_dcdc6_7_ranges,
+			72, AXP813_DCDC7_V_OUT, 0x7f, AXP22X_PWR_OUT_CTRL1,
+			BIT(6)),
+	AXP_DESC(AXP813, ALDO1, "aldo1", "aldoin", 700, 3300, 100,
+		 AXP22X_ALDO1_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL3, BIT(5)),
+	AXP_DESC(AXP813, ALDO2, "aldo2", "aldoin", 700, 3300, 100,
+		 AXP22X_ALDO2_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL3, BIT(6)),
+	AXP_DESC(AXP813, ALDO3, "aldo3", "aldoin", 700, 3300, 100,
+		 AXP22X_ALDO3_V_OUT, 0x1f, AXP22X_PWR_OUT_CTRL3, BIT(7)),
+	AXP_DESC_IO(AXP813, LDO_IO0, "ldo_io0", "ips", 700, 3300, 100,
+		    AXP22X_LDO_IO0_V_OUT, 0x1f, AXP20X_GPIO0_CTRL, 0x07,
+		    AXP22X_IO_ENABLED, AXP22X_IO_DISABLED),
+	AXP_DESC_IO(AXP813, LDO_IO1, "ldo_io1", "ips", 700, 3300, 100,
+		    AXP22X_LDO_IO1_V_OUT, 0x1f, AXP20X_GPIO1_CTRL, 0x07,
+		    AXP22X_IO_ENABLED, AXP22X_IO_DISABLED),
+	AXP_DESC_FIXED(AXP813, RTC_LDO, "rtc_ldo", "ips", 1800),
+};
+
+static const struct regmap_range axp813_writeable_ranges[] = {
+	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
+	regmap_reg_range(AXP20X_DCDC_MODE, AXP22X_BATLOW_THRES1),
+};
+
+static const struct regmap_range axp813_volatile_ranges[] = {
+	regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP20X_PWR_OP_MODE),
+	regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IRQ5_STATE),
+	regmap_reg_range(AXP22X_GPIO_STATE, AXP22X_GPIO_STATE),
+	regmap_reg_range(AXP20X_FG_RES, AXP20X_FG_RES),
+};
+
+static const struct regmap_access_table axp813_writeable_table = {
+	.yes_ranges	= axp813_writeable_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(axp813_writeable_ranges),
+};
+
+static const struct regmap_access_table axp813_volatile_table = {
+	.yes_ranges	= axp813_volatile_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(axp813_volatile_ranges),
+};
+
+static const struct regmap_config axp813_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.wr_table	= &axp813_writeable_table,
+	.volatile_table	= &axp813_volatile_table,
+	.max_register	= AXP22X_BATLOW_THRES1,
+	.cache_type	= REGCACHE_RBTREE,
+};
+
+#define INIT_REGMAP_IRQ(_irq, _off, _bit)			\
+	[AXP809_IRQ_##_irq] = { .reg_offset = (_off), .mask = BIT(_bit) }
+
+static const struct regmap_irq axp813_regmap_irqs[] = {
+	INIT_REGMAP_IRQ(PEK_RIS_EDGE,	        4, 6),
+	INIT_REGMAP_IRQ(PEK_FAL_EDGE,	        4, 5),
+	INIT_REGMAP_IRQ(PEK_SHORT,		4, 4),
+	INIT_REGMAP_IRQ(PEK_LONG,		4, 3),
+	INIT_REGMAP_IRQ(PEK_OVER_OFF,		4, 2),
+	INIT_REGMAP_IRQ(GPIO1_INPUT,		4, 1),
+	INIT_REGMAP_IRQ(GPIO0_INPUT,		4, 0),
+};
+
+static const struct regmap_irq_chip axp813_regmap_irq_chip = {
+	.name			= "axp813",
+	.status_base		= AXP20X_IRQ1_STATE,
+	.ack_base		= AXP20X_IRQ1_STATE,
+	.mask_base		= AXP20X_IRQ1_EN,
+	.mask_invert		= true,
+	.init_ack_masked	= true,
+	.irqs			= axp813_regmap_irqs,
+	.num_irqs		= ARRAY_SIZE(axp813_regmap_irqs),
+	.num_regs		= 6,
+};
+
+static const struct axp_cfg axp813_cfg = {
+	.regulators = axp813_regulators,
+	.nregulators= ARRAY_SIZE(axp813_regulators),
+	.dcdc1_ix = -1,
+	.dcdc5_ix = -1,
+	.dc1sw_ix = -1,
+	.dc5ldo_ix = -1,
+	.skip_bitmap = 1 << AXP813_FLDO3,
+};
+
+static struct axp20x_dev axp813_dev = {
+	.regmap_cfg = &axp813_regmap_config,
+	.regmap_irq_chip = &axp813_regmap_irq_chip,
+};
+
+static int axp813_rsb_probe(struct sunxi_rsb_device *rdev)
+{
+	return axp_rsb_probe(rdev, &axp813_dev, &axp813_cfg);
+}
+
+static const struct of_device_id axp813_of_match[] = {
+	{ .compatible = "x-powers,axp813", .data = (void *) AXP813_ID },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, axp813_of_match);
+
+static struct sunxi_rsb_driver axp813_rsb_driver = {
+	.driver = {
+		.name	= "axp813-rsb",
+		.of_match_table	= of_match_ptr(axp813_of_match),
+	},
+	.probe	= axp813_rsb_probe,
+	.remove	= axp_rsb_remove,
+};
+module_sunxi_rsb_driver(axp813_rsb_driver);
+
+MODULE_DESCRIPTION("AXP813 RSB driver");
+MODULE_AUTHOR("Jean-Francois Moine <moinejf@free.fr>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 9c5fb00..90296f0 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -23,6 +23,7 @@ enum {
 	AXP803_ID,
 	AXP806_ID,
 	AXP809_ID,
+	AXP813_ID,
 	NR_AXP20X_VARIANTS,
 };
 
-- 
2.10.0
