From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 25 Jan 2016 21:15:45 +0800
Subject: [PATCH RFC 09/11] clk: sunxi: rewrite sun6i-a31-ahb1-clk using
 factors clk with custom recalc
In-Reply-To: <1453727747-23307-1-git-send-email-wens@csie.org>
References: <1453727747-23307-1-git-send-email-wens@csie.org>
Message-ID: <1453727747-23307-10-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The factors clk implementation has been extended to support custom
recalc callbacks to support clocks that use one factor for certain
parents only, like a pre-divider.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi/clk-sunxi.c | 291 ++++++++++++------------------------------
 1 file changed, 83 insertions(+), 208 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 56d4fdcf9c89..32d0bfa4913b 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -28,214 +28,6 @@
 
 static DEFINE_SPINLOCK(clk_lock);
 
-/**
- * sun6i_a31_ahb1_clk_setup() - Setup function for a31 ahb1 composite clk
- */
-
-#define SUN6I_AHB1_MAX_PARENTS		4
-#define SUN6I_AHB1_MUX_PARENT_PLL6	3
-#define SUN6I_AHB1_MUX_SHIFT		12
-/* un-shifted mask is what mux_clk expects */
-#define SUN6I_AHB1_MUX_MASK		0x3
-#define SUN6I_AHB1_MUX_GET_PARENT(reg)	((reg >> SUN6I_AHB1_MUX_SHIFT) & \
-					 SUN6I_AHB1_MUX_MASK)
-
-#define SUN6I_AHB1_DIV_SHIFT		4
-#define SUN6I_AHB1_DIV_MASK		(0x3 << SUN6I_AHB1_DIV_SHIFT)
-#define SUN6I_AHB1_DIV_GET(reg)		((reg & SUN6I_AHB1_DIV_MASK) >> \
-						SUN6I_AHB1_DIV_SHIFT)
-#define SUN6I_AHB1_DIV_SET(reg, div)	((reg & ~SUN6I_AHB1_DIV_MASK) | \
-						(div << SUN6I_AHB1_DIV_SHIFT))
-#define SUN6I_AHB1_PLL6_DIV_SHIFT	6
-#define SUN6I_AHB1_PLL6_DIV_MASK	(0x3 << SUN6I_AHB1_PLL6_DIV_SHIFT)
-#define SUN6I_AHB1_PLL6_DIV_GET(reg)	((reg & SUN6I_AHB1_PLL6_DIV_MASK) >> \
-						SUN6I_AHB1_PLL6_DIV_SHIFT)
-#define SUN6I_AHB1_PLL6_DIV_SET(reg, div) ((reg & ~SUN6I_AHB1_PLL6_DIV_MASK) | \
-						(div << SUN6I_AHB1_PLL6_DIV_SHIFT))
-
-struct sun6i_ahb1_clk {
-	struct clk_hw hw;
-	void __iomem *reg;
-};
-
-#define to_sun6i_ahb1_clk(_hw) container_of(_hw, struct sun6i_ahb1_clk, hw)
-
-static unsigned long sun6i_ahb1_clk_recalc_rate(struct clk_hw *hw,
-						unsigned long parent_rate)
-{
-	struct sun6i_ahb1_clk *ahb1 = to_sun6i_ahb1_clk(hw);
-	unsigned long rate;
-	u32 reg;
-
-	/* Fetch the register value */
-	reg = readl(ahb1->reg);
-
-	/* apply pre-divider first if parent is pll6 */
-	if (SUN6I_AHB1_MUX_GET_PARENT(reg) == SUN6I_AHB1_MUX_PARENT_PLL6)
-		parent_rate /= SUN6I_AHB1_PLL6_DIV_GET(reg) + 1;
-
-	/* clk divider */
-	rate = parent_rate >> SUN6I_AHB1_DIV_GET(reg);
-
-	return rate;
-}
-
-static long sun6i_ahb1_clk_round(unsigned long rate, u8 *divp, u8 *pre_divp,
-				 u8 parent, unsigned long parent_rate)
-{
-	u8 div, calcp, calcm = 1;
-
-	/*
-	 * clock can only divide, so we will never be able to achieve
-	 * frequencies higher than the parent frequency
-	 */
-	if (parent_rate && rate > parent_rate)
-		rate = parent_rate;
-
-	div = DIV_ROUND_UP(parent_rate, rate);
-
-	/* calculate pre-divider if parent is pll6 */
-	if (parent == SUN6I_AHB1_MUX_PARENT_PLL6) {
-		if (div < 4)
-			calcp = 0;
-		else if (div / 2 < 4)
-			calcp = 1;
-		else if (div / 4 < 4)
-			calcp = 2;
-		else
-			calcp = 3;
-
-		calcm = DIV_ROUND_UP(div, 1 << calcp);
-	} else {
-		calcp = __roundup_pow_of_two(div);
-		calcp = calcp > 3 ? 3 : calcp;
-	}
-
-	/* we were asked to pass back divider values */
-	if (divp) {
-		*divp = calcp;
-		*pre_divp = calcm - 1;
-	}
-
-	return (parent_rate / calcm) >> calcp;
-}
-
-static int sun6i_ahb1_clk_determine_rate(struct clk_hw *hw,
-					 struct clk_rate_request *req)
-{
-	struct clk_hw *parent, *best_parent = NULL;
-	int i, num_parents;
-	unsigned long parent_rate, best = 0, child_rate, best_child_rate = 0;
-
-	/* find the parent that can help provide the fastest rate <= rate */
-	num_parents = clk_hw_get_num_parents(hw);
-	for (i = 0; i < num_parents; i++) {
-		parent = clk_hw_get_parent_by_index(hw, i);
-		if (!parent)
-			continue;
-		if (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)
-			parent_rate = clk_hw_round_rate(parent, req->rate);
-		else
-			parent_rate = clk_hw_get_rate(parent);
-
-		child_rate = sun6i_ahb1_clk_round(req->rate, NULL, NULL, i,
-						  parent_rate);
-
-		if (child_rate <= req->rate && child_rate > best_child_rate) {
-			best_parent = parent;
-			best = parent_rate;
-			best_child_rate = child_rate;
-		}
-	}
-
-	if (!best_parent)
-		return -EINVAL;
-
-	req->best_parent_hw = best_parent;
-	req->best_parent_rate = best;
-	req->rate = best_child_rate;
-
-	return 0;
-}
-
-static int sun6i_ahb1_clk_set_rate(struct clk_hw *hw, unsigned long rate,
-				   unsigned long parent_rate)
-{
-	struct sun6i_ahb1_clk *ahb1 = to_sun6i_ahb1_clk(hw);
-	unsigned long flags;
-	u8 div, pre_div, parent;
-	u32 reg;
-
-	spin_lock_irqsave(&clk_lock, flags);
-
-	reg = readl(ahb1->reg);
-
-	/* need to know which parent is used to apply pre-divider */
-	parent = SUN6I_AHB1_MUX_GET_PARENT(reg);
-	sun6i_ahb1_clk_round(rate, &div, &pre_div, parent, parent_rate);
-
-	reg = SUN6I_AHB1_DIV_SET(reg, div);
-	reg = SUN6I_AHB1_PLL6_DIV_SET(reg, pre_div);
-	writel(reg, ahb1->reg);
-
-	spin_unlock_irqrestore(&clk_lock, flags);
-
-	return 0;
-}
-
-static const struct clk_ops sun6i_ahb1_clk_ops = {
-	.determine_rate	= sun6i_ahb1_clk_determine_rate,
-	.recalc_rate	= sun6i_ahb1_clk_recalc_rate,
-	.set_rate	= sun6i_ahb1_clk_set_rate,
-};
-
-static void __init sun6i_ahb1_clk_setup(struct device_node *node)
-{
-	struct clk *clk;
-	struct sun6i_ahb1_clk *ahb1;
-	struct clk_mux *mux;
-	const char *clk_name = node->name;
-	const char *parents[SUN6I_AHB1_MAX_PARENTS];
-	void __iomem *reg;
-	int i;
-
-	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
-	if (IS_ERR(reg))
-		return;
-
-	/* we have a mux, we will have >1 parents */
-	i = of_clk_parent_fill(node, parents, SUN6I_AHB1_MAX_PARENTS);
-	of_property_read_string(node, "clock-output-names", &clk_name);
-
-	ahb1 = kzalloc(sizeof(struct sun6i_ahb1_clk), GFP_KERNEL);
-	if (!ahb1)
-		return;
-
-	mux = kzalloc(sizeof(struct clk_mux), GFP_KERNEL);
-	if (!mux) {
-		kfree(ahb1);
-		return;
-	}
-
-	/* set up clock properties */
-	mux->reg = reg;
-	mux->shift = SUN6I_AHB1_MUX_SHIFT;
-	mux->mask = SUN6I_AHB1_MUX_MASK;
-	mux->lock = &clk_lock;
-	ahb1->reg = reg;
-
-	clk = clk_register_composite(NULL, clk_name, parents, i,
-				     &mux->hw, &clk_mux_ops,
-				     &ahb1->hw, &sun6i_ahb1_clk_ops,
-				     NULL, NULL, 0);
-
-	if (!IS_ERR(clk)) {
-		of_clk_add_provider(node, of_clk_src_simple_get, clk);
-		clk_register_clkdev(clk, clk_name, NULL);
-	}
-}
-CLK_OF_DECLARE(sun6i_a31_ahb1, "allwinner,sun6i-a31-ahb1-clk", sun6i_ahb1_clk_setup);
-
 /* Maximum number of parents our clocks have */
 #define SUNXI_MAX_PARENTS	5
 
@@ -490,6 +282,68 @@ static void sun5i_a13_get_ahb_factors(struct factors_request *req)
 	req->p = div;
 }
 
+#define SUN6I_AHB1_PARENT_PLL6	3
+
+/**
+ * sun6i_a31_get_ahb_factors() - calculates m, p factors for AHB
+ * AHB rate is calculated as follows
+ * rate = parent_rate >> p
+ *
+ * if parent is pll6, then
+ * parent_rate = pll6 rate / (m + 1)
+ */
+
+static void sun6i_get_ahb1_factors(struct factors_request *req)
+{
+	u8 div, calcp, calcm = 1;
+
+	/*
+	 * clock can only divide, so we will never be able to achieve
+	 * frequencies higher than the parent frequency
+	 */
+	if (req->parent_rate && req->rate > req->parent_rate)
+		req->rate = req->parent_rate;
+
+	div = DIV_ROUND_UP(req->parent_rate, req->rate);
+
+	/* calculate pre-divider if parent is pll6 */
+	if (req->parent_index == SUN6I_AHB1_PARENT_PLL6) {
+		if (div < 4)
+			calcp = 0;
+		else if (div / 2 < 4)
+			calcp = 1;
+		else if (div / 4 < 4)
+			calcp = 2;
+		else
+			calcp = 3;
+
+		calcm = DIV_ROUND_UP(div, 1 << calcp);
+	} else {
+		calcp = __roundup_pow_of_two(div);
+		calcp = calcp > 3 ? 3 : calcp;
+	}
+
+	req->rate = (req->parent_rate / calcm) >> calcp;
+	req->p = calcp;
+	req->m = calcm - 1;
+}
+
+/**
+ * sun6i_ahb1_recalc() - calculates AHB clock rate from m, p factors and
+ *			 parent index
+ */
+static void sun6i_ahb1_recalc(struct factors_request *req)
+{
+	req->rate = req->parent_rate;
+
+	/* apply pre-divider first if parent is pll6 */
+	if (req->parent_index == SUN6I_AHB1_PARENT_PLL6)
+		req->rate /= req->m + 1;
+
+	/* clk divider */
+	req->rate >>= req->p;
+}
+
 /**
  * sun4i_get_apb1_factors() - calculates m, p factors for APB1
  * APB1 rate is calculated as follows
@@ -619,6 +473,13 @@ static const struct clk_factors_config sun5i_a13_ahb_config = {
 	.pwidth = 2,
 };
 
+static const struct clk_factors_config sun6i_ahb1_config = {
+	.mshift = 6,
+	.mwidth = 2,
+	.pshift = 4,
+	.pwidth = 2,
+};
+
 static const struct clk_factors_config sun4i_apb1_config = {
 	.mshift = 0,
 	.mwidth = 5,
@@ -686,6 +547,14 @@ static const struct factors_data sun5i_a13_ahb_data __initconst = {
 	.getter = sun5i_a13_get_ahb_factors,
 };
 
+static const struct factors_data sun6i_ahb1_data __initconst = {
+	.mux = 12,
+	.muxmask = BIT(1) | BIT(0),
+	.table = &sun6i_ahb1_config,
+	.getter = sun6i_get_ahb1_factors,
+	.recalc = sun6i_ahb1_recalc,
+};
+
 static const struct factors_data sun4i_apb1_data __initconst = {
 	.mux = 24,
 	.muxmask = BIT(1) | BIT(0),
@@ -725,6 +594,12 @@ static struct clk * __init sunxi_factors_clk_setup(struct device_node *node,
 	return clk;
 }
 
+static void __init sun6i_ahb1_clk_setup(struct device_node *node)
+{
+	sunxi_factors_clk_setup(node, &sun6i_ahb1_data);
+}
+CLK_OF_DECLARE(sun6i_a31_ahb1, "allwinner,sun6i-a31-ahb1-clk",
+	       sun6i_ahb1_clk_setup);
 
 
 /**
-- 
2.7.0
