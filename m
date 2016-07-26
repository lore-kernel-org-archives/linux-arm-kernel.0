From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Jul 2016 22:30:31 +0200
Subject: [PATCH 03/13] clk: sunxi-ng: sun8i: Rename DDR and video plls
In-Reply-To: <20160726203041.29366-1-maxime.ripard@free-electrons.com>
References: <20160726203041.29366-1-maxime.ripard@free-electrons.com>
Message-ID: <20160726203041.29366-4-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to deal with the A64 that will have several video and ddr plls,
rename the first ones to add an index.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
index 9af359544110..68492808e5fc 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
@@ -57,8 +57,8 @@ static SUNXI_CCU_NM_WITH_GATE_LOCK(pll_audio_base_clk, "pll-audio-base",
 				   BIT(28),	/* lock */
 				   0);
 
-static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_video_clk, "pll-video",
-					"osc24M", 0x0010,
+static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_video0_clk, "pll-video0",
+					"osc24M", 0x010,
 					8, 7,		/* N */
 					0, 4,		/* M */
 					BIT(24),	/* frac enable */
@@ -81,7 +81,7 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_ve_clk, "pll-ve",
 					BIT(28),	/* lock */
 					0);
 
-static SUNXI_CCU_NKM_WITH_GATE_LOCK(pll_ddr_clk, "pll-ddr",
+static SUNXI_CCU_NKM_WITH_GATE_LOCK(pll_ddr0_clk, "pll-ddr0",
 				    "osc24M", 0x020,
 				    8, 5,	/* N */
 				    4, 2,	/* K */
@@ -422,7 +422,7 @@ static SUNXI_CCU_GATE(usb_ohci2_clk,	"usb-ohci2",	"osc24M",
 static SUNXI_CCU_GATE(usb_ohci3_clk,	"usb-ohci3",	"osc24M",
 		      0x0cc, BIT(19), 0);
 
-static const char * const dram_parents[] = { "pll-ddr", "pll-periph0-2x" };
+static const char * const dram_parents[] = { "pll-ddr0", "pll-periph0-2x" };
 static SUNXI_CCU_M_WITH_MUX(dram_clk, "dram", dram_parents,
 			    0x0f4, 0, 4, 20, 2, CLK_IS_CRITICAL);
 
@@ -439,7 +439,7 @@ static const char * const de_parents[] = { "pll-periph0-2x", "pll-de" };
 static SUNXI_CCU_M_WITH_MUX_GATE(de_clk, "de", de_parents,
 				 0x104, 0, 4, 24, 3, BIT(31), 0);
 
-static const char * const tcon_parents[] = { "pll-video" };
+static const char * const tcon_parents[] = { "pll-video0" };
 static SUNXI_CCU_M_WITH_MUX_GATE(tcon_clk, "tcon", tcon_parents,
 				 0x118, 0, 4, 24, 3, BIT(31), 0);
 
@@ -458,7 +458,7 @@ static const char * const csi_sclk_parents[] = { "pll-periph0", "pll-periph1" };
 static SUNXI_CCU_M_WITH_MUX_GATE(csi_sclk_clk, "csi-sclk", csi_sclk_parents,
 				 0x134, 16, 4, 24, 3, BIT(31), 0);
 
-static const char * const csi_mclk_parents[] = { "osc24M", "pll-video", "pll-periph0" };
+static const char * const csi_mclk_parents[] = { "osc24M", "pll-video0", "pll-periph0" };
 static SUNXI_CCU_M_WITH_MUX_GATE(csi_mclk_clk, "csi-mclk", csi_mclk_parents,
 				 0x134, 0, 5, 8, 3, BIT(15), 0);
 
@@ -470,14 +470,14 @@ static SUNXI_CCU_GATE(ac_dig_clk,	"ac-dig",	"pll-audio",
 static SUNXI_CCU_GATE(avs_clk,		"avs",		"osc24M",
 		      0x144, BIT(31), 0);
 
-static const char * const hdmi_parents[] = { "pll-video" };
+static const char * const hdmi_parents[] = { "pll-video0" };
 static SUNXI_CCU_M_WITH_MUX_GATE(hdmi_clk, "hdmi", hdmi_parents,
 				 0x150, 0, 4, 24, 2, BIT(31), 0);
 
 static SUNXI_CCU_GATE(hdmi_ddc_clk,	"hdmi-ddc",	"osc24M",
 		      0x154, BIT(31), 0);
 
-static const char * const mbus_parents[] = { "osc24M", "pll-periph0-2x", "pll-ddr" };
+static const char * const mbus_parents[] = { "osc24M", "pll-periph0-2x", "pll-ddr0" };
 static SUNXI_CCU_M_WITH_MUX_GATE(mbus_clk, "mbus", mbus_parents,
 				 0x15c, 0, 3, 24, 2, BIT(31), CLK_IS_CRITICAL);
 
@@ -487,9 +487,9 @@ static SUNXI_CCU_M_WITH_GATE(gpu_clk, "gpu", "pll-gpu",
 static struct ccu_common *sun8i_h3_ccu_clks[] = {
 	&pll_cpux_clk.common,
 	&pll_audio_base_clk.common,
-	&pll_video_clk.common,
+	&pll_video0_clk.common,
 	&pll_ve_clk.common,
-	&pll_ddr_clk.common,
+	&pll_ddr0_clk.common,
 	&pll_periph0_clk.common,
 	&pll_gpu_clk.common,
 	&pll_periph1_clk.common,
-- 
2.9.2
