From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 26 May 2014 12:15:05 +0200
Subject: [PATCH 1/4] clk: imx5: add step and cpu_podf mux
Message-ID: <1401099308-9658-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Those two muxes are used when reprogramming PLL1 for
an ARM clock change.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx51-imx53.c    | 6 ++++++
 include/dt-bindings/clock/imx5-clock.h | 4 +++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 568ef0a4de84..a983b4381331 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -82,6 +82,8 @@ static const char *mx53_spdif_xtal_sel[] = { "osc", "ckih", "ckih2", "pll4_sw",
 static const char *spdif_sel[] = { "pll1_sw", "pll2_sw", "pll3_sw", "spdif_xtal_sel", };
 static const char *spdif0_com_sel[] = { "spdif0_podf", "ssi1_root_gate", };
 static const char *mx51_spdif1_com_sel[] = { "spdif1_podf", "ssi2_root_gate", };
+static const char *step_sels[] = { "lp_apm", };
+static const char *cpu_podf_sels[] = { "pll1_sw", "step_sel" };
 
 static struct clk *clk[IMX5_CLK_END];
 static struct clk_onecell_data clk_data;
@@ -152,6 +154,10 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
 	clk[IMX5_CLK_USB_PHY_PODF]	= imx_clk_divider("usb_phy_podf", "usb_phy_pred", MXC_CCM_CDCDR, 0, 3);
 	clk[IMX5_CLK_USB_PHY_SEL]	= imx_clk_mux("usb_phy_sel", MXC_CCM_CSCMR1, 26, 1,
 						usb_phy_sel_str, ARRAY_SIZE(usb_phy_sel_str));
+	clk[IMX5_CLK_STEP_SEL]		= imx_clk_mux("step_sel", MXC_CCM_CCSR, 7, 2,
+						step_sels, ARRAY_SIZE(step_sels));
+	clk[IMX5_CLK_CPU_PODF_SEL]	= imx_clk_mux("cpu_podf_sel", MXC_CCM_CCSR, 2, 1,
+						cpu_podf_sels, ARRAY_SIZE(cpu_podf_sels));
 	clk[IMX5_CLK_CPU_PODF]		= imx_clk_divider("cpu_podf", "pll1_sw", MXC_CCM_CACRR, 0, 3);
 	clk[IMX5_CLK_DI_PRED]		= imx_clk_divider("di_pred", "pll3_sw", MXC_CCM_CDCDR, 6, 3);
 	clk[IMX5_CLK_IIM_GATE]		= imx_clk_gate2("iim_gate", "ipg", MXC_CCM_CCGR0, 30);
diff --git a/include/dt-bindings/clock/imx5-clock.h b/include/dt-bindings/clock/imx5-clock.h
index 5f2667ecd98e..1a36ff4ace1e 100644
--- a/include/dt-bindings/clock/imx5-clock.h
+++ b/include/dt-bindings/clock/imx5-clock.h
@@ -198,6 +198,8 @@
 #define IMX5_CLK_OCRAM			186
 #define IMX5_CLK_SAHARA_IPG_GATE	187
 #define IMX5_CLK_SATA_REF		188
-#define IMX5_CLK_END			189
+#define IMX5_CLK_STEP_SEL		189
+#define IMX5_CLK_CPU_PODF_SEL		190
+#define IMX5_CLK_END			191
 
 #endif /* __DT_BINDINGS_CLOCK_IMX5_H */
-- 
2.0.0.rc2
