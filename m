From: subaparts@yandex.ru (Alexander)
Date: Wed, 08 Dec 2010 15:01:33 +0300
Subject: [PATCH 1/3] ASoC: EP93xx I2S and PCM fixes
Message-ID: <1291809693.31916.2.camel@r60e>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexander Sverdlin <subaparts@yandex.ru>

Changes to I2S code:
- MCLK is turned on on driver probe. This is done for several codecs that need this for 
  registers access (like CS4271).
- SCLK and LRCLK rates are corrected, assuming we always send 32 bits * 2 channels to codec.
- Formats list shortened to just S32_LE, this makes all the DMA transactions right,
  while ALSA will do all sample format translation for us.
Changes to both I2S and PCM code:
- Rates list extended up to 96kHz, it's tested on EDB9302 and works for both capture and
  playback.

Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>
---

 sound/soc/ep93xx/ep93xx-i2s.c |   37 +++++++++++++++++++++++--------------
 sound/soc/ep93xx/ep93xx-pcm.c |    4 ++--
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/sound/soc/ep93xx/ep93xx-i2s.c b/sound/soc/ep93xx/ep93xx-i2s.c
index 4f48733..e5e9b9a 100644
--- a/sound/soc/ep93xx/ep93xx-i2s.c
+++ b/sound/soc/ep93xx/ep93xx-i2s.c
@@ -98,7 +98,6 @@ static void ep93xx_i2s_enable(struct ep93xx_i2s_info *info, int stream)
 	if ((ep93xx_i2s_read_reg(info, EP93XX_I2S_TX0EN) & 0x1) == 0 &&
 	    (ep93xx_i2s_read_reg(info, EP93XX_I2S_RX0EN) & 0x1) == 0) {
 		/* Enable clocks */
-		clk_enable(info->mclk);
 		clk_enable(info->sclk);
 		clk_enable(info->lrclk);
 
@@ -136,7 +135,6 @@ static void ep93xx_i2s_disable(struct ep93xx_i2s_info *info, int stream)
 		/* Disable clocks */
 		clk_disable(info->lrclk);
 		clk_disable(info->sclk);
-		clk_disable(info->mclk);
 	}
 }
 
@@ -267,14 +265,16 @@ static int ep93xx_i2s_hw_params(struct snd_pcm_substream *substream,
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
@@ -316,6 +316,7 @@ static int ep93xx_i2s_suspend(struct snd_soc_dai *dai)
 
 	ep93xx_i2s_disable(info, SNDRV_PCM_STREAM_PLAYBACK);
 	ep93xx_i2s_disable(info, SNDRV_PCM_STREAM_CAPTURE);
+	clk_disable(info->mclk);
 }
 
 static int ep93xx_i2s_resume(struct snd_soc_dai *dai)
@@ -325,6 +326,7 @@ static int ep93xx_i2s_resume(struct snd_soc_dai *dai)
 	if (!dai->active)
 		return;
 
+	clk_enable(info->mclk);
 	ep93xx_i2s_enable(info, SNDRV_PCM_STREAM_PLAYBACK);
 	ep93xx_i2s_enable(info, SNDRV_PCM_STREAM_CAPTURE);
 }
@@ -341,9 +343,7 @@ static struct snd_soc_dai_ops ep93xx_i2s_dai_ops = {
 	.set_fmt	= ep93xx_i2s_set_dai_fmt,
 };
 
-#define EP93XX_I2S_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
-			    SNDRV_PCM_FMTBIT_S24_LE | \
-			    SNDRV_PCM_FMTBIT_S32_LE)
+#define EP93XX_I2S_FORMATS (SNDRV_PCM_FMTBIT_S32_LE)
 
 static struct snd_soc_dai_driver ep93xx_i2s_dai = {
 	.symmetric_rates= 1,
@@ -352,13 +352,13 @@ static struct snd_soc_dai_driver ep93xx_i2s_dai = {
 	.playback	= {
 		.channels_min	= 2,
 		.channels_max	= 2,
-		.rates		= SNDRV_PCM_RATE_8000_48000,
+		.rates		= SNDRV_PCM_RATE_8000_96000,
 		.formats	= EP93XX_I2S_FORMATS,
 	},
 	.capture	= {
 		 .channels_min	= 2,
 		 .channels_max	= 2,
-		 .rates		= SNDRV_PCM_RATE_8000_48000,
+		 .rates		= SNDRV_PCM_RATE_8000_96000,
 		 .formats	= EP93XX_I2S_FORMATS,
 	},
 	.ops		= &ep93xx_i2s_dai_ops,
@@ -404,10 +404,16 @@ static int ep93xx_i2s_probe(struct platform_device *pdev)
 		goto fail_unmap_mem;
 	}
 
+	/* Minimal MCLK freq to enable some codecs */
+	err = clk_set_rate(info->mclk, 8000 * 64 * 4);
+	if (err)
+		goto fail_put_mclk;
+	clk_enable(info->mclk);
+
 	info->sclk = clk_get(&pdev->dev, "sclk");
 	if (IS_ERR(info->sclk)) {
 		err = PTR_ERR(info->sclk);
-		goto fail_put_mclk;
+		goto fail_disable_mclk;
 	}
 
 	info->lrclk = clk_get(&pdev->dev, "lrclk");
@@ -426,6 +432,8 @@ fail_put_lrclk:
 	clk_put(info->lrclk);
 fail_put_sclk:
 	clk_put(info->sclk);
+fail_disable_mclk:
+	clk_disable(info->mclk);
 fail_put_mclk:
 	clk_put(info->mclk);
 fail_unmap_mem:
@@ -444,6 +452,7 @@ static int __devexit ep93xx_i2s_remove(struct platform_device *pdev)
 	snd_soc_unregister_dai(&pdev->dev);
 	clk_put(info->lrclk);
 	clk_put(info->sclk);
+	clk_disable(info->mclk);
 	clk_put(info->mclk);
 	iounmap(info->regs);
 	release_mem_region(info->mem->start, resource_size(info->mem));
diff --git a/sound/soc/ep93xx/ep93xx-pcm.c b/sound/soc/ep93xx/ep93xx-pcm.c
index 2f121dd..0667077 100644
--- a/sound/soc/ep93xx/ep93xx-pcm.c
+++ b/sound/soc/ep93xx/ep93xx-pcm.c
@@ -35,9 +35,9 @@ static const struct snd_pcm_hardware ep93xx_pcm_hardware = {
 				   SNDRV_PCM_INFO_INTERLEAVED	|
 				   SNDRV_PCM_INFO_BLOCK_TRANSFER),
 				   
-	.rates			= SNDRV_PCM_RATE_8000_48000,
+	.rates			= SNDRV_PCM_RATE_8000_96000,
 	.rate_min		= SNDRV_PCM_RATE_8000,
-	.rate_max		= SNDRV_PCM_RATE_48000,
+	.rate_max		= SNDRV_PCM_RATE_96000,
 	
 	.formats		= (SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE |
