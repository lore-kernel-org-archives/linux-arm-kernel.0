From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 27 Sep 2014 16:49:49 +0800
Subject: [PATCH v2 1/7] clk: sunxi: Specify number of child clocks for divs
 clocks
In-Reply-To: <1411807795-6575-1-git-send-email-wens@csie.org>
References: <1411807795-6575-1-git-send-email-wens@csie.org>
Message-ID: <1411807795-6575-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently sunxi_divs_clk_setup assumes the number of child clocks
to be the same as the number of clock-output-names, and a maximum
of SUNXI_DIVS_MAX_QTY child clocks.

On sun6i, PLL6 only has 1 child clock, but the parent would be used
as well, thereby also having it's own clock-output-names entry. This
results in an extra bogus clock being registered.

This patch adds an entry for the number of child clocks alongside
the data structures for them.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi/clk-sunxi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 2cf6581..05d9329 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1037,6 +1037,7 @@ static void __init sunxi_gates_clk_setup(struct device_node *node,
 
 struct divs_data {
 	const struct factors_data *factors; /* data for the factor clock */
+	int ndivs; /* number of children */
 	struct {
 		u8 fixed; /* is it a fixed divisor? if not... */
 		struct clk_div_table *table; /* is it a table based divisor? */
@@ -1056,6 +1057,7 @@ static struct clk_div_table pll6_sata_tbl[] = {
 
 static const struct divs_data pll5_divs_data __initconst = {
 	.factors = &sun4i_pll5_data,
+	.ndivs = 2,
 	.div = {
 		{ .shift = 0, .pow = 0, }, /* M, DDR */
 		{ .shift = 16, .pow = 1, }, /* P, other */
@@ -1064,6 +1066,7 @@ static const struct divs_data pll5_divs_data __initconst = {
 
 static const struct divs_data pll6_divs_data __initconst = {
 	.factors = &sun4i_pll6_data,
+	.ndivs = 2,
 	.div = {
 		{ .shift = 0, .table = pll6_sata_tbl, .gate = 14 }, /* M, SATA */
 		{ .fixed = 2 }, /* P, other */
@@ -1094,7 +1097,7 @@ static void __init sunxi_divs_clk_setup(struct device_node *node,
 	struct clk_fixed_factor *fix_factor;
 	struct clk_divider *divider;
 	void __iomem *reg;
-	int i = 0;
+	int ndivs = SUNXI_DIVS_MAX_QTY, i = 0;
 	int flags, clkflags;
 
 	/* Set up factor clock that we will be dividing */
@@ -1117,7 +1120,11 @@ static void __init sunxi_divs_clk_setup(struct device_node *node,
 	 * our RAM clock! */
 	clkflags = !strcmp("pll5", parent) ? 0 : CLK_SET_RATE_PARENT;
 
-	for (i = 0; i < SUNXI_DIVS_MAX_QTY; i++) {
+	/* if number of children known, use it */
+	if (data->ndivs)
+		ndivs = data->ndivs;
+
+	for (i = 0; i < ndivs; i++) {
 		if (of_property_read_string_index(node, "clock-output-names",
 						  i, &clk_name) != 0)
 			break;
-- 
2.1.1
