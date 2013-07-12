From: axel.lin@ingics.com (Axel Lin)
Date: Fri, 12 Jul 2013 16:15:15 +0800
Subject: [PATCH] clk: sunxi: Fix checking return value of
 clk_register_[composite|factors]
Message-ID: <1373616915.24328.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_register_composite() and clk_register_factors() return ERR_PTR on error.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/clk/sunxi/clk-sunxi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 412912b..02e440b 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -64,7 +64,7 @@ static void __init sunxi_osc_clk_setup(struct device_node *node)
 			&gate->hw, &clk_gate_ops,
 			CLK_IS_ROOT);
 
-	if (clk) {
+	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
 		clk_register_clkdev(clk, clk_name, NULL);
 	}
@@ -221,7 +221,7 @@ static void __init sunxi_factors_clk_setup(struct device_node *node,
 	clk = clk_register_factors(NULL, clk_name, parent, 0, reg,
 				   data->table, data->getter, &clk_lock);
 
-	if (clk) {
+	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
 		clk_register_clkdev(clk, clk_name, NULL);
 	}
-- 
1.8.1.2
