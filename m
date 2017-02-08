From: rask@formelder.dk (Rask Ingemann Lambertsen)
Date: Thu,  9 Feb 2017 00:32:06 +0100 (CET)
Subject: [PATCH v2 3/5] mfd: axp20x: Add support for the AXP808 PMIC
In-Reply-To: <cover.1486592470.git.rask@formelder.dk>
References: <cover.1486592470.git.rask@formelder.dk>
Message-ID: <eeb26dfec0cefc1e299a39e343b75e7af64a8daa.1486592471.git.rask@formelder.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The X-Powers AXP808 is a PMIC which, like the very similar AXP806, is
used on boards featuring Allwinner's A80 SoC. Unlike the AXP806, it
doesn't support address space extension and its associated registers,
but the two are otherwise identical (including the chip ID). After
commit b101829a029a ("mfd: axp20x: Fix AXP806 access errors on cold boot")
those registers are now used, causing the driver to no longer work with
an AXP808.

This patch adds support for the interrupts on the AXP808 and enables
the regulator sub-device. The next patch in the series adds the actual
regulator support.

Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---

Changes in v2:
- Noted in the commit message that another commit for better AXP806 support
  means the driver no longer works with an AXP808.
- axp808_writeable_table was changed to use the common part (between AXP806 and
  AXP808) of axp806_writeable_ranges instead of duplicating the entries.
  Suggested by Chen-Yu Tsai.

 drivers/mfd/axp20x-rsb.c   |  1 +
 drivers/mfd/axp20x.c       | 26 ++++++++++++++++++++++++++
 include/linux/mfd/axp20x.h |  1 +
 3 files changed, 28 insertions(+)

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
index 25115fe..125b470 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -41,6 +41,7 @@ static const char * const axp20x_model_names[] = {
 	"AXP223",
 	"AXP288",
 	"AXP806",
+	"AXP808",
 	"AXP809",
 };
 
@@ -140,6 +141,11 @@ static const struct regmap_access_table axp288_volatile_table = {
 	.n_yes_ranges	= ARRAY_SIZE(axp288_volatile_ranges),
 };
 
+/*
+ * These ranges are used by both axp806_writeable_table and
+ * axp808_writeable_table. This is possible as long as those not supported
+ * by the AXP808 (currently only the last one) are kept at an end.
+ */
 static const struct regmap_range axp806_writeable_ranges[] = {
 	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_DATACACHE(3)),
 	regmap_reg_range(AXP806_PWR_OUT_CTRL1, AXP806_CLDO3_V_CTRL),
@@ -162,6 +168,11 @@ static const struct regmap_access_table axp806_volatile_table = {
 	.n_yes_ranges	= ARRAY_SIZE(axp806_volatile_ranges),
 };
 
+static const struct regmap_access_table axp808_writeable_table = {
+	.yes_ranges	= axp806_writeable_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(axp806_writeable_ranges) - 1,
+};
+
 static struct resource axp152_pek_resources[] = {
 	DEFINE_RES_IRQ_NAMED(AXP152_IRQ_PEK_RIS_EDGE, "PEK_DBR"),
 	DEFINE_RES_IRQ_NAMED(AXP152_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
@@ -320,6 +331,15 @@ static const struct regmap_config axp806_regmap_config = {
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
 
@@ -842,6 +862,12 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
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
index 0d9a1ff..48c1788 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -21,6 +21,7 @@ enum axp20x_variants {
 	AXP223_ID,
 	AXP288_ID,
 	AXP806_ID,
+	AXP808_ID,
 	AXP809_ID,
 	NR_AXP20X_VARIANTS,
 };
-- 
2.10.2
