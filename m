From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 14 Apr 2014 15:35:43 +0200
Subject: [PATCH v3 13/18] ASoC: fsl-ssi: set bitclock in master mode from
 hw_params
In-Reply-To: <1397482548-28463-1-git-send-email-mpa@pengutronix.de>
References: <1397482548-28463-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1397482548-28463-14-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

The fsl_ssi driver uses the .set_sysclk callback to configure the
bitclock for master mode. This is unnecessary since the bitclock
is known in hw_params. This patch removes the .set_sysclk callback
and configures the bitclock from .hw_params.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 74f5a91..e3a93f0 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -533,7 +533,7 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
 }
 
 /**
- * fsl_ssi_set_dai_sysclk - configure Digital Audio Interface bit clock
+ * fsl_ssi_set_bclk - configure Digital Audio Interface bit clock
  *
  * Note: This function can be only called when using SSI as DAI master
  *
@@ -541,8 +541,8 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
  * freq: Output BCLK frequency = samplerate * 32 (fixed) * channels
  * dir: SND_SOC_CLOCK_OUT -> TxBCLK, SND_SOC_CLOCK_IN -> RxBCLK.
  */
-static int fsl_ssi_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
-				  int clk_id, unsigned int freq, int dir)
+static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *cpu_dai, unsigned int freq)
 {
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
 	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
@@ -607,7 +607,7 @@ static int fsl_ssi_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	mask = CCSR_SSI_SxCCR_PM_MASK | CCSR_SSI_SxCCR_DIV2 |
 		CCSR_SSI_SxCCR_PSR;
 
-	if (dir == SND_SOC_CLOCK_OUT || synchronous)
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK || synchronous)
 		write_ssi_mask(&ssi->stccr, mask, stccr);
 	else
 		write_ssi_mask(&ssi->srccr, mask, stccr);
@@ -651,6 +651,7 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 		snd_pcm_format_width(params_format(hw_params));
 	u32 wl = CCSR_SSI_SxCCR_WL(sample_size);
 	int enabled = read_ssi(&ssi->scr) & CCSR_SSI_SCR_SSIEN;
+	int ret;
 
 	/*
 	 * If we're in synchronous mode, and the SSI is already enabled,
@@ -659,6 +660,14 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	if (enabled && ssi_private->cpu_dai_drv.symmetric_rates)
 		return 0;
 
+	if (fsl_ssi_is_i2s_master(ssi_private)) {
+		ret = fsl_ssi_set_bclk(substream, cpu_dai,
+				params_channels(hw_params) * 32 *
+				params_rate(hw_params));
+		if (ret)
+			return ret;
+	}
+
 	/*
 	 * FIXME: The documentation says that SxCCR[WL] should not be
 	 * modified while the SSI is enabled.  The only time this can
@@ -953,7 +962,6 @@ static const struct snd_soc_dai_ops fsl_ssi_dai_ops = {
 	.shutdown	= fsl_ssi_shutdown,
 	.hw_params	= fsl_ssi_hw_params,
 	.set_fmt	= fsl_ssi_set_dai_fmt,
-	.set_sysclk	= fsl_ssi_set_dai_sysclk,
 	.set_tdm_slot	= fsl_ssi_set_dai_tdm_slot,
 	.trigger	= fsl_ssi_trigger,
 };
-- 
1.9.1
