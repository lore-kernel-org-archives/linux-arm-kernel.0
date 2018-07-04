From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  4 Jul 2018 10:49:23 -0300
Subject: [PATCH] clk: imx51-imx53: Annotate critical clocks as CLK_IS_CRITICAL
Message-ID: <1530712163-16130-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Instead of explicitly enabling critical clocks via clk_prepare_enable(),
let's use the standard CLK_IS_CRITICAL flag instead, which makes the code
a bit shorter.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/clk/imx/clk-imx51-imx53.c | 43 +++++++++++++--------------------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/drivers/clk/imx/clk-imx51-imx53.c b/drivers/clk/imx/clk-imx51-imx53.c
index caa8bd4..346a53b 100644
--- a/drivers/clk/imx/clk-imx51-imx53.c
+++ b/drivers/clk/imx/clk-imx51-imx53.c
@@ -175,13 +175,13 @@ static void __init mx5_clocks_common_init(void __iomem *ccm_base)
 	clk[IMX5_CLK_PER_ROOT]		= imx_clk_mux("per_root", MXC_CCM_CBCMR, 0, 1,
 						per_root_sel, ARRAY_SIZE(per_root_sel));
 	clk[IMX5_CLK_AHB]		= imx_clk_divider("ahb", "main_bus", MXC_CCM_CBCDR, 10, 3);
-	clk[IMX5_CLK_AHB_MAX]		= imx_clk_gate2("ahb_max", "ahb", MXC_CCM_CCGR0, 28);
-	clk[IMX5_CLK_AIPS_TZ1]		= imx_clk_gate2("aips_tz1", "ahb", MXC_CCM_CCGR0, 24);
-	clk[IMX5_CLK_AIPS_TZ2]		= imx_clk_gate2("aips_tz2", "ahb", MXC_CCM_CCGR0, 26);
-	clk[IMX5_CLK_TMAX1]		= imx_clk_gate2("tmax1", "ahb", MXC_CCM_CCGR1, 0);
-	clk[IMX5_CLK_TMAX2]		= imx_clk_gate2("tmax2", "ahb", MXC_CCM_CCGR1, 2);
-	clk[IMX5_CLK_TMAX3]		= imx_clk_gate2("tmax3", "ahb", MXC_CCM_CCGR1, 4);
-	clk[IMX5_CLK_SPBA]		= imx_clk_gate2("spba", "ipg", MXC_CCM_CCGR5, 0);
+	clk[IMX5_CLK_AHB_MAX]		= imx_clk_gate2_flags("ahb_max", "ahb", MXC_CCM_CCGR0, 28, CLK_IS_CRITICAL);
+	clk[IMX5_CLK_AIPS_TZ1]		= imx_clk_gate2_flags("aips_tz1", "ahb", MXC_CCM_CCGR0, 24, CLK_IS_CRITICAL);
+	clk[IMX5_CLK_AIPS_TZ2]		= imx_clk_gate2_flags("aips_tz2", "ahb", MXC_CCM_CCGR0, 26, CLK_IS_CRITICAL);
+	clk[IMX5_CLK_TMAX1]		= imx_clk_gate2_flags("tmax1", "ahb", MXC_CCM_CCGR1, 0, CLK_IS_CRITICAL);
+	clk[IMX5_CLK_TMAX2]		= imx_clk_gate2_flags("tmax2", "ahb", MXC_CCM_CCGR1, 2, CLK_IS_CRITICAL);
+	clk[IMX5_CLK_TMAX3]		= imx_clk_gate2_flags("tmax3", "ahb", MXC_CCM_CCGR1, 4, CLK_IS_CRITICAL);
+	clk[IMX5_CLK_SPBA]		= imx_clk_gate2_flags("spba", "ipg", MXC_CCM_CCGR5, 0, CLK_IS_CRITICAL);
 	clk[IMX5_CLK_IPG]		= imx_clk_divider("ipg", "ahb", MXC_CCM_CBCDR, 8, 2);
 	clk[IMX5_CLK_AXI_A]		= imx_clk_divider("axi_a", "main_bus", MXC_CCM_CBCDR, 16, 3);
 	clk[IMX5_CLK_AXI_B]		= imx_clk_divider("axi_b", "main_bus", MXC_CCM_CBCDR, 19, 3);
@@ -252,8 +252,8 @@ static void __init mx5_clocks_common_init(void __iomem *ccm_base)
 	clk[IMX5_CLK_ECSPI2_PER_GATE]	= imx_clk_gate2("ecspi2_per_gate", "ecspi_podf", MXC_CCM_CCGR4, 24);
 	clk[IMX5_CLK_CSPI_IPG_GATE]	= imx_clk_gate2("cspi_ipg_gate", "ipg", MXC_CCM_CCGR4, 26);
 	clk[IMX5_CLK_SDMA_GATE]		= imx_clk_gate2("sdma_gate", "ipg", MXC_CCM_CCGR4, 30);
-	clk[IMX5_CLK_EMI_FAST_GATE]	= imx_clk_gate2("emi_fast_gate", "dummy", MXC_CCM_CCGR5, 14);
-	clk[IMX5_CLK_EMI_SLOW_GATE]	= imx_clk_gate2("emi_slow_gate", "emi_slow_podf", MXC_CCM_CCGR5, 16);
+	clk[IMX5_CLK_EMI_FAST_GATE]	= imx_clk_gate2_flags("emi_fast_gate", "dummy", MXC_CCM_CCGR5, 14, CLK_IS_CRITICAL);
+	clk[IMX5_CLK_EMI_SLOW_GATE]	= imx_clk_gate2_flags("emi_slow_gate", "emi_slow_podf", MXC_CCM_CCGR5, 16, CLK_IS_CRITICAL);
 	clk[IMX5_CLK_IPU_SEL]		= imx_clk_mux("ipu_sel", MXC_CCM_CBCMR, 6, 2, ipu_sel, ARRAY_SIZE(ipu_sel));
 	clk[IMX5_CLK_IPU_GATE]		= imx_clk_gate2("ipu_gate", "ipu_sel", MXC_CCM_CCGR5, 10);
 	clk[IMX5_CLK_NFC_GATE]		= imx_clk_gate2("nfc_gate", "nfc_podf", MXC_CCM_CCGR5, 20);
@@ -267,7 +267,7 @@ static void __init mx5_clocks_common_init(void __iomem *ccm_base)
 	clk[IMX5_CLK_VPU_SEL]		= imx_clk_mux("vpu_sel", MXC_CCM_CBCMR, 14, 2, vpu_sel, ARRAY_SIZE(vpu_sel));
 	clk[IMX5_CLK_VPU_GATE]		= imx_clk_gate2("vpu_gate", "vpu_sel", MXC_CCM_CCGR5, 6);
 	clk[IMX5_CLK_VPU_REFERENCE_GATE] = imx_clk_gate2("vpu_reference_gate", "osc", MXC_CCM_CCGR5, 8);
-	clk[IMX5_CLK_GPC_DVFS]		= imx_clk_gate2("gpc_dvfs", "dummy", MXC_CCM_CCGR5, 24);
+	clk[IMX5_CLK_GPC_DVFS]		= imx_clk_gate2_flags("gpc_dvfs", "dummy", MXC_CCM_CCGR5, 24, CLK_IS_CRITICAL);
 
 	clk[IMX5_CLK_SSI_APM]		= imx_clk_mux("ssi_apm", MXC_CCM_CSCMR1, 8, 2, ssi_apm_sels, ARRAY_SIZE(ssi_apm_sels));
 	clk[IMX5_CLK_SSI1_ROOT_SEL]	= imx_clk_mux("ssi1_root_sel", MXC_CCM_CSCMR1, 14, 2, ssi_clk_sels, ARRAY_SIZE(ssi_clk_sels));
@@ -316,21 +316,6 @@ static void __init mx5_clocks_common_init(void __iomem *ccm_base)
 
 	/* move usb phy clk to 24MHz */
 	clk_set_parent(clk[IMX5_CLK_USB_PHY_SEL], clk[IMX5_CLK_OSC]);
-
-	clk_prepare_enable(clk[IMX5_CLK_GPC_DVFS]);
-	clk_prepare_enable(clk[IMX5_CLK_AHB_MAX]); /* esdhc3 */
-	clk_prepare_enable(clk[IMX5_CLK_AIPS_TZ1]);
-	clk_prepare_enable(clk[IMX5_CLK_AIPS_TZ2]); /* fec */
-	clk_prepare_enable(clk[IMX5_CLK_SPBA]);
-	clk_prepare_enable(clk[IMX5_CLK_EMI_FAST_GATE]); /* fec */
-	clk_prepare_enable(clk[IMX5_CLK_EMI_SLOW_GATE]); /* eim */
-	clk_prepare_enable(clk[IMX5_CLK_MIPI_HSC1_GATE]);
-	clk_prepare_enable(clk[IMX5_CLK_MIPI_HSC2_GATE]);
-	clk_prepare_enable(clk[IMX5_CLK_MIPI_ESC_GATE]);
-	clk_prepare_enable(clk[IMX5_CLK_MIPI_HSP_GATE]);
-	clk_prepare_enable(clk[IMX5_CLK_TMAX1]);
-	clk_prepare_enable(clk[IMX5_CLK_TMAX2]); /* esdhc2, fec */
-	clk_prepare_enable(clk[IMX5_CLK_TMAX3]); /* esdhc1, esdhc4 */
 }
 
 static void __init mx50_clocks_init(struct device_node *np)
@@ -442,10 +427,10 @@ static void __init mx51_clocks_init(struct device_node *np)
 	clk[IMX5_CLK_ESDHC4_PER_GATE]	= imx_clk_gate2("esdhc4_per_gate", "esdhc_d_sel", MXC_CCM_CCGR3, 14);
 	clk[IMX5_CLK_USB_PHY_GATE]	= imx_clk_gate2("usb_phy_gate", "usb_phy_sel", MXC_CCM_CCGR2, 0);
 	clk[IMX5_CLK_HSI2C_GATE]	= imx_clk_gate2("hsi2c_gate", "ipg", MXC_CCM_CCGR1, 22);
-	clk[IMX5_CLK_MIPI_HSC1_GATE]	= imx_clk_gate2("mipi_hsc1_gate", "ipg", MXC_CCM_CCGR4, 6);
-	clk[IMX5_CLK_MIPI_HSC2_GATE]	= imx_clk_gate2("mipi_hsc2_gate", "ipg", MXC_CCM_CCGR4, 8);
-	clk[IMX5_CLK_MIPI_ESC_GATE]	= imx_clk_gate2("mipi_esc_gate", "ipg", MXC_CCM_CCGR4, 10);
-	clk[IMX5_CLK_MIPI_HSP_GATE]	= imx_clk_gate2("mipi_hsp_gate", "ipg", MXC_CCM_CCGR4, 12);
+	clk[IMX5_CLK_MIPI_HSC1_GATE]	= imx_clk_gate2_flags("mipi_hsc1_gate", "ipg", MXC_CCM_CCGR4, 6, CLK_IS_CRITICAL);
+	clk[IMX5_CLK_MIPI_HSC2_GATE]	= imx_clk_gate2_flags("mipi_hsc2_gate", "ipg", MXC_CCM_CCGR4, 8, CLK_IS_CRITICAL);
+	clk[IMX5_CLK_MIPI_ESC_GATE]	= imx_clk_gate2_flags("mipi_esc_gate", "ipg", MXC_CCM_CCGR4, 10, CLK_IS_CRITICAL);
+	clk[IMX5_CLK_MIPI_HSP_GATE]	= imx_clk_gate2_flags("mipi_hsp_gate", "ipg", MXC_CCM_CCGR4, 12, CLK_IS_CRITICAL);
 	clk[IMX5_CLK_SPDIF_XTAL_SEL]	= imx_clk_mux("spdif_xtal_sel", MXC_CCM_CSCMR1, 2, 2,
 						mx51_spdif_xtal_sel, ARRAY_SIZE(mx51_spdif_xtal_sel));
 	clk[IMX5_CLK_SPDIF1_SEL]	= imx_clk_mux("spdif1_sel", MXC_CCM_CSCMR2, 2, 2,
-- 
2.7.4
