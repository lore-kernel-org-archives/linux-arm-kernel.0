From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 30 Oct 2013 02:41:29 +0200
Subject: [PATCH] clk: tegra: use pll_ref as the pll_e parent
Message-ID: <1383093707-10312-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use pll_ref instead of pll_re_vco as the pll_e parent on Tegra114 and
Tegra124. Also add a pll_ref table entry for pll_e for Tegra114.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/clk/tegra/clk-pll.c      |    7 ++++---
 drivers/clk/tegra/clk-tegra114.c |    3 ++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
index 7d775a9..193457b 100644
--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -1712,11 +1712,12 @@ struct clk *tegra_clk_register_plle_tegra114(const char *name,
 	val_aux = pll_readl(pll_params->aux_reg, pll);
 
 	if (val & PLL_BASE_ENABLE) {
-		if (!(val_aux & PLLE_AUX_PLLRE_SEL))
+		if ((val_aux & PLLE_AUX_PLLRE_SEL) || (val_aux & val_aux))
 			WARN(1, "pll_e enabled with unsupported parent %s\n",
-			  (val & PLLE_AUX_PLLP_SEL) ? "pllp_out0" : "pll_ref");
+			  (val_aux & PLLE_AUX_PLLP_SEL) ? "pllp_out0" :
+					"pll_re_vco");
 	} else {
-		val_aux |= PLLE_AUX_PLLRE_SEL;
+		val_aux &= ~(PLLE_AUX_PLLRE_SEL | PLLE_AUX_PLLP_SEL);
 		pll_writel(val, pll_params->aux_reg, pll);
 	}
 
diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index e365b35..5cfcd3e 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -560,6 +560,7 @@ static struct tegra_clk_pll_freq_table pll_e_freq_table[] = {
 	/* PLLE special case: use cpcon field to store cml divider value */
 	{336000000, 100000000, 100, 21, 16, 11},
 	{312000000, 100000000, 200, 26, 24, 13},
+	{12000000, 100000000, 200,  1,  24, 13},
 	{0, 0, 0, 0, 0, 0},
 };
 
@@ -1178,7 +1179,7 @@ static void __init tegra114_pll_init(void __iomem *clk_base,
 	clks[TEGRA114_CLK_PLL_RE_OUT] = clk;
 
 	/* PLLE */
-	clk = tegra_clk_register_plle_tegra114("pll_e_out0", "pll_re_vco",
+	clk = tegra_clk_register_plle_tegra114("pll_e_out0", "pll_ref",
 				      clk_base, 0, &pll_e_params, NULL);
 	clks[TEGRA114_CLK_PLL_E_OUT0] = clk;
 }
-- 
1.7.7.rc0.72.g4b5ea.dirty
