From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 20 Jun 2013 15:20:27 +0200
Subject: [PATCH v9 08/10] ASoC: Add phycore-ac97-dt driver
In-Reply-To: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
References: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1371734429-6081-9-git-send-email-mpa@pengutronix.de>
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

Notes:
    Changes in v9:
     - Fix blank line at end of file.
    
    Changes in v8:
     - Seperate DT capable driver from old phycore-ac97. This eliminates a lot of
       build issues and makes the driver easier to read.
     - fsl_ssi may not be built as module if used with ac97 because it defines
       the soc_ac97_ops symbol which is used by the soc ac97 core and codec drivers.
       So phycore-ac97-dt actually does not support building as module anymore. The
       same issue was existing with imx-ssi and phycore-ac97, which is also fixed
       now in this patch.
    
    Changes in v7:
     - Declare empty ac97 reset functions static.
     - Replace complicated machine compatible comparison with
       of_machine_is_compatible
     - Missing snd_soc_unregister_card in imx_phycore_ac97_remove
     - Rename driver
    
    Changes in v6:
     - phycore-ac97 now manages the ac97 reset functions of the boards using
       this combination of ssi-codec.
     - Removed preprocessor ifs for DT, non-DT distinction. pcm043 is now
       non-DT only and pca100 DT only.
    
    Changes in v4:
     - New property phytec,audmux to check which audmux setup should be
       executed. Checking for fsl,imx21-audmux and fsl,imx31-audmux.
    
    Changes in v3:
     - Add some more information in the commit message.
    
    Changes in v2:
     - Simplify the driver, by combining audmux port configurations. The
       audmux driver actually knows on which platform he is running and
       will return the appropriate error code if we use functions for
       another platform. So we don't need to have the knowledge about it
       in phycore-ac97 and can try both functions. This removes the need
       of different compatibilities and renames it to phycore-ac97.
     - Use a phandle for the cpu_dai link.
     - Add devicetree binding documentation.
     - Rename binding to phytec,phycore-ac97 and fsl,ssi to phytec,ssi

 .../bindings/sound/phytec,phycore-ac97.txt         |  14 ++
 sound/soc/fsl/Kconfig                              |  16 +-
 sound/soc/fsl/Makefile                             |   2 +
 sound/soc/fsl/phycore-ac97-dt.c                    | 242 +++++++++++++++++++++
 sound/soc/fsl/phycore-ac97.c                       |  13 +-
 5 files changed, 273 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/phytec,phycore-ac97.txt
 create mode 100644 sound/soc/fsl/phycore-ac97-dt.c

diff --git a/Documentation/devicetree/bindings/sound/phytec,phycore-ac97.txt b/Documentation/devicetree/bindings/sound/phytec,phycore-ac97.txt
new file mode 100644
index 0000000..41201ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/phytec,phycore-ac97.txt
@@ -0,0 +1,14 @@
+Phytec phycore AC97
+
+Required properties:
+- compatible: "phytec,phycore-ac97"
+- phytec,ssi: A phandle to the ssi device that is connected to ac97.
+- phytec,audmux: A phandle to the audmux device.
+
+Example:
+
+sound {
+	compatible = "phytec,phycore-ac97";
+	phytec,ssi = <&ssi1>;
+	phytec,audmux = <&audmux>;
+};
diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 74ef96e..dafffd1 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -143,8 +143,8 @@ config SND_SOC_MX27VIS_AIC32X4
 	  board with TLV320AIC32X4 codec.
 
 config SND_SOC_PHYCORE_AC97
-	tristate "SoC Audio support for Phytec phyCORE (and phyCARD) boards"
-	depends on MACH_PCM043 || MACH_PCA100
+	bool "SoC Audio support for Phytec phyCORE boards"
+	depends on MACH_PCM043
 	select SND_SOC_AC97_BUS
 	select SND_SOC_WM9712
 	select SND_SOC_IMX_PCM_FIQ
@@ -154,6 +154,18 @@ config SND_SOC_PHYCORE_AC97
 	  Say Y if you want to add support for SoC audio on Phytec phyCORE
 	  and phyCARD boards in AC97 mode
 
+config SND_SOC_PHYCORE_AC97_DT
+	bool "SoC Audio support for Phytec phyCORE (and phyCARD) boards (devicetree only)"
+	depends on MACH_PCA100 || MACH_PCM043
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
index 91883f8..be9b198 100644
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
@@ -46,6 +47,7 @@ snd-soc-imx-mc13783-objs := imx-mc13783.o
 
 obj-$(CONFIG_SND_SOC_EUKREA_TLV320) += snd-soc-eukrea-tlv320.o
 obj-$(CONFIG_SND_SOC_PHYCORE_AC97) += snd-soc-phycore-ac97.o
+obj-$(CONFIG_SND_SOC_PHYCORE_AC97_DT) += snd-soc-phycore-ac97-dt.o
 obj-$(CONFIG_SND_SOC_MX27VIS_AIC32X4) += snd-soc-mx27vis-aic32x4.o
 obj-$(CONFIG_SND_MXC_SOC_WM1133_EV1) += snd-soc-wm1133-ev1.o
 obj-$(CONFIG_SND_SOC_IMX_SGTL5000) += snd-soc-imx-sgtl5000.o
diff --git a/sound/soc/fsl/phycore-ac97-dt.c b/sound/soc/fsl/phycore-ac97-dt.c
new file mode 100644
index 0000000..f494b30
--- /dev/null
+++ b/sound/soc/fsl/phycore-ac97-dt.c
@@ -0,0 +1,242 @@
+/*
+ * phycore-ac97-dt.c  --  SoC audio for imx_phycore in AC97 mode
+ *
+ * Copyright 2009 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
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
+static struct snd_soc_card imx_phycore;
+static struct device_node *phycore_dai_cpu_node;
+static void (*phycore_ac97_reset) (struct snd_ac97 *ac97);
+static void (*phycore_ac97_warm_reset)(struct snd_ac97 *ac97);
+
+static struct snd_soc_ops imx_phycore_hifi_ops = {
+};
+
+static struct snd_soc_dai_link imx_phycore_dai_ac97[] = {
+	{
+		.name		= "HiFi",
+		.stream_name	= "HiFi",
+		.codec_dai_name		= "wm9712-hifi",
+		.codec_name	= "wm9712-codec",
+		.ops		= &imx_phycore_hifi_ops,
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
+static struct platform_device *imx_phycore_snd_device;
+
+static void phycore_ac97_imx21_audmux(void)
+{
+	imx_audmux_v1_configure_port(MX27_AUDMUX_HPCR1_SSI0,
+		IMX_AUDMUX_V1_PCR_SYN | /* 4wire mode */
+		IMX_AUDMUX_V1_PCR_TFCSEL(3) |
+		IMX_AUDMUX_V1_PCR_TCLKDIR | /* clock is output */
+		IMX_AUDMUX_V1_PCR_RXDSEL(3));
+	imx_audmux_v1_configure_port(3,
+		IMX_AUDMUX_V1_PCR_SYN | /* 4wire mode */
+		IMX_AUDMUX_V1_PCR_TFCSEL(0) |
+		IMX_AUDMUX_V1_PCR_TFSDIR |
+		IMX_AUDMUX_V1_PCR_RXDSEL(0));
+}
+
+static void phycore_ac97_imx31_audmux(void)
+{
+	imx_audmux_v2_configure_port(3,
+		IMX_AUDMUX_V2_PTCR_SYN | /* 4wire mode */
+		IMX_AUDMUX_V2_PTCR_TFSEL(0) |
+		IMX_AUDMUX_V2_PTCR_TFSDIR,
+		IMX_AUDMUX_V2_PDCR_RXDSEL(0));
+	imx_audmux_v2_configure_port(0,
+		IMX_AUDMUX_V2_PTCR_SYN | /* 4wire mode */
+		IMX_AUDMUX_V2_PTCR_TCSEL(3) |
+		IMX_AUDMUX_V2_PTCR_TCLKDIR, /* clock is output */
+		IMX_AUDMUX_V2_PDCR_RXDSEL(3));
+}
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
+
+/*
+ * Pointer to AC97 reset functions for specific boards
+ */
+#if IS_ENABLED(CONFIG_MACH_PCA100)
+extern void pca100_ac97_cold_reset(struct snd_ac97 *ac97);
+extern void pca100_ac97_warm_reset(struct snd_ac97 *ac97);
+#else
+static void pca100_ac97_cold_reset(struct snd_ac97 *ac97) { }
+static void pca100_ac97_warm_reset(struct snd_ac97 *ac97) { }
+#endif
+
+#if IS_ENABLED(CONFIG_MACH_PCM043)
+extern void pcm043_ac97_cold_reset(struct snd_ac97 *ac97);
+extern void pcm043_ac97_warm_reset(struct snd_ac97 *ac97);
+#else
+static void pcm043_ac97_cold_reset(struct snd_ac97 *ac97) { }
+static void pcm043_ac97_warm_reset(struct snd_ac97 *ac97) { }
+#endif
+
+static void phycore_soc_ac97_reset(struct snd_ac97 *ac97)
+{
+	if (phycore_ac97_reset)
+		phycore_ac97_reset(ac97);
+	/* First read sometimes fails, do a dummy read */
+	fsl_ssi_ac97_read(ac97, 0);
+}
+
+static void phycore_soc_ac97_warm_reset(struct snd_ac97 *ac97)
+{
+	if (phycore_ac97_warm_reset)
+		phycore_ac97_warm_reset(ac97);
+
+	/* First read sometimes fails, do a dummy read */
+	fsl_ssi_ac97_read(ac97, 0);
+}
+
+static int phycore_ac97_setup_devices(struct platform_device *pdev)
+{
+	int ret;
+
+	imx_phycore_snd_device = platform_device_alloc("wm9712-codec", -1);
+	if (!imx_phycore_snd_device)
+		return -ENOMEM;
+
+	ret = platform_device_add(imx_phycore_snd_device);
+	if (ret) {
+		dev_err(&pdev->dev, "ASoC: Platform device allocation failed\n");
+		goto fail1;
+	}
+
+	ret = snd_soc_register_card(&imx_phycore);
+	if (ret) {
+		dev_err(&pdev->dev, "ASoC: soc card registration failed\n");
+		goto fail2;
+	}
+	return 0;
+
+fail2:
+	platform_device_del(imx_phycore_snd_device);
+fail1:
+	platform_device_put(imx_phycore_snd_device);
+	return ret;
+}
+
+static int imx_phycore_ac97_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct device_node *ssi_np;
+	struct device_node *audmux_np;
+
+	imx_phycore.dev = &pdev->dev;
+
+	audmux_np = of_parse_phandle(pdev->dev.of_node, "phytec,audmux", 0);
+	if (!audmux_np) {
+		dev_err(&pdev->dev, "Failed to parse phytec,audmux phandle\n");
+		return -EINVAL;
+	}
+
+	if (of_device_is_compatible(audmux_np, "fsl,imx21-audmux")) {
+		phycore_ac97_imx21_audmux();
+	} else if (of_device_is_compatible(audmux_np, "fsl,imx31-audmux")) {
+		phycore_ac97_imx31_audmux();
+	} else {
+		dev_err(&pdev->dev, "Unknown audmux, failed to setup audmux\n");
+		of_node_put(audmux_np);
+		return -EINVAL;
+	}
+	of_node_put(audmux_np);
+
+	ssi_np = of_parse_phandle(pdev->dev.of_node, "phytec,ssi", 0);
+	if (!ssi_np) {
+		dev_err(&pdev->dev, "No valid ssi phandle found\n");
+		return -EINVAL;
+	}
+
+	imx_phycore_dai_ac97[0].cpu_of_node = ssi_np;
+	imx_phycore_dai_ac97[0].platform_of_node = ssi_np;
+	phycore_dai_cpu_node = ssi_np;
+
+	if (of_machine_is_compatible("phytec,imx27-pca100")) {
+		phycore_ac97_reset = pca100_ac97_cold_reset;
+		phycore_ac97_warm_reset = pca100_ac97_warm_reset;
+	} else if (of_machine_is_compatible("phytec,imx35-pcm043")) {
+		phycore_ac97_reset = pcm043_ac97_cold_reset;
+		phycore_ac97_warm_reset = pcm043_ac97_warm_reset;
+	} else {
+		dev_err(&pdev->dev, "Failed to set AC97 reset functions, unknown board.\n");
+		return -EINVAL;
+	}
+
+	fsl_ssi_ac97_set_reset(phycore_soc_ac97_reset,
+			phycore_soc_ac97_warm_reset);
+
+	ret = phycore_ac97_setup_devices(pdev);
+	if (ret)
+		of_node_put(phycore_dai_cpu_node);
+
+	return ret;
+}
+
+static int imx_phycore_ac97_remove(struct platform_device *pdev)
+{
+	of_node_put(phycore_dai_cpu_node);
+	phycore_dai_cpu_node = NULL;
+
+	snd_soc_unregister_card(&imx_phycore);
+
+	platform_device_unregister(imx_phycore_snd_device);
+
+	phycore_ac97_reset = NULL;
+	phycore_ac97_warm_reset = NULL;
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
+MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
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
1.8.2.1
