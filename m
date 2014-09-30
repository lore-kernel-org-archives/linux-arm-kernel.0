From: drake@endlessm.com (Daniel Drake)
Date: Tue, 30 Sep 2014 10:40:11 -0600
Subject: [PATCH] ASoC: samsung: fix CDCLK handling
Message-ID: <1412095211-4012-1-git-send-email-drake@endlessm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ODROID is the only platform that uses CDCLK, and right now,
CDCLK handling is buggy. If you start pulseaudio on ODROID,
audio is broken until reboot (even after killing pulse).

This happens because CDCLK gets disabled by i2s.c and never enabled again.

pulseaudio does:
1. i2s_startup for playback channel
2. i2s_startup for capture channel
3. i2s_shutdown for capture channel
4. i2s_shutdown for playback channel

In step 3 we disable CDCLK even though playback should still be active.

In step 4 we do this:
	u32 mod = readl(i2s->addr + I2SMOD);
	i2s->cdclk_out = !(mod & MOD_CDCLKCON);

and now cdclk_out is always going to be 0, so we'll never turn it back
on again.

Both this bug and the one that b97c60abf9a tries to fix happened
because of the way that CDCLK handling is painfully split between
platform and i2s drivers.

Simplify the situation and solve the bug with the following approach:
 - as before, samsung_i2s_dai_probe() gates CDCLK by default
   (no need for smartq_wm8987 to do this as well)
 - platform drivers can gate/ungate CDCLK as necessary
   (currently only odroidx2 needs to do this)
 - i2s code has no other interaction with CDCLK

Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 sound/soc/samsung/i2s.c               | 19 ++----------------
 sound/soc/samsung/odroidx2_max98090.c | 36 ++++++++++++++++++++++++++---------
 sound/soc/samsung/smartq_wm8987.c     |  6 ------
 3 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 9d51347..6654ce6 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -68,8 +68,6 @@ struct i2s_dai {
 #define DAI_OPENED	(1 << 0) /* Dai is opened */
 #define DAI_MANAGER	(1 << 1) /* Dai is the manager */
 	unsigned mode;
-	/* CDCLK pin direction: 0  - input, 1 - output */
-	unsigned int cdclk_out:1;
 	/* Driver for this DAI */
 	struct snd_soc_dai_driver i2s_dai_drv;
 	/* DMA parameters */
@@ -739,9 +737,6 @@ static int i2s_startup(struct snd_pcm_substream *substream,
 
 	spin_unlock_irqrestore(&lock, flags);
 
-	if (!is_opened(other) && i2s->cdclk_out)
-		i2s_set_sysclk(dai, SAMSUNG_I2S_CDCLK,
-				0, SND_SOC_CLOCK_OUT);
 	return 0;
 }
 
@@ -757,24 +752,14 @@ static void i2s_shutdown(struct snd_pcm_substream *substream,
 	i2s->mode &= ~DAI_OPENED;
 	i2s->mode &= ~DAI_MANAGER;
 
-	if (is_opened(other)) {
+	if (is_opened(other))
 		other->mode |= DAI_MANAGER;
-	} else {
-		u32 mod = readl(i2s->addr + I2SMOD);
-		i2s->cdclk_out = !(mod & MOD_CDCLKCON);
-		if (other)
-			other->cdclk_out = i2s->cdclk_out;
-	}
+
 	/* Reset any constraint on RFS and BFS */
 	i2s->rfs = 0;
 	i2s->bfs = 0;
 
 	spin_unlock_irqrestore(&lock, flags);
-
-	/* Gate CDCLK by default */
-	if (!is_opened(other))
-		i2s_set_sysclk(dai, SAMSUNG_I2S_CDCLK,
-				0, SND_SOC_CLOCK_IN);
 }
 
 static int config_setup(struct i2s_dai *i2s)
diff --git a/sound/soc/samsung/odroidx2_max98090.c b/sound/soc/samsung/odroidx2_max98090.c
index 278edf9..b700284 100644
--- a/sound/soc/samsung/odroidx2_max98090.c
+++ b/sound/soc/samsung/odroidx2_max98090.c
@@ -21,20 +21,37 @@ struct odroidx2_drv_data {
 /* The I2S CDCLK output clock frequency for the MAX98090 codec */
 #define MAX98090_MCLK 19200000
 
+static int odroidx2_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+
+	if (rtd->cpu_dai->active)
+		return 0;
+
+	return snd_soc_dai_set_sysclk(rtd->cpu_dai, SAMSUNG_I2S_CDCLK,
+				      0, SND_SOC_CLOCK_OUT);
+}
+
+static void odroidx2_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+
+	if (!rtd->cpu_dai->active)
+		snd_soc_dai_set_sysclk(rtd->cpu_dai, SAMSUNG_I2S_CDCLK,
+				       0, SND_SOC_CLOCK_IN);
+}
+
+static const struct snd_soc_ops odroidx2_ops = {
+	.startup = odroidx2_startup,
+	.shutdown = odroidx2_shutdown,
+};
+
 static int odroidx2_late_probe(struct snd_soc_card *card)
 {
 	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
-	struct snd_soc_dai *cpu_dai = card->rtd[0].cpu_dai;
-	int ret;
 
-	ret = snd_soc_dai_set_sysclk(codec_dai, 0, MAX98090_MCLK,
+	return snd_soc_dai_set_sysclk(codec_dai, 0, MAX98090_MCLK,
 						SND_SOC_CLOCK_IN);
-	if (ret < 0)
-		return ret;
-
-	/* Set the cpu DAI configuration in order to use CDCLK */
-	return snd_soc_dai_set_sysclk(cpu_dai, SAMSUNG_I2S_CDCLK,
-					0, SND_SOC_CLOCK_OUT);
 }
 
 static const struct snd_soc_dapm_widget odroidx2_dapm_widgets[] = {
@@ -55,6 +72,7 @@ static struct snd_soc_dai_link odroidx2_dai[] = {
 		.codec_dai_name	= "HiFi",
 		.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 				  SND_SOC_DAIFMT_CBM_CFM,
+		.ops		= &odroidx2_ops,
 	}
 };
 
diff --git a/sound/soc/samsung/smartq_wm8987.c b/sound/soc/samsung/smartq_wm8987.c
index 9b0ffac..2b5e7c5 100644
--- a/sound/soc/samsung/smartq_wm8987.c
+++ b/sound/soc/samsung/smartq_wm8987.c
@@ -76,12 +76,6 @@ static int smartq_hifi_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	/* Gate the RCLK output on PAD */
-	ret = snd_soc_dai_set_sysclk(cpu_dai, SAMSUNG_I2S_CDCLK,
-					0, SND_SOC_CLOCK_IN);
-	if (ret < 0)
-		return ret;
-
 	/* set the codec system clock for DAC and ADC */
 	ret = snd_soc_dai_set_sysclk(codec_dai, WM8750_SYSCLK, clk,
 				     SND_SOC_CLOCK_IN);
-- 
1.9.1
