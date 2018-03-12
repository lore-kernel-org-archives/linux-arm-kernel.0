From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 12 Mar 2018 19:49:39 +0100
Subject: [PATCH v3 2/2] ASoC: samsung: Add HDMI audio support for Snow
In-Reply-To: <20180312184939.11327-1-s.nawrocki@samsung.com>
References: <20180312184939.11327-1-s.nawrocki@samsung.com>
 <CGME20180312185000epcas1p2ae13436139bee76311206ac3fd74267c@epcas1p2.samsung.com>
Message-ID: <20180312184939.11327-2-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the driver so, in addition to current DT bindings, it
also can also use the new DT bindings with cpu, codec subnodes which allow
to support sound on the HDMI interface.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v2:
 - dropped addition of UL postfix in the FIN_PLL_RATE constant
   definition from this patch,
 - edited summary line.

Changes since v1:
 - adjustments to changed order of codecs in codec/cpu-dai property,
 - fixed errors in snow_remove().
---
 sound/soc/samsung/snow.c | 224 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 177 insertions(+), 47 deletions(-)

diff --git a/sound/soc/samsung/snow.c b/sound/soc/samsung/snow.c
index fc62110f500f..5d8efc2d5c38 100644
--- a/sound/soc/samsung/snow.c
+++ b/sound/soc/samsung/snow.c
@@ -11,92 +11,207 @@
  * General Public License for more details.
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-
+#include <sound/pcm_params.h>
 #include <sound/soc.h>
 
 #include "i2s.h"
 
 #define FIN_PLL_RATE		24000000
 
-static struct snd_soc_dai_link snow_dai[] = {
-	{
-		.name = "Primary",
-		.stream_name = "Primary",
-		.codec_dai_name = "HiFi",
-		.dai_fmt = SND_SOC_DAIFMT_I2S |
-				SND_SOC_DAIFMT_NB_NF |
-				SND_SOC_DAIFMT_CBS_CFS,
-	},
+struct snow_priv {
+	struct snd_soc_dai_link dai_link;
+	struct clk *clk_i2s_bus;
+};
+
+static int snow_card_hw_params(struct snd_pcm_substream *substream,
+				      struct snd_pcm_hw_params *params)
+{
+	static const unsigned int pll_rate[] = {
+		73728000U, 67737602U, 49152000U, 45158401U, 32768001U
+	};
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snow_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	int bfs, psr, rfs, bitwidth;
+	unsigned long int rclk;
+	long int freq = -EINVAL;
+	int ret, i;
+
+	bitwidth = snd_pcm_format_width(params_format(params));
+	if (bitwidth < 0) {
+		dev_err(rtd->card->dev, "Invalid bit-width: %d\n", bitwidth);
+		return bitwidth;
+	}
+
+	if (bitwidth != 16 && bitwidth != 24) {
+		dev_err(rtd->card->dev, "Unsupported bit-width: %d\n", bitwidth);
+		return -EINVAL;
+	}
+
+	bfs = 2 * bitwidth;
+
+	switch (params_rate(params)) {
+	case 16000:
+	case 22050:
+	case 24000:
+	case 32000:
+	case 44100:
+	case 48000:
+	case 88200:
+	case 96000:
+		rfs = 8 * bfs;
+		break;
+	case 64000:
+		rfs = 384;
+		break;
+	case 8000:
+	case 11025:
+	case 12000:
+		rfs = 16 * bfs;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	rclk = params_rate(params) * rfs;
+
+	for (psr = 8; psr > 0; psr /= 2) {
+		for (i = 0; i < ARRAY_SIZE(pll_rate); i++) {
+			if ((pll_rate[i] - rclk * psr) <= 2) {
+				freq = pll_rate[i];
+				break;
+			}
+		}
+	}
+	if (freq < 0) {
+		dev_err(rtd->card->dev, "Unsupported RCLK rate: %lu\n", rclk);
+		return -EINVAL;
+	}
+
+	ret = clk_set_rate(priv->clk_i2s_bus, freq);
+	if (ret < 0) {
+		dev_err(rtd->card->dev, "I2S bus clock rate set failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_ops snow_card_ops = {
+	.hw_params = snow_card_hw_params,
 };
 
 static int snow_late_probe(struct snd_soc_card *card)
 {
 	struct snd_soc_pcm_runtime *rtd;
 	struct snd_soc_dai *codec_dai;
-	struct snd_soc_dai *cpu_dai;
-	int ret;
 
 	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
-	codec_dai = rtd->codec_dai;
-	cpu_dai = rtd->cpu_dai;
-
-	/* Set the MCLK rate for the codec */
-	ret = snd_soc_dai_set_sysclk(codec_dai, 0,
-					FIN_PLL_RATE, SND_SOC_CLOCK_IN);
-	if (ret < 0)
-		return ret;
 
+	/* In the multi-codec case codec_dais 0 is MAX98095 and 1 is HDMI. */
+	if (rtd->num_codecs > 1)
+		codec_dai = rtd->codec_dais[0];
+	else
+		codec_dai = rtd->codec_dai;
 
-	return 0;
+	/* Set the MCLK rate for the codec */
+	return snd_soc_dai_set_sysclk(codec_dai, 0,
+				FIN_PLL_RATE, SND_SOC_CLOCK_IN);
 }
 
 static struct snd_soc_card snow_snd = {
 	.name = "Snow-I2S",
 	.owner = THIS_MODULE,
-	.dai_link = snow_dai,
-	.num_links = ARRAY_SIZE(snow_dai),
-
 	.late_probe = snow_late_probe,
 };
 
 static int snow_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct snd_soc_card *card = &snow_snd;
-	struct device_node *i2s_node, *codec_node;
-	int i, ret;
-
-	i2s_node = of_parse_phandle(pdev->dev.of_node,
-				    "samsung,i2s-controller", 0);
-	if (!i2s_node) {
-		dev_err(&pdev->dev,
-			"Property 'i2s-controller' missing or invalid\n");
-		return -EINVAL;
-	}
+	struct device_node *cpu, *codec;
+	struct snd_soc_dai_link *link;
+	struct snow_priv *priv;
+	int ret;
 
-	codec_node = of_parse_phandle(pdev->dev.of_node,
-				      "samsung,audio-codec", 0);
-	if (!codec_node) {
-		dev_err(&pdev->dev,
-			"Property 'audio-codec' missing or invalid\n");
-		return -EINVAL;
-	}
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	link = &priv->dai_link;
+
+	link->dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS;
+
+	link->name = "Primary";
+	link->stream_name = link->name;
+
+	card->dai_link = link;
+	card->num_links = 1;
+	card->dev = dev;
+
+	/* Try new DT bindings with HDMI support first. */
+	cpu = of_get_child_by_name(dev->of_node, "cpu");
+
+	if (cpu) {
+		link->ops = &snow_card_ops;
 
-	for (i = 0; i < ARRAY_SIZE(snow_dai); i++) {
-		snow_dai[i].codec_of_node = codec_node;
-		snow_dai[i].cpu_of_node = i2s_node;
-		snow_dai[i].platform_of_node = i2s_node;
+		link->cpu_of_node = of_parse_phandle(cpu, "sound-dai", 0);
+		of_node_put(cpu);
+
+		if (!link->cpu_of_node) {
+			dev_err(dev, "Failed parsing cpu/sound-dai property\n");
+			return -EINVAL;
+		}
+
+		codec = of_get_child_by_name(dev->of_node, "codec");
+		ret = snd_soc_of_get_dai_link_codecs(dev, codec, link);
+		of_node_put(codec);
+
+		if (ret < 0) {
+			of_node_put(link->cpu_of_node);
+			dev_err(dev, "Failed parsing codec node\n");
+			return ret;
+		}
+
+		priv->clk_i2s_bus = of_clk_get_by_name(link->cpu_of_node,
+						       "i2s_opclk0");
+		if (IS_ERR(priv->clk_i2s_bus)) {
+			snd_soc_of_put_dai_link_codecs(link);
+			of_node_put(link->cpu_of_node);
+			return PTR_ERR(priv->clk_i2s_bus);
+		}
+	} else {
+		link->codec_dai_name = "HiFi",
+
+		link->cpu_of_node = of_parse_phandle(dev->of_node,
+						"samsung,i2s-controller", 0);
+		if (!link->cpu_of_node) {
+			dev_err(dev, "i2s-controller property parse error\n");
+			return -EINVAL;
+		}
+
+		link->codec_of_node = of_parse_phandle(dev->of_node,
+						"samsung,audio-codec", 0);
+		if (!link->codec_of_node) {
+			of_node_put(link->cpu_of_node);
+			dev_err(dev, "audio-codec property parse error\n");
+			return -EINVAL;
+		}
 	}
 
-	card->dev = &pdev->dev;
+	link->platform_of_node = link->cpu_of_node;
 
 	/* Update card-name if provided through DT, else use default name */
 	snd_soc_of_parse_card_name(card, "samsung,model");
 
-	ret = devm_snd_soc_register_card(&pdev->dev, card);
+	snd_soc_card_set_drvdata(card, priv);
+
+	ret = devm_snd_soc_register_card(dev, card);
 	if (ret) {
 		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
 		return ret;
@@ -105,6 +220,20 @@ static int snow_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int snow_remove(struct platform_device *pdev)
+{
+	struct snow_priv *priv = platform_get_drvdata(pdev);
+	struct snd_soc_dai_link *link = &priv->dai_link;
+
+	of_node_put(link->cpu_of_node);
+	of_node_put(link->codec_of_node);
+	snd_soc_of_put_dai_link_codecs(link);
+
+	clk_put(priv->clk_i2s_bus);
+
+	return 0;
+}
+
 static const struct of_device_id snow_of_match[] = {
 	{ .compatible = "google,snow-audio-max98090", },
 	{ .compatible = "google,snow-audio-max98091", },
@@ -120,6 +249,7 @@ static struct platform_driver snow_driver = {
 		.of_match_table = snow_of_match,
 	},
 	.probe = snow_probe,
+	.remove = snow_remove,
 };
 
 module_platform_driver(snow_driver);
-- 
2.14.2
