From: Anson.Huang@nxp.com (Anson Huang)
Date: Sun, 18 Mar 2018 11:14:12 +0800
Subject: [PATCH 1/2] clk: imx6sx: add missing lvds2 clock to the clock tree
Message-ID: <1521342853-2941-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6SX has lvds2 (analog clock2), an I/O clock like lvds1.
And this lvds2, along with lvds1, can be used to provide
external clock source to the internal pll, such as pll4_audio
and pll5_video.

This patch mainly adds the lvds2 to the clock tree and fix its
relationship with pll accordingly.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 drivers/clk/imx/clk-imx6sx.c             | 6 +++++-
 include/dt-bindings/clock/imx6sx-clock.h | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index e6d389e..d180797 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -80,7 +80,7 @@ static const char *lvds_sels[]	= {
 	"arm", "pll1_sys", "dummy", "dummy", "dummy", "dummy", "dummy", "pll5_video_div",
 	"dummy", "dummy", "pcie_ref_125m", "dummy", "usbphy1", "usbphy2",
 };
-static const char *pll_bypass_src_sels[] = { "osc", "lvds1_in", };
+static const char *pll_bypass_src_sels[] = { "osc", "lvds1_in", "lvds2_in", "dummy", };
 static const char *pll1_bypass_sels[] = { "pll1", "pll1_bypass_src", };
 static const char *pll2_bypass_sels[] = { "pll2", "pll2_bypass_src", };
 static const char *pll3_bypass_sels[] = { "pll3", "pll3_bypass_src", };
@@ -160,6 +160,7 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 
 	/* Clock source from external clock via CLK1 PAD */
 	clks[IMX6SX_CLK_ANACLK1] = imx_obtain_fixed_clock("anaclk1", 0);
+	clks[IMX6SX_CLK_ANACLK2] = imx_obtain_fixed_clock("anaclk2", 0);
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx6sx-anatop");
 	base = of_iomap(np, 0);
@@ -228,7 +229,9 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SX_CLK_PCIE_REF_125M] = imx_clk_gate("pcie_ref_125m", "pcie_ref", base + 0xe0, 19);
 
 	clks[IMX6SX_CLK_LVDS1_OUT] = imx_clk_gate_exclusive("lvds1_out", "lvds1_sel", base + 0x160, 10, BIT(12));
+	clks[IMX6SX_CLK_LVDS2_OUT] = imx_clk_gate_exclusive("lvds2_out", "lvds2_sel", base + 0x160, 11, BIT(13));
 	clks[IMX6SX_CLK_LVDS1_IN]  = imx_clk_gate_exclusive("lvds1_in",  "anaclk1",   base + 0x160, 12, BIT(10));
+	clks[IMX6SX_CLK_LVDS2_IN]  = imx_clk_gate_exclusive("lvds2_in",  "anaclk2",   base + 0x160, 13, BIT(11));
 
 	clks[IMX6SX_CLK_ENET_REF] = clk_register_divider_table(NULL, "enet_ref", "pll6_enet", 0,
 			base + 0xe0, 0, 2, 0, clk_enet_ref_table,
@@ -270,6 +273,7 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 
 	/*                                                name                reg           shift   width   parent_names       num_parents */
 	clks[IMX6SX_CLK_LVDS1_SEL]          = imx_clk_mux("lvds1_sel",        base + 0x160, 0,      5,      lvds_sels,         ARRAY_SIZE(lvds_sels));
+	clks[IMX6SX_CLK_LVDS2_SEL]          = imx_clk_mux("lvds2_sel",        base + 0x160, 5,      5,      lvds_sels,         ARRAY_SIZE(lvds_sels));
 
 	np = ccm_node;
 	base = of_iomap(np, 0);
diff --git a/include/dt-bindings/clock/imx6sx-clock.h b/include/dt-bindings/clock/imx6sx-clock.h
index 36f0324..cd2d6c5 100644
--- a/include/dt-bindings/clock/imx6sx-clock.h
+++ b/include/dt-bindings/clock/imx6sx-clock.h
@@ -275,6 +275,10 @@
 #define IMX6SX_PLL6_BYPASS		262
 #define IMX6SX_PLL7_BYPASS		263
 #define IMX6SX_CLK_SPDIF_GCLK		264
-#define IMX6SX_CLK_CLK_END		265
+#define IMX6SX_CLK_LVDS2_SEL		265
+#define IMX6SX_CLK_LVDS2_OUT		266
+#define IMX6SX_CLK_LVDS2_IN		267
+#define IMX6SX_CLK_ANACLK2		268
+#define IMX6SX_CLK_CLK_END		269
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6SX_H */
-- 
2.7.4
