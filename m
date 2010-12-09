From: subaparts@yandex.ru (Alexander)
Date: Thu, 09 Dec 2010 03:59:35 +0300
Subject: [PATCH] ASoC: EP93xx: fixed LRCLK rate and DMA oper. in I2S code
In-Reply-To: <20101208124637.GD16418@rakim.wolfsonmicro.main>
References: <1291809693.31916.2.camel@r60e>
	<20101208124637.GD16418@rakim.wolfsonmicro.main>
Message-ID: <1291856375.31916.94.camel@r60e>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexander Sverdlin <subaparts@yandex.ru>

Changes to I2S code:
- SCLK and LRCLK rates are corrected, assuming we always send 32 bits * 2 channels to codec.
- Formats list shortened to just S32_LE, this makes all the DMA transactions right,
  while ALSA will do all sample format translation for us.

Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>
---

 sound/soc/ep93xx/ep93xx-i2s.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/ep93xx/ep93xx-i2s.c b/sound/soc/ep93xx/ep93xx-i2s.c
index 4f48733..3e4c3d9 100644
--- a/sound/soc/ep93xx/ep93xx-i2s.c
+++ b/sound/soc/ep93xx/ep93xx-i2s.c
@@ -267,14 +267,16 @@ static int ep93xx_i2s_hw_params(struct snd_pcm_substream *substream,
 		ep93xx_i2s_write_reg(info, EP93XX_I2S_RXWRDLEN, word_len);
 
 	/*
-	 * Calculate the sdiv (bit clock) and lrdiv (left/right clock) values.
-	 * If the lrclk is pulse length is larger than the word size, then the
-	 * bit clock will be gated for the unused bits.
+	 * EP93xx I2S module can be setup so SCLK / LRCLK value can be
+	 * 32, 64, 128. MCLK / SCLK value can be 2 and 4.
+	 * We set LRCLK equal to `rate' and minimum SCLK / LRCLK 
+	 * value is 64, because our sample size is 32 bit * 2 channels.
+	 * I2S standard permits us to transmit more bits than
+	 * the codec uses.
 	 */
-	div = (clk_get_rate(info->mclk) / params_rate(params)) *
-		params_channels(params);
+	div = clk_get_rate(info->mclk) / params_rate(params);
 	for (sdiv = 2; sdiv <= 4; sdiv += 2)
-		for (lrdiv = 32; lrdiv <= 128; lrdiv <<= 1)
+		for (lrdiv = 64; lrdiv <= 128; lrdiv <<= 1)
 			if (sdiv * lrdiv == div) {
 				found = 1;
 				goto out;
@@ -341,9 +343,7 @@ static struct snd_soc_dai_ops ep93xx_i2s_dai_ops = {
 	.set_fmt	= ep93xx_i2s_set_dai_fmt,
 };
 
-#define EP93XX_I2S_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
-			    SNDRV_PCM_FMTBIT_S24_LE | \
-			    SNDRV_PCM_FMTBIT_S32_LE)
+#define EP93XX_I2S_FORMATS (SNDRV_PCM_FMTBIT_S32_LE)
 
 static struct snd_soc_dai_driver ep93xx_i2s_dai = {
 	.symmetric_rates= 1,
