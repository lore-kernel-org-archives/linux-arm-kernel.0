From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 13 Apr 2017 12:55:59 -0600
Subject: [PATCH 2/2] ASoC: tegra: remove Whistler machine driver
In-Reply-To: <20170413185559.1939-1-swarren@wwwdotorg.org>
References: <20170413185559.1939-1-swarren@wwwdotorg.org>
Message-ID: <20170413185559.1939-2-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

The previous patch removed Whistler board support. There's no need to
keep around a Whistler-specific ASoC machine driver.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 .../bindings/sound/nvidia,tegra-audio-wm8753.txt   |  40 ----
 sound/soc/tegra/Kconfig                            |  10 -
 sound/soc/tegra/Makefile                           |   4 +-
 sound/soc/tegra/tegra_wm8753.c                     | 219 ---------------------
 4 files changed, 1 insertion(+), 272 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8753.txt
 delete mode 100644 sound/soc/tegra/tegra_wm8753.c

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8753.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8753.txt
deleted file mode 100644
index 96f6a57dd6b4..000000000000
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8753.txt
+++ /dev/null
@@ -1,40 +0,0 @@
-NVIDIA Tegra audio complex
-
-Required properties:
-- compatible : "nvidia,tegra-audio-wm8753"
-- clocks : Must contain an entry for each entry in clock-names.
-  See ../clocks/clock-bindings.txt for details.
-- clock-names : Must include the following entries:
-  - pll_a
-  - pll_a_out0
-  - mclk (The Tegra cdev1/extern1 clock, which feeds the CODEC's mclk)
-- nvidia,model : The user-visible name of this sound complex.
-- nvidia,audio-routing : A list of the connections between audio components.
-  Each entry is a pair of strings, the first being the connection's sink,
-  the second being the connection's source. Valid names for sources and
-  sinks are the WM8753's pins as documented in the binding for the WM8753,
-  and the jacks on the board:
-
-  * Headphone Jack
-  * Mic Jack
-
-- nvidia,i2s-controller : The phandle of the Tegra I2S1 controller
-- nvidia,audio-codec : The phandle of the WM8753 audio codec
-Example:
-
-sound {
-	compatible = "nvidia,tegra-audio-wm8753-whistler",
-		     "nvidia,tegra-audio-wm8753"
-	nvidia,model = "tegra-wm8753-harmony";
-
-	nvidia,audio-routing =
-		"Headphone Jack", "LOUT1",
-		"Headphone Jack", "ROUT1";
-
-	nvidia,i2s-controller = <&i2s1>;
-	nvidia,audio-codec = <&wm8753>;
-
-	clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 93>;
-	clock-names = "pll_a", "pll_a_out0", "mclk";
-};
-
diff --git a/sound/soc/tegra/Kconfig b/sound/soc/tegra/Kconfig
index efbe8d4c019e..19e5d92bb7bc 100644
--- a/sound/soc/tegra/Kconfig
+++ b/sound/soc/tegra/Kconfig
@@ -71,16 +71,6 @@ config SND_SOC_TEGRA_RT5640
 	  Say Y or M here if you want to add support for SoC audio on Tegra
 	  boards using the RT5640 codec, such as Dalmore.
 
-config SND_SOC_TEGRA_WM8753
-	tristate "SoC Audio support for Tegra boards using a WM8753 codec"
-	depends on SND_SOC_TEGRA && I2C && GPIOLIB
-	select SND_SOC_TEGRA20_I2S if ARCH_TEGRA_2x_SOC
-	select SND_SOC_TEGRA30_I2S if ARCH_TEGRA_3x_SOC
-	select SND_SOC_WM8753
-	help
-	  Say Y or M here if you want to add support for SoC audio on Tegra
-	  boards using the WM8753 codec, such as Whistler.
-
 config SND_SOC_TEGRA_WM8903
 	tristate "SoC Audio support for Tegra boards using a WM8903 codec"
 	depends on SND_SOC_TEGRA && I2C && GPIOLIB
diff --git a/sound/soc/tegra/Makefile b/sound/soc/tegra/Makefile
index f214a3fd0024..c85c34740aea 100644
--- a/sound/soc/tegra/Makefile
+++ b/sound/soc/tegra/Makefile
@@ -20,7 +20,6 @@ obj-$(CONFIG_SND_SOC_TEGRA30_I2S) += snd-soc-tegra30-i2s.o
 # Tegra machine Support
 snd-soc-tegra-rt5640-objs := tegra_rt5640.o
 snd-soc-tegra-rt5677-objs := tegra_rt5677.o
-snd-soc-tegra-wm8753-objs := tegra_wm8753.o
 snd-soc-tegra-wm8903-objs := tegra_wm8903.o
 snd-soc-tegra-wm9712-objs := tegra_wm9712.o
 snd-soc-tegra-trimslice-objs := trimslice.o
@@ -30,10 +29,9 @@ snd-soc-tegra-sgtl5000-objs := tegra_sgtl5000.o
 
 obj-$(CONFIG_SND_SOC_TEGRA_RT5640) += snd-soc-tegra-rt5640.o
 obj-$(CONFIG_SND_SOC_TEGRA_RT5677) += snd-soc-tegra-rt5677.o
-obj-$(CONFIG_SND_SOC_TEGRA_WM8753) += snd-soc-tegra-wm8753.o
 obj-$(CONFIG_SND_SOC_TEGRA_WM8903) += snd-soc-tegra-wm8903.o
 obj-$(CONFIG_SND_SOC_TEGRA_WM9712) += snd-soc-tegra-wm9712.o
 obj-$(CONFIG_SND_SOC_TEGRA_TRIMSLICE) += snd-soc-tegra-trimslice.o
 obj-$(CONFIG_SND_SOC_TEGRA_ALC5632) += snd-soc-tegra-alc5632.o
 obj-$(CONFIG_SND_SOC_TEGRA_MAX98090) += snd-soc-tegra-max98090.o
-obj-$(CONFIG_SND_SOC_TEGRA_SGTL5000) += snd-soc-tegra-sgtl5000.o
\ No newline at end of file
+obj-$(CONFIG_SND_SOC_TEGRA_SGTL5000) += snd-soc-tegra-sgtl5000.o
diff --git a/sound/soc/tegra/tegra_wm8753.c b/sound/soc/tegra/tegra_wm8753.c
deleted file mode 100644
index bdedd1028569..000000000000
--- a/sound/soc/tegra/tegra_wm8753.c
+++ /dev/null
@@ -1,219 +0,0 @@
-/*
- * tegra_wm8753.c - Tegra machine ASoC driver for boards using WM8753 codec.
- *
- * Author: Stephen Warren <swarren@nvidia.com>
- * Copyright (C) 2010-2012 - NVIDIA, Inc.
- *
- * Based on code copyright/by:
- *
- * (c) 2009, 2010 Nvidia Graphics Pvt. Ltd.
- *
- * Copyright 2007 Wolfson Microelectronics PLC.
- * Author: Graeme Gregory
- *         graeme.gregory at wolfsonmicro.com or linux at wolfsonmicro.com
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/gpio.h>
-#include <linux/of_gpio.h>
-
-#include <sound/core.h>
-#include <sound/jack.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/soc.h>
-
-#include "../codecs/wm8753.h"
-
-#include "tegra_asoc_utils.h"
-
-#define DRV_NAME "tegra-snd-wm8753"
-
-struct tegra_wm8753 {
-	struct tegra_asoc_utils_data util_data;
-};
-
-static int tegra_wm8753_hw_params(struct snd_pcm_substream *substream,
-					struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_card *card = rtd->card;
-	struct tegra_wm8753 *machine = snd_soc_card_get_drvdata(card);
-	int srate, mclk;
-	int err;
-
-	srate = params_rate(params);
-	switch (srate) {
-	case 11025:
-	case 22050:
-	case 44100:
-	case 88200:
-		mclk = 11289600;
-		break;
-	default:
-		mclk = 12288000;
-		break;
-	}
-
-	err = tegra_asoc_utils_set_rate(&machine->util_data, srate, mclk);
-	if (err < 0) {
-		dev_err(card->dev, "Can't configure clocks\n");
-		return err;
-	}
-
-	err = snd_soc_dai_set_sysclk(codec_dai, WM8753_MCLK, mclk,
-					SND_SOC_CLOCK_IN);
-	if (err < 0) {
-		dev_err(card->dev, "codec_dai clock not set\n");
-		return err;
-	}
-
-	return 0;
-}
-
-static const struct snd_soc_ops tegra_wm8753_ops = {
-	.hw_params = tegra_wm8753_hw_params,
-};
-
-static const struct snd_soc_dapm_widget tegra_wm8753_dapm_widgets[] = {
-	SND_SOC_DAPM_HP("Headphone Jack", NULL),
-	SND_SOC_DAPM_MIC("Mic Jack", NULL),
-};
-
-static struct snd_soc_dai_link tegra_wm8753_dai = {
-	.name = "WM8753",
-	.stream_name = "WM8753 PCM",
-	.codec_dai_name = "wm8753-hifi",
-	.ops = &tegra_wm8753_ops,
-	.dai_fmt = SND_SOC_DAIFMT_I2S |
-			SND_SOC_DAIFMT_NB_NF |
-			SND_SOC_DAIFMT_CBS_CFS,
-};
-
-static struct snd_soc_card snd_soc_tegra_wm8753 = {
-	.name = "tegra-wm8753",
-	.owner = THIS_MODULE,
-	.dai_link = &tegra_wm8753_dai,
-	.num_links = 1,
-
-	.dapm_widgets = tegra_wm8753_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(tegra_wm8753_dapm_widgets),
-	.fully_routed = true,
-};
-
-static int tegra_wm8753_driver_probe(struct platform_device *pdev)
-{
-	struct device_node *np = pdev->dev.of_node;
-	struct snd_soc_card *card = &snd_soc_tegra_wm8753;
-	struct tegra_wm8753 *machine;
-	int ret;
-
-	machine = devm_kzalloc(&pdev->dev, sizeof(struct tegra_wm8753),
-			       GFP_KERNEL);
-	if (!machine) {
-		dev_err(&pdev->dev, "Can't allocate tegra_wm8753 struct\n");
-		return -ENOMEM;
-	}
-
-	card->dev = &pdev->dev;
-	platform_set_drvdata(pdev, card);
-	snd_soc_card_set_drvdata(card, machine);
-
-	ret = snd_soc_of_parse_card_name(card, "nvidia,model");
-	if (ret)
-		goto err;
-
-	ret = snd_soc_of_parse_audio_routing(card, "nvidia,audio-routing");
-	if (ret)
-		goto err;
-
-	tegra_wm8753_dai.codec_of_node = of_parse_phandle(np,
-			"nvidia,audio-codec", 0);
-	if (!tegra_wm8753_dai.codec_of_node) {
-		dev_err(&pdev->dev,
-			"Property 'nvidia,audio-codec' missing or invalid\n");
-		ret = -EINVAL;
-		goto err;
-	}
-
-	tegra_wm8753_dai.cpu_of_node = of_parse_phandle(np,
-			"nvidia,i2s-controller", 0);
-	if (!tegra_wm8753_dai.cpu_of_node) {
-		dev_err(&pdev->dev,
-			"Property 'nvidia,i2s-controller' missing or invalid\n");
-		ret = -EINVAL;
-		goto err;
-	}
-
-	tegra_wm8753_dai.platform_of_node = tegra_wm8753_dai.cpu_of_node;
-
-	ret = tegra_asoc_utils_init(&machine->util_data, &pdev->dev);
-	if (ret)
-		goto err;
-
-	ret = snd_soc_register_card(card);
-	if (ret) {
-		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
-			ret);
-		goto err_fini_utils;
-	}
-
-	return 0;
-
-err_fini_utils:
-	tegra_asoc_utils_fini(&machine->util_data);
-err:
-	return ret;
-}
-
-static int tegra_wm8753_driver_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-	struct tegra_wm8753 *machine = snd_soc_card_get_drvdata(card);
-
-	snd_soc_unregister_card(card);
-
-	tegra_asoc_utils_fini(&machine->util_data);
-
-	return 0;
-}
-
-static const struct of_device_id tegra_wm8753_of_match[] = {
-	{ .compatible = "nvidia,tegra-audio-wm8753", },
-	{},
-};
-
-static struct platform_driver tegra_wm8753_driver = {
-	.driver = {
-		.name = DRV_NAME,
-		.pm = &snd_soc_pm_ops,
-		.of_match_table = tegra_wm8753_of_match,
-	},
-	.probe = tegra_wm8753_driver_probe,
-	.remove = tegra_wm8753_driver_remove,
-};
-module_platform_driver(tegra_wm8753_driver);
-
-MODULE_AUTHOR("Stephen Warren <swarren@nvidia.com>");
-MODULE_DESCRIPTION("Tegra+WM8753 machine ASoC driver");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:" DRV_NAME);
-MODULE_DEVICE_TABLE(of, tegra_wm8753_of_match);
-- 
2.11.0
