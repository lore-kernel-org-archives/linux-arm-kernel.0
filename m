From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 3 Apr 2013 17:40:38 +0300
Subject: [PATCH v9 04/14] clk: tegra: introduce TEGRA_PLL_HAS_LOCK_ENABLE
In-Reply-To: <1365000110-8916-1-git-send-email-pdeschrijver@nvidia.com>
References: <1365000110-8916-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1365000110-8916-5-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tegra114 PLLC2 and PLLC3 don't have a lock enable bit. The lock bits are
always functional.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/clk/tegra/clk-pll.c |    5 +++++
 drivers/clk/tegra/clk.h     |    2 ++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
index 4ee6d03..eaab060 100644
--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -108,6 +108,9 @@ static void clk_pll_enable_lock(struct tegra_clk_pll *pll)
 	if (!(pll->flags & TEGRA_PLL_USE_LOCK))
 		return;
 
+	if (!(pll->flags & TEGRA_PLL_HAS_LOCK_ENABLE))
+		return;
+
 	val = pll_readl_misc(pll);
 	val |= BIT(pll->params->lock_enable_bit_idx);
 	pll_writel_misc(val, pll);
@@ -675,6 +678,7 @@ struct clk *tegra_clk_register_pll(const char *name, const char *parent_name,
 	struct clk *clk;
 
 	pll_flags |= TEGRA_PLL_BYPASS;
+	pll_flags |= TEGRA_PLL_HAS_LOCK_ENABLE;
 	pll = _tegra_init_pll(clk_base, pmc, fixed_rate, pll_params, pll_flags,
 			      freq_table, lock);
 	if (IS_ERR(pll))
@@ -698,6 +702,7 @@ struct clk *tegra_clk_register_plle(const char *name, const char *parent_name,
 	struct clk *clk;
 
 	pll_flags |= TEGRA_PLL_LOCK_MISC | TEGRA_PLL_BYPASS;
+	pll_flags |= TEGRA_PLL_HAS_LOCK_ENABLE;
 	pll = _tegra_init_pll(clk_base, pmc, fixed_rate, pll_params, pll_flags,
 			      freq_table, lock);
 	if (IS_ERR(pll))
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index fff520a..17ddb22 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -185,6 +185,7 @@ struct tegra_clk_pll_params {
  * TEGRA_PLL_LOCK_MISC - Lock bit is in the misc register instead of the
  *     base register.
  * TEGRA_PLL_BYPASS - PLL has bypass bit
+ * TEGRA_PLL_HAS_LOCK_ENABLE - PLL has bit to enable lock monitoring
  */
 struct tegra_clk_pll {
 	struct clk_hw	hw;
@@ -215,6 +216,7 @@ struct tegra_clk_pll {
 #define TEGRA_PLLE_CONFIGURE BIT(7)
 #define TEGRA_PLL_LOCK_MISC BIT(8)
 #define TEGRA_PLL_BYPASS BIT(9)
+#define TEGRA_PLL_HAS_LOCK_ENABLE BIT(10)
 
 extern const struct clk_ops tegra_clk_pll_ops;
 extern const struct clk_ops tegra_clk_plle_ops;
-- 
1.7.7.rc0.72.g4b5ea.dirty
