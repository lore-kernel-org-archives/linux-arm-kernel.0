From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  3 Jan 2018 13:18:36 +0100
Subject: [PATCH v4 2/6] clk: renesas: rcar-gen3: Add Z2 clock divider support
In-Reply-To: <20180103121840.29316-1-horms+renesas@verge.net.au>
References: <20180103121840.29316-1-horms+renesas@verge.net.au>
Message-ID: <20180103121840.29316-3-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds Z2 clock divider support for R-Car Gen3 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v4 [Simon Horman]
* Rebase
* Use __ffs as FIELD_{GET,PREP} don't not work with non-constant masks
* Use correct mask in cpg_z_clk_recalc_rate()

v3 [Simon Horman]
* Consolidate Z and Z2 clock ops
* Allow setting of Z2 clock

v1 [Simon Horman]
* Provide __cpg_z_clk_recalc_rate() helper
* Use GENMASK

v0 [Takeshi Kihara]
---
 drivers/clk/renesas/rcar-gen3-cpg.c | 22 ++++++++++++++++------
 drivers/clk/renesas/rcar-gen3-cpg.h |  1 +
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index b85918fa62c6..a7d68cefda9c 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -63,7 +63,7 @@ static void cpg_simple_notifier_register(struct raw_notifier_head *notifiers,
 }
 
 /*
- * Z Clock
+ * Z Clock & Z2 Clock
  *
  * Traits of this clock:
  * prepare - clk_prepare only ensures that parents are prepared
@@ -75,11 +75,13 @@ static void cpg_simple_notifier_register(struct raw_notifier_head *notifiers,
 #define CPG_FRQCRB_KICK			BIT(31)
 #define CPG_FRQCRC			0x000000e0
 #define CPG_FRQCRC_ZFC_MASK		GENMASK(12, 8)
+#define CPG_FRQCRC_Z2FC_MASK		GENMASK(4, 0)
 
 struct cpg_z_clk {
 	struct clk_hw hw;
 	void __iomem *reg;
 	void __iomem *kick_reg;
+	unsigned long mask;
 };
 
 #define to_z_clk(_hw)	container_of(_hw, struct cpg_z_clk, hw)
@@ -89,8 +91,10 @@ static unsigned long cpg_z_clk_recalc_rate(struct clk_hw *hw,
 {
 	struct cpg_z_clk *zclk = to_z_clk(hw);
 	unsigned int mult;
+	u32 val;
 
-	mult = 32 - FIELD_GET(CPG_FRQCRC_ZFC_MASK, clk_readl(zclk->reg));
+	val = clk_readl(zclk->reg) & zclk->mask;
+	mult = 32 - (val >> (__ffs(zclk->mask) - 1));
 
 	/* Factor of 2 is for fixed divider */
 	return DIV_ROUND_CLOSEST_ULL((u64)parent_rate * mult, 32 * 2);
@@ -124,8 +128,8 @@ static int cpg_z_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (clk_readl(zclk->kick_reg) & CPG_FRQCRB_KICK)
 		return -EBUSY;
 
-	val = clk_readl(zclk->reg) & ~CPG_FRQCRC_ZFC_MASK;
-	val |= FIELD_PREP(CPG_FRQCRC_ZFC_MASK, 32 - mult);
+	val = clk_readl(zclk->reg) & ~zclk->mask;
+	val |= ((32 - mult) << (__ffs(zclk->mask) - 1)) & zclk->mask;
 	clk_writel(val, zclk->reg);
 
 	/*
@@ -163,7 +167,8 @@ static const struct clk_ops cpg_z_clk_ops = {
 
 static struct clk * __init cpg_z_clk_register(const char *name,
 					      const char *parent_name,
-					      void __iomem *reg)
+					      void __iomem *reg,
+					      unsigned long mask)
 {
 	struct clk_init_data init;
 	struct cpg_z_clk *zclk;
@@ -182,6 +187,7 @@ static struct clk * __init cpg_z_clk_register(const char *name,
 	zclk->reg = reg + CPG_FRQCRC;
 	zclk->kick_reg = reg + CPG_FRQCRB;
 	zclk->hw.init = &init;
+	zclk->mask = mask;
 
 	clk = clk_register(NULL, &zclk->hw);
 	if (IS_ERR(clk))
@@ -551,7 +557,11 @@ struct clk * __init rcar_gen3_cpg_clk_register(struct device *dev,
 
 	case CLK_TYPE_GEN3_Z:
 		return cpg_z_clk_register(core->name, __clk_get_name(parent),
-					  base);
+					  base, CPG_FRQCRC_ZFC_MASK);
+
+	case CLK_TYPE_GEN3_Z2:
+		return cpg_z_clk_register(core->name, __clk_get_name(parent),
+					  base, CPG_FRQCRC_Z2FC_MASK);
 
 	default:
 		return ERR_PTR(-EINVAL);
diff --git a/drivers/clk/renesas/rcar-gen3-cpg.h b/drivers/clk/renesas/rcar-gen3-cpg.h
index c73d4d6fdc85..ea4f8fc3c4c9 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.h
+++ b/drivers/clk/renesas/rcar-gen3-cpg.h
@@ -22,6 +22,7 @@ enum rcar_gen3_clk_types {
 	CLK_TYPE_GEN3_R,
 	CLK_TYPE_GEN3_PE,
 	CLK_TYPE_GEN3_Z,
+	CLK_TYPE_GEN3_Z2,
 };
 
 #define DEF_GEN3_SD(_name, _id, _parent, _offset)	\
-- 
2.11.0
