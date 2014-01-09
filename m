From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  9 Jan 2014 16:52:40 +0800
Subject: [PATCH v3 3/8] clk: sunxi: add names for pll5,
 pll6 parent clocks to factors_data
In-Reply-To: <1389257565-19797-1-git-send-email-wens@csie.org>
References: <1389257565-19797-1-git-send-email-wens@csie.org>
Message-ID: <1389257565-19797-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some factor clocks, such as the parent clock of pll5 and pll6, have
multiple output names. Add the corresponding names to factors_data
tied to compatible string.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi/clk-sunxi.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 14a3774..b5c18de 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -383,6 +383,7 @@ struct factors_data {
 	int mux;
 	struct clk_factors_config *table;
 	void (*getter) (u32 *rate, u32 parent_rate, u8 *n, u8 *k, u8 *m, u8 *p);
+	const char *name;
 };
 
 static struct clk_factors_config sun4i_pll1_config = {
@@ -451,6 +452,14 @@ static const struct factors_data sun4i_pll5_data __initconst = {
 	.enable = 31,
 	.table = &sun4i_pll5_config,
 	.getter = sun4i_get_pll5_factors,
+	.name = "pll5",
+};
+
+static const struct factors_data sun4i_pll6_data __initconst = {
+	.enable = 31,
+	.table = &sun4i_pll5_config,
+	.getter = sun4i_get_pll5_factors,
+	.name = "pll6",
 };
 
 static const struct factors_data sun4i_apb1_data __initconst = {
@@ -493,14 +502,14 @@ static struct clk * __init sunxi_factors_clk_setup(struct device_node *node,
 	       (parents[i] = of_clk_get_parent_name(node, i)) != NULL)
 		i++;
 
-	/* Nodes should be providing the name via clock-output-names
-	 * but originally our dts didn't, and so we used node->name.
-	 * The new, better nodes look like clk at deadbeef, so we pull the
-	 * name just in this case */
-	if (!strcmp("clk", clk_name)) {
-		of_property_read_string_index(node, "clock-output-names",
-					      0, &clk_name);
-	}
+	/*
+	 * some factor clocks, such as pll5 and pll6, may have multiple
+	 * outputs, and have their name designated in factors_data
+	 */
+	if (data->name)
+		clk_name = data->name;
+	else
+		of_property_read_string(node, "clock-output-names", &clk_name);
 
 	factors = kzalloc(sizeof(struct clk_factors), GFP_KERNEL);
 	if (!factors)
@@ -832,7 +841,7 @@ static const struct divs_data pll5_divs_data __initconst = {
 };
 
 static const struct divs_data pll6_divs_data __initconst = {
-	.factors = &sun4i_pll5_data,
+	.factors = &sun4i_pll6_data,
 	.div = {
 		{ .shift = 0, .table = pll6_sata_tbl, .gate = 14 }, /* M, SATA */
 		{ .fixed = 2 }, /* P, other */
-- 
1.8.5.2
