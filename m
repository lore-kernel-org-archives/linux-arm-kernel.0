From: peda@lysator.liu.se (Peter Rosin)
Date: Thu, 29 Jan 2015 22:33:26 +0100
Subject: [RFC PATCH] ASoC: atmel_ssc_dai: Allow more rates
Message-ID: <1422567206-24549-1-git-send-email-peda@lysator.liu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Rosin <peda@axentia.se>

When the SSC acts as BCK master, use a ratnum rule to limit
the rate instead of only doing the standard rates. When the SSC
acts as BCK slave, allow any BCK frequency up to within 500ppm
of the SSC master clock, possibly divided by 2, 3 or 6.

Put a cap at 384kHz. Who's /ever/ going to need more than that?

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/atmel/atmel_ssc_dai.c |   98 +++++++++++++++++++++++++++++++++++++--
 sound/soc/atmel/atmel_ssc_dai.h |    1 +
 2 files changed, 95 insertions(+), 4 deletions(-)


This patch depends on the patch I sent earlier that enables the
_CBS_CFS mode on the atmel SSC dai (1).

I'm unsure about the rate rules for reception on the TK pin when
outputting LRCLK and the rate rules for transmitting on the RK pin
when inputting LRCLK. The datasheet for "my" chip (SAMA5D31) doesn't
say anything about what rates are allowed when using the RK pin
for transmitting or the TK pin for receiving.

Another question I have is if these rate rules are the same across
all chips supported by this driver, or if there is need for some
amount of special casing? And what special casing if that is the
case?

The reason I'm digging around in this area is that I need support
for inputting a BCK of 16MHz on the TK pin during playback, i.e.
with the codec mastering BCK. And the only way I can get that is
to use _CBM_CFS. My SSC master clock is 66MHz, which means that
the max supported rate for _CBM_CFM is 11MHz, i.e. not enough.

This patch unlocks my use case, but I would like to correctly stop
rates that the SSC does not support in other use cases as well. I
simply do not have the hardware to fully test this myself.

An lastly, is it reasonable to deduct 500ppm to allow for some
clock skew? FYI, the 500ppm was pulled out of my hat...

Cheers,
Peter

(1) ASoC: atmel_ssc_dai: Support SND_SOC_DAIFMT_CBM_CFS on I2S
    https://lkml.org/lkml/2015/1/29/373

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index f55f3aab8bdd..11eab65c86c8 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -187,6 +187,76 @@ static irqreturn_t atmel_ssc_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int atmel_ssc_hw_rule_rate(struct snd_pcm_hw_params *params,
+				  struct snd_pcm_hw_rule *rule)
+{
+	struct atmel_ssc_info *ssc_p = rule->private;
+	struct ssc_device *ssc = ssc_p->ssc;
+	struct snd_interval *i = hw_param_interval(params, rule->var);
+	struct snd_interval t;
+	struct snd_ratnum r = {
+		.den_min = 1,
+		.den_max = 4095,
+		.den_step = 1,
+	};
+	unsigned int num = 0, den = 0;
+	int frame_size;
+	int mck_div = 2;
+	int ret;
+
+	frame_size = snd_soc_params_to_frame_size(params);
+	if (frame_size < 0)
+		return frame_size;
+
+	switch (ssc_p->daifmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFS:
+		if ((ssc_p->dir_mask & SSC_DIR_MASK_CAPTURE)
+		    && ssc->clk_from_rk_pin)
+			/* Receiver Frame Synchro is output on RK pin.
+			 * What rules are there when outputting on the TK pin?
+			 */
+			mck_div = 3;
+		break;
+
+	case SND_SOC_DAIFMT_CBM_CFM:
+		if ((ssc_p->dir_mask & SSC_DIR_MASK_PLAYBACK)
+		    && !ssc->clk_from_rk_pin)
+			/* Transmit Frame Synchro is input on TK pin.
+			 * What rules are there when inputting from the RK pin?
+			 */
+			mck_div = 6;
+		break;
+	}
+
+	switch (ssc_p->daifmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		r.num = ssc_p->mck_rate / mck_div / frame_size;
+
+		ret = snd_interval_ratnum(i, 1, &r, &num, &den);
+		if (ret >= 0 && den && rule->var == SNDRV_PCM_HW_PARAM_RATE) {
+			params->rate_num = num;
+			params->rate_den = den;
+		}
+		break;
+
+	case SND_SOC_DAIFMT_CBM_CFS:
+	case SND_SOC_DAIFMT_CBM_CFM:
+		t.min = 8000;
+		t.max = ssc_p->mck_rate / mck_div / frame_size;
+		/* Take away 500ppm, just to be on the safe side. */
+		t.max -= t.max / 2000;
+		t.openmin = t.openmax = 0;
+		t.integer = 0;
+		ret = snd_interval_refine(i, &t);
+		break;
+
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
 
 /*-------------------------------------------------------------------------*\
  * DAI functions
@@ -200,10 +270,17 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream,
 	struct atmel_ssc_info *ssc_p = &ssc_info[dai->id];
 	struct atmel_pcm_dma_params *dma_params;
 	int dir, dir_mask;
+	int ret;
 
 	pr_debug("atmel_ssc_startup: SSC_SR=0x%u\n",
 		ssc_readl(ssc_p->ssc->regs, SR));
 
+	if (!ssc_p->initialized)
+		clk_enable(ssc_p->ssc->clk);
+	ssc_p->mck_rate = clk_get_rate(ssc_p->ssc->clk) * 2;
+	if (!ssc_p->initialized)
+		clk_disable(ssc_p->ssc->clk);
+
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		dir = 0;
 		dir_mask = SSC_DIR_MASK_PLAYBACK;
@@ -212,6 +289,17 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream,
 		dir_mask = SSC_DIR_MASK_CAPTURE;
 	}
 
+	ret = snd_pcm_hw_rule_add(substream->runtime, 0,
+				  SNDRV_PCM_HW_PARAM_RATE,
+				  atmel_ssc_hw_rule_rate,
+				  ssc_p,
+				  SNDRV_PCM_HW_PARAM_FRAME_BITS,
+				  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+	if (ret < 0) {
+		dev_err(dai->dev, "Failed to specify rate rule: %d\n", ret);
+		return ret;
+	}
+
 	dma_params = &ssc_dma_params[dai->id][dir];
 	dma_params->ssc = ssc_p->ssc;
 	dma_params->substream = substream;
@@ -787,8 +875,6 @@ static int atmel_ssc_resume(struct snd_soc_dai *cpu_dai)
 #  define atmel_ssc_resume	NULL
 #endif /* CONFIG_PM */
 
-#define ATMEL_SSC_RATES (SNDRV_PCM_RATE_8000_96000)
-
 #define ATMEL_SSC_FORMATS (SNDRV_PCM_FMTBIT_S8     | SNDRV_PCM_FMTBIT_S16_LE |\
 			  SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
@@ -808,12 +894,16 @@ static struct snd_soc_dai_driver atmel_ssc_dai = {
 		.playback = {
 			.channels_min = 1,
 			.channels_max = 2,
-			.rates = ATMEL_SSC_RATES,
+			.rates = SNDRV_PCM_RATE_CONTINUOUS,
+			.rate_min = 8000,
+			.rate_max = 384000,
 			.formats = ATMEL_SSC_FORMATS,},
 		.capture = {
 			.channels_min = 1,
 			.channels_max = 2,
-			.rates = ATMEL_SSC_RATES,
+			.rates = SNDRV_PCM_RATE_CONTINUOUS,
+			.rate_min = 8000,
+			.rate_max = 384000,
 			.formats = ATMEL_SSC_FORMATS,},
 		.ops = &atmel_ssc_dai_ops,
 };
diff --git a/sound/soc/atmel/atmel_ssc_dai.h b/sound/soc/atmel/atmel_ssc_dai.h
index b1f08d511495..80b153857a88 100644
--- a/sound/soc/atmel/atmel_ssc_dai.h
+++ b/sound/soc/atmel/atmel_ssc_dai.h
@@ -115,6 +115,7 @@ struct atmel_ssc_info {
 	unsigned short rcmr_period;
 	struct atmel_pcm_dma_params *dma_params[2];
 	struct atmel_ssc_state ssc_state;
+	unsigned long mck_rate;
 };
 
 int atmel_ssc_set_audio(int ssc_id);
-- 
1.7.10.4
