From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 15 May 2014 16:23:45 +0200
Subject: [PATCH RFC 02/11] sound: ASoC: kirkwood: Remove unused drivers
In-Reply-To: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
References: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
Message-ID: <1400163836-9831-5-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both kirkwood-openrd and kirkwood-t5325 drivers have been replaced
with DT based simple-card equivelents.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel at alsa-project.org
---
 sound/soc/kirkwood/Kconfig           |  17 -----
 sound/soc/kirkwood/Makefile          |   4 --
 sound/soc/kirkwood/kirkwood-openrd.c | 109 -----------------------------
 sound/soc/kirkwood/kirkwood-t5325.c  | 129 -----------------------------------
 4 files changed, 259 deletions(-)
 delete mode 100644 sound/soc/kirkwood/kirkwood-openrd.c
 delete mode 100644 sound/soc/kirkwood/kirkwood-t5325.c

diff --git a/sound/soc/kirkwood/Kconfig b/sound/soc/kirkwood/Kconfig
index 06f4e8aa93ae..1f7c7ee3527a 100644
--- a/sound/soc/kirkwood/Kconfig
+++ b/sound/soc/kirkwood/Kconfig
@@ -15,20 +15,3 @@ config SND_KIRKWOOD_SOC_ARMADA370_DB
 	  Say Y if you want to add support for SoC audio on
 	  the Armada 370 Development Board.
 
-config SND_KIRKWOOD_SOC_OPENRD
-	tristate "SoC Audio support for Kirkwood Openrd Client"
-	depends on SND_KIRKWOOD_SOC && (MACH_OPENRD_CLIENT || MACH_OPENRD_ULTIMATE || COMPILE_TEST)
-	depends on I2C
-	select SND_SOC_CS42L51
-	help
-	  Say Y if you want to add support for SoC audio on
-	  Openrd Client.
-
-config SND_KIRKWOOD_SOC_T5325
-	tristate "SoC Audio support for HP t5325"
-	depends on SND_KIRKWOOD_SOC && (MACH_T5325 || COMPILE_TEST) && I2C
-	select SND_SOC_ALC5623
-	help
-	  Say Y if you want to add support for SoC audio on
-	  the HP t5325 thin client.
-
diff --git a/sound/soc/kirkwood/Makefile b/sound/soc/kirkwood/Makefile
index 7c1d8fe09e6b..c36b03d8006c 100644
--- a/sound/soc/kirkwood/Makefile
+++ b/sound/soc/kirkwood/Makefile
@@ -2,10 +2,6 @@ snd-soc-kirkwood-objs := kirkwood-dma.o kirkwood-i2s.o
 
 obj-$(CONFIG_SND_KIRKWOOD_SOC) += snd-soc-kirkwood.o
 
-snd-soc-openrd-objs := kirkwood-openrd.o
-snd-soc-t5325-objs := kirkwood-t5325.o
 snd-soc-armada-370-db-objs := armada-370-db.o
 
 obj-$(CONFIG_SND_KIRKWOOD_SOC_ARMADA370_DB) += snd-soc-armada-370-db.o
-obj-$(CONFIG_SND_KIRKWOOD_SOC_OPENRD) += snd-soc-openrd.o
-obj-$(CONFIG_SND_KIRKWOOD_SOC_T5325) += snd-soc-t5325.o
diff --git a/sound/soc/kirkwood/kirkwood-openrd.c b/sound/soc/kirkwood/kirkwood-openrd.c
deleted file mode 100644
index 65f2a5b9ec3b..000000000000
--- a/sound/soc/kirkwood/kirkwood-openrd.c
+++ /dev/null
@@ -1,109 +0,0 @@
-/*
- * kirkwood-openrd.c
- *
- * (c) 2010 Arnaud Patard <apatard@mandriva.com>
- * (c) 2010 Arnaud Patard <arnaud.patard@rtp-net.org>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
-
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <sound/soc.h>
-#include <linux/platform_data/asoc-kirkwood.h>
-#include "../codecs/cs42l51.h"
-
-static int openrd_client_hw_params(struct snd_pcm_substream *substream,
-		struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	unsigned int freq;
-
-	switch (params_rate(params)) {
-	default:
-	case 44100:
-		freq = 11289600;
-		break;
-	case 48000:
-		freq = 12288000;
-		break;
-	case 96000:
-		freq = 24576000;
-		break;
-	}
-
-	return snd_soc_dai_set_sysclk(codec_dai, 0, freq, SND_SOC_CLOCK_IN);
-
-}
-
-static struct snd_soc_ops openrd_client_ops = {
-	.hw_params = openrd_client_hw_params,
-};
-
-
-static struct snd_soc_dai_link openrd_client_dai[] = {
-{
-	.name = "CS42L51",
-	.stream_name = "CS42L51 HiFi",
-	.cpu_dai_name = "i2s",
-	.platform_name = "mvebu-audio",
-	.codec_dai_name = "cs42l51-hifi",
-	.codec_name = "cs42l51-codec.0-004a",
-	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS,
-	.ops = &openrd_client_ops,
-},
-};
-
-
-static struct snd_soc_card openrd_client = {
-	.name = "OpenRD Client",
-	.owner = THIS_MODULE,
-	.dai_link = openrd_client_dai,
-	.num_links = ARRAY_SIZE(openrd_client_dai),
-};
-
-static int openrd_probe(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = &openrd_client;
-	int ret;
-
-	card->dev = &pdev->dev;
-
-	ret = snd_soc_register_card(card);
-	if (ret)
-		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
-			ret);
-	return ret;
-}
-
-static int openrd_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_card(card);
-	return 0;
-}
-
-static struct platform_driver openrd_driver = {
-	.driver		= {
-		.name	= "openrd-client-audio",
-		.owner	= THIS_MODULE,
-	},
-	.probe		= openrd_probe,
-	.remove		= openrd_remove,
-};
-
-module_platform_driver(openrd_driver);
-
-/* Module information */
-MODULE_AUTHOR("Arnaud Patard <arnaud.patard@rtp-net.org>");
-MODULE_DESCRIPTION("ALSA SoC OpenRD Client");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:openrd-client-audio");
diff --git a/sound/soc/kirkwood/kirkwood-t5325.c b/sound/soc/kirkwood/kirkwood-t5325.c
deleted file mode 100644
index d213832b0c72..000000000000
--- a/sound/soc/kirkwood/kirkwood-t5325.c
+++ /dev/null
@@ -1,129 +0,0 @@
-/*
- * kirkwood-t5325.c
- *
- * (c) 2010 Arnaud Patard <arnaud.patard@rtp-net.org>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
-
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <sound/soc.h>
-#include <linux/platform_data/asoc-kirkwood.h>
-#include "../codecs/alc5623.h"
-
-static int t5325_hw_params(struct snd_pcm_substream *substream,
-		struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	unsigned int freq;
-
-	freq = params_rate(params) * 256;
-
-	return snd_soc_dai_set_sysclk(codec_dai, 0, freq, SND_SOC_CLOCK_IN);
-
-}
-
-static struct snd_soc_ops t5325_ops = {
-	.hw_params = t5325_hw_params,
-};
-
-static const struct snd_soc_dapm_widget t5325_dapm_widgets[] = {
-	SND_SOC_DAPM_HP("Headphone Jack", NULL),
-	SND_SOC_DAPM_SPK("Speaker", NULL),
-	SND_SOC_DAPM_MIC("Mic Jack", NULL),
-};
-
-static const struct snd_soc_dapm_route t5325_route[] = {
-	{ "Headphone Jack",	NULL,	"HPL" },
-	{ "Headphone Jack",	NULL,	"HPR" },
-
-	{"Speaker",		NULL,	"SPKOUT"},
-	{"Speaker",		NULL,	"SPKOUTN"},
-
-	{ "MIC1",		NULL,	"Mic Jack" },
-	{ "MIC2",		NULL,	"Mic Jack" },
-};
-
-static int t5325_dai_init(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
-	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
-	snd_soc_dapm_enable_pin(dapm, "Speaker");
-
-	return 0;
-}
-
-static struct snd_soc_dai_link t5325_dai[] = {
-{
-	.name = "ALC5621",
-	.stream_name = "ALC5621 HiFi",
-	.cpu_dai_name = "i2s",
-	.platform_name = "mvebu-audio",
-	.codec_dai_name = "alc5621-hifi",
-	.codec_name = "alc562x-codec.0-001a",
-	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS,
-	.ops = &t5325_ops,
-	.init = t5325_dai_init,
-},
-};
-
-static struct snd_soc_card t5325 = {
-	.name = "t5325",
-	.owner = THIS_MODULE,
-	.dai_link = t5325_dai,
-	.num_links = ARRAY_SIZE(t5325_dai),
-
-	.dapm_widgets = t5325_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(t5325_dapm_widgets),
-	.dapm_routes = t5325_route,
-	.num_dapm_routes = ARRAY_SIZE(t5325_route),
-};
-
-static int t5325_probe(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = &t5325;
-	int ret;
-
-	card->dev = &pdev->dev;
-
-	ret = snd_soc_register_card(card);
-	if (ret)
-		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
-			ret);
-	return ret;
-}
-
-static int t5325_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_card(card);
-	return 0;
-}
-
-static struct platform_driver t5325_driver = {
-	.driver		= {
-		.name	= "t5325-audio",
-		.owner	= THIS_MODULE,
-	},
-	.probe		= t5325_probe,
-	.remove		= t5325_remove,
-};
-
-module_platform_driver(t5325_driver);
-
-MODULE_AUTHOR("Arnaud Patard <arnaud.patard@rtp-net.org>");
-MODULE_DESCRIPTION("ALSA SoC t5325 audio client");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:t5325-audio");
-- 
2.0.0.rc2
