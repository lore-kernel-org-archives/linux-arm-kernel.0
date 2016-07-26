From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Jul 2016 22:30:34 +0200
Subject: [PATCH 06/13] clk: sunxi-ng: sun8i: Move fixed factors around
In-Reply-To: <20160726203041.29366-1-maxime.ripard@free-electrons.com>
References: <20160726203041.29366-1-maxime.ripard@free-electrons.com>
Message-ID: <20160726203041.29366-7-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the fixed factors clocks before the ccu_common list so that we can
separate the clocks definitions and the registration part.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
index f61d2e245ac4..ec8c67201e8e 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
@@ -484,6 +484,19 @@ static SUNXI_CCU_M_WITH_MUX_GATE(mbus_h3_clk, "mbus", mbus_h3_parents,
 static SUNXI_CCU_M_WITH_GATE(gpu_clk, "gpu", "pll-gpu",
 			     0x1a0, 0, 3, BIT(31), 0);
 
+/* Fixed Factor clocks */
+/* We hardcode the divider to 4 for now */
+static CLK_FIXED_FACTOR(pll_audio_clk, "pll-audio",
+			"pll-audio-base", 4, 1, CLK_SET_RATE_PARENT);
+static CLK_FIXED_FACTOR(pll_audio_2x_clk, "pll-audio-2x",
+			"pll-audio-base", 2, 1, CLK_SET_RATE_PARENT);
+static CLK_FIXED_FACTOR(pll_audio_4x_clk, "pll-audio-4x",
+			"pll-audio-base", 1, 1, CLK_SET_RATE_PARENT);
+static CLK_FIXED_FACTOR(pll_audio_8x_clk, "pll-audio-8x",
+			"pll-audio-base", 1, 2, CLK_SET_RATE_PARENT);
+static CLK_FIXED_FACTOR(pll_periph0_2x_clk, "pll-periph0-2x",
+			"pll-periph0", 1, 2, 0);
+
 static struct ccu_common *sun8i_h3_ccu_clks[] = {
 	&pll_cpux_clk.common,
 	&pll_audio_base_clk.common,
@@ -597,18 +610,6 @@ static struct ccu_common *sun8i_h3_ccu_clks[] = {
 	&gpu_clk.common,
 };
 
-/* We hardcode the divider to 4 for now */
-static CLK_FIXED_FACTOR(pll_audio_clk, "pll-audio",
-			"pll-audio-base", 4, 1, CLK_SET_RATE_PARENT);
-static CLK_FIXED_FACTOR(pll_audio_2x_clk, "pll-audio-2x",
-			"pll-audio-base", 2, 1, CLK_SET_RATE_PARENT);
-static CLK_FIXED_FACTOR(pll_audio_4x_clk, "pll-audio-4x",
-			"pll-audio-base", 1, 1, CLK_SET_RATE_PARENT);
-static CLK_FIXED_FACTOR(pll_audio_8x_clk, "pll-audio-8x",
-			"pll-audio-base", 1, 2, CLK_SET_RATE_PARENT);
-static CLK_FIXED_FACTOR(pll_periph0_2x_clk, "pll-periph0-2x",
-			"pll-periph0", 1, 2, 0);
-
 static struct clk_hw_onecell_data sun8i_h3_hw_clks = {
 	.hws	= {
 		[CLK_PLL_CPUX]		= &pll_cpux_clk.common.hw,
-- 
2.9.2
