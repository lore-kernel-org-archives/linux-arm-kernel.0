From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  3 Jan 2014 16:01:46 +0800
Subject: [PATCH 1/6] clk: sunxi: Add clock-output-names dt property support
In-Reply-To: <1388736111-10103-1-git-send-email-wens@csie.org>
References: <1388736111-10103-1-git-send-email-wens@csie.org>
Message-ID: <1388736111-10103-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sunxi clock drivers use dt node name as clock name, but clock
nodes should be named clk at X, so the names would be the same.
Let the drivers read clock names from dt clock-output-names
property.

of_property_read_string does not overwrite the name if the
named property was not found. Removed the strcmp in mod0
clock to match the others.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Should I split this patch?

 drivers/clk/sunxi/clk-sunxi.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 19d9e9e..777a07c 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -53,6 +53,8 @@ static void __init sun4i_osc_clk_setup(struct device_node *node)
 	if (of_property_read_u32(node, "clock-frequency", &rate))
 		return;
 
+	of_property_read_string(node, "clock-output-names", &clk_name);
+
 	/* set up gate and fixed rate properties */
 	gate->reg = of_iomap(node, 0);
 	gate->bit_idx = SUNXI_OSC24M_GATE;
@@ -491,14 +493,7 @@ static struct clk * __init sunxi_factors_clk_setup(struct device_node *node,
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
+	of_property_read_string(node, "clock-output-names", &clk_name);
 
 	factors = kzalloc(sizeof(struct clk_factors), GFP_KERNEL);
 	if (!factors)
@@ -595,6 +590,8 @@ static void __init sunxi_mux_clk_setup(struct device_node *node,
 	       (parents[i] = of_clk_get_parent_name(node, i)) != NULL)
 		i++;
 
+	of_property_read_string(node, "clock-output-names", &clk_name);
+
 	clk = clk_register_mux(NULL, clk_name, parents, i,
 			       CLK_SET_RATE_NO_REPARENT, reg,
 			       data->shift, SUNXI_MUX_GATE_WIDTH,
@@ -654,6 +651,8 @@ static void __init sunxi_divider_clk_setup(struct device_node *node,
 
 	clk_parent = of_clk_get_parent_name(node, 0);
 
+	of_property_read_string(node, "clock-output-names", &clk_name);
+
 	clk = clk_register_divider(NULL, clk_name, clk_parent, 0,
 				   reg, data->shift, data->width,
 				   data->pow ? CLK_DIVIDER_POWER_OF_TWO : 0,
-- 
1.8.5.2
