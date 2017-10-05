From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Oct 2017 15:23:53 +0200
Subject: [PATCH v3 2/6] clk: renesas: rcar-gen3: Add Z2 clock divider support
In-Reply-To: <1507209837-16938-1-git-send-email-horms+renesas@verge.net.au>
References: <1507209837-16938-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1507209837-16938-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds Z2 clock divider support for R-Car Gen3 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v2 [Simon Horman]
* Consolidate Z and Z2 clock ops
* Allow setting of Z2 clock

v1 [Simon Horman]
* Provide __cpg_z_clk_recalc_rate() helper
* Use GENMASK

v0 [Takeshi Kihara]
---
 drivers/clk/renesas/rcar-gen3-cpg.c | 18 +++++++++++++-----
 drivers/clk/renesas/rcar-gen3-cpg.h |  1 +
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index d98272a6075f..e794e7b9c40a 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -31,7 +31,7 @@
 #define CPG_PLL4CR		0x01f4
 
 /*
- * Z Clock
+ * Z Clock & Z2 Clock
  *
  * Traits of this clock:
  * prepare - clk_prepare only ensures that parents are prepared
@@ -43,11 +43,13 @@
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
@@ -88,8 +90,8 @@ static int cpg_z_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (clk_readl(zclk->kick_reg) & CPG_FRQCRB_KICK)
 		return -EBUSY;
 
-	val = clk_readl(zclk->reg) & ~CPG_FRQCRC_ZFC_MASK;
-	val |= FIELD_PREP(CPG_FRQCRC_ZFC_MASK, 32 - mult);
+	val = clk_readl(zclk->reg) & ~zclk->mask;
+	val |= ((32 - mult) << __bf_shf(zclk->mask)) & zclk->mask;
 	clk_writel(val, zclk->reg);
 
 	/*
@@ -127,7 +129,8 @@ static const struct clk_ops cpg_z_clk_ops = {
 
 static struct clk * __init cpg_z_clk_register(const char *name,
 					      const char *parent_name,
-					      void __iomem *reg)
+					      void __iomem *reg,
+					      unsigned long mask)
 {
 	struct clk_init_data init;
 	struct cpg_z_clk *zclk;
@@ -146,6 +149,7 @@ static struct clk * __init cpg_z_clk_register(const char *name,
 	zclk->reg = reg + CPG_FRQCRC;
 	zclk->kick_reg = reg + CPG_FRQCRB;
 	zclk->hw.init = &init;
+	zclk->mask = mask;
 
 	clk = clk_register(NULL, &zclk->hw);
 	if (IS_ERR(clk))
@@ -499,7 +503,11 @@ struct clk * __init rcar_gen3_cpg_clk_register(struct device *dev,
 
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
index 89da28f6f71b..c03fd498c96b 100644
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
2.1.4
