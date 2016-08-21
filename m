From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 21 Aug 2016 10:11:18 +0800
Subject: [PATCH 2/9] mfd: axp20x: Add support for AXP806 PMIC
In-Reply-To: <20160821021125.1521-1-wens@csie.org>
References: <20160821021125.1521-1-wens@csie.org>
Message-ID: <20160821021125.1521-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The X-Powers AXP809 is a new PMIC that is paired with Allwinner's A80
SoC, along with a master AXP809 PMIC.

This PMIC has a new register layout, and supports some functions not
seen in other X-Powers PMICs, such as master-slave mode, or having
multiple AXP806 PMICs on the same bus with address space extension,
or supporting both I2C and RSB mode. I2C has not been tested.

This patch adds support for the interrupts of the PMIC. A regulator
sub-device is enabled, but actual regulator support will come in a
later patch.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mfd/axp20x-rsb.c   |  1 +
 drivers/mfd/axp20x.c       | 72 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/axp20x.h | 60 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+)

diff --git a/drivers/mfd/axp20x-rsb.c b/drivers/mfd/axp20x-rsb.c
index a407527bcd09..a732cb50bcff 100644
--- a/drivers/mfd/axp20x-rsb.c
+++ b/drivers/mfd/axp20x-rsb.c
@@ -61,6 +61,7 @@ static int axp20x_rsb_remove(struct sunxi_rsb_device *rdev)
 
 static const struct of_device_id axp20x_rsb_of_match[] = {
 	{ .compatible = "x-powers,axp223", .data = (void *)AXP223_ID },
+	{ .compatible = "x-powers,axp806", .data = (void *)AXP806_ID },
 	{ .compatible = "x-powers,axp809", .data = (void *)AXP809_ID },
 	{ },
 };
diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index fd80b0981f0f..96102753847f 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -38,6 +38,7 @@ static const char * const axp20x_model_names[] = {
 	"AXP221",
 	"AXP223",
 	"AXP288",
+	"AXP806",
 	"AXP809",
 };
 
@@ -129,6 +130,27 @@ static const struct regmap_access_table axp288_volatile_table = {
 	.n_yes_ranges	= ARRAY_SIZE(axp288_volatile_ranges),
 };
 
+static const struct regmap_range axp806_writeable_ranges[] = {
+	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_DATACACHE(3)),
+	regmap_reg_range(AXP806_PWR_OUT_CTRL1, AXP806_CLDO3_V_CTRL),
+	regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IRQ2_EN),
+	regmap_reg_range(AXP20X_IRQ1_STATE, AXP20X_IRQ2_STATE),
+};
+
+static const struct regmap_range axp806_volatile_ranges[] = {
+	regmap_reg_range(AXP20X_IRQ1_STATE, AXP20X_IRQ2_STATE),
+};
+
+static const struct regmap_access_table axp806_writeable_table = {
+	.yes_ranges	= axp806_writeable_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(axp806_writeable_ranges),
+};
+
+static const struct regmap_access_table axp806_volatile_table = {
+	.yes_ranges	= axp806_volatile_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(axp806_volatile_ranges),
+};
+
 static struct resource axp152_pek_resources[] = {
 	DEFINE_RES_IRQ_NAMED(AXP152_IRQ_PEK_RIS_EDGE, "PEK_DBR"),
 	DEFINE_RES_IRQ_NAMED(AXP152_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
@@ -278,6 +300,15 @@ static const struct regmap_config axp288_regmap_config = {
 	.cache_type	= REGCACHE_RBTREE,
 };
 
+static const struct regmap_config axp806_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.wr_table	= &axp806_writeable_table,
+	.volatile_table	= &axp806_volatile_table,
+	.max_register	= AXP806_VREF_TEMP_WARN_L,
+	.cache_type	= REGCACHE_RBTREE,
+};
+
 #define INIT_REGMAP_IRQ(_variant, _irq, _off, _mask)			\
 	[_variant##_IRQ_##_irq] = { .reg_offset = (_off), .mask = BIT(_mask) }
 
@@ -409,6 +440,21 @@ static const struct regmap_irq axp288_regmap_irqs[] = {
 	INIT_REGMAP_IRQ(AXP288, BC_USB_CHNG,            5, 1),
 };
 
+static const struct regmap_irq axp806_regmap_irqs[] = {
+	INIT_REGMAP_IRQ(AXP806, DIE_TEMP_HIGH_LV1,	0, 0),
+	INIT_REGMAP_IRQ(AXP806, DIE_TEMP_HIGH_LV2,	0, 1),
+	INIT_REGMAP_IRQ(AXP806, DCDCA_V_LOW,		0, 3),
+	INIT_REGMAP_IRQ(AXP806, DCDCB_V_LOW,		0, 4),
+	INIT_REGMAP_IRQ(AXP806, DCDCC_V_LOW,		0, 5),
+	INIT_REGMAP_IRQ(AXP806, DCDCD_V_LOW,		0, 6),
+	INIT_REGMAP_IRQ(AXP806, DCDCE_V_LOW,		0, 7),
+	INIT_REGMAP_IRQ(AXP806, PWROK_LONG,		1, 0),
+	INIT_REGMAP_IRQ(AXP806, PWROK_SHORT,		1, 1),
+	INIT_REGMAP_IRQ(AXP806, WAKEUP,			1, 4),
+	INIT_REGMAP_IRQ(AXP806, PWROK_FALL,		1, 5),
+	INIT_REGMAP_IRQ(AXP806, PWROK_RISE,		1, 6),
+};
+
 static const struct regmap_irq axp809_regmap_irqs[] = {
 	INIT_REGMAP_IRQ(AXP809, ACIN_OVER_V,		0, 7),
 	INIT_REGMAP_IRQ(AXP809, ACIN_PLUGIN,		0, 6),
@@ -494,6 +540,18 @@ static const struct regmap_irq_chip axp288_regmap_irq_chip = {
 
 };
 
+static const struct regmap_irq_chip axp806_regmap_irq_chip = {
+	.name			= "axp806",
+	.status_base		= AXP20X_IRQ1_STATE,
+	.ack_base		= AXP20X_IRQ1_STATE,
+	.mask_base		= AXP20X_IRQ1_EN,
+	.mask_invert		= true,
+	.init_ack_masked	= true,
+	.irqs			= axp806_regmap_irqs,
+	.num_irqs		= ARRAY_SIZE(axp806_regmap_irqs),
+	.num_regs		= 2,
+};
+
 static const struct regmap_irq_chip axp809_regmap_irq_chip = {
 	.name			= "axp809",
 	.status_base		= AXP20X_IRQ1_STATE,
@@ -660,12 +718,20 @@ static struct mfd_cell axp288_cells[] = {
 	},
 };
 
+static struct mfd_cell axp806_cells[] = {
+	{
+		.id			= 2,
+		.name			= "axp20x-regulator",
+	},
+};
+
 static struct mfd_cell axp809_cells[] = {
 	{
 		.name			= "axp20x-pek",
 		.num_resources		= ARRAY_SIZE(axp809_pek_resources),
 		.resources		= axp809_pek_resources,
 	}, {
+		.id			= 1,
 		.name			= "axp20x-regulator",
 	},
 };
@@ -732,6 +798,12 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
 		axp20x->regmap_cfg = &axp288_regmap_config;
 		axp20x->regmap_irq_chip = &axp288_regmap_irq_chip;
 		break;
+	case AXP806_ID:
+		axp20x->nr_cells = ARRAY_SIZE(axp806_cells);
+		axp20x->cells = axp806_cells;
+		axp20x->regmap_cfg = &axp806_regmap_config;
+		axp20x->regmap_irq_chip = &axp806_regmap_irq_chip;
+		break;
 	case AXP809_ID:
 		axp20x->nr_cells = ARRAY_SIZE(axp809_cells);
 		axp20x->cells = axp809_cells;
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 0be4982f08fe..fec597fb34cb 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -20,6 +20,7 @@ enum {
 	AXP221_ID,
 	AXP223_ID,
 	AXP288_ID,
+	AXP806_ID,
 	AXP809_ID,
 	NR_AXP20X_VARIANTS,
 };
@@ -91,6 +92,30 @@ enum {
 #define AXP22X_ALDO3_V_OUT		0x2a
 #define AXP22X_CHRG_CTRL3		0x35
 
+#define AXP806_STARTUP_SRC		0x00
+#define AXP806_CHIP_ID			0x03
+#define AXP806_PWR_OUT_CTRL1		0x10
+#define AXP806_PWR_OUT_CTRL2		0x11
+#define AXP806_DCDCA_V_CTRL		0x12
+#define AXP806_DCDCB_V_CTRL		0x13
+#define AXP806_DCDCC_V_CTRL		0x14
+#define AXP806_DCDCD_V_CTRL		0x15
+#define AXP806_DCDCE_V_CTRL		0x16
+#define AXP806_ALDO1_V_CTRL		0x17
+#define AXP806_ALDO2_V_CTRL		0x18
+#define AXP806_ALDO3_V_CTRL		0x19
+#define AXP806_DCDC_MODE_CTRL1		0x1a
+#define AXP806_DCDC_MODE_CTRL2		0x1b
+#define AXP806_DCDC_FREQ_CTRL		0x1c
+#define AXP806_BLDO1_V_CTRL		0x20
+#define AXP806_BLDO2_V_CTRL		0x21
+#define AXP806_BLDO3_V_CTRL		0x22
+#define AXP806_BLDO4_V_CTRL		0x23
+#define AXP806_CLDO1_V_CTRL		0x24
+#define AXP806_CLDO2_V_CTRL		0x25
+#define AXP806_CLDO3_V_CTRL		0x26
+#define AXP806_VREF_TEMP_WARN_L		0xf3
+
 /* Interrupt */
 #define AXP152_IRQ1_EN			0x40
 #define AXP152_IRQ2_EN			0x41
@@ -266,6 +291,26 @@ enum {
 };
 
 enum {
+	AXP806_DCDCA = 0,
+	AXP806_DCDCB,
+	AXP806_DCDCC,
+	AXP806_DCDCD,
+	AXP806_DCDCE,
+	AXP806_ALDO1,
+	AXP806_ALDO2,
+	AXP806_ALDO3,
+	AXP806_BLDO1,
+	AXP806_BLDO2,
+	AXP806_BLDO3,
+	AXP806_BLDO4,
+	AXP806_CLDO1,
+	AXP806_CLDO2,
+	AXP806_CLDO3,
+	AXP806_SW,
+	AXP806_REG_ID_MAX,
+};
+
+enum {
 	AXP809_DCDC1 = 0,
 	AXP809_DCDC2,
 	AXP809_DCDC3,
@@ -414,6 +459,21 @@ enum axp288_irqs {
 	AXP288_IRQ_BC_USB_CHNG,
 };
 
+enum axp806_irqs {
+	AXP806_IRQ_DIE_TEMP_HIGH_LV1,
+	AXP806_IRQ_DIE_TEMP_HIGH_LV2,
+	AXP806_IRQ_DCDCA_V_LOW,
+	AXP806_IRQ_DCDCB_V_LOW,
+	AXP806_IRQ_DCDCC_V_LOW,
+	AXP806_IRQ_DCDCD_V_LOW,
+	AXP806_IRQ_DCDCE_V_LOW,
+	AXP806_IRQ_PWROK_LONG,
+	AXP806_IRQ_PWROK_SHORT,
+	AXP806_IRQ_WAKEUP,
+	AXP806_IRQ_PWROK_FALL,
+	AXP806_IRQ_PWROK_RISE,
+};
+
 enum axp809_irqs {
 	AXP809_IRQ_ACIN_OVER_V = 1,
 	AXP809_IRQ_ACIN_PLUGIN,
-- 
2.9.3
