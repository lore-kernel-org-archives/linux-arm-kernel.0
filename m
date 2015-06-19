From: ykk@rock-chips.com (Yakir Yang)
Date: Sat, 20 Jun 2015 00:31:05 +0800
Subject: [PATCH v5 5/6] ASoC: rockchip/rockchip-hdmi-audio: add sound driver
 for hdmi audio
In-Reply-To: <1434730417-10629-1-git-send-email-ykk@rock-chips.com>
References: <1434730417-10629-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1434731465-11106-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a sound driver that combines rockchip-i2s cpu_dai and dw-hdmi-codec
as codec_dai to provide hdmi audio output on rk3288 platforms.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v5:
- Take Mark Brown suggest that remove the no useful code in probe func,
  and remove the snd_soc_dai_set_fmt() snd_soc_unregister_card(), remove
  those noisy dev_info()
- Rename codec_dai_name to "dw-hdmi-i2s-hifi"

Changes in v4:
- Add ".pm = &snd_soc_pm_ops,"

Changes in v3:
- Delete the operation of jack in rockchip-hdmi-audio driver,
  get ready to switch to simple-audio-card driver.

Changes in v2:
- give "codec-name" & "codec-dai-name" an const name

 sound/soc/rockchip/Kconfig               |   9 ++
 sound/soc/rockchip/Makefile              |   2 +
 sound/soc/rockchip/rockchip_hdmi_audio.c | 138 +++++++++++++++++++++++++++++++
 3 files changed, 149 insertions(+)
 create mode 100644 sound/soc/rockchip/rockchip_hdmi_audio.c

diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
index e181826..ed2b7f0 100644
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -14,3 +14,12 @@ config SND_SOC_ROCKCHIP_I2S
 	  Say Y or M if you want to add support for I2S driver for
 	  Rockchip I2S device. The device supports upto maximum of
 	  8 channels each for play and record.
+
+config SND_SOC_ROCKCHIP_HDMI_AUDIO
+	tristate "ASoC support for Rockchip HDMI audio"
+	depends on SND_SOC_ROCKCHIP
+	select SND_SOC_ROCKCHIP_I2S
+	select SND_SOC_DW_HDMI_AUDIO
+	help
+	  Say Y or M here if you want to add support for SoC audio on Rockchip
+	  HDMI, such as rk3288 hdmi.
diff --git a/sound/soc/rockchip/Makefile b/sound/soc/rockchip/Makefile
index b921909..b9185b3 100644
--- a/sound/soc/rockchip/Makefile
+++ b/sound/soc/rockchip/Makefile
@@ -1,4 +1,6 @@
 # ROCKCHIP Platform Support
 snd-soc-i2s-objs := rockchip_i2s.o
+snd-soc-rockchip-hdmi-audio-objs := rockchip_hdmi_audio.o
 
 obj-$(CONFIG_SND_SOC_ROCKCHIP_I2S) += snd-soc-i2s.o
+obj-$(CONFIG_SND_SOC_ROCKCHIP_HDMI_AUDIO) += snd-soc-rockchip-hdmi-audio.o
diff --git a/sound/soc/rockchip/rockchip_hdmi_audio.c b/sound/soc/rockchip/rockchip_hdmi_audio.c
new file mode 100644
index 0000000..53ecd60
--- /dev/null
+++ b/sound/soc/rockchip/rockchip_hdmi_audio.c
@@ -0,0 +1,138 @@
+/*
+ * ROCKCHIP ALSA SoC DAI driver for HDMI audio on rockchip processors.
+ * Copyright (c) 2014, ROCKCHIP CORPORATION. All rights reserved.
+ * Authors: Yakir Yang <ykk@rock-chips.com>
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
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.*
+ *
+ */
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
+#define DRV_NAME "rockchip-hdmi-audio"
+
+static int rockchip_hdmi_audio_hw_params(struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *params)
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
+	ret = snd_soc_dai_set_sysclk(cpu_dai, 0, mclk, SND_SOC_CLOCK_OUT);
+	if (ret < 0) {
+		dev_err(cpu_dai->dev, "failed to set cpu_dai sysclk.\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops hdmi_audio_dai_ops = {
+	.hw_params = rockchip_hdmi_audio_hw_params,
+};
+
+static struct snd_soc_dai_link hdmi_audio_dai = {
+	.name = "RockchipHDMI",
+	.stream_name = "RockchipHDMI",
+	.codec_name = "dw-hdmi-i2s-audio",
+	.codec_dai_name = "dw-hdmi-i2s-hifi",
+	.ops = &hdmi_audio_dai_ops,
+	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+		   SND_SOC_DAIFMT_CBS_CFS,
+};
+
+static struct snd_soc_card rockchip_hdmi_audio_card = {
+	.name = "RockchipHDMI",
+	.owner = THIS_MODULE,
+	.dai_link = &hdmi_audio_dai,
+	.num_links = 1,
+};
+
+static int rockchip_hdmi_audio_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &rockchip_hdmi_audio_card;
+	struct device_node *np = pdev->dev.of_node;
+	int ret;
+
+	card->dev = &pdev->dev;
+	platform_set_drvdata(pdev, card);
+
+	hdmi_audio_dai.cpu_of_node = of_parse_phandle(np, "i2s-controller", 0);
+	if (!hdmi_audio_dai.cpu_of_node) {
+		dev_err(&pdev->dev, "Property 'i2s-controller' missing !\n");
+		return -EINVAL;
+	}
+
+	hdmi_audio_dai.platform_of_node = hdmi_audio_dai.cpu_of_node;
+
+	ret = snd_soc_register_card(card);
+	if (ret) {
+		dev_err(&pdev->dev, "register card failed (%d)\n", ret);
+		card->dev = NULL;
+		return -EINVAL;
+	}
+
+	dev_dbg(&pdev->dev, "hdmi audio init success.\n");
+
+	return 0;
+}
+
+static const struct of_device_id rockchip_hdmi_audio_of_match[] = {
+	{ .compatible = "rockchip,rk3288-hdmi-audio", },
+	{},
+};
+
+static struct platform_driver rockchip_hdmi_audio_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+		.pm = &snd_soc_pm_ops,
+		.of_match_table = rockchip_hdmi_audio_of_match,
+	},
+	.probe = rockchip_hdmi_audio_probe,
+};
+module_platform_driver(rockchip_hdmi_audio_driver);
+
+MODULE_AUTHOR("Yakir Yang <ykk@rock-chips.com>");
+MODULE_DESCRIPTION("Rockchip HDMI Audio ASoC Interface");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_DEVICE_TABLE(of, rockchip_hdmi_audio_of_match);
-- 
2.1.2
