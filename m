From: lamiaposta71@gmail.com (Raffaele Recalcati)
Date: Wed, 30 Jun 2010 15:47:58 +0200
Subject: [PATCH 3/3] ASoC: DaVinci: Added fast clock timing for McBSP (I2S)
In-Reply-To: <1277905678-4695-1-git-send-email-lamiaposta71@gmail.com>
References: <1277905678-4695-1-git-send-email-lamiaposta71@gmail.com>
Message-ID: <1277905678-4695-4-git-send-email-lamiaposta71@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Raffaele Recalcati <raffaele.recalcati@bticino.it>

    i2s_fast_clock switch can be used to have a better approximate
    frequency.
    The waveform will be not symmetric.

    This patch has been developed against the
        http://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davinci.git
    git tree and has been tested on bmx board (similar to dm365 evm, but using
    uda1345 as external audio codec).

Signed-off-by: Raffaele Recalcati <raffaele.recalcati@bticino.it>
Signed-off-by: Davide Bonfanti <davide.bonfanti@bticino.it>
---
 arch/arm/mach-davinci/include/mach/asp.h |    7 +++++++
 sound/soc/davinci/davinci-i2s.c          |   24 +++++++++++++++++++-----
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/asp.h b/arch/arm/mach-davinci/include/mach/asp.h
index 314570d..2d8f8af 100644
--- a/arch/arm/mach-davinci/include/mach/asp.h
+++ b/arch/arm/mach-davinci/include/mach/asp.h
@@ -63,6 +63,13 @@ struct snd_platform_data {
 	unsigned sram_size_playback;
 	unsigned sram_size_capture;
 
+	/*
+	 * This define works when both clock and FS are output for the cpu
+	 * and makes clock very fast (FS is not symmetrical, but sampling
+	 * frequency is better approximated
+	 */
+	bool i2s_fast_clock;
+
 	/* To be used when cpu gets clock from external pin */
 	int clk_input_pin;
 
diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index e478be9..0af5bae 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -150,6 +150,7 @@ struct davinci_mcbsp_dev {
 	 */
 	unsigned enable_channel_combine:1;
 
+	bool i2s_fast_clock;
 	unsigned int fmt;
 	int clk_div;
 	int clk_input_pin;
@@ -443,11 +444,23 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 		       DAVINCI_MCBSP_SRGR_CLKSM;
 		srgr |= DAVINCI_MCBSP_SRGR_FWID(mcbsp_word_length *
 						8 - 1);
-		/* symmetric waveforms */
-		clk_div = freq / (mcbsp_word_length * 16) /
-			  params->rate_num * params->rate_den;
-		srgr |= DAVINCI_MCBSP_SRGR_FPER(mcbsp_word_length *
-						16 - 1);
+		if (dev->i2s_fast_clock) {
+			clk_div = 256;
+			do {
+				framesize = (freq / (--clk_div)) /
+					    params->rate_num *
+					    params->rate_den;
+			} while (((framesize < 33) || (framesize > 4095)) &&
+				 (clk_div));
+			clk_div--;
+			srgr |= DAVINCI_MCBSP_SRGR_FPER(framesize - 1);
+		} else {
+			/* symmetric waveforms */
+			clk_div = freq / (mcbsp_word_length * 16) /
+				  params->rate_num * params->rate_den;
+			srgr |= DAVINCI_MCBSP_SRGR_FPER(mcbsp_word_length *
+							16 - 1);
+		}
 		clk_div &= 0xFF;
 		srgr |= clk_div;
 		break;
@@ -643,6 +656,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 			pdata->sram_size_playback;
 		dev->dma_params[SNDRV_PCM_STREAM_CAPTURE].sram_size =
 			pdata->sram_size_capture;
+		dev->i2s_fast_clock = pdata->i2s_fast_clock;
 		dev->clk_input_pin = pdata->clk_input_pin;
 	}
 	dev->clk = clk_get(&pdev->dev, NULL);
-- 
1.7.0.4
