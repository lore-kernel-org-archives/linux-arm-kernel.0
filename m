From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Nov 2015 23:32:33 +0100
Subject: [PATCH] clk: tegra: move _calc_dynamic_ram_rate out of #ifdef
Message-ID: <4290741.p1jMzEOUEU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

_calc_dynamic_ram_rate is defined inside an #ifdef but called
later in the same file outside of that #ifdef, which can cause a
build error:

drivers/clk/tegra/clk-pll.c: In function '_tegra_clk_register_pll':
drivers/clk/tegra/clk-pll.c:1541:29: error: '_calc_dynamic_ramp_rate' undeclared (first use in this function)

This moves both _calc_dynamic_ram_rate and _pll_fixed_mdiv in
front of the #ifdef to make all configurations compile again.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 44c8b9fa432c ("clk: tegra: pll: Fix _pll_ramp_calc_pll logic and _calc_dynamic_ramp_rate")
----
The patch that caused it appears to be older, but I only ran into
the randconfig bug today for the first time. Apparently the commit
is only in linux-next at the moment, not in 4.4-rc1

diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
index 9734ffa185d3..94f3a6d34e3a 100644
--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -967,11 +967,6 @@ const struct clk_ops tegra_clk_plle_ops = {
 	.enable = clk_plle_enable,
 };
 
-#if defined(CONFIG_ARCH_TEGRA_114_SOC) || \
-	defined(CONFIG_ARCH_TEGRA_124_SOC) || \
-	defined(CONFIG_ARCH_TEGRA_132_SOC) || \
-	defined(CONFIG_ARCH_TEGRA_210_SOC)
-
 static int _pll_fixed_mdiv(struct tegra_clk_pll_params *pll_params,
 			   unsigned long parent_rate)
 {
@@ -990,6 +985,40 @@ static int _pll_fixed_mdiv(struct tegra_clk_pll_params *pll_params,
 		return 1;
 }
 
+static int _calc_dynamic_ramp_rate(struct clk_hw *hw,
+				struct tegra_clk_pll_freq_table *cfg,
+				unsigned long rate, unsigned long parent_rate)
+{
+	struct tegra_clk_pll *pll = to_clk_pll(hw);
+	unsigned int p;
+	int p_div;
+
+	if (!rate)
+		return -EINVAL;
+
+	p = DIV_ROUND_UP(pll->params->vco_min, rate);
+	cfg->m = _pll_fixed_mdiv(pll->params, parent_rate);
+	cfg->output_rate = rate * p;
+	cfg->n = cfg->output_rate * cfg->m / parent_rate;
+	cfg->input_rate = parent_rate;
+
+	p_div = _p_div_to_hw(hw, p);
+	if (p_div < 0)
+		return p_div;
+
+	cfg->p = p_div;
+
+	if (cfg->n > divn_max(pll) || cfg->output_rate > pll->params->vco_max)
+		return -EINVAL;
+
+	return 0;
+}
+
+#if defined(CONFIG_ARCH_TEGRA_114_SOC) || \
+	defined(CONFIG_ARCH_TEGRA_124_SOC) || \
+	defined(CONFIG_ARCH_TEGRA_132_SOC) || \
+	defined(CONFIG_ARCH_TEGRA_210_SOC)
+
 u16 tegra_pll_get_fixed_mdiv(struct clk_hw *hw, unsigned long input_rate)
 {
 	struct tegra_clk_pll *pll = to_clk_pll(hw);
@@ -1039,35 +1068,6 @@ static int _setup_dynamic_ramp(struct tegra_clk_pll_params *pll_params,
 	return 0;
 }
 
-static int _calc_dynamic_ramp_rate(struct clk_hw *hw,
-				struct tegra_clk_pll_freq_table *cfg,
-				unsigned long rate, unsigned long parent_rate)
-{
-	struct tegra_clk_pll *pll = to_clk_pll(hw);
-	unsigned int p;
-	int p_div;
-
-	if (!rate)
-		return -EINVAL;
-
-	p = DIV_ROUND_UP(pll->params->vco_min, rate);
-	cfg->m = _pll_fixed_mdiv(pll->params, parent_rate);
-	cfg->output_rate = rate * p;
-	cfg->n = cfg->output_rate * cfg->m / parent_rate;
-	cfg->input_rate = parent_rate;
-
-	p_div = _p_div_to_hw(hw, p);
-	if (p_div < 0)
-		return p_div;
-
-	cfg->p = p_div;
-
-	if (cfg->n > divn_max(pll) || cfg->output_rate > pll->params->vco_max)
-		return -EINVAL;
-
-	return 0;
-}
-
 static int _pll_ramp_calc_pll(struct clk_hw *hw,
 			      struct tegra_clk_pll_freq_table *cfg,
 			      unsigned long rate, unsigned long parent_rate)
