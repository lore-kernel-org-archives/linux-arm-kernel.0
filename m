From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 5 Jun 2013 17:21:46 +0300
Subject: [PATCH] clk: tegra: fix pllre initilization
Message-ID: <1370442111-13215-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PLLRE flags weren't set correctly. Fixed in this patch.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/clk/tegra/clk-pll.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
index 4293643..197074a 100644
--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -1424,7 +1424,7 @@ struct clk *tegra_clk_register_pllre(const char *name, const char *parent_name,
 	struct tegra_clk_pll *pll;
 	struct clk *clk;
 
-	pll_flags |= TEGRA_PLL_HAS_LOCK_ENABLE;
+	pll_flags |= TEGRA_PLL_HAS_LOCK_ENABLE | TEGRA_PLL_LOCK_MISC;
 	pll = _tegra_init_pll(clk_base, pmc, fixed_rate, pll_params, pll_flags,
 			      freq_table, lock);
 	if (IS_ERR(pll))
@@ -1451,7 +1451,6 @@ struct clk *tegra_clk_register_pllre(const char *name, const char *parent_name,
 	val &= ~BIT(29);
 	pll_writel_misc(val, pll);
 
-	pll_flags |= TEGRA_PLL_LOCK_MISC;
 	clk = _tegra_clk_register_pll(pll, name, parent_name, flags,
 				      &tegra_clk_pllre_ops);
 	if (IS_ERR(clk))
-- 
1.7.7.rc0.72.g4b5ea.dirty
