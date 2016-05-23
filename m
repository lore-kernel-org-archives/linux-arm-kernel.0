From: zhengxing@rock-chips.com (Xing Zheng)
Date: Mon, 23 May 2016 11:11:48 +0800
Subject: [PATCH] ASoC: rockchip: Add machine driver for MAX98357A/RT5514/DA7219
Message-ID: <1463973108-8699-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are multi codec devices on the RK3399 platform, we can use
this patch support and control these codecs.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 .../sound/rockchip-max98357a-rt5514-da7219.txt     |   15 +
 sound/soc/rockchip/Kconfig                         |   11 +
 sound/soc/rockchip/Makefile                        |    2 +
 .../rockchip/rockchip_max98357a_rt5514_da7219.c    |  339 ++++++++++++++++++++
 4 files changed, 367 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip-max98357a-rt5514-da7219.txt
 create mode 100644 sound/soc/rockchip/rockchip_max98357a_rt5514_da7219.c

diff --git a/Documentation/devicetree/bindings/sound/rockchip-max98357a-rt5514-da7219.txt b/Documentation/devicetree/bindings/sound/rockchip-max98357a-rt5514-da7219.txt
new file mode 100644
index 0000000..5928384
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rockchip-max98357a-rt5514-da7219.txt
@@ -0,0 +1,15 @@
+ROCKCHIP with MAX98357A/RT5514/DA7219 codecs
+
+Required properties:
+- compatible: "rockchip,rockchip-sound"
+- rockchip,cpu: The phandle of the Rockchip I2S controller that's
+  connected to the codecs
+- rockchip,codec: The phandle of the MAX98357A/RT5514/DA7219 codecs
+
+Example:
+
+sound {
+	compatible = "rockchip,rockchip-sound";
+	rockchip,cpu = <&i2s0 &i2s0 &i2s1>;
+	rockchip,codec = <&max98357a &headsetcodec &codec>;
+};
diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
index f1e0c70..d02aa94 100644
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -41,3 +41,14 @@ config SND_SOC_ROCKCHIP_RT5645
 	help
 	  Say Y or M here if you want to add support for SoC audio on Rockchip
 	  boards using the RT5645/RT5650 codec, such as Veyron.
+
+config SND_SOC_ROCKCHIP_MAX98357A_RT5514_DA7219
+	tristate "ASoC support for Rockchip boards using the MAX98357A/RT5514/DA7219"
+	depends on SND_SOC_ROCKCHIP && GPIOLIB
+	select SND_SOC_ROCKCHIP_I2S
+	select SND_SOC_MAX98357A
+	select SND_SOC_RT5514
+	select SND_SOC_DA7219
+	help
+	  Say Y or M here if you want to add support for SoC audio on Rockchip
+	  boards using the MAX98357A/RT5514/DA7219.
diff --git a/sound/soc/rockchip/Makefile b/sound/soc/rockchip/Makefile
index c0bf560..ca97489 100644
--- a/sound/soc/rockchip/Makefile
+++ b/sound/soc/rockchip/Makefile
@@ -7,6 +7,8 @@ obj-$(CONFIG_SND_SOC_ROCKCHIP_SPDIF) += snd-soc-rockchip-spdif.o
 
 snd-soc-rockchip-max98090-objs := rockchip_max98090.o
 snd-soc-rockchip-rt5645-objs := rockchip_rt5645.o
+snd-soc-rockchip-max98357a-rt5514-da7219-objs := rockchip_max98357a_rt5514_da7219.o
 
 obj-$(CONFIG_SND_SOC_ROCKCHIP_MAX98090) += snd-soc-rockchip-max98090.o
 obj-$(CONFIG_SND_SOC_ROCKCHIP_RT5645) += snd-soc-rockchip-rt5645.o
+obj-$(CONFIG_SND_SOC_ROCKCHIP_MAX98357A_RT5514_DA7219) += snd-soc-rockchip-max98357a-rt5514-da7219.o
diff --git a/sound/soc/rockchip/rockchip_max98357a_rt5514_da7219.c b/sound/soc/rockchip/rockchip_max98357a_rt5514_da7219.c
new file mode 100644
index 0000000..50c0d35
--- /dev/null
+++ b/sound/soc/rockchip/rockchip_max98357a_rt5514_da7219.c
@@ -0,0 +1,339 @@
+/*
+ * Rockchip machine ASoC driver for boards using MAX98357A/RT5514/DA7219
+ *
+ * Copyright (c) 2016, ROCKCHIP CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
+#include <linux/delay.h>
+#include <linux/spi/spi.h>
+#include <sound/core.h>
+#include <sound/jack.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include "rockchip_i2s.h"
+#include "../codecs/da7219.h"
+#include "../codecs/da7219-aad.h"
+#include "../codecs/rt5514.h"
+
+#define DRV_NAME "rockchip-sound"
+
+static struct snd_soc_jack rockchip_sound_jack;
+
+static const struct snd_soc_dapm_widget rockchip_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphones", NULL),
+	SND_SOC_DAPM_SPK("Speakers", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Int Mic", NULL),
+};
+
+static const struct snd_soc_dapm_route rockchip_dapm_routes[] = {
+	/* Input Lines */
+	{"MIC", NULL, "Headset Mic"},
+	{"DMIC1L", NULL, "Int Mic"},
+	{"DMIC1R", NULL, "Int Mic"},
+
+	/* Output Lines */
+	{"Headphones", NULL, "HPL"},
+	{"Headphones", NULL, "HPR"},
+	{"Speakers", NULL, "Speakers"},
+};
+
+static const struct snd_kcontrol_new rockchip_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphones"),
+	SOC_DAPM_PIN_SWITCH("Speakers"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Int Mic"),
+};
+
+static int rockchip_sound_max98357a_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dapm_context *dapm = &rtd->card->dapm;
+	unsigned int mclk;
+	int ret;
+
+	switch (params_rate(params)) {
+	case 8000:
+	case 16000:
+	case 48000:
+	case 96000:
+		mclk = 12288000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = snd_soc_dai_set_sysclk(rtd->cpu_dai, 0, mclk, 0);
+	if (ret) {
+		dev_err(rtd->card->dev, "%s() error setting sysclk to %u: %d\n",
+				__func__, mclk, ret);
+		return ret;
+	}
+
+	snd_soc_dapm_disable_pin(dapm, "Headphones");
+	snd_soc_dapm_enable_pin(dapm, "Speakers");
+	snd_soc_dapm_sync(dapm);
+
+	return 0;
+}
+
+static int rockchip_sound_rt5514_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	unsigned int mclk;
+	int ret;
+
+	switch (params_rate(params)) {
+	case 8000:
+	case 16000:
+	case 32000:
+	case 48000:
+	case 96000:
+		mclk = 12288000;
+		break;
+	case 11025:
+	case 22050:
+	case 44100:
+		mclk = 11289600;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = snd_soc_dai_set_sysclk(cpu_dai, 0, mclk,
+				     SND_SOC_CLOCK_OUT);
+	if (ret < 0) {
+		dev_err(rtd->card->dev, "Can't set cpu clock out %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, RT5514_SCLK_S_MCLK,
+				     mclk, SND_SOC_CLOCK_IN);
+	if (ret) {
+		dev_err(rtd->card->dev, "%s() error setting sysclk to %u: %d\n",
+				__func__, params_rate(params) * 512, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rockchip_sound_da7219_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dapm_context *dapm = &rtd->card->dapm;
+	int mclk, ret;
+
+	switch (params_rate(params)) {
+	case 8000:
+	case 16000:
+	case 32000:
+	case 48000:
+	case 96000:
+		mclk = 12288000;
+		break;
+	case 11025:
+	case 22050:
+	case 44100:
+		mclk = 11289600;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = snd_soc_dai_set_sysclk(cpu_dai, 0, mclk,
+				     SND_SOC_CLOCK_OUT);
+	if (ret < 0) {
+		dev_err(codec_dai->dev, "Can't set cpu clock out %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(codec_dai->dev, "Can't set codec clock in %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_pll(codec_dai, 0, DA7219_SYSCLK_MCLK, 0, 0);
+	if (ret < 0) {
+		dev_err(codec_dai->dev, "Can't set pll sysclk mclk %d\n", ret);
+		return ret;
+	}
+
+	snd_soc_dapm_disable_pin(dapm, "Speakers");
+	snd_soc_dapm_enable_pin(dapm, "Headphones");
+	snd_soc_dapm_sync(dapm);
+
+	return 0;
+}
+
+static int rockchip_sound_da7219_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec_dais[0]->codec;
+	int ret;
+
+	/* Enable Headset and 4 Buttons Jack detection */
+	ret = snd_soc_card_jack_new(rtd->card, "Headset Jack",
+				    SND_JACK_HEADSET |
+				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
+				    &rockchip_sound_jack, NULL, 0);
+
+	if (ret) {
+		dev_err(rtd->card->dev, "New Headset Jack failed! (%d)\n", ret);
+		return ret;
+	}
+
+	da7219_aad_jack_det(codec, &rockchip_sound_jack);
+
+	return 0;
+}
+
+static struct snd_soc_ops rockchip_sound_max98357a_ops = {
+	.hw_params = rockchip_sound_max98357a_hw_params,
+};
+
+static struct snd_soc_ops rockchip_sound_rt5514_ops = {
+	.hw_params = rockchip_sound_rt5514_hw_params,
+};
+
+static struct snd_soc_ops rockchip_sound_da7219_ops = {
+	.hw_params = rockchip_sound_da7219_hw_params,
+};
+
+enum {
+	DAILINK_MAX98357A,
+	DAILINK_RT5514,
+	DAILINK_DA7219,
+};
+
+static struct snd_soc_dai_link rockchip_dailinks[] = {
+	[DAILINK_MAX98357A] = {
+		.name = "MAX98357A",
+		.stream_name = "MAX98357A PCM",
+		.codec_dai_name = "HiFi",
+		.ops = &rockchip_sound_max98357a_ops,
+		/* set max98357a as slave */
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS,
+	},
+	[DAILINK_RT5514] = {
+		.name = "RT5514",
+		.stream_name = "RT5514 PCM",
+		.codec_dai_name = "rt5514-aif1",
+		.ops = &rockchip_sound_rt5514_ops,
+		/* set rt5514 as slave */
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS,
+	},
+	[DAILINK_DA7219] = {
+		.name = "DA7219",
+		.stream_name = "DA7219 PCM",
+		.codec_dai_name = "da7219-hifi",
+		.init = rockchip_sound_da7219_init,
+		.ops = &rockchip_sound_da7219_ops,
+		/* set da7219 as slave */
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS,
+	},
+};
+
+static struct snd_soc_card rockchip_sound_card = {
+	.name = "rockchip-sound",
+	.owner = THIS_MODULE,
+	.dai_link = rockchip_dailinks,
+	.num_links =  ARRAY_SIZE(rockchip_dailinks),
+	.dapm_widgets = rockchip_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(rockchip_dapm_widgets),
+	.dapm_routes = rockchip_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(rockchip_dapm_routes),
+	.controls = rockchip_controls,
+	.num_controls = ARRAY_SIZE(rockchip_controls),
+};
+
+static int rockchip_sound_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &rockchip_sound_card;
+	struct device_node *cpu_node;
+	int i, ret;
+
+	for (i = 0; i < card->num_links; i++) {
+		cpu_node = of_parse_phandle(pdev->dev.of_node,
+					 "rockchip,cpu", i);
+		if (!cpu_node) {
+			dev_err(&pdev->dev, "Property[%d] 'rockchip,cpu' missing or invalid\n", i);
+			return -EINVAL;
+		}
+
+		rockchip_dailinks[i].platform_of_node = cpu_node;
+		rockchip_dailinks[i].cpu_of_node = cpu_node;
+
+		rockchip_dailinks[i].codec_of_node =
+			of_parse_phandle(pdev->dev.of_node, "rockchip,codec", i);
+		if (!rockchip_dailinks[i].codec_of_node) {
+			dev_err(&pdev->dev,
+				"Property[%d] 'rockchip,codec' missing or invalid\n", i);
+			return -EINVAL;
+		}
+	}
+
+	card->dev = &pdev->dev;
+	platform_set_drvdata(pdev, card);
+
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
+	if (ret)
+		dev_err(&pdev->dev, "%s snd_soc_register_card fail %d\n",
+			__func__, ret);
+
+	return ret;
+}
+
+static const struct of_device_id rockchip_sound_of_match[] = {
+	{ .compatible = "rockchip,rockchip-sound", },
+	{},
+};
+
+static struct platform_driver rockchip_sound_driver = {
+	.probe = rockchip_sound_probe,
+	.driver = {
+		.name = DRV_NAME,
+		.of_match_table = rockchip_sound_of_match,
+#ifdef CONFIG_PM
+		.pm = &snd_soc_pm_ops,
+#endif
+	},
+};
+
+module_platform_driver(rockchip_sound_driver);
+
+MODULE_AUTHOR("Xing Zheng <zhengxing@rock-chips.com>");
+MODULE_DESCRIPTION("Rockchip ASoC Machine Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_DEVICE_TABLE(of, rockchip_sound_of_match);
-- 
1.7.9.5
