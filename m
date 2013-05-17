From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 17 May 2013 15:49:03 +0200
Subject: [PATCH 2/2] ARM i.MX5: Add S/PDIF clocks
In-Reply-To: <1368798543-23285-1-git-send-email-p.zabel@pengutronix.de>
References: <1368798543-23285-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1368798543-23285-2-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the S/PDIF clocks for i.MX51 and i.MX53. Tested on i.MX53.
The i.MX51 has a second set of spdif_root clock dividers, and on i.MX53
there is an additional input to the spdif_xtal mux.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 .../devicetree/bindings/clock/imx5-clock.txt       | 12 ++++++++++
 arch/arm/mach-imx/clk-imx51-imx53.c                | 28 +++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/imx5-clock.txt b/Documentation/devicetree/bindings/clock/imx5-clock.txt
index b66cf36..f46f562 100644
--- a/Documentation/devicetree/bindings/clock/imx5-clock.txt
+++ b/Documentation/devicetree/bindings/clock/imx5-clock.txt
@@ -185,6 +185,18 @@ clocks and IDs.
 	srtc_gate		171
 	pata_gate		172
 	sata_gate		173
+	spdif_xtal_sel		174
+	spdif0_sel		175
+	spdif1_sel		176
+	spdif0_pred		177
+	spdif0_podf		178
+	spdif1_pred		179
+	spdif1_podf		180
+	spdif0_com_sel		181
+	spdif1_com_sel		182
+	spdif0_gate		183
+	spdif1_gate		184
+	spdif_ipg_gate		185
 
 Examples (for mx53):
 
diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index fbc15f2..6ac38de 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -73,6 +73,12 @@ static const char *mx53_cko2_sel[] = {
 	"tve_sel", "lp_apm",
 	"uart_root", "dummy"/* spdif0_clk_root */,
 	"dummy", "dummy", };
+static const char *mx51_spdif_xtal_sel[] = { "osc", "ckih", "ckih2", };
+static const char *mx53_spdif_xtal_sel[] = { "osc", "ckih", "ckih2", "pll4_sw", };
+static const char *spdif_sel[] = { "pll1_sw", "pll2_sw", "pll3_sw", "spdif_xtal_sel", };
+static const char *spdif0_com_sel[] = { "spdif0_podf", "ssi1_root_gate", };
+static const char *mx51_spdif1_com_sel[] = { "spdif1_podf", "ssi2_root_gate", };
+
 
 enum imx5_clks {
 	dummy, ckil, osc, ckih1, ckih2, ahb, ipg, axi_a, axi_b, uart_pred,
@@ -110,7 +116,9 @@ enum imx5_clks {
 	owire_gate, gpu3d_s, gpu2d_s, gpu3d_gate, gpu2d_gate, garb_gate,
 	cko1_sel, cko1_podf, cko1,
 	cko2_sel, cko2_podf, cko2,
-	srtc_gate, pata_gate, sata_gate,
+	srtc_gate, pata_gate, sata_gate, spdif_xtal_sel, spdif0_sel,
+	spdif1_sel, spdif0_pred, spdif0_podf, spdif1_pred, spdif1_podf,
+	spdif0_com_s, spdif1_com_sel, spdif0_gate, spdif1_gate, spdif_ipg_gate,
 	clk_max
 };
 
@@ -267,6 +275,13 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
 	clk[owire_gate] = imx_clk_gate2("owire_gate", "per_root", MXC_CCM_CCGR2, 22);
 	clk[srtc_gate] = imx_clk_gate2("srtc_gate", "per_root", MXC_CCM_CCGR4, 28);
 	clk[pata_gate] = imx_clk_gate2("pata_gate", "ipg", MXC_CCM_CCGR4, 0);
+	clk[spdif0_sel] = imx_clk_mux("spdif0_sel", MXC_CCM_CSCMR2, 0, 2, spdif_sel, ARRAY_SIZE(spdif_sel));
+	clk[spdif0_pred] = imx_clk_divider("spdif0_pred", "spdif0_sel", MXC_CCM_CDCDR, 25, 3);
+	clk[spdif0_podf] = imx_clk_divider("spdif0_podf", "spdif0_pred", MXC_CCM_CDCDR, 19, 6);
+	clk[spdif0_com_s] = imx_clk_mux_flags("spdif0_com_sel", MXC_CCM_CSCMR2, 4, 1,
+				spdif0_com_sel, ARRAY_SIZE(spdif0_com_sel), CLK_SET_RATE_PARENT);
+	clk[spdif0_gate] = imx_clk_gate2("spdif0_gate", "spdif0_com_sel", MXC_CCM_CCGR5, 26);
+	clk[spdif_ipg_gate] = imx_clk_gate2("spdif_ipg_gate", "ipg", MXC_CCM_CCGR5, 30);
 
 	for (i = 0; i < ARRAY_SIZE(clk); i++)
 		if (IS_ERR(clk[i]))
@@ -378,6 +393,15 @@ int __init mx51_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 	clk[mipi_hsc2_gate] = imx_clk_gate2("mipi_hsc2_gate", "ipg", MXC_CCM_CCGR4, 8);
 	clk[mipi_esc_gate] = imx_clk_gate2("mipi_esc_gate", "ipg", MXC_CCM_CCGR4, 10);
 	clk[mipi_hsp_gate] = imx_clk_gate2("mipi_hsp_gate", "ipg", MXC_CCM_CCGR4, 12);
+	clk[spdif_xtal_sel] = imx_clk_mux("spdif_xtal_sel", MXC_CCM_CSCMR1, 2, 2,
+				mx51_spdif_xtal_sel, ARRAY_SIZE(mx51_spdif_xtal_sel));
+	clk[spdif1_sel] = imx_clk_mux("spdif1_sel", MXC_CCM_CSCMR2, 2, 2,
+				spdif_sel, ARRAY_SIZE(spdif_sel));
+	clk[spdif1_pred] = imx_clk_divider("spdif1_podf", "spdif1_sel", MXC_CCM_CDCDR, 16, 3);
+	clk[spdif1_podf] = imx_clk_divider("spdif1_podf", "spdif1_pred", MXC_CCM_CDCDR, 9, 6);
+	clk[spdif1_com_sel] = imx_clk_mux("spdif1_com_sel", MXC_CCM_CSCMR2, 5, 1,
+				mx51_spdif1_com_sel, ARRAY_SIZE(mx51_spdif1_com_sel));
+	clk[spdif1_gate] = imx_clk_gate2("spdif1_gate", "spdif1_com_sel", MXC_CCM_CCGR5, 28);
 
 	for (i = 0; i < ARRAY_SIZE(clk); i++)
 		if (IS_ERR(clk[i]))
@@ -496,6 +520,8 @@ int __init mx53_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 				mx53_cko2_sel, ARRAY_SIZE(mx53_cko2_sel));
 	clk[cko2_podf] = imx_clk_divider("cko2_podf", "cko2_sel", MXC_CCM_CCOSR, 21, 3);
 	clk[cko2] = imx_clk_gate2("cko2", "cko2_podf", MXC_CCM_CCOSR, 24);
+	clk[spdif_xtal_sel] = imx_clk_mux("spdif_xtal_sel", MXC_CCM_CSCMR1, 2, 2,
+				mx53_spdif_xtal_sel, ARRAY_SIZE(mx53_spdif_xtal_sel));
 
 	for (i = 0; i < ARRAY_SIZE(clk); i++)
 		if (IS_ERR(clk[i]))
-- 
1.8.2.rc2
