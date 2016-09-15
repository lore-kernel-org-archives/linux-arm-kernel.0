From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 15 Sep 2016 14:57:38 +0800
Subject: [PATCH 1/3] clk: sunxi-ng: sun6i-a31: Set CLK_SET_RATE_PARENT for
 display output clocks
In-Reply-To: <20160915065740.13664-1-wens@csie.org>
References: <20160915065740.13664-1-wens@csie.org>
Message-ID: <20160915065740.13664-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LCD controller and HDMI controller use the LCDx-CHy and HDMI clocks
to generate their dot clocks. To be able to generate a full range of
possible clock rates, the parent PLL clock rates should also be changed.

Fixes: c6e6c96d8fa6 ("clk: sunxi-ng: Add A31/A31s clocks")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
index f1d61faa5bd9..bb488e8baea8 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
@@ -543,17 +543,19 @@ static const char * const lcd_ch0_parents[] = { "pll-video0", "pll-video1",
 						"pll-video0-2x",
 						"pll-video1-2x", "pll-mipi" };
 static SUNXI_CCU_MUX_WITH_GATE(lcd0_ch0_clk, "lcd0-ch0", lcd_ch0_parents,
-			       0x118, 24, 2, BIT(31), 0);
+			       0x118, 24, 2, BIT(31), CLK_SET_RATE_PARENT);
 static SUNXI_CCU_MUX_WITH_GATE(lcd1_ch0_clk, "lcd1-ch0", lcd_ch0_parents,
-			       0x11c, 24, 2, BIT(31), 0);
+			       0x11c, 24, 2, BIT(31), CLK_SET_RATE_PARENT);
 
 static const char * const lcd_ch1_parents[] = { "pll-video0", "pll-video1",
 						"pll-video0-2x",
 						"pll-video1-2x" };
 static SUNXI_CCU_M_WITH_MUX_GATE(lcd0_ch1_clk, "lcd0-ch1", lcd_ch1_parents,
-				 0x12c, 0, 4, 24, 3, BIT(31), 0);
+				 0x12c, 0, 4, 24, 3, BIT(31),
+				 CLK_SET_RATE_PARENT);
 static SUNXI_CCU_M_WITH_MUX_GATE(lcd1_ch1_clk, "lcd1-ch1", lcd_ch1_parents,
-				 0x12c, 0, 4, 24, 3, BIT(31), 0);
+				 0x12c, 0, 4, 24, 3, BIT(31),
+				 CLK_SET_RATE_PARENT);
 
 static const char * const csi_sclk_parents[] = { "pll-video0", "pll-video1",
 						 "pll9", "pll10", "pll-mipi",
@@ -601,7 +603,8 @@ static SUNXI_CCU_GATE(digital_mic_clk,	"digital-mic",	"pll-audio",
 		      0x148, BIT(31), CLK_SET_RATE_PARENT);
 
 static SUNXI_CCU_M_WITH_MUX_GATE(hdmi_clk, "hdmi", lcd_ch1_parents,
-				 0x150, 0, 4, 24, 2, BIT(31), 0);
+				 0x150, 0, 4, 24, 2, BIT(31),
+				 CLK_SET_RATE_PARENT);
 
 static SUNXI_CCU_GATE(hdmi_ddc_clk, "hdmi-ddc", "osc24M", 0x150, BIT(31), 0);
 
@@ -624,10 +627,11 @@ static SUNXI_CCU_MP_WITH_MUX_GATE(mbus1_clk, "mbus1", mbus_parents, 0x160,
 				  CLK_IS_CRITICAL);
 
 static SUNXI_CCU_M_WITH_MUX_GATE(mipi_dsi_clk, "mipi-dsi", lcd_ch1_parents,
-				 0x168, 16, 3, 24, 2, BIT(31), 0);
+				 0x168, 16, 3, 24, 2, BIT(31),
+				 CLK_SET_RATE_PARENT);
 static SUNXI_CCU_M_WITH_MUX_GATE(mipi_dsi_dphy_clk, "mipi-dsi-dphy",
 				 lcd_ch1_parents, 0x168, 0, 3, 8, 2,
-				 BIT(15), 0);
+				 BIT(15), CLK_SET_RATE_PARENT);
 static SUNXI_CCU_M_WITH_MUX_GATE(mipi_csi_dphy_clk, "mipi-csi-dphy",
 				 lcd_ch1_parents, 0x168, 0, 3, 8, 2,
 				 BIT(15), 0);
@@ -956,9 +960,9 @@ static CLK_FIXED_FACTOR(pll_audio_8x_clk, "pll-audio-8x",
 static CLK_FIXED_FACTOR(pll_periph_2x_clk, "pll-periph-2x",
 			"pll-periph", 1, 2, 0);
 static CLK_FIXED_FACTOR(pll_video0_2x_clk, "pll-video0-2x",
-			"pll-video0", 1, 2, 0);
+			"pll-video0", 1, 2, CLK_SET_RATE_PARENT);
 static CLK_FIXED_FACTOR(pll_video1_2x_clk, "pll-video1-2x",
-			"pll-video1", 1, 2, 0);
+			"pll-video1", 1, 2, CLK_SET_RATE_PARENT);
 
 static struct clk_hw_onecell_data sun6i_a31_hw_clks = {
 	.hws	= {
-- 
2.9.3
