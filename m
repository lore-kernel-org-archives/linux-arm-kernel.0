From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 25 Jan 2016 21:15:39 +0800
Subject: [PATCH RFC 03/11] clk: sunxi: factors: Add clk cleanup in
 sunxi_factors_register() error path
In-Reply-To: <1453727747-23307-1-git-send-email-wens@csie.org>
References: <1453727747-23307-1-git-send-email-wens@csie.org>
Message-ID: <1453727747-23307-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sunxi_factors_register() does not check for failures or cleanup after
clk_register_composite() or other clk-related calls.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi/clk-factors.c | 43 +++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
index 928c079da193..1de57c22a358 100644
--- a/drivers/clk/sunxi/clk-factors.c
+++ b/drivers/clk/sunxi/clk-factors.c
@@ -172,7 +172,7 @@ struct clk *sunxi_factors_register(struct device_node *node,
 	struct clk_hw *mux_hw = NULL;
 	const char *clk_name = node->name;
 	const char *parents[FACTORS_MAX_PARENTS];
-	int i = 0;
+	int ret, i = 0;
 
 	/* if we have a mux, we will have >1 parents */
 	i = of_clk_parent_fill(node, parents, FACTORS_MAX_PARENTS);
@@ -188,7 +188,7 @@ struct clk *sunxi_factors_register(struct device_node *node,
 
 	factors = kzalloc(sizeof(struct clk_factors), GFP_KERNEL);
 	if (!factors)
-		return NULL;
+		goto err_factors;
 
 	/* set up factors properties */
 	factors->reg = reg;
@@ -199,10 +199,8 @@ struct clk *sunxi_factors_register(struct device_node *node,
 	/* Add a gate if this factor clock can be gated */
 	if (data->enable) {
 		gate = kzalloc(sizeof(struct clk_gate), GFP_KERNEL);
-		if (!gate) {
-			kfree(factors);
-			return NULL;
-		}
+		if (!gate)
+			goto err_gate;
 
 		/* set up gate properties */
 		gate->reg = reg;
@@ -214,11 +212,8 @@ struct clk *sunxi_factors_register(struct device_node *node,
 	/* Add a mux if this factor clock can be muxed */
 	if (data->mux) {
 		mux = kzalloc(sizeof(struct clk_mux), GFP_KERNEL);
-		if (!mux) {
-			kfree(factors);
-			kfree(gate);
-			return NULL;
-		}
+		if (!mux)
+			goto err_mux;
 
 		/* set up gate properties */
 		mux->reg = reg;
@@ -233,11 +228,29 @@ struct clk *sunxi_factors_register(struct device_node *node,
 			mux_hw, &clk_mux_ops,
 			&factors->hw, &clk_factors_ops,
 			gate_hw, &clk_gate_ops, 0);
+	if (IS_ERR(clk))
+		goto err_register;
 
-	if (!IS_ERR(clk)) {
-		of_clk_add_provider(node, of_clk_src_simple_get, clk);
-		clk_register_clkdev(clk, clk_name, NULL);
-	}
+	ret = of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	if (ret)
+		goto err_provider;
+
+	ret = clk_register_clkdev(clk, clk_name, NULL);
+	if (ret)
+		goto err_clkdev;
 
 	return clk;
+
+err_clkdev:
+	of_clk_del_provider(node);
+err_provider:
+	clk_unregister_composite(clk);
+err_register:
+	kfree(mux);
+err_mux:
+	kfree(gate);
+err_gate:
+	kfree(factors);
+err_factors:
+	return NULL;
 }
-- 
2.7.0
