From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed,  1 Jun 2016 16:15:15 -0700
Subject: [PATCH 16/34] clk: ls1x: Migrate to clk_hw based OF and registration
 APIs
In-Reply-To: <20160601231533.9354-1-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
Message-ID: <20160601231533.9354-17-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have clk_hw based provider APIs to register clks, we
can get rid of struct clk pointers while registering clks in
these drivers, allowing us to move closer to a clear split of
consumer and provider clk APIs.

Cc: Kelvin Cheung <keguang.zhang@gmail.com>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

See commit 58657d189a2f and it's children for details on this
new registration API.

 drivers/clk/clk-ls1x.c | 69 +++++++++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/drivers/clk/clk-ls1x.c b/drivers/clk/clk-ls1x.c
index 5097831387ff..c1cc427d2b78 100644
--- a/drivers/clk/clk-ls1x.c
+++ b/drivers/clk/clk-ls1x.c
@@ -48,13 +48,13 @@ static const struct clk_ops ls1x_pll_clk_ops = {
 	.recalc_rate = ls1x_pll_recalc_rate,
 };
 
-static struct clk *__init clk_register_pll(struct device *dev,
-					   const char *name,
-					   const char *parent_name,
-					   unsigned long flags)
+static struct clk_hw *__init clk_hw_register_pll(struct device *dev,
+						 const char *name,
+						 const char *parent_name,
+						 unsigned long flags)
 {
+	int ret;
 	struct clk_hw *hw;
-	struct clk *clk;
 	struct clk_init_data init;
 
 	/* allocate the divider */
@@ -72,12 +72,13 @@ static struct clk *__init clk_register_pll(struct device *dev,
 	hw->init = &init;
 
 	/* register the clock */
-	clk = clk_register(dev, hw);
-
-	if (IS_ERR(clk))
+	ret = clk_hw_register(dev, hw);
+	if (ret) {
 		kfree(hw);
+		hw = ERR_PTR(ret);
+	}
 
-	return clk;
+	return hw;
 }
 
 static const char * const cpu_parents[] = { "cpu_clk_div", "osc_33m_clk", };
@@ -86,14 +87,14 @@ static const char * const dc_parents[] = { "dc_clk_div", "osc_33m_clk", };
 
 void __init ls1x_clk_init(void)
 {
-	struct clk *clk;
+	struct clk_hw *hw;
 
-	clk = clk_register_fixed_rate(NULL, "osc_33m_clk", NULL, 0, OSC);
-	clk_register_clkdev(clk, "osc_33m_clk", NULL);
+	hw = clk_hw_register_fixed_rate(NULL, "osc_33m_clk", NULL, 0, OSC);
+	clk_hw_register_clkdev(clk, "osc_33m_clk", NULL);
 
 	/* clock derived from 33 MHz OSC clk */
-	clk = clk_register_pll(NULL, "pll_clk", "osc_33m_clk", 0);
-	clk_register_clkdev(clk, "pll_clk", NULL);
+	hw = clk_hw_register_pll(NULL, "pll_clk", "osc_33m_clk", 0);
+	clk_hw_register_clkdev(hw, "pll_clk", NULL);
 
 	/* clock derived from PLL clk */
 	/*                                 _____
@@ -102,17 +103,17 @@ void __init ls1x_clk_init(void)
 	 *        \___ PLL ___ CPU DIV ___|     |
 	 *                                |_____|
 	 */
-	clk = clk_register_divider(NULL, "cpu_clk_div", "pll_clk",
+	hw = clk_hw_register_divider(NULL, "cpu_clk_div", "pll_clk",
 				   CLK_GET_RATE_NOCACHE, LS1X_CLK_PLL_DIV,
 				   DIV_CPU_SHIFT, DIV_CPU_WIDTH,
 				   CLK_DIVIDER_ONE_BASED |
 				   CLK_DIVIDER_ROUND_CLOSEST, &_lock);
-	clk_register_clkdev(clk, "cpu_clk_div", NULL);
-	clk = clk_register_mux(NULL, "cpu_clk", cpu_parents,
+	clk_hw_register_clkdev(hw, "cpu_clk_div", NULL);
+	hw = clk_hw_register_mux(NULL, "cpu_clk", cpu_parents,
 			       ARRAY_SIZE(cpu_parents),
 			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
 			       BYPASS_CPU_SHIFT, BYPASS_CPU_WIDTH, 0, &_lock);
-	clk_register_clkdev(clk, "cpu_clk", NULL);
+	clk_hw_register_clkdev(hw, "cpu_clk", NULL);
 
 	/*                                 _____
 	 *         _______________________|     |
@@ -120,15 +121,15 @@ void __init ls1x_clk_init(void)
 	 *        \___ PLL ___ DC  DIV ___|     |
 	 *                                |_____|
 	 */
-	clk = clk_register_divider(NULL, "dc_clk_div", "pll_clk",
+	hw = clk_hw_register_divider(NULL, "dc_clk_div", "pll_clk",
 				   0, LS1X_CLK_PLL_DIV, DIV_DC_SHIFT,
 				   DIV_DC_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
-	clk_register_clkdev(clk, "dc_clk_div", NULL);
-	clk = clk_register_mux(NULL, "dc_clk", dc_parents,
+	clk_hw_register_clkdev(hw, "dc_clk_div", NULL);
+	hw = clk_hw_register_mux(NULL, "dc_clk", dc_parents,
 			       ARRAY_SIZE(dc_parents),
 			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
 			       BYPASS_DC_SHIFT, BYPASS_DC_WIDTH, 0, &_lock);
-	clk_register_clkdev(clk, "dc_clk", NULL);
+	clk_hw_register_clkdev(hw, "dc_clk", NULL);
 
 	/*                                 _____
 	 *         _______________________|     |
@@ -136,26 +137,26 @@ void __init ls1x_clk_init(void)
 	 *        \___ PLL ___ DDR DIV ___|     |
 	 *                                |_____|
 	 */
-	clk = clk_register_divider(NULL, "ahb_clk_div", "pll_clk",
+	hw = clk_hw_register_divider(NULL, "ahb_clk_div", "pll_clk",
 				   0, LS1X_CLK_PLL_DIV, DIV_DDR_SHIFT,
 				   DIV_DDR_WIDTH, CLK_DIVIDER_ONE_BASED,
 				   &_lock);
-	clk_register_clkdev(clk, "ahb_clk_div", NULL);
-	clk = clk_register_mux(NULL, "ahb_clk", ahb_parents,
+	clk_hw_register_clkdev(hw, "ahb_clk_div", NULL);
+	hw = clk_hw_register_mux(NULL, "ahb_clk", ahb_parents,
 			       ARRAY_SIZE(ahb_parents),
 			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
 			       BYPASS_DDR_SHIFT, BYPASS_DDR_WIDTH, 0, &_lock);
-	clk_register_clkdev(clk, "ahb_clk", NULL);
-	clk_register_clkdev(clk, "stmmaceth", NULL);
+	clk_hw_register_clkdev(hw, "ahb_clk", NULL);
+	clk_hw_register_clkdev(hw, "stmmaceth", NULL);
 
 	/* clock derived from AHB clk */
 	/* APB clk is always half of the AHB clk */
-	clk = clk_register_fixed_factor(NULL, "apb_clk", "ahb_clk", 0, 1,
+	hw = clk_hw_register_fixed_factor(NULL, "apb_clk", "ahb_clk", 0, 1,
 					DIV_APB);
-	clk_register_clkdev(clk, "apb_clk", NULL);
-	clk_register_clkdev(clk, "ls1x_i2c", NULL);
-	clk_register_clkdev(clk, "ls1x_pwmtimer", NULL);
-	clk_register_clkdev(clk, "ls1x_spi", NULL);
-	clk_register_clkdev(clk, "ls1x_wdt", NULL);
-	clk_register_clkdev(clk, "serial8250", NULL);
+	clk_hw_register_clkdev(hw, "apb_clk", NULL);
+	clk_hw_register_clkdev(hw, "ls1x_i2c", NULL);
+	clk_hw_register_clkdev(hw, "ls1x_pwmtimer", NULL);
+	clk_hw_register_clkdev(hw, "ls1x_spi", NULL);
+	clk_hw_register_clkdev(hw, "ls1x_wdt", NULL);
+	clk_hw_register_clkdev(hw, "serial8250", NULL);
 }
-- 
2.7.4
