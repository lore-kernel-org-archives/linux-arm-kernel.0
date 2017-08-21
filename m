From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 21 Aug 2017 15:01:23 +0200
Subject: [PATCH v2 2/6] clk: renesas: rcar-gen3: Add Z2 clock divider support
In-Reply-To: <1503320487-13591-1-git-send-email-horms+renesas@verge.net.au>
References: <1503320487-13591-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1503320487-13591-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds Z2 clock divider support for R-Car Gen3 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[simon: add recalc_rate() helper; use bitops macros]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v1 [Simon Horman]
* Provide __cpg_z_clk_recalc_rate() helper
* Use GENMASK

v0 [Takeshi Kihara]
---
 drivers/clk/renesas/rcar-gen3-cpg.c | 76 ++++++++++++++++++++++++++++++++++---
 drivers/clk/renesas/rcar-gen3-cpg.h |  1 +
 2 files changed, 72 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index f688b5f44961..8f44cbf895fb 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -30,7 +30,7 @@
 #define CPG_PLL2CR		0x002c
 #define CPG_PLL4CR		0x01f4
 
-/* Z Clock
+/* Z Clock & Z2 Clock
  *
  * Traits of this clock:
  * prepare - clk_prepare only ensures that parents are prepared
@@ -42,6 +42,7 @@
 #define CPG_FRQCRB_KICK			BIT(31)
 #define CPG_FRQCRC			0x000000e0
 #define CPG_FRQCRC_ZFC_MASK		GENMASK(12, 8)
+#define CPG_FRQCRC_Z2FC_MASK		GENMASK(4, 0)
 
 struct cpg_z_clk {
 	struct clk_hw hw;
@@ -51,14 +52,13 @@ struct cpg_z_clk {
 
 #define to_z_clk(_hw)	container_of(_hw, struct cpg_z_clk, hw)
 
-static unsigned long cpg_z_clk_recalc_rate(struct clk_hw *hw,
-					   unsigned long parent_rate)
+static unsigned long __cpg_z_clk_recalc_rate(unsigned long parent_rate,
+					     unsigned int val)
 {
-	struct cpg_z_clk *zclk = to_z_clk(hw);
 	unsigned long rate;
 	unsigned int mult;
 
-	mult = 32 - FIELD_GET(CPG_FRQCRC_ZFC_MASK, clk_readl(zclk->reg));
+	mult = 32 - val;
 	/* There is a PLL post-divider of 1/2,
 	 * thus the doubling of the divisor below.
 	 */
@@ -69,6 +69,26 @@ static unsigned long cpg_z_clk_recalc_rate(struct clk_hw *hw,
 	return rate;
 }
 
+static unsigned long cpg_z_clk_recalc_rate(struct clk_hw *hw,
+					   unsigned long parent_rate)
+{
+	struct cpg_z_clk *zclk = to_z_clk(hw);
+	unsigned int val;
+
+	val = FIELD_GET(CPG_FRQCRC_ZFC_MASK, clk_readl(zclk->reg));
+	return __cpg_z_clk_recalc_rate(parent_rate, val);
+}
+
+static unsigned long cpg_z2_clk_recalc_rate(struct clk_hw *hw,
+					   unsigned long parent_rate)
+{
+	struct cpg_z_clk *zclk = to_z_clk(hw);
+	unsigned int val;
+
+	val = FIELD_GET(CPG_FRQCRC_Z2FC_MASK, clk_readl(zclk->reg));
+	return __cpg_z_clk_recalc_rate(parent_rate, val);
+}
+
 static long cpg_z_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 				 unsigned long *parent_rate)
 {
@@ -129,12 +149,25 @@ static int cpg_z_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	return -ETIMEDOUT;
 }
 
+static int cpg_z2_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long parent_rate)
+{
+	pr_info("Do not support Z2 clock changing\n");
+	return 0;
+}
+
 static const struct clk_ops cpg_z_clk_ops = {
 	.recalc_rate = cpg_z_clk_recalc_rate,
 	.round_rate = cpg_z_clk_round_rate,
 	.set_rate = cpg_z_clk_set_rate,
 };
 
+static const struct clk_ops cpg_z2_clk_ops = {
+	.recalc_rate = cpg_z2_clk_recalc_rate,
+	.round_rate = cpg_z_clk_round_rate,
+	.set_rate = cpg_z2_clk_set_rate,
+};
+
 static struct clk * __init cpg_z_clk_register(const char *name,
 					      const char *parent_name,
 					      void __iomem *reg)
@@ -164,6 +197,35 @@ static struct clk * __init cpg_z_clk_register(const char *name,
 	return clk;
 }
 
+static struct clk * __init cpg_z2_clk_register(const char *name,
+					      const char *parent_name,
+					      void __iomem *reg)
+{
+	struct clk_init_data init;
+	struct cpg_z_clk *zclk;
+	struct clk *clk;
+
+	zclk = kzalloc(sizeof(*zclk), GFP_KERNEL);
+	if (!zclk)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &cpg_z2_clk_ops;
+	init.flags = 0;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	zclk->reg = reg + CPG_FRQCRC;
+	zclk->kick_reg = reg + CPG_FRQCRB;
+	zclk->hw.init = &init;
+
+	clk = clk_register(NULL, &zclk->hw);
+	if (IS_ERR(clk))
+		kfree(zclk);
+
+	return clk;
+}
+
 /*
  * SDn Clock
  */
@@ -511,6 +573,10 @@ struct clk * __init rcar_gen3_cpg_clk_register(struct device *dev,
 		return cpg_z_clk_register(core->name, __clk_get_name(parent),
 					  base);
 
+	case CLK_TYPE_GEN3_Z2:
+		return cpg_z2_clk_register(core->name, __clk_get_name(parent),
+					   base);
+
 	default:
 		return ERR_PTR(-EINVAL);
 	}
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
