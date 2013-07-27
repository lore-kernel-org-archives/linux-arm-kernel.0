From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 27 Jul 2013 13:31:56 +0200
Subject: [PATCH v10 7/7] ASoC: Add phycore-ac97-dt driver
In-Reply-To: <1374924716-23475-1-git-send-email-mpa@pengutronix.de>
References: <1374924716-23475-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1374924716-23475-8-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add devicetree support for phycore-ac97 driver in a seperated driver for
DT loading. The seperation reduces the confusion with the old style
initialization of this driver via late_initcall. Also this driver is
using fsl-ssi instead of imx-ssi.

platform_of_node and cpu_of_node are set according to the fsl,audmux
phandle.

This patch adds handling of ac97 reset functions according to fsl ac97
support. They are setup from here to avoid board specific code in the
generic fsl-ssi driver.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Tested-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../bindings/sound/phytec,phycore-ac97.txt         |  16 +++
 sound/soc/fsl/Kconfig                              |  15 ++-
 sound/soc/fsl/Makefile                             |   2 +
 sound/soc/fsl/phycore-ac97-dt.c                    | 124 +++++++++++++++++++++
 sound/soc/fsl/phycore-ac97.c                       |  13 +--
 5 files changed, 156 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/phytec,phycore-ac97.txt
 create mode 100644 sound/soc/fsl/phycore-ac97-dt.c

diff --git a/Documentation/devicetree/bindings/sound/phytec,phycore-ac97.txt b/Documentation/devicetree/bindings/sound/phytec,phycore-ac97.txt
new file mode 100644
index 0000000..b3ce9cb
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/phytec,phycore-ac97.txt
@@ -0,0 +1,16 @@
+Phytec phycore AC97
+
+Required properties:
+- compatible: "phytec,phycore-ac97"
+- phytec,ssi: A phandle to the ssi device that is connected to ac97.
+- phytec,audmux: A phandle to the audmux device.
+- audio-codec: phandle to the codec device node.
+
+Example:
+
+sound {
+	compatible = "phytec,phycore-ac97";
+	phytec,ssi = <&ssi1>;
+	phytec,audmux = <&audmux>;
+	audio-codec = <&codec>;
+};
diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 3a79d01..5f992b3 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -142,8 +142,8 @@ config SND_SOC_MX27VIS_AIC32X4
 	  board with TLV320AIC32X4 codec.
 
 config SND_SOC_PHYCORE_AC97
-	tristate "SoC Audio support for Phytec phyCORE (and phyCARD) boards"
-	depends on MACH_PCM043 || MACH_PCA100
+	tristate "SoC Audio support for Phytec phyCORE boards"
+	depends on MACH_PCM043
 	select SND_SOC_AC97_BUS
 	select SND_SOC_WM9712
 	select SND_SOC_IMX_PCM_FIQ
@@ -153,6 +153,17 @@ config SND_SOC_PHYCORE_AC97
 	  Say Y if you want to add support for SoC audio on Phytec phyCORE
 	  and phyCARD boards in AC97 mode
 
+config SND_SOC_PHYCORE_AC97_DT
+	tristate "SoC Audio support for Phytec phyCORE (and phyCARD) boards (devicetree only)"
+	select SND_SOC_AC97_BUS
+	select SND_SOC_WM9712
+	select SND_SOC_IMX_PCM_FIQ
+	select SND_SOC_IMX_AUDMUX
+	select SND_SOC_FSL_SSI
+	help
+	  Say Y if you want to add support for SoC audio on Phytec phyCORE
+	  and phyCARD boards in AC97 mode when using devicetree.
+
 config SND_SOC_EUKREA_TLV320
 	tristate "Eukrea TLV320"
 	depends on MACH_EUKREA_MBIMX27_BASEBOARD \
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index d4b4aa8..31bdd69 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_SND_SOC_IMX_PCM_DMA) += imx-pcm-dma.o
 # i.MX Machine Support
 snd-soc-eukrea-tlv320-objs := eukrea-tlv320.o
 snd-soc-phycore-ac97-objs := phycore-ac97.o
+snd-soc-phycore-ac97-dt-objs := phycore-ac97-dt.o
 snd-soc-mx27vis-aic32x4-objs := mx27vis-aic32x4.o
 snd-soc-wm1133-ev1-objs := wm1133-ev1.o
 snd-soc-imx-sgtl5000-objs := imx-sgtl5000.o
@@ -47,6 +48,7 @@ snd-soc-imx-mc13783-objs := imx-mc13783.o
 
 obj-$(CONFIG_SND_SOC_EUKREA_TLV320) += snd-soc-eukrea-tlv320.o
 obj-$(CONFIG_SND_SOC_PHYCORE_AC97) += snd-soc-phycore-ac97.o
+obj-$(CONFIG_SND_SOC_PHYCORE_AC97_DT) += snd-soc-phycore-ac97-dt.o
 obj-$(CONFIG_SND_SOC_MX27VIS_AIC32X4) += snd-soc-mx27vis-aic32x4.o
 obj-$(CONFIG_SND_MXC_SOC_WM1133_EV1) += snd-soc-wm1133-ev1.o
 obj-$(CONFIG_SND_SOC_IMX_SGTL5000) += snd-soc-imx-sgtl5000.o
diff --git a/sound/soc/fsl/phycore-ac97-dt.c b/sound/soc/fsl/phycore-ac97-dt.c
new file mode 100644
index 0000000..46b3423
--- /dev/null
+++ b/sound/soc/fsl/phycore-ac97-dt.c
@@ -0,0 +1,124 @@
+/*
+ * phycore-ac97-dt.c  --  SoC audio for imx_phycore in AC97 mode
+ *
+ * Copyright 2013 Markus Pargmann, Pengutronix <mpa@pengutronix.de>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/of.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+
+#include "imx-audmux.h"
+#include "fsl_ssi.h"
+
+#define DRV_NAME "phycore-ac97-dt-driver"
+
+struct phycore_ac97_data {
+	struct snd_soc_card card;
+	struct device_node *cpu_np;
+	struct device_node *codec_np;
+};
+
+static struct snd_soc_dai_link imx_phycore_dai_ac97[] = {
+	{
+		.name		= "HiFi",
+		.stream_name	= "HiFi",
+		.codec_dai_name	= "wm9712-hifi",
+	},
+};
+
+static struct snd_soc_card imx_phycore = {
+	.name		= "PhyCORE-ac97-audio",
+	.owner		= THIS_MODULE,
+	.dai_link	= imx_phycore_dai_ac97,
+	.num_links	= ARRAY_SIZE(imx_phycore_dai_ac97),
+};
+
+static const struct of_device_id imx_phycore_ac97_of_dev_id[] = {
+	{
+		.compatible = "phytec,phycore-ac97",
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(of, imx_phycore_ac97_of_dev_id);
+
+static int imx_phycore_ac97_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct phycore_ac97_data *priv;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+
+	if (!priv)
+		return -ENOMEM;
+
+	imx_phycore.dev = &pdev->dev;
+
+	priv->cpu_np = of_parse_phandle(pdev->dev.of_node, "phytec,ssi", 0);
+	if (!priv->cpu_np) {
+		dev_err(&pdev->dev, "No valid ssi phandle found\n");
+		return -EINVAL;
+	}
+
+	priv->codec_np = of_parse_phandle(pdev->dev.of_node, "audio-codec", 0);
+	if (!priv->codec_np) {
+		dev_err(&pdev->dev, "No valid codec phandle found\n");
+		of_node_put(priv->cpu_np);
+		return -EINVAL;
+	}
+
+	imx_phycore_dai_ac97[0].cpu_of_node = priv->cpu_np;
+	imx_phycore_dai_ac97[0].platform_of_node = priv->cpu_np;
+	imx_phycore_dai_ac97[0].codec_of_node = priv->codec_np;
+
+	ret = snd_soc_register_card(&imx_phycore);
+	if (ret) {
+		dev_err(&pdev->dev, "ASoC: soc card registration failed\n");
+		of_node_put(priv->cpu_np);
+		of_node_put(priv->codec_np);
+		return ret;
+	}
+
+	dev_set_drvdata(&pdev->dev, priv);
+
+	return ret;
+}
+
+static int imx_phycore_ac97_remove(struct platform_device *pdev)
+{
+	struct phycore_ac97_data *priv = dev_get_drvdata(&pdev->dev);
+
+	snd_soc_unregister_card(&imx_phycore);
+
+	of_node_put(priv->cpu_np);
+	of_node_put(priv->codec_np);
+
+	return 0;
+}
+
+static struct platform_driver imx_phycore_ac97_driver = {
+	.probe		= imx_phycore_ac97_probe,
+	.remove		= imx_phycore_ac97_remove,
+	.driver		= {
+		.name	= DRV_NAME,
+		.owner	= THIS_MODULE,
+		.of_match_table = imx_phycore_ac97_of_dev_id,
+	},
+};
+
+module_platform_driver(imx_phycore_ac97_driver);
+
+MODULE_AUTHOR("Markus Pargmann <mpa@pengutronix.de>");
+MODULE_DESCRIPTION(DRV_NAME ": PhyCORE ALSA SoC DT driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/fsl/phycore-ac97.c b/sound/soc/fsl/phycore-ac97.c
index ae403c2..4126edc 100644
--- a/sound/soc/fsl/phycore-ac97.c
+++ b/sound/soc/fsl/phycore-ac97.c
@@ -52,18 +52,7 @@ static int __init imx_phycore_init(void)
 {
 	int ret;
 
-	if (machine_is_pca100()) {
-		imx_audmux_v1_configure_port(MX27_AUDMUX_HPCR1_SSI0,
-			IMX_AUDMUX_V1_PCR_SYN | /* 4wire mode */
-			IMX_AUDMUX_V1_PCR_TFCSEL(3) |
-			IMX_AUDMUX_V1_PCR_TCLKDIR | /* clock is output */
-			IMX_AUDMUX_V1_PCR_RXDSEL(3));
-		imx_audmux_v1_configure_port(3,
-			IMX_AUDMUX_V1_PCR_SYN | /* 4wire mode */
-			IMX_AUDMUX_V1_PCR_TFCSEL(0) |
-			IMX_AUDMUX_V1_PCR_TFSDIR |
-			IMX_AUDMUX_V1_PCR_RXDSEL(0));
-	} else if (machine_is_pcm043()) {
+	if (machine_is_pcm043()) {
 		imx_audmux_v2_configure_port(3,
 			IMX_AUDMUX_V2_PTCR_SYN | /* 4wire mode */
 			IMX_AUDMUX_V2_PTCR_TFSEL(0) |
-- 
1.8.3.2
