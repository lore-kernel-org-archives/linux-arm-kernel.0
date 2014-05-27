From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 27 May 2014 10:24:20 +0200
Subject: [PATCH v5 3/8] ASoC: fsl-ssi: set bitclock in master mode from
 hw_params
In-Reply-To: <1401179065-31195-1-git-send-email-mpa@pengutronix.de>
References: <1401179065-31195-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1401179065-31195-4-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

The fsl_ssi driver uses the .set_sysclk callback to configure the
bitclock for master mode. This is unnecessary since the bitclock
is known in hw_params. This patch configures the bitclock from .hw_params.
.set_dai_sysclk now sets a bitclock frequency which is preferred over
the default calculated bitclock frequency.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Tested-By: Michael Grzeschik <mgr@pengutronix.de>
---

Notes:
    Changes in v5:
     - Added .set_dai_sysclk again to set a bitclock frequency manually

 sound/soc/fsl/fsl_ssi.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 18eacf5..930095b 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -166,6 +166,7 @@ struct fsl_ssi_private {
 	spinlock_t baudclk_lock;
 	struct clk *baudclk;
 	struct clk *clk;
+	unsigned int bitclk_freq;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
 	struct imx_pcm_fiq_params fiq_params;
@@ -236,6 +237,12 @@ static bool fsl_ssi_is_ac97(struct fsl_ssi_private *ssi_private)
 	return !!(ssi_private->dai_fmt & SND_SOC_DAIFMT_AC97);
 }
 
+static bool fsl_ssi_is_i2s_master(struct fsl_ssi_private *ssi_private)
+{
+	return (ssi_private->dai_fmt & SND_SOC_DAIFMT_MASTER_MASK) ==
+		SND_SOC_DAIFMT_CBS_CFS;
+}
+
 /**
  * fsl_ssi_isr: SSI interrupt handler
  *
@@ -509,7 +516,7 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 }
 
 /**
- * fsl_ssi_set_dai_sysclk - configure Digital Audio Interface bit clock
+ * fsl_ssi_set_bclk - configure Digital Audio Interface bit clock
  *
  * Note: This function can be only called when using SSI as DAI master
  *
@@ -517,8 +524,9 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
  * freq: Output BCLK frequency = samplerate * 32 (fixed) * channels
  * dir: SND_SOC_CLOCK_OUT -> TxBCLK, SND_SOC_CLOCK_IN -> RxBCLK.
  */
-static int fsl_ssi_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
-				  int clk_id, unsigned int freq, int dir)
+static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *cpu_dai,
+		struct snd_pcm_hw_params *hw_params)
 {
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
 	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
@@ -526,6 +534,13 @@ static int fsl_ssi_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	u32 pm = 999, div2, psr, stccr, mask, afreq, factor, i;
 	unsigned long flags, clkrate, baudrate, tmprate;
 	u64 sub, savesub = 100000;
+	unsigned int freq;
+
+	/* Prefer the explicitly set bitclock frequency */
+	if (ssi_private->bitclk_freq)
+		freq = ssi_private->bitclk_freq;
+	else
+		freq = params_channels(hw_params) * 32 * params_rate(hw_params);
 
 	/* Don't apply it to any non-baudclk circumstance */
 	if (IS_ERR(ssi_private->baudclk))
@@ -583,7 +598,7 @@ static int fsl_ssi_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	mask = CCSR_SSI_SxCCR_PM_MASK | CCSR_SSI_SxCCR_DIV2 |
 		CCSR_SSI_SxCCR_PSR;
 
-	if (dir == SND_SOC_CLOCK_OUT || synchronous)
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK || synchronous)
 		write_ssi_mask(&ssi->stccr, mask, stccr);
 	else
 		write_ssi_mask(&ssi->srccr, mask, stccr);
@@ -604,6 +619,16 @@ static int fsl_ssi_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	return 0;
 }
 
+static int fsl_ssi_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
+		int clk_id, unsigned int freq, int dir)
+{
+	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
+
+	ssi_private->bitclk_freq = freq;
+
+	return 0;
+}
+
 /**
  * fsl_ssi_hw_params - program the sample size
  *
@@ -627,6 +652,7 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 		snd_pcm_format_width(params_format(hw_params));
 	u32 wl = CCSR_SSI_SxCCR_WL(sample_size);
 	int enabled = read_ssi(&ssi->scr) & CCSR_SSI_SCR_SSIEN;
+	int ret;
 
 	/*
 	 * If we're in synchronous mode, and the SSI is already enabled,
@@ -635,6 +661,12 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	if (enabled && ssi_private->cpu_dai_drv.symmetric_rates)
 		return 0;
 
+	if (fsl_ssi_is_i2s_master(ssi_private)) {
+		ret = fsl_ssi_set_bclk(substream, cpu_dai, hw_params);
+		if (ret)
+			return ret;
+	}
+
 	/*
 	 * FIXME: The documentation says that SxCCR[WL] should not be
 	 * modified while the SSI is enabled.  The only time this can
-- 
2.0.0.rc2
