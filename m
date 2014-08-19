From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 19 Aug 2014 15:21:11 -0300
Subject: [PATCH 1/4] ARM: clk-imx6sl: Remove csi_lcdif_sels[]
Message-ID: <1408472474-4914-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently csi_lcdif_sels[] is a shared array for the providing the possible 
clock parents for csi and lcdif blocks.

This is not correct, as csi and lcdif do not share the same clock parents.

Introduce csi_sels[] for the csi and lcdif_axi_sels[] for the lcdif clocks in
order to describe the parents correctly.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/clk-imx6sl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6sl.c b/arch/arm/mach-imx/clk-imx6sl.c
index fef46fa..ba3af22 100644
--- a/arch/arm/mach-imx/clk-imx6sl.c
+++ b/arch/arm/mach-imx/clk-imx6sl.c
@@ -43,7 +43,8 @@ static const char *periph_clk2_sels[]	= { "pll3_usb_otg", "osc", "osc", "dummy",
 static const char *periph2_clk2_sels[]	= { "pll3_usb_otg", "pll2_bus", };
 static const char *periph_sels[]	= { "pre_periph_sel", "periph_clk2_podf", };
 static const char *periph2_sels[]	= { "pre_periph2_sel", "periph2_clk2_podf", };
-static const char *csi_lcdif_sels[]	= { "mmdc", "pll2_pfd2", "pll3_120m", "pll3_pfd1", };
+static const char *csi_sels[]		= { "osc", "pll2_pfd2", "pll3_120m", "pll3_pfd1", };
+static const char *lcdif_axi_sels[]	= { "pll2_bus", "pll2_pfd2", "pll3_usb_otg", "pll3_pfd1", };
 static const char *usdhc_sels[]		= { "pll2_pfd2", "pll2_pfd0", };
 static const char *ssi_sels[]		= { "pll3_pfd2", "pll3_pfd3", "pll4_audio_div", "dummy", };
 static const char *perclk_sels[]	= { "ipg", "osc", };
@@ -241,8 +242,8 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SL_CLK_PRE_PERIPH_SEL]   = imx_clk_mux("pre_periph_sel",   base + 0x18, 18, 2, pre_periph_sels,   ARRAY_SIZE(pre_periph_sels));
 	clks[IMX6SL_CLK_PERIPH2_CLK2_SEL] = imx_clk_mux("periph2_clk2_sel", base + 0x18, 20, 1, periph2_clk2_sels, ARRAY_SIZE(periph2_clk2_sels));
 	clks[IMX6SL_CLK_PERIPH_CLK2_SEL]  = imx_clk_mux("periph_clk2_sel",  base + 0x18, 12, 2, periph_clk2_sels,  ARRAY_SIZE(periph_clk2_sels));
-	clks[IMX6SL_CLK_CSI_SEL]          = imx_clk_mux("csi_sel",          base + 0x3c, 9,  2, csi_lcdif_sels,    ARRAY_SIZE(csi_lcdif_sels));
-	clks[IMX6SL_CLK_LCDIF_AXI_SEL]    = imx_clk_mux("lcdif_axi_sel",    base + 0x3c, 14, 2, csi_lcdif_sels,    ARRAY_SIZE(csi_lcdif_sels));
+	clks[IMX6SL_CLK_CSI_SEL]          = imx_clk_mux("csi_sel",          base + 0x3c, 9,  2, csi_sels,          ARRAY_SIZE(csi_sels));
+	clks[IMX6SL_CLK_LCDIF_AXI_SEL]    = imx_clk_mux("lcdif_axi_sel",    base + 0x3c, 14, 2, lcdif_axi_sels,    ARRAY_SIZE(lcdif_axi_sels));
 	clks[IMX6SL_CLK_USDHC1_SEL]       = imx_clk_fixup_mux("usdhc1_sel", base + 0x1c, 16, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels),  imx_cscmr1_fixup);
 	clks[IMX6SL_CLK_USDHC2_SEL]       = imx_clk_fixup_mux("usdhc2_sel", base + 0x1c, 17, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels),  imx_cscmr1_fixup);
 	clks[IMX6SL_CLK_USDHC3_SEL]       = imx_clk_fixup_mux("usdhc3_sel", base + 0x1c, 18, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels),  imx_cscmr1_fixup);
-- 
1.9.1
