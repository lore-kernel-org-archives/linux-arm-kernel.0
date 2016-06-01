From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed,  1 Jun 2016 16:15:18 -0700
Subject: [PATCH 19/34] clk: moxart: Migrate to clk_hw based OF and
 registration APIs
In-Reply-To: <20160601231533.9354-1-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
Message-ID: <20160601231533.9354-20-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have clk_hw based provider APIs to register clks, we
can get rid of struct clk pointers while registering clks in
these drivers, allowing us to move closer to a clear split of
consumer and provider clk APIs.

Cc: Jonas Jensen <jonas.jensen@gmail.com>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

See commit 58657d189a2f and it's children for details on this
new registration API.

 drivers/clk/clk-moxart.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/clk-moxart.c b/drivers/clk/clk-moxart.c
index f37f719643ec..b86dac851116 100644
--- a/drivers/clk/clk-moxart.c
+++ b/drivers/clk/clk-moxart.c
@@ -19,7 +19,8 @@
 static void __init moxart_of_pll_clk_init(struct device_node *node)
 {
 	static void __iomem *base;
-	struct clk *clk, *ref_clk;
+	struct clk_hw *hw;
+	struct clk *ref_clk;
 	unsigned int mul;
 	const char *name = node->name;
 	const char *parent_name;
@@ -42,14 +43,14 @@ static void __init moxart_of_pll_clk_init(struct device_node *node)
 		return;
 	}
 
-	clk = clk_register_fixed_factor(NULL, name, parent_name, 0, mul, 1);
-	if (IS_ERR(clk)) {
+	hw = clk_hw_register_fixed_factor(NULL, name, parent_name, 0, mul, 1);
+	if (IS_ERR(hw)) {
 		pr_err("%s: failed to register clock\n", node->full_name);
 		return;
 	}
 
-	clk_register_clkdev(clk, NULL, name);
-	of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	clk_hw_register_clkdev(hw, NULL, name);
+	of_clk_add_hw_provider(node, of_clk_hw_simple_get, hw);
 }
 CLK_OF_DECLARE(moxart_pll_clock, "moxa,moxart-pll-clock",
 	       moxart_of_pll_clk_init);
@@ -57,7 +58,8 @@ CLK_OF_DECLARE(moxart_pll_clock, "moxa,moxart-pll-clock",
 static void __init moxart_of_apb_clk_init(struct device_node *node)
 {
 	static void __iomem *base;
-	struct clk *clk, *pll_clk;
+	struct clk_hw *hw;
+	struct clk *pll_clk;
 	unsigned int div, val;
 	unsigned int div_idx[] = { 2, 3, 4, 6, 8};
 	const char *name = node->name;
@@ -85,14 +87,14 @@ static void __init moxart_of_apb_clk_init(struct device_node *node)
 		return;
 	}
 
-	clk = clk_register_fixed_factor(NULL, name, parent_name, 0, 1, div);
-	if (IS_ERR(clk)) {
+	hw = clk_hw_register_fixed_factor(NULL, name, parent_name, 0, 1, div);
+	if (IS_ERR(hw)) {
 		pr_err("%s: failed to register clock\n", node->full_name);
 		return;
 	}
 
-	clk_register_clkdev(clk, NULL, name);
-	of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	clk_hw_register_clkdev(hw, NULL, name);
+	of_clk_add_hw_provider(node, of_clk_hw_simple_get, hw);
 }
 CLK_OF_DECLARE(moxart_apb_clock, "moxa,moxart-apb-clock",
 	       moxart_of_apb_clk_init);
-- 
2.7.4
