From: lori.hikichi@broadcom.com (Lori Hikichi)
Date: Thu, 28 Sep 2017 15:29:35 -0700
Subject: [PATCH v1 3/3] ASoC: cygnus: Remove support for 8 bit audio and for
 mono
In-Reply-To: <1506637775-18293-1-git-send-email-lori.hikichi@broadcom.com>
References: <1506637775-18293-1-git-send-email-lori.hikichi@broadcom.com>
Message-ID: <1506637775-18293-5-git-send-email-lori.hikichi@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These modes of operation were not working properly and it is
unclear if the hardware could fully support these modes properly.
There is little to be gained by enabling these modes, therefore,
we will just remove support.

Signed-off-by: Lori Hikichi <lori.hikichi@broadcom.com>
---
 sound/soc/bcm/cygnus-ssp.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
index da14fac..cd8aef8 100644
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
@@ -1148,11 +1135,10 @@ static int cygnus_ssp_resume(struct snd_soc_dai *cpu_dai)
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
@@ -1160,7 +1146,7 @@ static int cygnus_ssp_resume(struct snd_soc_dai *cpu_dai)
 		.channels_max = 16, \
 		.rates = SNDRV_PCM_RATE_KNOT, \
 		.formats =  SNDRV_PCM_FMTBIT_S16_LE | \
-					SNDRV_PCM_FMTBIT_S32_LE, \
+				SNDRV_PCM_FMTBIT_S32_LE, \
 	}, \
 	.ops = &cygnus_ssp_dai_ops, \
 	.suspend = cygnus_ssp_suspend, \
-- 
1.9.1
