From: jsarha@ti.com (Jyri Sarha)
Date: Mon, 27 Jan 2014 17:37:52 +0200
Subject: [PATCH RFC v3 3/8] ASoC: davinci-mcasp: Set BCLK divider if McASP is
 BCLK master
In-Reply-To: <cover.1390836773.git.jsarha@ti.com>
References: <cover.1390836773.git.jsarha@ti.com>
Message-ID: <27d041ee149081cd9b401939d4382e73fba5e7a5.1390836773.git.jsarha@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make BCLK divider setting implicite in hw_params call if McASP device
is the bit clock master on the audio serial bus.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index b7858bf..ae328be 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -53,6 +53,9 @@ struct davinci_mcasp {
 	u16	bclk_lrclk_ratio;
 	int	streams;
 
+	int	sysclk_freq;
+	bool	bclk_master;
+
 	/* McASP FIFO related */
 	u8	txnumevt;
 	u8	rxnumevt;
@@ -292,6 +295,7 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, ACLKX | ACLKR);
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AFSX | AFSR);
+		mcasp->bclk_master = 1;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFS:
 		/* codec is clock master and frame slave */
@@ -303,6 +307,7 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG, ACLKX | ACLKR);
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AFSX | AFSR);
+		mcasp->bclk_master = 0;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
 		/* codec is clock and frame master */
@@ -314,6 +319,7 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG,
 			       ACLKX | AHCLKX | AFSX | ACLKR | AHCLKR | AFSR);
+		mcasp->bclk_master = 0;
 		break;
 
 	default:
@@ -405,6 +411,8 @@ static int davinci_mcasp_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AHCLKX);
 	}
 
+	mcasp->sysclk_freq = freq;
+
 	return 0;
 }
 
@@ -607,6 +615,18 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 	int channels;
 	struct snd_interval *pcm_channels = hw_param_interval(params,
 					SNDRV_PCM_HW_PARAM_CHANNELS);
+
+	/* If mcasp is BCLK master we need to set BCLK divider */
+	if (mcasp->bclk_master) {
+		unsigned int bclk_freq = snd_soc_params_to_bclk(params);
+		if (mcasp->sysclk_freq % bclk_freq != 0) {
+			dev_err(mcasp->dev, "Can't produce requred BCLK\n");
+			return -EINVAL;
+		}
+		davinci_mcasp_set_clkdiv(
+			cpu_dai, 1, mcasp->sysclk_freq / bclk_freq);
+	}
+
 	channels = pcm_channels->min;
 
 	active_serializers = (channels + slots - 1) / slots;
-- 
1.7.9.5
