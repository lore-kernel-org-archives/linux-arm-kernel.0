From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue,  4 Jul 2017 13:59:26 +0200
Subject: [PATCH v2 8/9] ASoC: atmel-classd: remove aclk clock
In-Reply-To: <20170704115927.32662-1-quentin.schulz@free-electrons.com>
References: <20170704115927.32662-1-quentin.schulz@free-electrons.com>
Message-ID: <20170704115927.32662-9-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since gclk (generated-clk) is now able to determine the rate of the
audio_pll, there is no need for classd to have a direct phandle to the
audio_pll while already having a phandle to gclk.

Thus, remove all mentions to aclk in classd driver and update macros and
variable names.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

added in v2:
  - split from bigger patch with audio PLLs and DT binding,
  - updated all variables and macros named ACLK to GCLK,

 sound/soc/atmel/atmel-classd.c | 47 +++++++++++++-----------------------------
 1 file changed, 14 insertions(+), 33 deletions(-)

diff --git a/sound/soc/atmel/atmel-classd.c b/sound/soc/atmel/atmel-classd.c
index b7ef8c59b49a..be6b775b6f46 100644
--- a/sound/soc/atmel/atmel-classd.c
+++ b/sound/soc/atmel/atmel-classd.c
@@ -32,7 +32,6 @@ struct atmel_classd {
 	struct regmap *regmap;
 	struct clk *pclk;
 	struct clk *gclk;
-	struct clk *aclk;
 	int irq;
 	const struct atmel_classd_pdata *pdata;
 };
@@ -330,11 +329,6 @@ static int atmel_classd_codec_dai_startup(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct atmel_classd *dd = snd_soc_card_get_drvdata(rtd->card);
-	int ret;
-
-	ret = clk_prepare_enable(dd->aclk);
-	if (ret)
-		return ret;
 
 	return clk_prepare_enable(dd->gclk);
 }
@@ -357,31 +351,31 @@ static int atmel_classd_codec_dai_digital_mute(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
-#define CLASSD_ACLK_RATE_11M2896_MPY_8 (112896 * 100 * 8)
-#define CLASSD_ACLK_RATE_12M288_MPY_8  (12288 * 1000 * 8)
+#define CLASSD_GCLK_RATE_11M2896_MPY_8 (112896 * 100 * 8)
+#define CLASSD_GCLK_RATE_12M288_MPY_8  (12288 * 1000 * 8)
 
 static struct {
 	int rate;
 	int sample_rate;
 	int dsp_clk;
-	unsigned long aclk_rate;
+	unsigned long gclk_rate;
 } const sample_rates[] = {
 	{ 8000,  CLASSD_INTPMR_FRAME_8K,
-	CLASSD_INTPMR_DSP_CLK_FREQ_12M288, CLASSD_ACLK_RATE_12M288_MPY_8 },
+	CLASSD_INTPMR_DSP_CLK_FREQ_12M288, CLASSD_GCLK_RATE_12M288_MPY_8 },
 	{ 16000, CLASSD_INTPMR_FRAME_16K,
-	CLASSD_INTPMR_DSP_CLK_FREQ_12M288, CLASSD_ACLK_RATE_12M288_MPY_8 },
+	CLASSD_INTPMR_DSP_CLK_FREQ_12M288, CLASSD_GCLK_RATE_12M288_MPY_8 },
 	{ 32000, CLASSD_INTPMR_FRAME_32K,
-	CLASSD_INTPMR_DSP_CLK_FREQ_12M288, CLASSD_ACLK_RATE_12M288_MPY_8 },
+	CLASSD_INTPMR_DSP_CLK_FREQ_12M288, CLASSD_GCLK_RATE_12M288_MPY_8 },
 	{ 48000, CLASSD_INTPMR_FRAME_48K,
-	CLASSD_INTPMR_DSP_CLK_FREQ_12M288, CLASSD_ACLK_RATE_12M288_MPY_8 },
+	CLASSD_INTPMR_DSP_CLK_FREQ_12M288, CLASSD_GCLK_RATE_12M288_MPY_8 },
 	{ 96000, CLASSD_INTPMR_FRAME_96K,
-	CLASSD_INTPMR_DSP_CLK_FREQ_12M288, CLASSD_ACLK_RATE_12M288_MPY_8 },
+	CLASSD_INTPMR_DSP_CLK_FREQ_12M288, CLASSD_GCLK_RATE_12M288_MPY_8 },
 	{ 22050, CLASSD_INTPMR_FRAME_22K,
-	CLASSD_INTPMR_DSP_CLK_FREQ_11M2896, CLASSD_ACLK_RATE_11M2896_MPY_8 },
+	CLASSD_INTPMR_DSP_CLK_FREQ_11M2896, CLASSD_GCLK_RATE_11M2896_MPY_8 },
 	{ 44100, CLASSD_INTPMR_FRAME_44K,
-	CLASSD_INTPMR_DSP_CLK_FREQ_11M2896, CLASSD_ACLK_RATE_11M2896_MPY_8 },
+	CLASSD_INTPMR_DSP_CLK_FREQ_11M2896, CLASSD_GCLK_RATE_11M2896_MPY_8 },
 	{ 88200, CLASSD_INTPMR_FRAME_88K,
-	CLASSD_INTPMR_DSP_CLK_FREQ_11M2896, CLASSD_ACLK_RATE_11M2896_MPY_8 },
+	CLASSD_INTPMR_DSP_CLK_FREQ_11M2896, CLASSD_GCLK_RATE_11M2896_MPY_8 },
 };
 
 static int
@@ -410,13 +404,12 @@ atmel_classd_codec_dai_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	dev_dbg(codec->dev,
-		"Selected SAMPLE_RATE of %dHz, ACLK_RATE of %ldHz\n",
-		sample_rates[best].rate, sample_rates[best].aclk_rate);
+		"Selected SAMPLE_RATE of %dHz, GCLK_RATE of %ldHz\n",
+		sample_rates[best].rate, sample_rates[best].gclk_rate);
 
 	clk_disable_unprepare(dd->gclk);
-	clk_disable_unprepare(dd->aclk);
 
-	ret = clk_set_rate(dd->aclk, sample_rates[best].aclk_rate);
+	ret = clk_set_rate(dd->gclk, sample_rates[best].gclk_rate);
 	if (ret)
 		return ret;
 
@@ -426,10 +419,6 @@ atmel_classd_codec_dai_hw_params(struct snd_pcm_substream *substream,
 
 	snd_soc_update_bits(codec, CLASSD_INTPMR, mask, val);
 
-	ret = clk_prepare_enable(dd->aclk);
-	if (ret)
-		return ret;
-
 	return clk_prepare_enable(dd->gclk);
 }
 
@@ -441,7 +430,6 @@ atmel_classd_codec_dai_shutdown(struct snd_pcm_substream *substream,
 	struct atmel_classd *dd = snd_soc_card_get_drvdata(rtd->card);
 
 	clk_disable_unprepare(dd->gclk);
-	clk_disable_unprepare(dd->aclk);
 }
 
 static int atmel_classd_codec_dai_prepare(struct snd_pcm_substream *substream,
@@ -596,13 +584,6 @@ static int atmel_classd_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	dd->aclk = devm_clk_get(dev, "aclk");
-	if (IS_ERR(dd->aclk)) {
-		ret = PTR_ERR(dd->aclk);
-		dev_err(dev, "failed to get audio clock: %d\n", ret);
-		return ret;
-	}
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	io_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(io_base)) {
-- 
2.11.0
