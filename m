From: philippe.retornaz@epfl.ch (=?utf-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Fri,  9 Mar 2012 15:55:14 +0100
Subject: [PATCH 2/4] Add imx3sound sound support.
In-Reply-To: <1331304916-4724-2-git-send-email-philippe.retornaz@epfl.ch>
References: <1331304916-4724-1-git-send-email-philippe.retornaz@epfl.ch>
 <1331304916-4724-2-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <1331304916-4724-3-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Several boards are using the mc13783 codec with the same
configuration. Provide an unique asoc platform driver for it.

Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>
---
 sound/soc/imx/Kconfig             |   10 +++
 sound/soc/imx/Makefile            |    2 +
 sound/soc/imx/imx3sound-mc13783.c |  141 +++++++++++++++++++++++++++++++++++++
 3 files changed, 153 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/imx/imx3sound-mc13783.c

diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
index 7383917..244a5fe 100644
--- a/sound/soc/imx/Kconfig
+++ b/sound/soc/imx/Kconfig
@@ -57,4 +57,14 @@ config SND_SOC_EUKREA_TLV320
 	  Enable I2S based access to the TLV320AIC23B codec attached
 	  to the SSI interface
 
+config SND_SOC_IMX3SOUND_MC13783
+	tristate "SoC Audio support for imx31 with MC13783 codecs"
+	depends on IMX_SDMA
+	select SND_MXC_SOC_SSI
+	select SND_SOC_MC13783
+	select SND_MXC_SOC_MX2
+	help
+		Say Y if you want to add support for SoC audio on mx31moboard
+		and imx31pdk_3ds boards using a MC13783 Codec.
+
 endif	# SND_IMX_SOC
diff --git a/sound/soc/imx/Makefile b/sound/soc/imx/Makefile
index d6d609b..742fd35 100644
--- a/sound/soc/imx/Makefile
+++ b/sound/soc/imx/Makefile
@@ -12,8 +12,10 @@ snd-soc-eukrea-tlv320-objs := eukrea-tlv320.o
 snd-soc-phycore-ac97-objs := phycore-ac97.o
 snd-soc-mx27vis-aic32x4-objs := mx27vis-aic32x4.o
 snd-soc-wm1133-ev1-objs := wm1133-ev1.o
+snd-soc-imx3sound-mc13783-objs := imx3sound-mc13783.o
 
 obj-$(CONFIG_SND_SOC_EUKREA_TLV320) += snd-soc-eukrea-tlv320.o
 obj-$(CONFIG_SND_SOC_PHYCORE_AC97) += snd-soc-phycore-ac97.o
 obj-$(CONFIG_SND_SOC_MX27VIS_AIC32X4) += snd-soc-mx27vis-aic32x4.o
 obj-$(CONFIG_SND_MXC_SOC_WM1133_EV1) += snd-soc-wm1133-ev1.o
+obj-$(CONFIG_SND_SOC_IMX3SOUND_MC13783) += snd-soc-imx3sound-mc13783.o
diff --git a/sound/soc/imx/imx3sound-mc13783.c b/sound/soc/imx/imx3sound-mc13783.c
new file mode 100644
index 0000000..b11e455
--- /dev/null
+++ b/sound/soc/imx/imx3sound-mc13783.c
@@ -0,0 +1,141 @@
+/*
+ * imx3sound-mc13783.c  --  SoC audio for imx31_3ds based boards
+ *
+ * Copyright 2012 Philippe Retornaz, <philippe.retornaz@epfl.ch>
+ *
+ * Heavly based on phycore-mc13783:
+ * Copyright 2009 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
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
+#include <sound/soc-dapm.h>
+#include <asm/mach-types.h>
+
+#include "../codecs/mc13783.h"
+#include "imx-ssi.h"
+
+static struct snd_soc_card imx3sound;
+
+#define FMT_SSI (SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_NB_NF | \
+		SND_SOC_DAIFMT_CBM_CFM)
+
+static int imx3sound_hifi_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int ret;
+
+	ret = snd_soc_dai_set_fmt(codec_dai, FMT_SSI);
+	if (ret)
+		return ret;
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, FMT_SSI);
+	if (ret)
+		return ret;
+
+	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xfffffffc, 0xfffffffc, 4, 16);
+	if (ret)
+		return ret;
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, MC13783_CLK_CLIA, 26000000, 0);
+	if (ret)
+		return ret;
+
+	ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0x0, 0xfffffffc, 2, 16);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int imx3sound_hifi_hw_free(struct snd_pcm_substream *substream)
+{
+	return 0;
+}
+
+static struct snd_soc_ops imx3sound_hifi_ops = {
+	.hw_params = imx3sound_hifi_hw_params,
+	.hw_free = imx3sound_hifi_hw_free,
+};
+
+static int imx3sound_probe(struct snd_soc_card *dev)
+{
+	return 0;
+}
+
+static int imx3sound_remove(struct snd_soc_card *dev)
+{
+	return 0;
+}
+
+static struct snd_soc_dai_link imx3sound_dai_mc13783[] = {
+	{
+		.name = "MC13783",
+		.stream_name	 = "Sound",
+		.codec_dai_name	 = "mc13783-hifi",
+		.codec_name	 = "mc13783-codec",
+		.cpu_dai_name	 = "imx-ssi.0",
+		.platform_name	 = "imx-pcm-audio.0",
+		.ops		 = &imx3sound_hifi_ops,
+		.symmetric_rates = 1,
+	},
+};
+
+static struct snd_soc_card imx3sound = {
+	.name		= "imx3sound",
+	.probe		= imx3sound_probe,
+	.remove		= imx3sound_remove,
+	.dai_link	= imx3sound_dai_mc13783,
+	.num_links	= ARRAY_SIZE(imx3sound_dai_mc13783),
+};
+
+static struct platform_device *imx3sound_snd_device;
+
+static int __init imx3sound_init(void)
+{
+	int ret;
+
+	if (!(machine_is_mx31moboard() || machine_is_mx31_3ds()))
+		/* return happy. We might run on a totally different machine */
+		return 0;
+
+	imx3sound_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!imx3sound_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(imx3sound_snd_device, &imx3sound);
+	ret = platform_device_add(imx3sound_snd_device);
+
+	if (ret) {
+		printk(KERN_ERR "ASoC: Platform device allocation failed\n");
+		platform_device_put(imx3sound_snd_device);
+	}
+
+	return ret;
+}
+
+static void __exit imx3sound_exit(void)
+{
+	platform_device_unregister(imx3sound_snd_device);
+}
+
+late_initcall(imx3sound_init);
+module_exit(imx3sound_exit);
+
+MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
+MODULE_AUTHOR("Philippe Retornaz <philippe.retornaz@epfl.ch");
+MODULE_DESCRIPTION("mx31moboard & mx31_3ds ALSA SoC driver");
+MODULE_LICENSE("GPL");
-- 
1.6.3.3
