From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 12 Oct 2017 16:37:02 +0800
Subject: [PATCH 6/9] clk: sunxi-ng: sun4i: Use sigma-delta modulation for
 audio PLL
In-Reply-To: <20171012083705.24409-1-wens@csie.org>
References: <20171012083705.24409-1-wens@csie.org>
Message-ID: <20171012083705.24409-7-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The audio blocks require specific clock rates. Until now we were using
the closest clock rate possible with integer N-M factors. This resulted
in audio playback being slightly slower than it should be.

The vendor kernel gets around this (for newer SoCs) by using sigma-delta
modulation to generate a fractional-N factor. As the PLL hardware is
identical in most chips, we can back port the settings from the newer
SoC, in this case the H3, onto the A10 and A20.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
index a48fde191c0a..ffa5dac221e4 100644
--- a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
+++ b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
@@ -28,6 +28,7 @@
 #include "ccu_nkmp.h"
 #include "ccu_nm.h"
 #include "ccu_phase.h"
+#include "ccu_sdm.h"
 
 #include "ccu-sun4i-a10.h"
 
@@ -51,16 +52,29 @@ static struct ccu_nkmp pll_core_clk = {
  * the base (2x, 4x and 8x), and one variable divider (the one true
  * pll audio).
  *
- * We don't have any need for the variable divider for now, so we just
- * hardcode it to match with the clock names.
+ * With sigma-delta modulation for fractional-N on the audio PLL,
+ * we have to use specific dividers. This means the variable divider
+ * can no longer be used, as the audio codec requests the exact clock
+ * rates we support through this mechanism. So we now hard code the
+ * variable divider to 1. This means the clock rates will no longer
+ * match the clock names.
  */
 #define SUN4I_PLL_AUDIO_REG	0x008
+
+static struct ccu_sdm_setting pll_audio_sdm_table[] = {
+	{ .rate = 22579200, .pattern = 0xc0010d84, .m = 8, .n = 7 },
+	{ .rate = 24576000, .pattern = 0xc000ac02, .m = 14, .n = 14 },
+};
+
 static struct ccu_nm pll_audio_base_clk = {
 	.enable		= BIT(31),
 	.n		= _SUNXI_CCU_MULT_OFFSET(8, 7, 0),
 	.m		= _SUNXI_CCU_DIV_OFFSET(0, 5, 0),
+	.sdm		= _SUNXI_CCU_SDM(pll_audio_sdm_table, 0,
+					 0x00c, BIT(31)),
 	.common		= {
 		.reg		= 0x008,
+		.features	= CCU_FEATURE_SIGMA_DELTA_MOD,
 		.hw.init	= CLK_HW_INIT("pll-audio-base",
 					      "hosc",
 					      &ccu_nm_ops,
@@ -1021,9 +1035,9 @@ static struct ccu_common *sun4i_sun7i_ccu_clks[] = {
 	&out_b_clk.common
 };
 
-/* Post-divider for pll-audio is hardcoded to 4 */
+/* Post-divider for pll-audio is hardcoded to 1 */
 static CLK_FIXED_FACTOR(pll_audio_clk, "pll-audio",
-			"pll-audio-base", 4, 1, CLK_SET_RATE_PARENT);
+			"pll-audio-base", 1, 1, CLK_SET_RATE_PARENT);
 static CLK_FIXED_FACTOR(pll_audio_2x_clk, "pll-audio-2x",
 			"pll-audio-base", 2, 1, CLK_SET_RATE_PARENT);
 static CLK_FIXED_FACTOR(pll_audio_4x_clk, "pll-audio-4x",
@@ -1420,10 +1434,10 @@ static void __init sun4i_ccu_init(struct device_node *node,
 		return;
 	}
 
-	/* Force the PLL-Audio-1x divider to 4 */
+	/* Force the PLL-Audio-1x divider to 1 */
 	val = readl(reg + SUN4I_PLL_AUDIO_REG);
 	val &= ~GENMASK(29, 26);
-	writel(val | (4 << 26), reg + SUN4I_PLL_AUDIO_REG);
+	writel(val | (1 << 26), reg + SUN4I_PLL_AUDIO_REG);
 
 	/*
 	 * Use the peripheral PLL6 as the AHB parent, instead of CPU /
-- 
2.14.2
