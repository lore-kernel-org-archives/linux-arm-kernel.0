From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  6 Sep 2018 21:25:37 +0800
Subject: [PATCH] clk: sunxi-ng: sun4i: Set VCO and PLL bias current to lowest
 setting
Message-ID: <20180906132537.20772-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The default mid-level PLL bias current setting interferes with sigma
delta modulation. This manifests as decreased audio quality at lower
sampling rates, which sounds like radio broadcast quality, and
distortion noises at sampling rates at 48 kHz or above.

Changing the bias current settings to the lowest gets rid of the
noise.

Fixes: de3448519194 ("clk: sunxi-ng: sun4i: Use sigma-delta modulation
		      for audio PLL")
Cc: <stable@vger.kernel.org> # 4.15.x
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
index ffa5dac221e4..129ebd2588fd 100644
--- a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
+++ b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
@@ -1434,8 +1434,16 @@ static void __init sun4i_ccu_init(struct device_node *node,
 		return;
 	}
 
-	/* Force the PLL-Audio-1x divider to 1 */
 	val = readl(reg + SUN4I_PLL_AUDIO_REG);
+
+	/*
+	 * Force VCO and PLL bias current to lowest setting. Higher
+	 * settings interfere with sigma-delta modulation and result
+	 * in audible noise and distortions when using SPDIF or I2S.
+	 */
+	val &= ~GENMASK(25, 16);
+
+	/* Force the PLL-Audio-1x divider to 1 */
 	val &= ~GENMASK(29, 26);
 	writel(val | (1 << 26), reg + SUN4I_PLL_AUDIO_REG);
 
-- 
2.19.0.rc1
