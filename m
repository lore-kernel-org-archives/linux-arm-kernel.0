From: zyw@rock-chips.com (Chris Zhong)
Date: Fri, 27 May 2016 14:02:19 +0800
Subject: [PATCH 6/6] ASoC: rockchip: Add machine driver for cdn dp codec
In-Reply-To: <1464328939-8073-1-git-send-email-zyw@rock-chips.com>
References: <1464328939-8073-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1464328939-8073-7-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver is used for cdn dp codec embedded in rk3399

Signed-off-by: Chris Zhong <zyw@rock-chips.com>

---

 .../bindings/sound/rockchip-cdn-dp-audio.txt       |  12 ++
 sound/soc/rockchip/Kconfig                         |   9 ++
 sound/soc/rockchip/Makefile                        |   2 +
 sound/soc/rockchip/rockchip-cdn-dp-audio.c         | 167 +++++++++++++++++++++
 4 files changed, 190 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip-cdn-dp-audio.txt
 create mode 100644 sound/soc/rockchip/rockchip-cdn-dp-audio.c

diff --git a/Documentation/devicetree/bindings/sound/rockchip-cdn-dp-audio.txt b/Documentation/devicetree/bindings/sound/rockchip-cdn-dp-audio.txt
new file mode 100644
index 0000000..b7b0898
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rockchip-cdn-dp-audio.txt
@@ -0,0 +1,12 @@
+Rockchip cdn dp audio bindings
+
+Required properties:
+- compatible: platform specific, must be "rockchip,cdn-dp-audio"
+- i2s-controller: the device of i2s controller
+
+Example:
+
+	cdn_dp_audio: cdn-dp_audio {
+		compatible = "rockchip,cdn-dp-audio";
+		i2s-controller = <&i2s2>;
+	};
diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
index f1e0c70..7e7d905 100644
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -15,6 +15,15 @@ config SND_SOC_ROCKCHIP_I2S
 	  Rockchip I2S device. The device supports upto maximum of
 	  8 channels each for play and record.
 
+config SND_SOC_ROCKCHIP_CDN_DP_AUDIO
+	tristate "cdn DP audio support"
+	depends on ROCKCHIP_CDN_DP
+	select SND_SOC_ROCKCHIP_I2S
+	select SND_SOC_CDN_DP_AUDIO
+	help
+	  Say Y or M here if you want to add support for SoC audio on Rockchip
+	  boards using the cdn dp codec, such as RK3399.
+
 config SND_SOC_ROCKCHIP_SPDIF
 	tristate "Rockchip SPDIF Device Driver"
 	depends on CLKDEV_LOOKUP && SND_SOC_ROCKCHIP
diff --git a/sound/soc/rockchip/Makefile b/sound/soc/rockchip/Makefile
index c0bf560..9367f55 100644
--- a/sound/soc/rockchip/Makefile
+++ b/sound/soc/rockchip/Makefile
@@ -5,8 +5,10 @@ snd-soc-rockchip-spdif-objs := rockchip_spdif.o
 obj-$(CONFIG_SND_SOC_ROCKCHIP_I2S) += snd-soc-rockchip-i2s.o
 obj-$(CONFIG_SND_SOC_ROCKCHIP_SPDIF) += snd-soc-rockchip-spdif.o
 
+snd-soc-rockchip-cdn-dp-objs := rockchip-cdn-dp-audio.o
 snd-soc-rockchip-max98090-objs := rockchip_max98090.o
 snd-soc-rockchip-rt5645-objs := rockchip_rt5645.o
 
+obj-$(CONFIG_SND_SOC_ROCKCHIP_CDN_DP_AUDIO) += snd-soc-rockchip-cdn-dp.o
 obj-$(CONFIG_SND_SOC_ROCKCHIP_MAX98090) += snd-soc-rockchip-max98090.o
 obj-$(CONFIG_SND_SOC_ROCKCHIP_RT5645) += snd-soc-rockchip-rt5645.o
diff --git a/sound/soc/rockchip/rockchip-cdn-dp-audio.c b/sound/soc/rockchip/rockchip-cdn-dp-audio.c
new file mode 100644
index 0000000..2bf6649
--- /dev/null
+++ b/sound/soc/rockchip/rockchip-cdn-dp-audio.c
@@ -0,0 +1,167 @@
+/*
+ * rockchip-cdn-dp-card.c
+ *
+ * ROCKCHIP ALSA SoC DAI driver for cdn dp audio on rockchip processors.
+ *
+ * Copyright (C) 2016 Chris Zhong <zyw@rock-chips.com>
+ * Copyright (C) 2016 ROCKCHIP, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <sound/soc.h>
+#include <sound/pcm.h>
+#include <sound/core.h>
+#include <sound/pcm_params.h>
+
+#include "rockchip_i2s.h"
+
+#define DRV_NAME "rockchip-cdn-dp-audio"
+
+static int cdn_dp_audio_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	unsigned int dai_fmt = rtd->dai_link->dai_fmt;
+	int mclk, ret;
+
+	switch (params_rate(params)) {
+	case 8000:
+	case 16000:
+	case 24000:
+	case 32000:
+	case 48000:
+	case 64000:
+	case 96000:
+		mclk = 12288000;
+		break;
+	case 11025:
+	case 22050:
+	case 44100:
+	case 88200:
+		mclk = 11289600;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, dai_fmt);
+	if (ret < 0) {
+		dev_err(cpu_dai->dev, "failed to set cpu_dai fmt.\n");
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_sysclk(cpu_dai, 0, mclk, SND_SOC_CLOCK_OUT);
+	if (ret < 0) {
+		dev_err(cpu_dai->dev, "failed to set cpu_dai sysclk.\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops cdn_dp_dai_ops = {
+	.hw_params = cdn_dp_audio_hw_params,
+};
+
+static struct snd_soc_dai_link cdn_dp_dai = {
+	.name = "cdn_dp",
+	.stream_name = "cdn_dp",
+	.codec_name = "cdn-dp-audio",
+	.codec_dai_name = "cdn-dp-hifi",
+	.ops = &cdn_dp_dai_ops,
+	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+		   SND_SOC_DAIFMT_CBS_CFS,
+};
+
+static struct snd_soc_card cdn_dp_audio_card = {
+	.name = "cdn_dp",
+	.owner = THIS_MODULE,
+	.dai_link = &cdn_dp_dai,
+	.num_links = 1,
+};
+
+static int cdn_dp_audio_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &cdn_dp_audio_card;
+	struct device_node *np = pdev->dev.of_node;
+	int ret;
+
+	card->dev = &pdev->dev;
+	platform_set_drvdata(pdev, card);
+
+	cdn_dp_dai.cpu_of_node = of_parse_phandle(np, "i2s-controller", 0);
+	if (!cdn_dp_dai.cpu_of_node) {
+		dev_err(&pdev->dev, "Property 'i2s-controller' missing !\n");
+		goto free_priv_data;
+	}
+
+	cdn_dp_dai.platform_of_node = cdn_dp_dai.cpu_of_node;
+
+	ret = snd_soc_register_card(card);
+	if (ret) {
+		dev_err(&pdev->dev, "register card failed (%d)\n", ret);
+		card->dev = NULL;
+		goto free_cpu_of_node;
+	}
+
+	dev_info(&pdev->dev, "rockchip cdn dp audio init success.\n");
+
+	return 0;
+
+free_cpu_of_node:
+	cdn_dp_dai.cpu_of_node = NULL;
+	cdn_dp_dai.platform_of_node = NULL;
+free_priv_data:
+	snd_soc_card_set_drvdata(card, NULL);
+	platform_set_drvdata(pdev, NULL);
+	card->dev = NULL;
+
+	return ret;
+}
+
+static int cdn_dp_audio_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_card(card);
+	snd_soc_card_set_drvdata(card, NULL);
+	platform_set_drvdata(pdev, NULL);
+	card->dev = NULL;
+
+	return 0;
+}
+
+static const struct of_device_id cdn_dp_audio_of_match[] = {
+	{ .compatible = "rockchip,cdn-dp-audio", },
+	{},
+};
+
+static struct platform_driver cdn_dp_audio_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+		.pm = &snd_soc_pm_ops,
+		.of_match_table = cdn_dp_audio_of_match,
+	},
+	.probe = cdn_dp_audio_probe,
+	.remove = cdn_dp_audio_remove,
+};
+module_platform_driver(cdn_dp_audio_driver);
+
+MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
+MODULE_DESCRIPTION("CDN DP Audio ASoC Interface");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_DEVICE_TABLE(of, cdn_dp_audio_of_match);
-- 
2.6.3
