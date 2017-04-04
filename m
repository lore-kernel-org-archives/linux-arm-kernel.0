From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed,  5 Apr 2017 02:01:38 +0800
Subject: [PATCH 04/11] mfd: axp20x: support AXP803 variant
In-Reply-To: <20170404180145.12897-1-icenowy@aosc.io>
References: <20170404180145.12897-1-icenowy@aosc.io>
Message-ID: <20170404180145.12897-5-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AXP803 is a new PMIC chip produced by X-Powers, usually paired with A64
via RSB bus. The PMIC itself is like AXP288, but with RSB support and
dedicated VBUS and ACIN.

Add support for it in the axp20x mfd driver.

Currently only power key function is supported.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/mfd/axp20x-rsb.c   |   1 +
 drivers/mfd/axp20x.c       | 113 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/axp20x.h |  40 +++++++++++++++-
 3 files changed, 153 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x-rsb.c b/drivers/mfd/axp20x-rsb.c
index a732cb50bcff..3ff8a7d1ce88 100644
--- a/drivers/mfd/axp20x-rsb.c
+++ b/drivers/mfd/axp20x-rsb.c
@@ -63,6 +63,7 @@ static const struct of_device_id axp20x_rsb_of_match[] = {
 	{ .compatible = "x-powers,axp223", .data = (void *)AXP223_ID },
 	{ .compatible = "x-powers,axp806", .data = (void *)AXP806_ID },
 	{ .compatible = "x-powers,axp809", .data = (void *)AXP809_ID },
+	{ .compatible = "x-powers,axp803", .data = (void *)AXP803_ID },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, axp20x_rsb_of_match);
diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 5ba3b04cc9b1..e468e08d84db 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -43,6 +43,7 @@ static const char * const axp20x_model_names[] = {
 	"AXP288",
 	"AXP806",
 	"AXP809",
+	"AXP803",
 };
 
 static const struct regmap_range axp152_writeable_ranges[] = {
@@ -165,6 +166,32 @@ static const struct regmap_access_table axp806_volatile_table = {
 	.n_yes_ranges	= ARRAY_SIZE(axp806_volatile_ranges),
 };
 
+static const struct regmap_range axp803_writeable_ranges[] = {
+	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ6_STATE),
+	regmap_reg_range(AXP20X_DCDC_MODE, AXP288_FG_TUNE5),
+};
+
+static const struct regmap_range axp803_volatile_ranges[] = {
+	regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP288_POWER_REASON),
+	regmap_reg_range(AXP288_BC_GLOBAL, AXP288_BC_GLOBAL),
+	regmap_reg_range(AXP288_BC_DET_STAT, AXP288_BC_DET_STAT),
+	regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IPSOUT_V_HIGH_L),
+	regmap_reg_range(AXP20X_TIMER_CTRL, AXP20X_TIMER_CTRL),
+	regmap_reg_range(AXP22X_GPIO_STATE, AXP22X_GPIO_STATE),
+	regmap_reg_range(AXP288_RT_BATT_V_H, AXP288_RT_BATT_V_L),
+	regmap_reg_range(AXP20X_FG_RES, AXP288_FG_CC_CAP_REG),
+};
+
+static const struct regmap_access_table axp803_writeable_table = {
+	.yes_ranges	= axp803_writeable_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(axp803_writeable_ranges),
+};
+
+static const struct regmap_access_table axp803_volatile_table = {
+	.yes_ranges	= axp803_volatile_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(axp803_volatile_ranges),
+};
+
 static struct resource axp152_pek_resources[] = {
 	DEFINE_RES_IRQ_NAMED(AXP152_IRQ_PEK_RIS_EDGE, "PEK_DBR"),
 	DEFINE_RES_IRQ_NAMED(AXP152_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
@@ -278,6 +305,20 @@ static struct resource axp809_pek_resources[] = {
 	},
 };
 
+static struct resource axp803_pek_resources[] = {
+	{
+		.name   = "PEK_DBR",
+		.start  = AXP803_IRQ_PEK_RIS_EDGE,
+		.end    = AXP803_IRQ_PEK_RIS_EDGE,
+		.flags  = IORESOURCE_IRQ,
+	}, {
+		.name   = "PEK_DBF",
+		.start  = AXP803_IRQ_PEK_FAL_EDGE,
+		.end    = AXP803_IRQ_PEK_FAL_EDGE,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
 static const struct regmap_config axp152_regmap_config = {
 	.reg_bits	= 8,
 	.val_bits	= 8,
@@ -323,6 +364,15 @@ static const struct regmap_config axp806_regmap_config = {
 	.cache_type	= REGCACHE_RBTREE,
 };
 
+static const struct regmap_config axp803_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.wr_table	= &axp803_writeable_table,
+	.volatile_table	= &axp803_volatile_table,
+	.max_register	= AXP288_FG_TUNE5,
+	.cache_type	= REGCACHE_RBTREE,
+};
+
 #define INIT_REGMAP_IRQ(_variant, _irq, _off, _mask)			\
 	[_variant##_IRQ_##_irq] = { .reg_offset = (_off), .mask = BIT(_mask) }
 
@@ -507,6 +557,43 @@ static const struct regmap_irq axp809_regmap_irqs[] = {
 	INIT_REGMAP_IRQ(AXP809, GPIO0_INPUT,		4, 0),
 };
 
+static const struct regmap_irq axp803_regmap_irqs[] = {
+	INIT_REGMAP_IRQ(AXP803, ACIN_OVER_V,		0, 7),
+	INIT_REGMAP_IRQ(AXP803, ACIN_PLUGIN,		0, 6),
+	INIT_REGMAP_IRQ(AXP803, ACIN_REMOVAL,	        0, 5),
+	INIT_REGMAP_IRQ(AXP803, VBUS_OVER_V,		0, 4),
+	INIT_REGMAP_IRQ(AXP803, VBUS_PLUGIN,		0, 3),
+	INIT_REGMAP_IRQ(AXP803, VBUS_REMOVAL,	        0, 2),
+	INIT_REGMAP_IRQ(AXP803, BATT_PLUGIN,		1, 7),
+	INIT_REGMAP_IRQ(AXP803, BATT_REMOVAL,	        1, 6),
+	INIT_REGMAP_IRQ(AXP803, BATT_ENT_ACT_MODE,	1, 5),
+	INIT_REGMAP_IRQ(AXP803, BATT_EXIT_ACT_MODE,	1, 4),
+	INIT_REGMAP_IRQ(AXP803, CHARG,		        1, 3),
+	INIT_REGMAP_IRQ(AXP803, CHARG_DONE,		1, 2),
+	INIT_REGMAP_IRQ(AXP803, BATT_CHG_TEMP_HIGH,	2, 7),
+	INIT_REGMAP_IRQ(AXP803, BATT_CHG_TEMP_HIGH_END,	2, 6),
+	INIT_REGMAP_IRQ(AXP803, BATT_CHG_TEMP_LOW,	2, 5),
+	INIT_REGMAP_IRQ(AXP803, BATT_CHG_TEMP_LOW_END,	2, 4),
+	INIT_REGMAP_IRQ(AXP803, BATT_ACT_TEMP_HIGH,	2, 3),
+	INIT_REGMAP_IRQ(AXP803, BATT_ACT_TEMP_HIGH_END,	2, 2),
+	INIT_REGMAP_IRQ(AXP803, BATT_ACT_TEMP_LOW,	2, 1),
+	INIT_REGMAP_IRQ(AXP803, BATT_ACT_TEMP_LOW_END,	2, 0),
+	INIT_REGMAP_IRQ(AXP803, DIE_TEMP_HIGH,	        3, 7),
+	INIT_REGMAP_IRQ(AXP803, GPADC,		        3, 2),
+	INIT_REGMAP_IRQ(AXP803, LOW_PWR_LVL1,	        3, 1),
+	INIT_REGMAP_IRQ(AXP803, LOW_PWR_LVL2,	        3, 0),
+	INIT_REGMAP_IRQ(AXP803, TIMER,		        4, 7),
+	INIT_REGMAP_IRQ(AXP803, PEK_RIS_EDGE,	        4, 6),
+	INIT_REGMAP_IRQ(AXP803, PEK_FAL_EDGE,	        4, 5),
+	INIT_REGMAP_IRQ(AXP803, PEK_SHORT,		4, 4),
+	INIT_REGMAP_IRQ(AXP803, PEK_LONG,		4, 3),
+	INIT_REGMAP_IRQ(AXP803, PEK_OVER_OFF,		4, 2),
+	INIT_REGMAP_IRQ(AXP803, GPIO1_INPUT,		4, 1),
+	INIT_REGMAP_IRQ(AXP803, GPIO0_INPUT,		4, 0),
+	INIT_REGMAP_IRQ(AXP803, BC_USB_CHNG,            5, 1),
+	INIT_REGMAP_IRQ(AXP803, MV_CHNG,                5, 0),
+};
+
 static const struct regmap_irq_chip axp152_regmap_irq_chip = {
 	.name			= "axp152_irq_chip",
 	.status_base		= AXP152_IRQ1_STATE,
@@ -581,6 +668,18 @@ static const struct regmap_irq_chip axp809_regmap_irq_chip = {
 	.num_regs		= 5,
 };
 
+static const struct regmap_irq_chip axp803_regmap_irq_chip = {
+	.name			= "axp803",
+	.status_base		= AXP20X_IRQ1_STATE,
+	.ack_base		= AXP20X_IRQ1_STATE,
+	.mask_base		= AXP20X_IRQ1_EN,
+	.mask_invert		= true,
+	.init_ack_masked	= true,
+	.irqs			= axp803_regmap_irqs,
+	.num_irqs		= ARRAY_SIZE(axp803_regmap_irqs),
+	.num_regs		= 6,
+};
+
 static struct mfd_cell axp20x_cells[] = {
 	{
 		.name		= "axp20x-gpio",
@@ -787,6 +886,14 @@ static struct mfd_cell axp809_cells[] = {
 	},
 };
 
+static struct mfd_cell axp803_cells[] = {
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
@@ -867,6 +974,12 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
 		axp20x->regmap_cfg = &axp22x_regmap_config;
 		axp20x->regmap_irq_chip = &axp809_regmap_irq_chip;
 		break;
+	case AXP803_ID:
+		axp20x->nr_cells = ARRAY_SIZE(axp803_cells);
+		axp20x->cells = axp803_cells;
+		axp20x->regmap_cfg = &axp803_regmap_config;
+		axp20x->regmap_irq_chip = &axp803_regmap_irq_chip;
+		break;
 	default:
 		dev_err(dev, "unsupported AXP20X ID %lu\n", axp20x->variant);
 		return -EINVAL;
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index dc8798cf2a24..b3220ef374d3 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -22,6 +22,7 @@ enum axp20x_variants {
 	AXP288_ID,
 	AXP806_ID,
 	AXP809_ID,
+	AXP803_ID,
 	NR_AXP20X_VARIANTS,
 };
 
@@ -234,7 +235,7 @@ enum axp20x_variants {
 #define AXP22X_TS_ADC_L			0x59
 #define AXP22X_BATLOW_THRES1		0xe6
 
-/* AXP288 specific registers */
+/* AXP288/AXP803 specific registers */
 #define AXP288_POWER_REASON		0x02
 #define AXP288_BC_GLOBAL		0x2c
 #define AXP288_BC_VBUS_CNTL		0x2d
@@ -525,6 +526,43 @@ enum axp809_irqs {
 	AXP809_IRQ_GPIO0_INPUT,
 };
 
+enum axp803_irqs {
+	AXP803_IRQ_ACIN_OVER_V = 1,
+	AXP803_IRQ_ACIN_PLUGIN,
+	AXP803_IRQ_ACIN_REMOVAL,
+	AXP803_IRQ_VBUS_OVER_V,
+	AXP803_IRQ_VBUS_PLUGIN,
+	AXP803_IRQ_VBUS_REMOVAL,
+	AXP803_IRQ_BATT_PLUGIN,
+	AXP803_IRQ_BATT_REMOVAL,
+	AXP803_IRQ_BATT_ENT_ACT_MODE,
+	AXP803_IRQ_BATT_EXIT_ACT_MODE,
+	AXP803_IRQ_CHARG,
+	AXP803_IRQ_CHARG_DONE,
+	AXP803_IRQ_BATT_CHG_TEMP_HIGH,
+	AXP803_IRQ_BATT_CHG_TEMP_HIGH_END,
+	AXP803_IRQ_BATT_CHG_TEMP_LOW,
+	AXP803_IRQ_BATT_CHG_TEMP_LOW_END,
+	AXP803_IRQ_BATT_ACT_TEMP_HIGH,
+	AXP803_IRQ_BATT_ACT_TEMP_HIGH_END,
+	AXP803_IRQ_BATT_ACT_TEMP_LOW,
+	AXP803_IRQ_BATT_ACT_TEMP_LOW_END,
+	AXP803_IRQ_DIE_TEMP_HIGH,
+	AXP803_IRQ_GPADC,
+	AXP803_IRQ_LOW_PWR_LVL1,
+	AXP803_IRQ_LOW_PWR_LVL2,
+	AXP803_IRQ_TIMER,
+	AXP803_IRQ_PEK_RIS_EDGE,
+	AXP803_IRQ_PEK_FAL_EDGE,
+	AXP803_IRQ_PEK_SHORT,
+	AXP803_IRQ_PEK_LONG,
+	AXP803_IRQ_PEK_OVER_OFF,
+	AXP803_IRQ_GPIO1_INPUT,
+	AXP803_IRQ_GPIO0_INPUT,
+	AXP803_IRQ_BC_USB_CHNG,
+	AXP803_IRQ_MV_CHNG,
+};
+
 struct axp20x_dev {
 	struct device			*dev;
 	int				irq;
-- 
2.12.2
