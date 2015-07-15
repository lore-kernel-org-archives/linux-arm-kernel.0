From: zhengxing@rock-chips.com (Xing Zheng)
Date: Wed, 15 Jul 2015 11:15:42 +0800
Subject: [PATCH 1/2] ASoC: rockchip: Add machine driver for max98090 codec
In-Reply-To: <1436930143-31361-1-git-send-email-zhengxing@rock-chips.com>
References: <1436930143-31361-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1436930143-31361-2-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: zhengxing <zhengxing@rock-chips.com>

The driver is used for rockchip board using a max98090.

Reviewed-by: Dylan Reid <dgreid@chromium.org>
Signed-off-by: zhengxing <zhengxing@rock-chips.com>
---

 sound/soc/rockchip/Kconfig             |   10 ++
 sound/soc/rockchip/Makefile            |    4 +
 sound/soc/rockchip/rockchip_max98090.c |  246 ++++++++++++++++++++++++++++++++
 3 files changed, 260 insertions(+)
 create mode 100644 sound/soc/rockchip/rockchip_max98090.c

diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
index e181826..d123566 100644
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -14,3 +14,13 @@ config SND_SOC_ROCKCHIP_I2S
 	  Say Y or M if you want to add support for I2S driver for
 	  Rockchip I2S device. The device supports upto maximum of
 	  8 channels each for play and record.
+
+config SND_SOC_ROCKCHIP_MAX98090
+	tristate "ASoC support for Rockchip boards using a MAX98090 codec"
+	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB
+	select SND_SOC_ROCKCHIP_I2S
+	select SND_SOC_MAX98090
+	select SND_SOC_TS3A227E
+	help
+	  Say Y or M here if you want to add support for SoC audio on Rockchip
+	  boards using the MAX98090 codec, such as Veyron.
diff --git a/sound/soc/rockchip/Makefile b/sound/soc/rockchip/Makefile
index b921909..df3445b 100644
--- a/sound/soc/rockchip/Makefile
+++ b/sound/soc/rockchip/Makefile
@@ -2,3 +2,7 @@
 snd-soc-i2s-objs := rockchip_i2s.o
 
 obj-$(CONFIG_SND_SOC_ROCKCHIP_I2S) += snd-soc-i2s.o
+
+snd-soc-rockchip-max98090-objs := rockchip_max98090.o
+
+obj-$(CONFIG_SND_SOC_ROCKCHIP_MAX98090) += snd-soc-rockchip-max98090.o
diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
new file mode 100644
index 0000000..dcdce06
--- /dev/null
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -0,0 +1,246 @@
+/*
+ * Rockchip machine ASoC driver for boards using a MAX90809 CODEC.
+ *
+ * Copyright (c) 2014, ROCKCHIP CORPORATION.  All rights reserved.
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
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
+#include <sound/core.h>
+#include <sound/jack.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include "rockchip_i2s.h"
+#include "../codecs/ts3a227e.h"
+
+#define DRV_NAME "rockchip-snd-max98090"
+
+static struct snd_soc_jack headset_jack;
+static struct snd_soc_jack_pin headset_jack_pins[] = {
+	{
+		.pin = "Headset Jack",
+		.mask = SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
+			SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+			SND_JACK_BTN_2 | SND_JACK_BTN_3,
+	},
+};
+
+static const struct snd_soc_dapm_widget rk_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Int Mic", NULL),
+	SND_SOC_DAPM_SPK("Speaker", NULL),
+};
+
+static const struct snd_soc_dapm_route rk_audio_map[] = {
+	{"IN34", NULL, "Headset Mic"},
+	{"IN34", NULL, "MICBIAS"},
+	{"MICBIAS", NULL, "Headset Mic"},
+	{"DMICL", NULL, "Int Mic"},
+	{"Headphone", NULL, "HPL"},
+	{"Headphone", NULL, "HPR"},
+	{"Speaker", NULL, "SPKL"},
+	{"Speaker", NULL, "SPKR"},
+};
+
+static const struct snd_kcontrol_new rk_mc_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Int Mic"),
+	SOC_DAPM_PIN_SWITCH("Speaker"),
+};
+
+static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params)
+{
+	int ret = 0;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int mclk;
+
+	switch (params_rate(params)) {
+	case 8000:
+	case 16000:
+	case 48000:
+	case 96000:
+		mclk = 12288000;
+		break;
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
+		dev_err(codec_dai->dev, "Can't set codec clock %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(codec_dai->dev, "Can't set codec clock %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int rk_init(struct snd_soc_pcm_runtime *runtime)
+{
+	struct snd_soc_card *card = runtime->card;
+
+	card->dapm.idle_bias_off = true;
+
+	/* Enable Headset and 4 Buttons Jack detection */
+	return snd_soc_card_jack_new(card, "Headset Jack",
+			       SND_JACK_HEADSET |
+			       SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+			       SND_JACK_BTN_2 | SND_JACK_BTN_3,
+			       &headset_jack,
+			       headset_jack_pins,
+			       ARRAY_SIZE(headset_jack_pins));
+}
+
+static int rk_98090_headset_init(struct snd_soc_component *component)
+{
+	return ts3a227e_enable_jack_detect(component, &headset_jack);
+}
+
+static struct snd_soc_ops rk_aif1_ops = {
+	.hw_params = rk_aif1_hw_params,
+};
+
+static struct snd_soc_aux_dev rk_98090_headset_dev = {
+	.name = "Headset Chip",
+	.init = rk_98090_headset_init,
+};
+
+static struct snd_soc_dai_link rk_dailink = {
+	.name = "max98090",
+	.stream_name = "Audio",
+	.codec_dai_name = "HiFi",
+	.init = rk_init,
+	.ops = &rk_aif1_ops,
+	/* set max98090 as slave */
+	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+		SND_SOC_DAIFMT_CBS_CFS,
+};
+
+static struct snd_soc_card snd_soc_card_rk = {
+	.name = "ROCKCHIP-I2S",
+	.dai_link = &rk_dailink,
+	.num_links = 1,
+	.aux_dev = &rk_98090_headset_dev,
+	.num_aux_devs = 1,
+	.dapm_widgets = rk_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(rk_dapm_widgets),
+	.dapm_routes = rk_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(rk_audio_map),
+	.controls = rk_mc_controls,
+	.num_controls = ARRAY_SIZE(rk_mc_controls),
+};
+
+static int snd_rk_mc_probe(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct snd_soc_card *card = &snd_soc_card_rk;
+	struct device_node *np = pdev->dev.of_node;
+
+	/* register the soc card */
+	card->dev = &pdev->dev;
+	platform_set_drvdata(pdev, card);
+
+	rk_dailink.codec_of_node = of_parse_phandle(np,
+			"rockchip,audio-codec", 0);
+	if (!rk_dailink.codec_of_node) {
+		dev_err(&pdev->dev,
+			"Property 'rockchip,audio-codec' missing or invalid\n");
+		return -EINVAL;
+	}
+
+	rk_dailink.cpu_of_node = of_parse_phandle(np,
+			"rockchip,i2s-controller", 0);
+	if (!rk_dailink.cpu_of_node) {
+		dev_err(&pdev->dev,
+			"Property 'rockchip,i2s-controller' missing or invalid\n");
+		return -EINVAL;
+	}
+
+	rk_dailink.platform_of_node = rk_dailink.cpu_of_node;
+
+	rk_98090_headset_dev.codec_of_node = of_parse_phandle(np,
+			"rockchip,headset-codec", 0);
+	if (!rk_98090_headset_dev.codec_of_node) {
+		dev_err(&pdev->dev,
+			"Property 'rockchip,headset-codec' missing/invalid\n");
+		return -EINVAL;
+	}
+
+	ret = snd_soc_register_card(card);
+	if (ret) {
+		pr_err("snd_soc_register_card failed %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_of_parse_card_name(card, "rockchip,model");
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+static int snd_rk_mc_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *soc_card = platform_get_drvdata(pdev);
+
+	snd_soc_card_set_drvdata(soc_card, NULL);
+	snd_soc_unregister_card(soc_card);
+	platform_set_drvdata(pdev, NULL);
+	return 0;
+}
+
+static const struct of_device_id rockchip_max98090_of_match[] = {
+	{ .compatible = "rockchip,rockchip-audio-max98090", },
+	{},
+};
+
+static struct platform_driver snd_rk_mc_driver = {
+	.probe = snd_rk_mc_probe,
+	.remove = snd_rk_mc_remove,
+	.driver = {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+		.pm = &snd_soc_pm_ops,
+		.of_match_table = rockchip_max98090_of_match,
+	},
+};
+
+module_platform_driver(snd_rk_mc_driver);
+MODULE_AUTHOR("jianqun <jay.xu@rock-chips.com>");
+MODULE_DESCRIPTION("Rockchip max98090 machine ASoC driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_DEVICE_TABLE(of, rockchip_max98090_of_match);
-- 
1.7.9.5
