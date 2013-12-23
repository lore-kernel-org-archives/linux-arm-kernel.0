From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 23 Dec 2013 00:32:36 -0300
Subject: [PATCH v3 05/13] clk: sunxi: make factors_clk_setup return the clock
 it registers
In-Reply-To: <1387769564-12894-1-git-send-email-emilio@elopez.com.ar>
References: <1387769564-12894-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1387769564-12894-6-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We will be needing this to register a factor clock as parent with leaf
divisors on a single call.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
Acked-by: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/sunxi/clk-sunxi.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 42e8690..0f23d16 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -311,8 +311,8 @@ static const struct factors_data sun4i_apb1_data __initconst = {
 	.getter = sun4i_get_apb1_factors,
 };
 
-static void __init sunxi_factors_clk_setup(struct device_node *node,
-					   struct factors_data *data)
+static struct clk * __init sunxi_factors_clk_setup(struct device_node *node,
+						const struct factors_data *data)
 {
 	struct clk *clk;
 	struct clk_factors *factors;
@@ -334,14 +334,14 @@ static void __init sunxi_factors_clk_setup(struct device_node *node,
 
 	factors = kzalloc(sizeof(struct clk_factors), GFP_KERNEL);
 	if (!factors)
-		return;
+		return NULL;
 
 	/* Add a gate if this factor clock can be gated */
 	if (data->enable) {
 		gate = kzalloc(sizeof(struct clk_gate), GFP_KERNEL);
 		if (!gate) {
 			kfree(factors);
-			return;
+			return NULL;
 		}
 
 		/* set up gate properties */
@@ -357,7 +357,7 @@ static void __init sunxi_factors_clk_setup(struct device_node *node,
 		if (!mux) {
 			kfree(factors);
 			kfree(gate);
-			return;
+			return NULL;
 		}
 
 		/* set up gate properties */
@@ -378,13 +378,14 @@ static void __init sunxi_factors_clk_setup(struct device_node *node,
 			parents, i,
 			mux_hw, &clk_mux_ops,
 			&factors->hw, &clk_factors_ops,
-			gate_hw, &clk_gate_ops,
-			i ? 0 : CLK_IS_ROOT);
+			gate_hw, &clk_gate_ops, 0);
 
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
 		clk_register_clkdev(clk, clk_name, NULL);
 	}
+
+	return clk;
 }
 
 
-- 
1.8.5.2
