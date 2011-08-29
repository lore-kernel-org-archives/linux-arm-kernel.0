From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 29 Aug 2011 17:15:14 +0800
Subject: [RFC v2 PATCH 1/1] ASoC: soc-core: symmetry checking for each DAIs
	separately
Message-ID: <1314609314-22162-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The orginal code does not cover the case that one DAI such as codec
may be shared between other two DAIs(CPU).
When do symmetry checking, altough the codec DAI requires symmetry,
the two CPU DAIs may still be configured to run on different rates.

We change to check each DAI's state separately instead of only checking
the dai link to prevent this issue.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
Change since v1:
 Address the comments from Lars-Peter Clausen.
 * add the dai as an parameter for soc_pcm_apply_symmetry
 Thanks for the suggestion.

---
 include/sound/soc-dai.h |    3 +++
 include/sound/soc.h     |    2 --
 sound/soc/soc-pcm.c     |   40 +++++++++++++++++++++++++---------------
 3 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 5ad5f3a..12d98b4 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -242,6 +242,9 @@ struct snd_soc_dai {
 	void *playback_dma_data;
 	void *capture_dma_data;
 
+	/* Symmetry data - only valid if symmetry is being enforced */
+	unsigned int rate;
+
 	/* parent platform/codec */
 	union {
 		struct snd_soc_platform *platform;
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 3fe658e..5449139 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -849,8 +849,6 @@ struct snd_soc_pcm_runtime  {
 	unsigned int complete:1;
 	unsigned int dev_registered:1;
 
-	/* Symmetry data - only valid if symmetry is being enforced */
-	unsigned int rate;
 	long pmdown_time;
 
 	/* runtime devices */
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 1aee9fc..8eb0f07 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -27,15 +27,13 @@
 #include <sound/soc.h>
 #include <sound/initval.h>
 
-static int soc_pcm_apply_symmetry(struct snd_pcm_substream *substream)
+static int soc_pcm_apply_symmetry(struct snd_pcm_substream *substream,
+					struct snd_soc_dai *soc_dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	int ret;
 
-	if (!codec_dai->driver->symmetric_rates &&
-	    !cpu_dai->driver->symmetric_rates &&
+	if (!soc_dai->driver->symmetric_rates &&
 	    !rtd->dai_link->symmetric_rates)
 		return 0;
 
@@ -43,19 +41,19 @@ static int soc_pcm_apply_symmetry(struct snd_pcm_substream *substream)
 	 * the second can need to get its constraints before the first has
 	 * picked a rate.  Complain and allow the application to carry on.
 	 */
-	if (!rtd->rate) {
-		dev_warn(&rtd->dev,
+	if (!soc_dai->rate) {
+		dev_warn(soc_dai->dev,
 			 "Not enforcing symmetric_rates due to race\n");
 		return 0;
 	}
 
-	dev_dbg(&rtd->dev, "Symmetry forces %dHz rate\n", rtd->rate);
+	dev_dbg(soc_dai->dev, "Symmetry forces %dHz rate\n", soc_dai->rate);
 
 	ret = snd_pcm_hw_constraint_minmax(substream->runtime,
 					   SNDRV_PCM_HW_PARAM_RATE,
-					   rtd->rate, rtd->rate);
+					   soc_dai->rate, soc_dai->rate);
 	if (ret < 0) {
-		dev_err(&rtd->dev,
+		dev_err(soc_dai->dev,
 			"Unable to apply rate symmetry constraint: %d\n", ret);
 		return ret;
 	}
@@ -185,8 +183,14 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	}
 
 	/* Symmetry only applies if we've already got an active stream. */
-	if (cpu_dai->active || codec_dai->active) {
-		ret = soc_pcm_apply_symmetry(substream);
+	if (cpu_dai->active) {
+		ret = soc_pcm_apply_symmetry(substream, cpu_dai);
+		if (ret != 0)
+			goto config_err;
+	}
+
+	if (codec_dai->active) {
+		ret = soc_pcm_apply_symmetry(substream, codec_dai);
 		if (ret != 0)
 			goto config_err;
 	}
@@ -288,8 +292,12 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 	codec_dai->active--;
 	codec->active--;
 
-	if (!cpu_dai->active && !codec_dai->active)
-		rtd->rate = 0;
+	/* clear the corresponding DAIs rate when inactive */
+	if (!cpu_dai->active)
+		cpu_dai->rate = 0;
+
+	if (!codec_dai->active)
+		codec_dai->rate = 0;
 
 	/* Muting the DAC suppresses artifacts caused during digital
 	 * shutdown, for example from stopping clocks.
@@ -447,7 +455,9 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 
-	rtd->rate = params_rate(params);
+	/* store the rate for each DAIs */
+	cpu_dai->rate = params_rate(params);
+	codec_dai->rate = params_rate(params);
 
 out:
 	mutex_unlock(&rtd->pcm_mutex);
-- 
1.7.0.4
