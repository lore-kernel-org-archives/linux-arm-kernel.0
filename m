From: broonie@kernel.org (Mark Brown)
Date: Wed, 04 Oct 2017 12:27:49 +0100
Subject: Applied "ASoC: cygnus: Remove support for 8 bit audio and for mono"
 to the asoc tree
In-Reply-To: <1506637775-18293-5-git-send-email-lori.hikichi@broadcom.com>
Message-ID: <E1dzhq9-0004DL-4s@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: cygnus: Remove support for 8 bit audio and for mono

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 934e4885cb958566a34124e5a1dad2f9212a8ec6 Mon Sep 17 00:00:00 2001
From: Lori Hikichi <lori.hikichi@broadcom.com>
Date: Thu, 28 Sep 2017 15:29:35 -0700
Subject: [PATCH] ASoC: cygnus: Remove support for 8 bit audio and for mono

These modes of operation were not working properly and it is
unclear if the hardware could fully support these modes properly.
There is little to be gained by enabling these modes, therefore,
we will just remove support.

Signed-off-by: Lori Hikichi <lori.hikichi@broadcom.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/bcm/cygnus-ssp.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
index da14facb8a6f..cd8aef8ed8a5 100644
--- a/sound/soc/bcm/cygnus-ssp.c
+++ b/sound/soc/bcm/cygnus-ssp.c
@@ -655,23 +655,10 @@ static int cygnus_ssp_hw_params(struct snd_pcm_substream *substream,
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		value = readl(aio->cygaud->audio + aio->regs.bf_sourcech_cfg);
 		value &= ~BIT(BF_SRC_CFGX_BUFFER_PAIR_ENABLE);
-		/* Configure channels as mono or stereo/TDM */
-		if (params_channels(params) == 1)
-			value |= BIT(BF_SRC_CFGX_SAMPLE_CH_MODE);
-		else
-			value &= ~BIT(BF_SRC_CFGX_SAMPLE_CH_MODE);
+		value &= ~BIT(BF_SRC_CFGX_SAMPLE_CH_MODE);
 		writel(value, aio->cygaud->audio + aio->regs.bf_sourcech_cfg);
 
 		switch (params_format(params)) {
-		case SNDRV_PCM_FORMAT_S8:
-			if (aio->port_type == PORT_SPDIF) {
-				dev_err(aio->cygaud->dev,
-				"SPDIF does not support 8bit format\n");
-				return -EINVAL;
-			}
-			bitres = 8;
-			break;
-
 		case SNDRV_PCM_FORMAT_S16_LE:
 			bitres = 16;
 			break;
@@ -1148,11 +1135,10 @@ static const struct snd_soc_dai_ops cygnus_spdif_dai_ops = {
 #define INIT_CPU_DAI(num) { \
 	.name = "cygnus-ssp" #num, \
 	.playback = { \
-		.channels_min = 1, \
+		.channels_min = 2, \
 		.channels_max = 16, \
 		.rates = SNDRV_PCM_RATE_KNOT, \
-		.formats = SNDRV_PCM_FMTBIT_S8 | \
-				SNDRV_PCM_FMTBIT_S16_LE | \
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | \
 				SNDRV_PCM_FMTBIT_S32_LE, \
 	}, \
 	.capture = { \
@@ -1160,7 +1146,7 @@ static const struct snd_soc_dai_ops cygnus_spdif_dai_ops = {
 		.channels_max = 16, \
 		.rates = SNDRV_PCM_RATE_KNOT, \
 		.formats =  SNDRV_PCM_FMTBIT_S16_LE | \
-					SNDRV_PCM_FMTBIT_S32_LE, \
+				SNDRV_PCM_FMTBIT_S32_LE, \
 	}, \
 	.ops = &cygnus_ssp_dai_ops, \
 	.suspend = cygnus_ssp_suspend, \
-- 
2.14.1
