From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 20 Mar 2015 01:19:06 +0800
Subject: [PATCH 4/6] clk: sunxi: Make divs clocks specify which output is the
 parent clock
In-Reply-To: <1426785548-5932-1-git-send-email-wens@csie.org>
References: <1426785548-5932-1-git-send-email-wens@csie.org>
Message-ID: <1426785548-5932-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current sunxi clock driver has the parent of divs clocks as the
last clock output of the clock node. This makes it rather difficult
to add new outputs, such as fixed dividers, which were previously
unknown.

This patch makes the divs clocks data structure specify which output
is the parent clock, and updates all current divs clocks accordingly.

We can then add new outputs after the parent clocks, at least not
breaking backward compatibility with regards to the devicetree bindings.

Also replace kzalloc with kcalloc in sunxi_divs_clk_setup().

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi/clk-sunxi.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index d92e30371d8a..d28acdde364e 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1046,13 +1046,14 @@ static void __init sunxi_gates_clk_setup(struct device_node *node,
  * sunxi_divs_clk_setup() helper data
  */
 
-#define SUNXI_DIVS_MAX_QTY	2
+#define SUNXI_DIVS_MAX_QTY	4
 #define SUNXI_DIVISOR_WIDTH	2
 
 struct divs_data {
 	const struct factors_data *factors; /* data for the factor clock */
-	int ndivs; /* number of children */
+	int ndivs; /* number of outputs */
 	struct {
+		u8 parent; /* is it the parent? (only one please) */
 		u8 fixed; /* is it a fixed divisor? if not... */
 		struct clk_div_table *table; /* is it a table based divisor? */
 		u8 shift; /* otherwise it's a normal divisor with this shift */
@@ -1075,23 +1076,26 @@ static const struct divs_data pll5_divs_data __initconst = {
 	.div = {
 		{ .shift = 0, .pow = 0, }, /* M, DDR */
 		{ .shift = 16, .pow = 1, }, /* P, other */
+		/* No output for the parent */
 	}
 };
 
 static const struct divs_data pll6_divs_data __initconst = {
 	.factors = &sun4i_pll6_data,
-	.ndivs = 2,
+	.ndivs = 3,
 	.div = {
 		{ .shift = 0, .table = pll6_sata_tbl, .gate = 14 }, /* M, SATA */
 		{ .fixed = 2 }, /* P, other */
+		{ .parent = 1 }, /* parent, 2x */
 	}
 };
 
 static const struct divs_data sun6i_a31_pll6_divs_data __initconst = {
 	.factors = &sun6i_a31_pll6_data,
-	.ndivs = 1,
+	.ndivs = 2,
 	.div = {
 		{ .fixed = 2 }, /* normal output */
+		{ .parent = 1 }, /* parent, 2x */
 	}
 };
 
@@ -1122,6 +1126,10 @@ static void __init sunxi_divs_clk_setup(struct device_node *node,
 	int ndivs = SUNXI_DIVS_MAX_QTY, i = 0;
 	int flags, clkflags;
 
+	/* if number of children known, use it */
+	if (data->ndivs)
+		ndivs = data->ndivs;
+
 	/* Set up factor clock that we will be dividing */
 	pclk = sunxi_factors_clk_setup(node, data->factors);
 	parent = __clk_get_name(pclk);
@@ -1132,7 +1140,7 @@ static void __init sunxi_divs_clk_setup(struct device_node *node,
 	if (!clk_data)
 		return;
 
-	clks = kzalloc((SUNXI_DIVS_MAX_QTY+1) * sizeof(*clks), GFP_KERNEL);
+	clks = kcalloc(ndivs, sizeof(*clks), GFP_KERNEL);
 	if (!clks)
 		goto free_clkdata;
 
@@ -1142,15 +1150,17 @@ static void __init sunxi_divs_clk_setup(struct device_node *node,
 	 * our RAM clock! */
 	clkflags = !strcmp("pll5", parent) ? 0 : CLK_SET_RATE_PARENT;
 
-	/* if number of children known, use it */
-	if (data->ndivs)
-		ndivs = data->ndivs;
-
 	for (i = 0; i < ndivs; i++) {
 		if (of_property_read_string_index(node, "clock-output-names",
 						  i, &clk_name) != 0)
 			break;
 
+		/* If this is the parent, just update clks and skip */
+		if (data->div[i].parent) {
+			clk_data->clks[i] = pclk;
+			continue;
+		}
+
 		gate_hw = NULL;
 		rate_hw = NULL;
 		rate_ops = NULL;
@@ -1209,9 +1219,6 @@ static void __init sunxi_divs_clk_setup(struct device_node *node,
 		clk_register_clkdev(clks[i], clk_name, NULL);
 	}
 
-	/* The last clock available on the getter is the parent */
-	clks[i++] = pclk;
-
 	/* Adjust to the real max */
 	clk_data->clk_num = i;
 
-- 
2.1.4
