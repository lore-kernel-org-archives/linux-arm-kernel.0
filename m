From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 27 Mar 2013 18:30:41 +0100
Subject: [PATCH v2 07/11] ARM i.MX53: fix ldb di divider and selector clocks
In-Reply-To: <1364405445-5271-1-git-send-email-p.zabel@pengutronix.de>
References: <1364405445-5271-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1364405445-5271-8-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use imx_clk_mux_flags and imx_clk_divider_flags to set the appropriate
flags for the LDB display interface divider and selector clocks.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx51-imx53.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index d22ee6a..ed08aba 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -420,15 +420,15 @@ int __init mx53_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 	clk[pll3_sw] = imx_clk_pllv2("pll3_sw", "osc", MX53_DPLL3_BASE);
 	clk[pll4_sw] = imx_clk_pllv2("pll4_sw", "osc", MX53_DPLL4_BASE);
 
-	clk[ldb_di1_sel] = imx_clk_mux("ldb_di1_sel", MXC_CCM_CSCMR2, 9, 1,
-				mx53_ldb_di1_sel, ARRAY_SIZE(mx53_ldb_di1_sel));
 	clk[ldb_di1_div_3_5] = imx_clk_fixed_factor("ldb_di1_div_3_5", "ldb_di1_sel", 2, 7);
-	clk[ldb_di1_div] = imx_clk_divider("ldb_di1_div", "ldb_di1_div_3_5", MXC_CCM_CSCMR2, 11, 1);
+	clk[ldb_di1_div] = imx_clk_divider_flags("ldb_di1_div", "ldb_di1_div_3_5", MXC_CCM_CSCMR2, 11, 1, 0);
+	clk[ldb_di1_sel] = imx_clk_mux_flags("ldb_di1_sel", MXC_CCM_CSCMR2, 9, 1,
+				mx53_ldb_di1_sel, ARRAY_SIZE(mx53_ldb_di1_sel), CLK_SET_RATE_PARENT);
 	clk[di_pll4_podf] = imx_clk_divider("di_pll4_podf", "pll4_sw", MXC_CCM_CDCDR, 16, 3);
-	clk[ldb_di0_sel] = imx_clk_mux("ldb_di0_sel", MXC_CCM_CSCMR2, 8, 1,
-				mx53_ldb_di0_sel, ARRAY_SIZE(mx53_ldb_di0_sel));
 	clk[ldb_di0_div_3_5] = imx_clk_fixed_factor("ldb_di0_div_3_5", "ldb_di0_sel", 2, 7);
-	clk[ldb_di0_div] = imx_clk_divider("ldb_di0_div", "ldb_di0_div_3_5", MXC_CCM_CSCMR2, 10, 1);
+	clk[ldb_di0_div] = imx_clk_divider_flags("ldb_di0_div", "ldb_di0_div_3_5", MXC_CCM_CSCMR2, 10, 1, 0);
+	clk[ldb_di0_sel] = imx_clk_mux_flags("ldb_di0_sel", MXC_CCM_CSCMR2, 8, 1,
+				mx53_ldb_di0_sel, ARRAY_SIZE(mx53_ldb_di0_sel), CLK_SET_RATE_PARENT);
 	clk[ldb_di0_gate] = imx_clk_gate2("ldb_di0_gate", "ldb_di0_div", MXC_CCM_CCGR6, 28);
 	clk[ldb_di1_gate] = imx_clk_gate2("ldb_di1_gate", "ldb_di1_div", MXC_CCM_CCGR6, 30);
 	clk[ipu_di0_sel] = imx_clk_mux("ipu_di0_sel", MXC_CCM_CSCMR2, 26, 3,
-- 
1.8.2.rc2
