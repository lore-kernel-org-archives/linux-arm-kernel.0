From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed,  1 Jun 2016 16:15:19 -0700
Subject: [PATCH 20/34] clk: nomadik: Migrate to clk_hw based OF and
 registration APIs
In-Reply-To: <20160601231533.9354-1-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
Message-ID: <20160601231533.9354-21-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have clk_hw based provider APIs to register clks, we
can get rid of struct clk pointers while registering clks in
these drivers, allowing us to move closer to a clear split of
consumer and provider clk APIs.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

See commit 58657d189a2f and it's children for details on this
new registration API.

 drivers/clk/clk-nomadik.c | 48 +++++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/clk-nomadik.c b/drivers/clk/clk-nomadik.c
index e4d8a991c58f..71677eb12565 100644
--- a/drivers/clk/clk-nomadik.c
+++ b/drivers/clk/clk-nomadik.c
@@ -253,11 +253,11 @@ static const struct clk_ops pll_clk_ops = {
 	.recalc_rate = pll_clk_recalc_rate,
 };
 
-static struct clk * __init
+static struct clk_hw * __init
 pll_clk_register(struct device *dev, const char *name,
 		 const char *parent_name, u32 id)
 {
-	struct clk *clk;
+	int ret;
 	struct clk_pll *pll;
 	struct clk_init_data init;
 
@@ -281,11 +281,13 @@ pll_clk_register(struct device *dev, const char *name,
 
 	pr_debug("register PLL1 clock \"%s\"\n", name);
 
-	clk = clk_register(dev, &pll->hw);
-	if (IS_ERR(clk))
+	ret = clk_hw_register(dev, &pll->hw);
+	if (ret) {
 		kfree(pll);
+		return ERR_PTR(ret);
+	}
 
-	return clk;
+	return &pll->hw;
 }
 
 /*
@@ -345,11 +347,11 @@ static const struct clk_ops src_clk_ops = {
 	.recalc_rate = src_clk_recalc_rate,
 };
 
-static struct clk * __init
+static struct clk_hw * __init
 src_clk_register(struct device *dev, const char *name,
 		 const char *parent_name, u8 id)
 {
-	struct clk *clk;
+	int ret;
 	struct clk_src *sclk;
 	struct clk_init_data init;
 
@@ -376,11 +378,13 @@ src_clk_register(struct device *dev, const char *name,
 	pr_debug("register clock \"%s\" ID: %d group: %d bits: %08x\n",
 		 name, id, sclk->group1, sclk->clkbit);
 
-	clk = clk_register(dev, &sclk->hw);
-	if (IS_ERR(clk))
+	ret = clk_hw_register(dev, &sclk->hw);
+	if (ret) {
 		kfree(sclk);
+		return ERR_PTR(ret);
+	}
 
-	return clk;
+	return &sclk->hw;
 }
 
 #ifdef CONFIG_DEBUG_FS
@@ -508,7 +512,7 @@ device_initcall(nomadik_src_clk_init_debugfs);
 
 static void __init of_nomadik_pll_setup(struct device_node *np)
 {
-	struct clk *clk = ERR_PTR(-EINVAL);
+	struct clk_hw *hw;
 	const char *clk_name = np->name;
 	const char *parent_name;
 	u32 pll_id;
@@ -522,16 +526,16 @@ static void __init of_nomadik_pll_setup(struct device_node *np)
 		return;
 	}
 	parent_name = of_clk_get_parent_name(np, 0);
-	clk = pll_clk_register(NULL, clk_name, parent_name, pll_id);
-	if (!IS_ERR(clk))
-		of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	hw = pll_clk_register(NULL, clk_name, parent_name, pll_id);
+	if (!IS_ERR(hw))
+		of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
 }
 CLK_OF_DECLARE(nomadik_pll_clk,
 	"st,nomadik-pll-clock", of_nomadik_pll_setup);
 
 static void __init of_nomadik_hclk_setup(struct device_node *np)
 {
-	struct clk *clk = ERR_PTR(-EINVAL);
+	struct clk_hw *hw;
 	const char *clk_name = np->name;
 	const char *parent_name;
 
@@ -542,20 +546,20 @@ static void __init of_nomadik_hclk_setup(struct device_node *np)
 	/*
 	 * The HCLK divides PLL1 with 1 (passthru), 2, 3 or 4.
 	 */
-	clk = clk_register_divider(NULL, clk_name, parent_name,
+	hw = clk_hw_register_divider(NULL, clk_name, parent_name,
 			   0, src_base + SRC_CR,
 			   13, 2,
 			   CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
 			   &src_lock);
-	if (!IS_ERR(clk))
-		of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	if (!IS_ERR(hw))
+		of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
 }
 CLK_OF_DECLARE(nomadik_hclk_clk,
 	"st,nomadik-hclk-clock", of_nomadik_hclk_setup);
 
 static void __init of_nomadik_src_clk_setup(struct device_node *np)
 {
-	struct clk *clk = ERR_PTR(-EINVAL);
+	struct clk_hw *hw;
 	const char *clk_name = np->name;
 	const char *parent_name;
 	u32 clk_id;
@@ -569,9 +573,9 @@ static void __init of_nomadik_src_clk_setup(struct device_node *np)
 		return;
 	}
 	parent_name = of_clk_get_parent_name(np, 0);
-	clk = src_clk_register(NULL, clk_name, parent_name, clk_id);
-	if (!IS_ERR(clk))
-		of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	hw = src_clk_register(NULL, clk_name, parent_name, clk_id);
+	if (!IS_ERR(hw))
+		of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
 }
 CLK_OF_DECLARE(nomadik_src_clk,
 	"st,nomadik-src-clock", of_nomadik_src_clk_setup);
-- 
2.7.4
