From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed,  1 Jun 2016 16:15:31 -0700
Subject: [PATCH 32/34] clk: u300: Migrate to clk_hw based registration APIs
In-Reply-To: <20160601231533.9354-1-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
Message-ID: <20160601231533.9354-33-stephen.boyd@linaro.org>
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

 drivers/clk/clk-u300.c | 59 ++++++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/drivers/clk/clk-u300.c b/drivers/clk/clk-u300.c
index 95d1742dac30..ec8aafda6e24 100644
--- a/drivers/clk/clk-u300.c
+++ b/drivers/clk/clk-u300.c
@@ -689,7 +689,7 @@ static const struct clk_ops syscon_clk_ops = {
 	.set_rate = syscon_clk_set_rate,
 };
 
-static struct clk * __init
+static struct clk_hw * __init
 syscon_clk_register(struct device *dev, const char *name,
 		    const char *parent_name, unsigned long flags,
 		    bool hw_ctrld,
@@ -697,9 +697,10 @@ syscon_clk_register(struct device *dev, const char *name,
 		    void __iomem *en_reg, u8 en_bit,
 		    u16 clk_val)
 {
-	struct clk *clk;
+	struct clk_hw *hw;
 	struct clk_syscon *sclk;
 	struct clk_init_data init;
+	int ret;
 
 	sclk = kzalloc(sizeof(struct clk_syscon), GFP_KERNEL);
 	if (!sclk) {
@@ -722,11 +723,14 @@ syscon_clk_register(struct device *dev, const char *name,
 	sclk->en_bit = en_bit;
 	sclk->clk_val = clk_val;
 
-	clk = clk_register(dev, &sclk->hw);
-	if (IS_ERR(clk))
+	hw = &sclk->hw;
+	ret = clk_hw_register(dev, hw);
+	if (ret) {
 		kfree(sclk);
+		hw = ERR_PTR(ret);
+	}
 
-	return clk;
+	return hw;
 }
 
 #define U300_CLK_TYPE_SLOW 0
@@ -868,7 +872,7 @@ static struct u300_clock const u300_clk_lookup[] __initconst = {
 
 static void __init of_u300_syscon_clk_init(struct device_node *np)
 {
-	struct clk *clk = ERR_PTR(-EINVAL);
+	struct clk_hw *hw = ERR_PTR(-EINVAL);
 	const char *clk_name = np->name;
 	const char *parent_name;
 	void __iomem *res_reg;
@@ -911,16 +915,15 @@ static void __init of_u300_syscon_clk_init(struct device_node *np)
 		const struct u300_clock *u3clk = &u300_clk_lookup[i];
 
 		if (u3clk->type == clk_type && u3clk->id == clk_id)
-			clk = syscon_clk_register(NULL,
-						  clk_name, parent_name,
-						  0, u3clk->hw_ctrld,
-						  res_reg, u3clk->id,
-						  en_reg, u3clk->id,
-						  u3clk->clk_val);
+			hw = syscon_clk_register(NULL, clk_name, parent_name,
+						 0, u3clk->hw_ctrld,
+						 res_reg, u3clk->id,
+						 en_reg, u3clk->id,
+						 u3clk->clk_val);
 	}
 
-	if (!IS_ERR(clk)) {
-		of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	if (!IS_ERR(hw)) {
+		of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
 
 		/*
 		 * Some few system clocks - device tree does not
@@ -928,11 +931,11 @@ static void __init of_u300_syscon_clk_init(struct device_node *np)
 		 * for now we add these three clocks here.
 		 */
 		if (clk_type == U300_CLK_TYPE_REST && clk_id == 5)
-			clk_register_clkdev(clk, NULL, "pl172");
+			clk_hw_register_clkdev(hw, NULL, "pl172");
 		if (clk_type == U300_CLK_TYPE_REST && clk_id == 9)
-			clk_register_clkdev(clk, NULL, "semi");
+			clk_hw_register_clkdev(hw, NULL, "semi");
 		if (clk_type == U300_CLK_TYPE_REST && clk_id == 12)
-			clk_register_clkdev(clk, NULL, "intcon");
+			clk_hw_register_clkdev(hw, NULL, "intcon");
 	}
 }
 
@@ -1111,13 +1114,14 @@ static const struct clk_ops mclk_ops = {
 	.set_rate = mclk_clk_set_rate,
 };
 
-static struct clk * __init
+static struct clk_hw * __init
 mclk_clk_register(struct device *dev, const char *name,
 		  const char *parent_name, bool is_mspro)
 {
-	struct clk *clk;
+	struct clk_hw *hw;
 	struct clk_mclk *mclk;
 	struct clk_init_data init;
+	int ret;
 
 	mclk = kzalloc(sizeof(struct clk_mclk), GFP_KERNEL);
 	if (!mclk) {
@@ -1133,23 +1137,26 @@ mclk_clk_register(struct device *dev, const char *name,
 	mclk->hw.init = &init;
 	mclk->is_mspro = is_mspro;
 
-	clk = clk_register(dev, &mclk->hw);
-	if (IS_ERR(clk))
+	hw = &mclk->hw;
+	ret = clk_hw_register(dev, hw);
+	if (ret) {
 		kfree(mclk);
+		hw = ERR_PTR(ret);
+	}
 
-	return clk;
+	return hw;
 }
 
 static void __init of_u300_syscon_mclk_init(struct device_node *np)
 {
-	struct clk *clk = ERR_PTR(-EINVAL);
+	struct clk_hw *hw;
 	const char *clk_name = np->name;
 	const char *parent_name;
 
 	parent_name = of_clk_get_parent_name(np, 0);
-	clk = mclk_clk_register(NULL, clk_name, parent_name, false);
-	if (!IS_ERR(clk))
-		of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	hw = mclk_clk_register(NULL, clk_name, parent_name, false);
+	if (!IS_ERR(hw))
+		of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
 }
 
 static const struct of_device_id u300_clk_match[] __initconst = {
-- 
2.7.4
