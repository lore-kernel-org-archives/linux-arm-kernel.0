From: rask@formelder.dk (Rask Ingemann Lambertsen)
Date: Thu, 26 Jan 2017 22:25:40 +0100 (CET)
Subject: [PATCH 3/5] mfd: axp20x: Add support for the AXP808 PMIC
In-Reply-To: <cover.1485456003.git.rask@formelder.dk>
References: <cover.1485456003.git.rask@formelder.dk>
Message-ID: <e1d6d6acfaa95e214b6baa73a7edeaa8e6af3670.1485456006.git.rask@formelder.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The X-Powers AXP808 is a PMIC which, like the very similar AXP806, is
used on boards featuring Allwinner's A80 SoC. Unlike the AXP806, it
doesn't support address space extension and its associated registers,
but the two are otherwise identical (including the chip ID).

This patch adds support for the interrupts on the AXP808 and enables
the regulator sub-device. The next patch in the series adds the actual
regulator support.

Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>
---
 drivers/mfd/axp20x-rsb.c   |  1 +
 drivers/mfd/axp20x.c       | 28 ++++++++++++++++++++++++++++
 include/linux/mfd/axp20x.h |  1 +
 3 files changed, 30 insertions(+)

diff --git a/drivers/mfd/axp20x-rsb.c b/drivers/mfd/axp20x-rsb.c
index a732cb5..96ea2e9 100644
--- a/drivers/mfd/axp20x-rsb.c
+++ b/drivers/mfd/axp20x-rsb.c
@@ -62,6 +62,7 @@ static int axp20x_rsb_remove(struct sunxi_rsb_device *rdev)
 static const struct of_device_id axp20x_rsb_of_match[] = {
 	{ .compatible = "x-powers,axp223", .data = (void *)AXP223_ID },
 	{ .compatible = "x-powers,axp806", .data = (void *)AXP806_ID },
+	{ .compatible = "x-powers,axp808", .data = (void *)AXP808_ID },
 	{ .compatible = "x-powers,axp809", .data = (void *)AXP809_ID },
 	{ },
 };
diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 25115fe..2d3383e 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -41,6 +41,7 @@ static const char * const axp20x_model_names[] = {
 	"AXP223",
 	"AXP288",
 	"AXP806",
+	"AXP808",
 	"AXP809",
 };
 
@@ -148,6 +149,13 @@ static const struct regmap_range axp806_writeable_ranges[] = {
 	regmap_reg_range(AXP806_REG_ADDR_EXT, AXP806_REG_ADDR_EXT),
 };
 
+static const struct regmap_range axp808_writeable_ranges[] = {
+	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_DATACACHE(3)),
+	regmap_reg_range(AXP806_PWR_OUT_CTRL1, AXP806_CLDO3_V_CTRL),
+	regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IRQ2_EN),
+	regmap_reg_range(AXP20X_IRQ1_STATE, AXP20X_IRQ2_STATE),
+};
+
 static const struct regmap_range axp806_volatile_ranges[] = {
 	regmap_reg_range(AXP20X_IRQ1_STATE, AXP20X_IRQ2_STATE),
 };
@@ -162,6 +170,11 @@ static const struct regmap_access_table axp806_volatile_table = {
 	.n_yes_ranges	= ARRAY_SIZE(axp806_volatile_ranges),
 };
 
+static const struct regmap_access_table axp808_writeable_table = {
+	.yes_ranges	= axp808_writeable_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(axp808_writeable_ranges),
+};
+
 static struct resource axp152_pek_resources[] = {
 	DEFINE_RES_IRQ_NAMED(AXP152_IRQ_PEK_RIS_EDGE, "PEK_DBR"),
 	DEFINE_RES_IRQ_NAMED(AXP152_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
@@ -320,6 +333,15 @@ static const struct regmap_config axp806_regmap_config = {
 	.cache_type	= REGCACHE_RBTREE,
 };
 
+static const struct regmap_config axp808_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.wr_table	= &axp808_writeable_table,
+	.volatile_table	= &axp806_volatile_table,
+	.max_register	= AXP806_VREF_TEMP_WARN_L,
+	.cache_type	= REGCACHE_RBTREE,
+};
+
 #define INIT_REGMAP_IRQ(_variant, _irq, _off, _mask)			\
 	[_variant##_IRQ_##_irq] = { .reg_offset = (_off), .mask = BIT(_mask) }
 
@@ -842,6 +864,12 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
 		axp20x->regmap_cfg = &axp806_regmap_config;
 		axp20x->regmap_irq_chip = &axp806_regmap_irq_chip;
 		break;
+	case AXP808_ID:
+		axp20x->nr_cells = ARRAY_SIZE(axp806_cells);
+		axp20x->cells = axp806_cells;
+		axp20x->regmap_cfg = &axp808_regmap_config;
+		axp20x->regmap_irq_chip = &axp806_regmap_irq_chip;
+		break;
 	case AXP809_ID:
 		axp20x->nr_cells = ARRAY_SIZE(axp809_cells);
 		axp20x->cells = axp809_cells;
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 0aa4ef7..b9b7eae 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -21,6 +21,7 @@ enum {
 	AXP223_ID,
 	AXP288_ID,
 	AXP806_ID,
+	AXP808_ID,
 	AXP809_ID,
 	NR_AXP20X_VARIANTS,
 };
-- 
2.10.2
