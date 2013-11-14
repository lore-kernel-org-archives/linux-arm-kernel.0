From: b42378@freescale.com (Nicolin Chen)
Date: Thu, 14 Nov 2013 19:07:10 +0800
Subject: [PATCH 2/2] ASoC: fsl_ssi: Add monaural audio support for non-ac97
 interface
In-Reply-To: <1384427230-979-1-git-send-email-b42378@freescale.com>
References: <1384427230-979-1-git-send-email-b42378@freescale.com>
Message-ID: <1384427230-979-3-git-send-email-b42378@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The normal mode of SSI allows it to send/receive data to/from the first
slot of each period. So we can use this normal mode to trick I2S signal
by puting/getting data to/from the first slot only (the left channel)
so as to support monaural audio playback and recording.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index f43be6d..ccf1d38 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -517,10 +517,12 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 {
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
 	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+	unsigned int channels = params_channels(hw_params);
 	unsigned int sample_size =
 		snd_pcm_format_width(params_format(hw_params));
 	u32 wl = CCSR_SSI_SxCCR_WL(sample_size);
 	int enabled = read_ssi(&ssi->scr) & CCSR_SSI_SCR_SSIEN;
+	static u8 i2s_mode;
 
 	/*
 	 * If we're in synchronous mode, and the SSI is already enabled,
@@ -546,6 +548,21 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	else
 		write_ssi_mask(&ssi->srccr, CCSR_SSI_SxCCR_WL_MASK, wl);
 
+	if (ssi_private->imx_ac97)
+		return 0;
+
+	/* Save i2s mode configuration so that we can restore it later */
+	switch (read_ssi(&ssi->scr) & CCSR_SSI_SCR_I2S_MODE_MASK) {
+	case CCSR_SSI_SCR_I2S_MODE_SLAVE:
+	case CCSR_SSI_SCR_I2S_MODE_MASTER:
+		i2s_mode = read_ssi(&ssi->scr) & CCSR_SSI_SCR_I2S_MODE_MASK;
+	default:
+		break;
+	}
+
+	write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_NET | CCSR_SSI_SCR_I2S_MODE_MASK,
+			channels == 1 ? 0 : CCSR_SSI_SCR_NET | i2s_mode);
+
 	return 0;
 }
 
@@ -658,14 +675,13 @@ static const struct snd_soc_dai_ops fsl_ssi_dai_ops = {
 static struct snd_soc_dai_driver fsl_ssi_dai_template = {
 	.probe = fsl_ssi_dai_probe,
 	.playback = {
-		/* The SSI does not support monaural audio. */
-		.channels_min = 2,
+		.channels_min = 1,
 		.channels_max = 2,
 		.rates = FSLSSI_I2S_RATES,
 		.formats = FSLSSI_I2S_FORMATS,
 	},
 	.capture = {
-		.channels_min = 2,
+		.channels_min = 1,
 		.channels_max = 2,
 		.rates = FSLSSI_I2S_RATES,
 		.formats = FSLSSI_I2S_FORMATS,
-- 
1.8.4
