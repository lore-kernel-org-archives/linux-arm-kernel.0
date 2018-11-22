From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 22 Nov 2018 18:23:22 +0800
Subject: [PATCH v9 5/8] clk: sunxi-ng: sun50i: a64: Use sigma-delta modulation
 for audio PLL
In-Reply-To: <20181122102325.29495-1-wens@csie.org>
References: <20181122102325.29495-1-wens@csie.org>
Message-ID: <20181122102325.29495-6-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The audio blocks require specific clock rates. Until now we were using
the closest clock rate possible with integer N-M factors. This resulted
in audio playback being slightly slower than it should be.

The vendor kernel gets around this (for some SoCs) by using sigma-delta
modulation to generate a fractional-N factor. As the PLL hardware is
identical in most chips, we can port the settings for H3 onto the A64.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 37 +++++++++++++++++----------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index 1f45b20ad752..181b599dc163 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -51,18 +51,29 @@ static struct ccu_nkmp pll_cpux_clk = {
  * the base (2x, 4x and 8x), and one variable divider (the one true
  * pll audio).
  *
- * We don't have any need for the variable divider for now, so we just
- * hardcode it to match with the clock names
+ * With sigma-delta modulation for fractional-N on the audio PLL,
+ * we have to use specific dividers. This means the variable divider
+ * can no longer be used, as the audio codec requests the exact clock
+ * rates we support through this mechanism. So we now hard code the
+ * variable divider to 1. This means the clock rates will no longer
+ * match the clock names.
  */
 #define SUN50I_A64_PLL_AUDIO_REG	0x008
 
-static SUNXI_CCU_NM_WITH_GATE_LOCK(pll_audio_base_clk, "pll-audio-base",
-				   "osc24M", 0x008,
-				   8, 7,	/* N */
-				   0, 5,	/* M */
-				   BIT(31),	/* gate */
-				   BIT(28),	/* lock */
-				   CLK_SET_RATE_UNGATE);
+static struct ccu_sdm_setting pll_audio_sdm_table[] = {
+	{ .rate = 22579200, .pattern = 0xc0010d84, .m = 8, .n = 7 },
+	{ .rate = 24576000, .pattern = 0xc000ac02, .m = 14, .n = 14 },
+};
+
+static SUNXI_CCU_NM_WITH_SDM_GATE_LOCK(pll_audio_base_clk, "pll-audio-base",
+				       "osc24M", 0x008,
+				       8, 7,	/* N */
+				       0, 5,	/* M */
+				       pll_audio_sdm_table, BIT(24),
+				       0x284, BIT(31),
+				       BIT(31),	/* gate */
+				       BIT(28),	/* lock */
+				       CLK_SET_RATE_UNGATE);
 
 static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX(pll_video0_clk, "pll-video0",
 						"osc24M", 0x010,
@@ -594,9 +605,9 @@ static SUNXI_CCU_M_WITH_GATE(gpu_clk, "gpu", "pll-gpu",
 /* Fixed Factor clocks */
 static CLK_FIXED_FACTOR(osc12M_clk, "osc12M", "osc24M", 2, 1, 0);
 
-/* We hardcode the divider to 4 for now */
+/* We hardcode the divider to 1 for now */
 static CLK_FIXED_FACTOR(pll_audio_clk, "pll-audio",
-			"pll-audio-base", 4, 1, CLK_SET_RATE_PARENT);
+			"pll-audio-base", 1, 1, CLK_SET_RATE_PARENT);
 static CLK_FIXED_FACTOR(pll_audio_2x_clk, "pll-audio-2x",
 			"pll-audio-base", 2, 1, CLK_SET_RATE_PARENT);
 static CLK_FIXED_FACTOR(pll_audio_4x_clk, "pll-audio-4x",
@@ -916,10 +927,10 @@ static int sun50i_a64_ccu_probe(struct platform_device *pdev)
 	if (IS_ERR(reg))
 		return PTR_ERR(reg);
 
-	/* Force the PLL-Audio-1x divider to 4 */
+	/* Force the PLL-Audio-1x divider to 1 */
 	val = readl(reg + SUN50I_A64_PLL_AUDIO_REG);
 	val &= ~GENMASK(19, 16);
-	writel(val | (3 << 16), reg + SUN50I_A64_PLL_AUDIO_REG);
+	writel(val | (0 << 16), reg + SUN50I_A64_PLL_AUDIO_REG);
 
 	writel(0x515, reg + SUN50I_A64_PLL_MIPI_REG);
 
-- 
2.19.1
