From: housel@acm.org (Peter S. Housel)
Date: Tue, 20 Oct 2015 16:40:59 -0700
Subject: [PATCH 1/2] ARM: imx6sl: Add EIM clock to clock tree
In-Reply-To: <1445384460-34108-1-git-send-email-housel@acm.org>
References: <1445384460-34108-1-git-send-email-housel@acm.org>
Message-ID: <1445384460-34108-2-git-send-email-housel@acm.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing clock tree entries for the clock that drives the External
Interface Module (EIM) as implemented in the i.MX6sl.

Signed-off-by: Peter S. Housel <housel@acm.org>
---
 drivers/clk/imx/clk-imx6sl.c             | 6 +++++-
 include/dt-bindings/clock/imx6sl-clock.h | 5 ++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6sl.c b/drivers/clk/imx/clk-imx6sl.c
index 1be6230..497ade3 100644
--- a/drivers/clk/imx/clk-imx6sl.c
+++ b/drivers/clk/imx/clk-imx6sl.c
@@ -44,6 +44,7 @@ static const char *periph_sels[]	= { "pre_periph_sel", "periph_clk2_podf", };
 static const char *periph2_sels[]	= { "pre_periph2_sel", "periph2_clk2_podf", };
 static const char *csi_sels[]		= { "osc", "pll2_pfd2", "pll3_120m", "pll3_pfd1", };
 static const char *lcdif_axi_sels[]	= { "pll2_bus", "pll2_pfd2", "pll3_usb_otg", "pll3_pfd1", };
+static const char *eim_slow_sels[]      = { "ocram_podf", "pll3_usb_otg", "pll2_pfd2", "pll2_pfd0", };
 static const char *usdhc_sels[]		= { "pll2_pfd2", "pll2_pfd0", };
 static const char *ssi_sels[]		= { "pll3_pfd2", "pll3_pfd3", "pll4_audio_div", "dummy", };
 static const char *perclk_sels[]	= { "ipg", "osc", };
@@ -60,7 +61,7 @@ static const char *lvds_sels[]		= {
 	"pll1_sys", "pll2_bus", "pll2_pfd0", "pll2_pfd1", "pll2_pfd2", "dummy", "pll4_audio", "pll5_video",
 	"dummy", "enet_ref", "dummy", "dummy", "pll3_usb_otg", "pll7_usb_host", "pll3_pfd0", "pll3_pfd1",
 	"pll3_pfd2", "pll3_pfd3", "osc", "dummy", "dummy", "dummy", "dummy", "dummy",
-	 "dummy", "dummy", "dummy", "dummy", "dummy", "dummy", "dummy", "dummy",
+	 "dummy", "dummy", "dummy", "eim_slow_podf", "dummy", "dummy", "dummy", "dummy",
 };
 static const char *pll_bypass_src_sels[] = { "osc", "lvds1_in", };
 static const char *pll1_bypass_sels[]	= { "pll1", "pll1_bypass_src", };
@@ -305,6 +306,7 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SL_CLK_PERIPH_CLK2_SEL]  = imx_clk_mux("periph_clk2_sel",  base + 0x18, 12, 2, periph_clk2_sels,  ARRAY_SIZE(periph_clk2_sels));
 	clks[IMX6SL_CLK_CSI_SEL]          = imx_clk_mux("csi_sel",          base + 0x3c, 9,  2, csi_sels,          ARRAY_SIZE(csi_sels));
 	clks[IMX6SL_CLK_LCDIF_AXI_SEL]    = imx_clk_mux("lcdif_axi_sel",    base + 0x3c, 14, 2, lcdif_axi_sels,    ARRAY_SIZE(lcdif_axi_sels));
+	clks[IMX6SL_CLK_EIM_SLOW_SEL]     = imx_clk_fixup_mux("eim_slow_sel", base + 0x1c, 29, 2, eim_slow_sels,   ARRAY_SIZE(eim_slow_sels), imx_cscmr1_fixup);
 	clks[IMX6SL_CLK_USDHC1_SEL]       = imx_clk_fixup_mux("usdhc1_sel", base + 0x1c, 16, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels),  imx_cscmr1_fixup);
 	clks[IMX6SL_CLK_USDHC2_SEL]       = imx_clk_fixup_mux("usdhc2_sel", base + 0x1c, 17, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels),  imx_cscmr1_fixup);
 	clks[IMX6SL_CLK_USDHC3_SEL]       = imx_clk_fixup_mux("usdhc3_sel", base + 0x1c, 18, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels),  imx_cscmr1_fixup);
@@ -353,6 +355,7 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SL_CLK_GPU2D_PODF]        = imx_clk_divider("gpu2d_podf",        "gpu2d_sel",         base + 0x18, 29, 3);
 	clks[IMX6SL_CLK_LCDIF_PIX_PRED]    = imx_clk_divider("lcdif_pix_pred",    "lcdif_pix_sel",     base + 0x38, 3,  3);
 	clks[IMX6SL_CLK_EPDC_PIX_PRED]     = imx_clk_divider("epdc_pix_pred",     "epdc_pix_sel",      base + 0x38, 12, 3);
+	clks[IMX6SL_CLK_EIM_SLOW_PODF]     = imx_clk_fixup_divider("eim_slow_podf", "eim_slow_sel",    base + 0x1c, 23, 3, imx_cscmr1_fixup);
 	clks[IMX6SL_CLK_LCDIF_PIX_PODF]    = imx_clk_fixup_divider("lcdif_pix_podf", "lcdif_pix_pred", base + 0x1c, 20, 3, imx_cscmr1_fixup);
 	clks[IMX6SL_CLK_EPDC_PIX_PODF]     = imx_clk_divider("epdc_pix_podf",     "epdc_pix_pred",     base + 0x18, 23, 3);
 	clks[IMX6SL_CLK_SPDIF0_PRED]       = imx_clk_divider("spdif0_pred",       "spdif0_sel",        base + 0x30, 25, 3);
@@ -413,6 +416,7 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SL_CLK_USDHC2]       = imx_clk_gate2("usdhc2",       "usdhc2_podf",       base + 0x80, 4);
 	clks[IMX6SL_CLK_USDHC3]       = imx_clk_gate2("usdhc3",       "usdhc3_podf",       base + 0x80, 6);
 	clks[IMX6SL_CLK_USDHC4]       = imx_clk_gate2("usdhc4",       "usdhc4_podf",       base + 0x80, 8);
+	clks[IMX6SL_CLK_EIM_SLOW]     = imx_clk_gate2("eim_slow",     "eim_slow_podf",     base + 0x80, 10);
 
 	imx_check_clocks(clks, ARRAY_SIZE(clks));
 
diff --git a/include/dt-bindings/clock/imx6sl-clock.h b/include/dt-bindings/clock/imx6sl-clock.h
index e14573e..cf51a90 100644
--- a/include/dt-bindings/clock/imx6sl-clock.h
+++ b/include/dt-bindings/clock/imx6sl-clock.h
@@ -175,6 +175,9 @@
 #define IMX6SL_CLK_SSI2_IPG		162
 #define IMX6SL_CLK_SSI3_IPG		163
 #define IMX6SL_CLK_SPDIF_GCLK		164
-#define IMX6SL_CLK_END			165
+#define IMX6SL_CLK_EIM_SLOW_SEL		165
+#define IMX6SL_CLK_EIM_SLOW_PODF	166
+#define IMX6SL_CLK_EIM_SLOW		167
+#define IMX6SL_CLK_END			168
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6SL_H */
-- 
2.6.0
