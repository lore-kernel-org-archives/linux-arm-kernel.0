From: philippe.retornaz@epfl.ch (=?UTF-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Tue, 15 May 2012 13:53:51 +0200
Subject: [PATCH 3/4] ASoC: add imx-mc13783 sound support
In-Reply-To: <1337082832-9764-3-git-send-email-philippe.retornaz@epfl.ch>
References: <1337082832-9764-1-git-send-email-philippe.retornaz@epfl.ch>
 <1337082832-9764-2-git-send-email-philippe.retornaz@epfl.ch>
 <1337082832-9764-3-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <1337082832-9764-4-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>
---
 sound/soc/fsl/Kconfig       |    8 ++
 sound/soc/fsl/Makefile      |    2 +
 sound/soc/fsl/imx-mc13783.c |  163 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 173 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/fsl/imx-mc13783.c

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 0094789..3f2dd3a 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -171,4 +171,12 @@ config SND_SOC_IMX_SGTL5000
 	  Say Y if you want to add support for SoC audio on an i.MX board with
 	  a sgtl5000 codec.
 
+config SND_SOC_IMX_MC13783
+	tristate "SoC Audio support for I.MX boards with mc13783"
+	depends on MFD_MC13783
+	select SND_SOC_IMX_SSI
+	select SND_SOC_IMX_AUDMUX
+	select SND_SOC_MC13783
+	select SND_SOC_IMX_PCM_DMA
+
 endif # SND_IMX_SOC
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index 638d385..5f3cf3f 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -41,9 +41,11 @@ snd-soc-phycore-ac97-objs := phycore-ac97.o
 snd-soc-mx27vis-aic32x4-objs := mx27vis-aic32x4.o
 snd-soc-wm1133-ev1-objs := wm1133-ev1.o
 snd-soc-imx-sgtl5000-objs := imx-sgtl5000.o
+snd-soc-imx-mc13783-objs := imx-mc13783.o
 
 obj-$(CONFIG_SND_SOC_EUKREA_TLV320) += snd-soc-eukrea-tlv320.o
 obj-$(CONFIG_SND_SOC_PHYCORE_AC97) += snd-soc-phycore-ac97.o
 obj-$(CONFIG_SND_SOC_MX27VIS_AIC32X4) += snd-soc-mx27vis-aic32x4.o
 obj-$(CONFIG_SND_MXC_SOC_WM1133_EV1) += snd-soc-wm1133-ev1.o
 obj-$(CONFIG_SND_SOC_IMX_SGTL5000) += snd-soc-imx-sgtl5000.o
+obj-$(CONFIG_SND_SOC_IMX_MC13783) += snd-soc-imx-mc13783.o
diff --git a/sound/soc/fsl/imx-mc13783.c b/sound/soc/fsl/imx-mc13783.c
new file mode 100644
index 0000000..a7b7170
--- /dev/null
+++ b/sound/soc/fsl/imx-mc13783.c
@@ -0,0 +1,163 @@
+/*
+ * imx-mc13783.c  --  SoC audio for imx based boards with mc13783 codec
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
+#include "imx-audmux.h"
+
+#define FMT_SSI (SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_NB_NF | \
+		SND_SOC_DAIFMT_CBM_CFM)
+
+static int imx_mc13783_hifi_hw_params(struct snd_pcm_substream *substream,
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
+	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xfffffffc, 0xfffffffc,
+					4, 16);
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
+static struct snd_soc_ops imx_mc13783_hifi_ops = {
+	.hw_params = imx_mc13783_hifi_hw_params,
+};
+
+static struct snd_soc_dai_link imx_mc13783_dai_mc13783[] = {
+	{
+		.name = "MC13783",
+		.stream_name	 = "Sound",
+		.codec_dai_name	 = "mc13783-hifi",
+		.codec_name	 = "mc13783-codec",
+		.cpu_dai_name	 = "imx-ssi.0",
+		.platform_name	 = "imx-pcm-audio.0",
+		.ops		 = &imx_mc13783_hifi_ops,
+		.symmetric_rates = 1,
+	},
+};
+
+static const struct snd_soc_dapm_widget imx_mc13783_widget[] = {
+	SND_SOC_DAPM_MIC("Mic", NULL),
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_SPK("Speaker", NULL),
+};
+
+static const struct snd_soc_dapm_route imx_mc13783_routes[] = {
+	{"Speaker", NULL, "LSP"},
+	{"Headphone", NULL, "HSL"},
+	{"Headphone", NULL, "HSR"},
+
+	{"MC1LIN", NULL, "MC1 Bias"},
+	{"MC2IN", NULL, "MC2 Bias"},
+	{"MC1 Bias", NULL, "Mic"},
+	{"MC2 Bias", NULL, "Mic"},
+};
+
+static struct snd_soc_card imx_mc13783 = {
+	.name		= "imx_mc13783",
+	.dai_link	= imx_mc13783_dai_mc13783,
+	.num_links	= ARRAY_SIZE(imx_mc13783_dai_mc13783),
+	.dapm_widgets	= imx_mc13783_widget,
+	.num_dapm_widgets = ARRAY_SIZE(imx_mc13783_widget),
+	.dapm_routes	= imx_mc13783_routes,
+	.num_dapm_routes = ARRAY_SIZE(imx_mc13783_routes),
+};
+
+static int __devinit imx_mc13783_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	imx_mc13783.dev = &pdev->dev;
+
+	ret = snd_soc_register_card(&imx_mc13783);
+	if (ret) {
+		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
+			ret);
+		return ret;
+	}
+
+	imx_audmux_v2_configure_port(MX31_AUDMUX_PORT4_SSI_PINS_4,
+		IMX_AUDMUX_V2_PTCR_SYN,
+		IMX_AUDMUX_V2_PDCR_RXDSEL(MX31_AUDMUX_PORT1_SSI0) |
+		IMX_AUDMUX_V2_PDCR_MODE(1) |
+		IMX_AUDMUX_V2_PDCR_INMMASK(0xfc));
+	imx_audmux_v2_configure_port(MX31_AUDMUX_PORT1_SSI0,
+		IMX_AUDMUX_V2_PTCR_SYN |
+		IMX_AUDMUX_V2_PTCR_TFSDIR |
+		IMX_AUDMUX_V2_PTCR_TFSEL(MX31_AUDMUX_PORT4_SSI_PINS_4) |
+		IMX_AUDMUX_V2_PTCR_TCLKDIR |
+		IMX_AUDMUX_V2_PTCR_TCSEL(MX31_AUDMUX_PORT4_SSI_PINS_4) |
+		IMX_AUDMUX_V2_PTCR_RFSDIR |
+		IMX_AUDMUX_V2_PTCR_RFSEL(MX31_AUDMUX_PORT4_SSI_PINS_4) |
+		IMX_AUDMUX_V2_PTCR_RCLKDIR |
+		IMX_AUDMUX_V2_PTCR_RCSEL(MX31_AUDMUX_PORT4_SSI_PINS_4),
+		IMX_AUDMUX_V2_PDCR_RXDSEL(MX31_AUDMUX_PORT4_SSI_PINS_4));
+
+	return ret;
+}
+
+static int __devexit imx_mc13783_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_card(&imx_mc13783);
+
+	return 0;
+}
+
+static struct platform_driver imx_mc13783_audio_driver = {
+	.driver = {
+		.name = "imx_mc13783",
+		.owner = THIS_MODULE,
+	},
+	.probe = imx_mc13783_probe,
+	.remove = __devexit_p(imx_mc13783_remove)
+};
+
+module_platform_driver(imx_mc13783_audio_driver);
+
+MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
+MODULE_AUTHOR("Philippe Retornaz <philippe.retornaz@epfl.ch");
+MODULE_DESCRIPTION("imx with mc13783 codec ALSA SoC driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:imx_mc13783");
-- 
1.7.0.4
