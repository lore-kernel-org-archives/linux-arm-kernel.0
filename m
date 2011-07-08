From: juergen.lambrecht@gmail.com (=?UTF-8?q?J=C3=BCrgen=20Lambrecht?=)
Date: Fri,  8 Jul 2011 15:24:51 +0200
Subject: [RFC PATCH] ARM ASoC: add sound driver for imx27pdk using mc13783
	codec
Message-ID: <1310131491-625-1-git-send-email-J.Lambrecht@televic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- Started from sound/soc/imx/phycore-mc13783.c
- Renamed to general "imx" because also valid for imx27pdk (3ds) and other 3ds platforms.
  Or should there be a file per platform?
- Fixed some issues (add names, add read/write functions, changed late_initcall to module_init, configure clock input pin)
- Add debug printing and comments.
- Result:
  * soundcard detection;
  * after creating /dev entries, aplay runs;
  * both 'aplay song.wav' and 'madplay song.mp3' give the same error:
    a time-out waiting for DMA (ALSA pcm_lib.c:1802: playback write error (DMA or IRQ trouble?))
  * this driver uses the DMA method; the FIQ method gives the same error

Signed-off-by: J?rgen Lambrecht <J.Lambrecht@televic.com>
---
 sound/soc/imx/Kconfig       |   20 +++--
 sound/soc/imx/Makefile      |    2 +
 sound/soc/imx/imx-mc13783.c |  175 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+), 7 deletions(-)
 create mode 100644 sound/soc/imx/imx-mc13783.c

diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
index d8f130d..2f57f12 100644
--- a/sound/soc/imx/Kconfig
+++ b/sound/soc/imx/Kconfig
@@ -11,20 +11,19 @@ menuconfig SND_IMX_SOC
 
 if SND_IMX_SOC
 
-config SND_MXC_SOC_SSI
-	tristate
-
 config SND_MXC_SOC_FIQ
 	tristate
 
 config SND_MXC_SOC_MX2
 	tristate
 
+config SND_SOC_IMX_MC13783
+	tristate
+
 config SND_MXC_SOC_WM1133_EV1
 	tristate "Audio on the the i.MX31ADS with WM1133-EV1 fitted"
 	depends on MACH_MX31ADS_WM1133_EV1 && EXPERIMENTAL
 	select SND_SOC_WM8350
-	select SND_MXC_SOC_SSI
 	select SND_MXC_SOC_FIQ
 	help
 	  Enable support for audio on the i.MX31ADS with the WM1133-EV1
@@ -34,7 +33,6 @@ config SND_SOC_MX27VIS_AIC32X4
 	tristate "SoC audio support for Visstrim M10 boards"
 	depends on MACH_IMX27_VISSTRIM_M10
 	select SND_SOC_TVL320AIC32X4
-	select SND_MXC_SOC_SSI
 	select SND_MXC_SOC_MX2
 	help
 	  Say Y if you want to add support for SoC audio on Visstrim SM10
@@ -44,7 +42,6 @@ config SND_SOC_PHYCORE_AC97
 	tristate "SoC Audio support for Phytec phyCORE (and phyCARD) boards"
 	depends on MACH_PCM043 || MACH_PCA100
 	select SND_SOC_WM9712
-	select SND_MXC_SOC_SSI
 	select SND_MXC_SOC_FIQ
 	help
 	  Say Y if you want to add support for SoC audio on Phytec phyCORE
@@ -57,10 +54,19 @@ config SND_SOC_EUKREA_TLV320
 		|| MACH_EUKREA_MBIMXSD35_BASEBOARD \
 		|| MACH_EUKREA_MBIMXSD51_BASEBOARD
 	select SND_SOC_TLV320AIC23
-	select SND_MXC_SOC_SSI
 	select SND_MXC_SOC_FIQ
 	help
 	  Enable I2S based access to the TLV320AIC23B codec attached
 	  to the SSI interface
 
+config SND_SOC_IMX27_MC13783
+	tristate "SoC Audio support for i.MX27 platforms with a MC13783 codec"
+	depends on MACH_MX27_3DS
+	select SND_SOC_MC13783
+	select SND_MXC_SOC_MX2
+	select SND_SOC_IMX_MC13783
+	help
+	  Say Y if you want to add support for SoC audio on i.MX27 platforms
+	  with a MC13783 codec (based on Freescale's imx27pdk kit)
+
 endif	# SND_IMX_SOC
diff --git a/sound/soc/imx/Makefile b/sound/soc/imx/Makefile
index d6d609b..d86e5b8 100644
--- a/sound/soc/imx/Makefile
+++ b/sound/soc/imx/Makefile
@@ -12,8 +12,10 @@ snd-soc-eukrea-tlv320-objs := eukrea-tlv320.o
 snd-soc-phycore-ac97-objs := phycore-ac97.o
 snd-soc-mx27vis-aic32x4-objs := mx27vis-aic32x4.o
 snd-soc-wm1133-ev1-objs := wm1133-ev1.o
+snd-soc-imx-mc13783-objs := imx-mc13783.o
 
 obj-$(CONFIG_SND_SOC_EUKREA_TLV320) += snd-soc-eukrea-tlv320.o
 obj-$(CONFIG_SND_SOC_PHYCORE_AC97) += snd-soc-phycore-ac97.o
 obj-$(CONFIG_SND_SOC_MX27VIS_AIC32X4) += snd-soc-mx27vis-aic32x4.o
 obj-$(CONFIG_SND_MXC_SOC_WM1133_EV1) += snd-soc-wm1133-ev1.o
+obj-$(CONFIG_SND_SOC_IMX_MC13783) += snd-soc-imx-mc13783.o
diff --git a/sound/soc/imx/imx-mc13783.c b/sound/soc/imx/imx-mc13783.c
new file mode 100644
index 0000000..4274f84
--- /dev/null
+++ b/sound/soc/imx/imx-mc13783.c
@@ -0,0 +1,175 @@
+/*
+ * imx-mc13783.c  --  SoC audio for imx processor with mx13783 co-processor
+ *
+ * Copyright 2009 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
+ * Copyright 2011 J?rgen Lambrecht, Televic <J.Lambrecht@televic.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+#include <asm/mach-types.h>
+#include "../codecs/mc13783.h"
+#include "imx-ssi.h"
+
+static struct snd_soc_card imx_mc13783_audio;
+
+#define FMT_PLAYBACK (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | \
+		SND_SOC_DAIFMT_CBM_CFM)
+#define FMT_CAPTURE (SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_NB_NF | \
+		SND_SOC_DAIFMT_CBM_CFM)
+
+static int imx_mc13783_audio_hifi_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int ret;
+
+	/* set codec and cpu DAI configuration */
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		ret = snd_soc_dai_set_fmt(codec_dai, FMT_PLAYBACK);
+		if (ret) {
+			pr_err("%s: failed set codec dai format\n", __func__);
+			return ret;
+		}
+		ret = snd_soc_dai_set_fmt(cpu_dai, FMT_PLAYBACK);
+		if (ret) {
+			pr_err("%s: failed set cpu dai format\n", __func__);
+			return ret;
+		}
+	} else {
+		ret = snd_soc_dai_set_fmt(codec_dai, FMT_CAPTURE);
+		if (ret) {
+			pr_err("%s: failed set codec dai format\n", __func__);
+			return ret;
+		}
+		ret = snd_soc_dai_set_fmt(cpu_dai, FMT_CAPTURE);
+		if (ret) {
+			pr_err("%s: failed set cpu dai format\n", __func__);
+			return ret;
+		}
+		ret = snd_soc_dai_set_tdm_slot(codec_dai, 0, 0, 4, 32); /* args are not used in mc13783 */
+		if (ret)
+			return ret;
+	}
+//ok: checked; we use clia input pin; last arg is not used
+	ret = snd_soc_dai_set_sysclk(codec_dai, MC13783_CLK_CLIA, 26000000, SND_SOC_CLOCK_OUT);
+	if (ret) {
+		pr_err("%s: failed setting codec sysclk\n", __func__);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0x0, 0xfffffffc, 4, 32);
+	if (ret)
+		return ret;
+
+//from eukrea-tlv320.c and mx27vis-aic32x4.c
+	ret = snd_soc_dai_set_sysclk(cpu_dai, IMX_SSP_SYS_CLK, 0,
+				SND_SOC_CLOCK_IN);
+	if (ret) {
+		pr_err("can't set CPU system clock IMX_SSP_SYS_CLK\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int imx_mc13783_audio_hifi_hw_free(struct snd_pcm_substream *substream)
+{
+	return 0;
+}
+
+static struct snd_soc_ops imx_mc13783_audio_hifi_ops = {
+	.hw_params = imx_mc13783_audio_hifi_hw_params,
+	.hw_free = imx_mc13783_audio_hifi_hw_free,
+};
+
+static int imx_mc13783_audio_probe(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int imx_mc13783_audio_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct snd_soc_dai_link imx_dai_mc13783[] = {
+	{
+		.name = "MC13783 Playback",
+		.stream_name	= "Playback",
+		.codec_dai_name	= "mc13783-hifi",
+		.platform_name	= "imx-pcm-audio.0",
+		.codec_name	= "mc13783-codec",
+		.cpu_dai_name	= "imx-ssi.0",
+		.ops		= &imx_mc13783_audio_hifi_ops,
+	}, {
+		.name = "MC13783 Capture",
+		.stream_name	= "Capture",
+		.codec_dai_name	= "mc13783-hifi",
+		.platform_name	= "imx-pcm-audio.0",
+		.codec_name	= "mc13783-codec",
+		.cpu_dai_name	= "imx-ssi.0",
+		.ops		= &imx_mc13783_audio_hifi_ops,
+	},
+};
+
+static struct snd_soc_card imx_mc13783_audio = {
+	.name		= "iMX-mc13783-audio",
+	.probe		= imx_mc13783_audio_probe,
+	.remove		= imx_mc13783_audio_remove,
+	.dai_link	= imx_dai_mc13783,
+	.num_links	= ARRAY_SIZE(imx_dai_mc13783),
+};
+
+static struct platform_device *imx_mc13783_snd_device;
+
+static int __init imx_mc13783_audio_init(void)
+{
+	int ret;
+
+	pr_info("IMX MC13783 Sound Card\n");
+/* Possibly add a check for IMX and MC13783 */
+/* 	if (!machine_is_pcm038() && !machine_is_pcm037()) */
+/* 		* return happy. We might run on a totally different machine * */
+/* 		return 0; */
+
+	imx_mc13783_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!imx_mc13783_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(imx_mc13783_snd_device, &imx_mc13783_audio);
+	ret = platform_device_add(imx_mc13783_snd_device);
+
+	if (ret) {
+		printk(KERN_ERR "ASoC: Platform device allocation failed\n");
+		platform_device_put(imx_mc13783_snd_device);
+	}
+
+	return ret;
+}
+
+static void __exit imx_mc13783_audio_exit(void)
+{
+	platform_device_unregister(imx_mc13783_snd_device);
+}
+
+//late_initcall(imx_mc13783_audio_init);
+module_init(imx_mc13783_audio_init);
+module_exit(imx_mc13783_audio_exit);
+
+MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
+MODULE_DESCRIPTION("iMX ALSA SoC driver");
+MODULE_LICENSE("GPL");
-- 
1.7.1
