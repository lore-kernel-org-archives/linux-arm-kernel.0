From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  6 Jan 2014 13:58:06 +0800
Subject: [PATCH v2 2/8] clk: sunxi: choose correct name for multiple output
 factor clocks
In-Reply-To: <1388987892-23733-1-git-send-email-wens@csie.org>
References: <1388987892-23733-1-git-send-email-wens@csie.org>
Message-ID: <1388987892-23733-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some factor clocks, such as the parent clock of pll5 and pll6, have
multiple output names. Use the last name as the name for the clock
itself.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi/clk-sunxi.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 14a3774..7ce7e1c 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -484,7 +484,7 @@ static struct clk * __init sunxi_factors_clk_setup(struct device_node *node,
 	const char *clk_name = node->name;
 	const char *parents[SUNXI_MAX_PARENTS];
 	void *reg;
-	int i = 0;
+	int j, i = 0;
 
 	reg = of_iomap(node, 0);
 
@@ -493,14 +493,14 @@ static struct clk * __init sunxi_factors_clk_setup(struct device_node *node,
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
+	 * factor clocks, such as pll5 and pll6, may have multiple outputs
+	 * Use the last clock output name as this clock's name.
+	 * This matches the behavior of of_clk_get_parent_name()
+	 */
+	j = of_property_count_strings(node, "clock-output-names");
+	of_property_read_string_index(node, "clock-output-names", j - 1,
+				      &clk_name);
 
 	factors = kzalloc(sizeof(struct clk_factors), GFP_KERNEL);
 	if (!factors)
-- 
1.8.5.2
