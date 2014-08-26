From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 26 Aug 2014 23:35:12 +0800
Subject: [RFC PATCH 1/2] ARM: imx: add BYPASS support for PLL clocks
In-Reply-To: <1409067313-32063-1-git-send-email-shawn.guo@freescale.com>
References: <1409067313-32063-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1409067313-32063-2-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX6 clock drivers currently hard-code all PLL clocks sourcing from
OSC24M without BYPASS support.  The patch adds BYPASS and BYPASS_CLK_SRC
selection for PLL clocks as per Figure 10-3. Primary Clock Generation
in IMX6DQRM, i.e. both BYPASS_CLK_SRC and BYPASS bits are implemented as
mux clocks, and ENABLE bit of PLL clocks is implemented as a gate clock
after BYPASS mux.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-imx/clk-imx6q.c             | 57 ++++++++++++++++++++++++++-----
 include/dt-bindings/clock/imx6qdl-clock.h | 23 ++++++++++++-
 2 files changed, 71 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index e6c60188ec14..c1199a26c24e 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -73,6 +73,14 @@ static const char *lvds_sels[] = {
 	"pll4_audio", "pll5_video", "pll8_mlb", "enet_ref",
 	"pcie_ref_125m", "sata_ref_100m",
 };
+static const char *pll_bypass_src_sels[] = { "osc", "anaclk1", "anaclk2", "dummy", };
+static const char *pll1_bypass_sels[] = { "pll1", "pll1_bypass_src", };
+static const char *pll2_bypass_sels[] = { "pll2", "pll2_bypass_src", };
+static const char *pll3_bypass_sels[] = { "pll3", "pll3_bypass_src", };
+static const char *pll4_bypass_sels[] = { "pll4", "pll4_bypass_src", };
+static const char *pll5_bypass_sels[] = { "pll5", "pll5_bypass_src", };
+static const char *pll6_bypass_sels[] = { "pll6", "pll6_bypass_src", };
+static const char *pll7_bypass_sels[] = { "pll7", "pll7_bypass_src", };
 
 static struct clk *clk[IMX6QDL_CLK_END];
 static struct clk_onecell_data clk_data;
@@ -135,14 +143,47 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 		video_div_table[2].div = 1;
 	};
 
-	/*                                             type             name         parent_name  base     div_mask */
-	clk[IMX6QDL_CLK_PLL1_SYS]      = imx_clk_pllv3(IMX_PLLV3_SYS,	"pll1_sys",	"osc", base,        0x7f);
-	clk[IMX6QDL_CLK_PLL2_BUS]      = imx_clk_pllv3(IMX_PLLV3_GENERIC,	"pll2_bus",	"osc", base + 0x30, 0x1);
-	clk[IMX6QDL_CLK_PLL3_USB_OTG]  = imx_clk_pllv3(IMX_PLLV3_USB,	"pll3_usb_otg",	"osc", base + 0x10, 0x3);
-	clk[IMX6QDL_CLK_PLL4_AUDIO]    = imx_clk_pllv3(IMX_PLLV3_AV,	"pll4_audio",	"osc", base + 0x70, 0x7f);
-	clk[IMX6QDL_CLK_PLL5_VIDEO]    = imx_clk_pllv3(IMX_PLLV3_AV,	"pll5_video",	"osc", base + 0xa0, 0x7f);
-	clk[IMX6QDL_CLK_PLL6_ENET]     = imx_clk_pllv3(IMX_PLLV3_ENET,	"pll6_enet",	"osc", base + 0xe0, 0x3);
-	clk[IMX6QDL_CLK_PLL7_USB_HOST] = imx_clk_pllv3(IMX_PLLV3_USB,	"pll7_usb_host","osc", base + 0x20, 0x3);
+	clk[IMX6QDL_PLL1_BYPASS_SRC] = imx_clk_mux("pll1_bypass_src", base + 0x00, 14, 2, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	clk[IMX6QDL_PLL2_BYPASS_SRC] = imx_clk_mux("pll2_bypass_src", base + 0x30, 14, 2, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	clk[IMX6QDL_PLL3_BYPASS_SRC] = imx_clk_mux("pll3_bypass_src", base + 0x10, 14, 2, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	clk[IMX6QDL_PLL4_BYPASS_SRC] = imx_clk_mux("pll4_bypass_src", base + 0x70, 14, 2, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	clk[IMX6QDL_PLL5_BYPASS_SRC] = imx_clk_mux("pll5_bypass_src", base + 0xa0, 14, 2, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	clk[IMX6QDL_PLL6_BYPASS_SRC] = imx_clk_mux("pll6_bypass_src", base + 0xe0, 14, 2, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	clk[IMX6QDL_PLL7_BYPASS_SRC] = imx_clk_mux("pll7_bypass_src", base + 0x20, 14, 2, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+
+	/*                                    type               name    parent_name        base         div_mask */
+	clk[IMX6QDL_CLK_PLL1] = imx_clk_pllv3(IMX_PLLV3_SYS,     "pll1", "pll1_bypass_src", base + 0x00, 0x7f);
+	clk[IMX6QDL_CLK_PLL2] = imx_clk_pllv3(IMX_PLLV3_GENERIC, "pll2", "pll2_bypass_src", base + 0x30, 0x1);
+	clk[IMX6QDL_CLK_PLL3] = imx_clk_pllv3(IMX_PLLV3_USB,     "pll3", "pll3_bypass_src", base + 0x10, 0x3);
+	clk[IMX6QDL_CLK_PLL4] = imx_clk_pllv3(IMX_PLLV3_AV,      "pll4", "pll4_bypass_src", base + 0x70, 0x7f);
+	clk[IMX6QDL_CLK_PLL5] = imx_clk_pllv3(IMX_PLLV3_AV,      "pll5", "pll5_bypass_src", base + 0xa0, 0x7f);
+	clk[IMX6QDL_CLK_PLL6] = imx_clk_pllv3(IMX_PLLV3_ENET,    "pll6", "pll6_bypass_src", base + 0xe0, 0x3);
+	clk[IMX6QDL_CLK_PLL7] = imx_clk_pllv3(IMX_PLLV3_USB,     "pll7", "pll7_bypass_src", base + 0x20, 0x3);
+
+	clk[IMX6QDL_PLL1_BYPASS] = imx_clk_mux("pll1_bypass", base + 0x00, 16, 1, pll1_bypass_sels, ARRAY_SIZE(pll1_bypass_sels));
+	clk[IMX6QDL_PLL2_BYPASS] = imx_clk_mux("pll2_bypass", base + 0x30, 16, 1, pll2_bypass_sels, ARRAY_SIZE(pll2_bypass_sels));
+	clk[IMX6QDL_PLL3_BYPASS] = imx_clk_mux("pll3_bypass", base + 0x10, 16, 1, pll3_bypass_sels, ARRAY_SIZE(pll3_bypass_sels));
+	clk[IMX6QDL_PLL4_BYPASS] = imx_clk_mux("pll4_bypass", base + 0x70, 16, 1, pll4_bypass_sels, ARRAY_SIZE(pll4_bypass_sels));
+	clk[IMX6QDL_PLL5_BYPASS] = imx_clk_mux("pll5_bypass", base + 0xa0, 16, 1, pll5_bypass_sels, ARRAY_SIZE(pll5_bypass_sels));
+	clk[IMX6QDL_PLL6_BYPASS] = imx_clk_mux("pll6_bypass", base + 0xe0, 16, 1, pll6_bypass_sels, ARRAY_SIZE(pll6_bypass_sels));
+	clk[IMX6QDL_PLL7_BYPASS] = imx_clk_mux("pll7_bypass", base + 0x20, 16, 1, pll7_bypass_sels, ARRAY_SIZE(pll7_bypass_sels));
+
+	/* Do not bypass PLLs initially */
+	clk_set_parent(clk[IMX6QDL_PLL1_BYPASS], clk[IMX6QDL_CLK_PLL1]);
+	clk_set_parent(clk[IMX6QDL_PLL2_BYPASS], clk[IMX6QDL_CLK_PLL2]);
+	clk_set_parent(clk[IMX6QDL_PLL3_BYPASS], clk[IMX6QDL_CLK_PLL3]);
+	clk_set_parent(clk[IMX6QDL_PLL4_BYPASS], clk[IMX6QDL_CLK_PLL4]);
+	clk_set_parent(clk[IMX6QDL_PLL5_BYPASS], clk[IMX6QDL_CLK_PLL5]);
+	clk_set_parent(clk[IMX6QDL_PLL6_BYPASS], clk[IMX6QDL_CLK_PLL6]);
+	clk_set_parent(clk[IMX6QDL_PLL7_BYPASS], clk[IMX6QDL_CLK_PLL7]);
+
+	clk[IMX6QDL_CLK_PLL1_SYS]      = imx_clk_gate("pll1_sys",      "pll1_bypass", base + 0x00, 13);
+	clk[IMX6QDL_CLK_PLL2_BUS]      = imx_clk_gate("pll2_bus",      "pll2_bypass", base + 0x30, 13);
+	clk[IMX6QDL_CLK_PLL3_USB_OTG]  = imx_clk_gate("pll3_usb_otg",  "pll3_bypass", base + 0x10, 13);
+	clk[IMX6QDL_CLK_PLL4_AUDIO]    = imx_clk_gate("pll4_audio",    "pll4_bypass", base + 0x70, 13);
+	clk[IMX6QDL_CLK_PLL5_VIDEO]    = imx_clk_gate("pll5_video",    "pll5_bypass", base + 0xa0, 13);
+	clk[IMX6QDL_CLK_PLL6_ENET]     = imx_clk_gate("pll6_enet",     "pll6_bypass", base + 0xe0, 13);
+	clk[IMX6QDL_CLK_PLL7_USB_HOST] = imx_clk_gate("pll7_usb_host", "pll7_bypass", base + 0xe0, 13);
 
 	/*
 	 * Bit 20 is the reserved and read-only bit, we do this only for:
diff --git a/include/dt-bindings/clock/imx6qdl-clock.h b/include/dt-bindings/clock/imx6qdl-clock.h
index e992ce5e05a5..361afd09c2b7 100644
--- a/include/dt-bindings/clock/imx6qdl-clock.h
+++ b/include/dt-bindings/clock/imx6qdl-clock.h
@@ -224,6 +224,27 @@
 #define IMX6QDL_CLK_LVDS2_IN			211
 #define IMX6QDL_CLK_ANACLK1			212
 #define IMX6QDL_CLK_ANACLK2			213
-#define IMX6QDL_CLK_END				214
+#define IMX6QDL_PLL1_BYPASS_SRC			214
+#define IMX6QDL_PLL2_BYPASS_SRC			215
+#define IMX6QDL_PLL3_BYPASS_SRC			216
+#define IMX6QDL_PLL4_BYPASS_SRC			217
+#define IMX6QDL_PLL5_BYPASS_SRC			218
+#define IMX6QDL_PLL6_BYPASS_SRC			219
+#define IMX6QDL_PLL7_BYPASS_SRC			220
+#define IMX6QDL_CLK_PLL1			221
+#define IMX6QDL_CLK_PLL2			222
+#define IMX6QDL_CLK_PLL3			223
+#define IMX6QDL_CLK_PLL4			224
+#define IMX6QDL_CLK_PLL5			225
+#define IMX6QDL_CLK_PLL6			226
+#define IMX6QDL_CLK_PLL7			227
+#define IMX6QDL_PLL1_BYPASS			228
+#define IMX6QDL_PLL2_BYPASS			229
+#define IMX6QDL_PLL3_BYPASS			230
+#define IMX6QDL_PLL4_BYPASS			231
+#define IMX6QDL_PLL5_BYPASS			232
+#define IMX6QDL_PLL6_BYPASS			233
+#define IMX6QDL_PLL7_BYPASS			234
+#define IMX6QDL_CLK_END				235
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6QDL_H */
-- 
1.9.1
