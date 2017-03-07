From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  7 Mar 2017 09:56:20 +0100
Subject: [PATCH 1/15] clk: divider: Make divider_round_rate take the parent
 clock
In-Reply-To: <cover.bc06ffa88f847ddd9ddd7c259415d5f61b55307b.1488876832.git-series.maxime.ripard@free-electrons.com>
References: <cover.bc06ffa88f847ddd9ddd7c259415d5f61b55307b.1488876832.git-series.maxime.ripard@free-electrons.com>
Message-ID: <7ebd073b4941e4b7c619f15ff0a375ff7919d403.1488876832.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far, divider_round_rate only considers the parent clock returned by
clk_hw_get_parent.

This works fine on clocks that have a single parents, this doesn't work on
muxes, since we will only consider the first parent, while other parents
may totally be able to provide a better combination.

Clocks in that case cannot use divider_round_rate, so would have to come up
with a very similar logic to work around it. Instead of having to do
something like this, and duplicate that logic everywhere, give an
additional parameter for the parent clock to consider.

Current users have been converted using the following coccinelle script

@@
identifier hw, rate, prate, table, width, flags;
@@

-long divider_round_rate(struct clk_hw *hw,
+long divider_round_rate(struct clk_hw *hw, struct clk_hw *parent,
                        unsigned long rate,
                        unsigned long *prate,
                        const struct clk_div_table *table,
                        u8 width,
                        unsigned long flags) { ... }

@@
identifier fn, hw;
expression E2, E3, E4, E5, E6;
@@
 fn (struct clk_hw *hw, ...) {
 <...
-divider_round_rate(hw, E2, E3, E4, E5, E6)
+divider_round_rate(hw, clk_hw_get_parent(hw), E2, E3, E4, E5, E6)
 ...>
}

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Carlo Caione <carlo@caione.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-amlogic at lists.infradead.org
Cc: linux-arm-msm at vger.kernel.org
Cc: linux-soc at vger.kernel.org
Cc: rtc-linux at googlegroups.com
---
 drivers/clk/clk-divider.c                 | 18 ++++++++++--------
 drivers/clk/hisilicon/clkdivider-hi6220.c |  5 +++--
 drivers/clk/meson/clk-cpu.c               |  5 +++--
 drivers/clk/nxp/clk-lpc32xx.c             |  5 +++--
 drivers/clk/qcom/clk-alpha-pll.c          |  5 +++--
 drivers/clk/qcom/clk-regmap-divider.c     |  3 ++-
 drivers/clk/sunxi-ng/ccu_div.c            |  6 +++---
 drivers/rtc/rtc-ac100.c                   |  6 ++++--
 include/linux/clk-provider.h              |  5 +++--
 9 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 96386ffc8483..d8d7dc84956a 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -275,7 +275,8 @@ static int _next_div(const struct clk_div_table *table, int div,
 	return div;
 }
 
-static int clk_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
+static int clk_divider_bestdiv(struct clk_hw *hw, struct clk_hw *parent,
+			       unsigned long rate,
 			       unsigned long *best_parent_rate,
 			       const struct clk_div_table *table, u8 width,
 			       unsigned long flags)
@@ -314,8 +315,7 @@ static int clk_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
 			*best_parent_rate = parent_rate_saved;
 			return i;
 		}
-		parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw),
-					       rate * i);
+		parent_rate = clk_hw_round_rate(parent, rate * i);
 		now = DIV_ROUND_UP_ULL((u64)parent_rate, i);
 		if (_is_best_div(rate, now, best, flags)) {
 			bestdiv = i;
@@ -326,19 +326,20 @@ static int clk_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
 
 	if (!bestdiv) {
 		bestdiv = _get_maxdiv(table, width, flags);
-		*best_parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw), 1);
+		*best_parent_rate = clk_hw_round_rate(parent, 1);
 	}
 
 	return bestdiv;
 }
 
-long divider_round_rate(struct clk_hw *hw, unsigned long rate,
+long divider_round_rate(struct clk_hw *hw, struct clk_hw *parent,
+			unsigned long rate,
 			unsigned long *prate, const struct clk_div_table *table,
 			u8 width, unsigned long flags)
 {
 	int div;
 
-	div = clk_divider_bestdiv(hw, rate, prate, table, width, flags);
+	div = clk_divider_bestdiv(hw, parent, rate, prate, table, width, flags);
 
 	return DIV_ROUND_UP_ULL((u64)*prate, div);
 }
@@ -359,8 +360,9 @@ static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
 		return DIV_ROUND_UP_ULL((u64)*prate, bestdiv);
 	}
 
-	return divider_round_rate(hw, rate, prate, divider->table,
-				  divider->width, divider->flags);
+	return divider_round_rate(hw, clk_hw_get_parent(hw), rate, prate,
+				  divider->table, divider->width,
+				  divider->flags);
 }
 
 int divider_get_val(unsigned long rate, unsigned long parent_rate,
diff --git a/drivers/clk/hisilicon/clkdivider-hi6220.c b/drivers/clk/hisilicon/clkdivider-hi6220.c
index a1c1f684ad58..deaa72902555 100644
--- a/drivers/clk/hisilicon/clkdivider-hi6220.c
+++ b/drivers/clk/hisilicon/clkdivider-hi6220.c
@@ -64,8 +64,9 @@ static long hi6220_clkdiv_round_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct hi6220_clk_divider *dclk = to_hi6220_clk_divider(hw);
 
-	return divider_round_rate(hw, rate, prate, dclk->table,
-				  dclk->width, CLK_DIVIDER_ROUND_CLOSEST);
+	return divider_round_rate(hw, clk_hw_get_parent(hw), rate, prate,
+				  dclk->table, dclk->width,
+				  CLK_DIVIDER_ROUND_CLOSEST);
 }
 
 static int hi6220_clkdiv_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/clk/meson/clk-cpu.c b/drivers/clk/meson/clk-cpu.c
index f8b2b7efd016..63c44d8c7ea4 100644
--- a/drivers/clk/meson/clk-cpu.c
+++ b/drivers/clk/meson/clk-cpu.c
@@ -59,8 +59,9 @@ static long meson_clk_cpu_round_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct meson_clk_cpu *clk_cpu = to_meson_clk_cpu_hw(hw);
 
-	return divider_round_rate(hw, rate, prate, clk_cpu->div_table,
-				  MESON_N_WIDTH, CLK_DIVIDER_ROUND_CLOSEST);
+	return divider_round_rate(hw, clk_hw_get_parent(hw), rate, prate,
+				  clk_cpu->div_table, MESON_N_WIDTH,
+				  CLK_DIVIDER_ROUND_CLOSEST);
 }
 
 static int meson_clk_cpu_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/clk/nxp/clk-lpc32xx.c b/drivers/clk/nxp/clk-lpc32xx.c
index 5b98ff9076f3..73e83a7da7d6 100644
--- a/drivers/clk/nxp/clk-lpc32xx.c
+++ b/drivers/clk/nxp/clk-lpc32xx.c
@@ -975,8 +975,9 @@ static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
 		return DIV_ROUND_UP(*prate, bestdiv);
 	}
 
-	return divider_round_rate(hw, rate, prate, divider->table,
-				  divider->width, divider->flags);
+	return divider_round_rate(hw, clk_hw_get_parent(hw), rate, prate,
+				  divider->table, divider->width,
+				  divider->flags);
 }
 
 static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 47a1da3739ce..7c08afecc811 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -478,8 +478,9 @@ clk_alpha_pll_postdiv_round_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
 
-	return divider_round_rate(hw, rate, prate, clk_alpha_div_table,
-				  pll->width, CLK_DIVIDER_POWER_OF_TWO);
+	return divider_round_rate(hw, clk_hw_get_parent(hw), rate, prate,
+				  clk_alpha_div_table, pll->width,
+				  CLK_DIVIDER_POWER_OF_TWO);
 }
 
 static int clk_alpha_pll_postdiv_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/clk/qcom/clk-regmap-divider.c b/drivers/clk/qcom/clk-regmap-divider.c
index 53484912301e..63489f0f2a02 100644
--- a/drivers/clk/qcom/clk-regmap-divider.c
+++ b/drivers/clk/qcom/clk-regmap-divider.c
@@ -28,7 +28,8 @@ static long div_round_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct clk_regmap_div *divider = to_clk_regmap_div(hw);
 
-	return divider_round_rate(hw, rate, prate, NULL, divider->width,
+	return divider_round_rate(hw, clk_hw_get_parent(hw), rate, prate,
+				  NULL, divider->width,
 				  CLK_DIVIDER_ROUND_CLOSEST);
 }
 
diff --git a/drivers/clk/sunxi-ng/ccu_div.c b/drivers/clk/sunxi-ng/ccu_div.c
index 4057e6021aa9..92855c2b30bb 100644
--- a/drivers/clk/sunxi-ng/ccu_div.c
+++ b/drivers/clk/sunxi-ng/ccu_div.c
@@ -78,10 +78,10 @@ static int ccu_div_determine_rate(struct clk_hw *hw,
 	struct ccu_div *cd = hw_to_ccu_div(hw);
 
 	if (clk_hw_get_num_parents(hw) == 1) {
-		req->rate = divider_round_rate(hw, req->rate,
+		req->rate = divider_round_rate(hw, clk_hw_get_parent(hw),
+					       req->rate,
 					       &req->best_parent_rate,
-					       cd->div.table,
-					       cd->div.width,
+					       cd->div.table, cd->div.width,
 					       cd->div.flags);
 
 		req->best_parent_hw = clk_hw_get_parent(hw);
diff --git a/drivers/rtc/rtc-ac100.c b/drivers/rtc/rtc-ac100.c
index 9e336184491c..0cad1bc41aa7 100644
--- a/drivers/rtc/rtc-ac100.c
+++ b/drivers/rtc/rtc-ac100.c
@@ -153,13 +153,15 @@ static long ac100_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
 	int i;
 
 	if (prate == AC100_RTC_32K_RATE)
-		return divider_round_rate(hw, rate, &prate, NULL,
+		return divider_round_rate(hw, clk_hw_get_parent(hw), rate,
+					  &prate, NULL,
 					  AC100_CLKOUT_DIV_WIDTH,
 					  CLK_DIVIDER_POWER_OF_TWO);
 
 	for (i = 0; ac100_clkout_prediv[i].div; i++) {
 		tmp_prate = DIV_ROUND_UP(prate, ac100_clkout_prediv[i].val);
-		tmp_rate = divider_round_rate(hw, rate, &tmp_prate, NULL,
+		tmp_rate = divider_round_rate(hw, clk_hw_get_parent(hw), rate,
+					      &tmp_prate, NULL,
 					      AC100_CLKOUT_DIV_WIDTH,
 					      CLK_DIVIDER_POWER_OF_TWO);
 
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index a428aec36ace..e17d4cc7660c 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -412,8 +412,9 @@ extern const struct clk_ops clk_divider_ro_ops;
 unsigned long divider_recalc_rate(struct clk_hw *hw, unsigned long parent_rate,
 		unsigned int val, const struct clk_div_table *table,
 		unsigned long flags);
-long divider_round_rate(struct clk_hw *hw, unsigned long rate,
-		unsigned long *prate, const struct clk_div_table *table,
+long divider_round_rate(struct clk_hw *hw, struct clk_hw *parent,
+		unsigned long rate, unsigned long *prate,
+		const struct clk_div_table *table,
 		u8 width, unsigned long flags);
 int divider_get_val(unsigned long rate, unsigned long parent_rate,
 		const struct clk_div_table *table, u8 width,
-- 
git-series 0.8.11
