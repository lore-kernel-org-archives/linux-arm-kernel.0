From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Fri,  9 Nov 2012 15:00:25 +0100
Subject: [PATCH 6/6] ASoC: fsl: add imx-wm8974 machine driver
In-Reply-To: <1352469625-32024-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1352469625-32024-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1352469625-32024-7-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the initial support for a wm8974 sound codec connected to an imx ssi.
It follows along the lines of the imx-sgtl5000 driver.

	* only the playback dai link is implemented.
	* DT only driver, working with the fsl_ssi driver and imx21 compatible
	  audmux

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 .../devicetree/bindings/sound/imx-audio-wm8974.txt |   48 ++++
 sound/soc/fsl/Kconfig                              |   12 +
 sound/soc/fsl/Makefile                             |    2 +
 sound/soc/fsl/imx-wm8974.c                         |  233 ++++++++++++++++++++
 4 files changed, 295 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-wm8974.txt
 create mode 100644 sound/soc/fsl/imx-wm8974.c

diff --git a/Documentation/devicetree/bindings/sound/imx-audio-wm8974.txt b/Documentation/devicetree/bindings/sound/imx-audio-wm8974.txt
new file mode 100644
index 0000000..7e661e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/imx-audio-wm8974.txt
@@ -0,0 +1,48 @@
+Freescale i.MX audio complex with WM8974 codec
+
+Required properties:
+- compatible : "fsl,imx-audio-wm8974"
+- model : The user-visible name of this sound complex
+- ssi-controller : The phandle of the i.MX SSI controller (imx21 compatible)
+- audio-codec : The phandle of the WM8974 audio codec
+- audio-routing : A list of the connections between audio components.
+  Each entry is a pair of strings, the first being the connection's sink,
+  the second being the connection's source. Valid names could be power
+  supplies, WM8974 pins, and the jacks on the board:
+
+  Power supplies:
+   * Mic Bias
+
+  WM8974 pins:
+   * MICN
+   * MICP
+   * AUX
+   * MONOOUT
+   * SPKOUTP
+   * SPKOUTN
+
+  Board connectors:
+   * Mic Jack
+   * Line In Jack
+   * Headphone Jack
+   * Line Out Jack
+   * Ext Spk
+
+- mux-int-port : The internal port of the i.MX audio muxer (AUDMUX)
+- mux-ext-port : The external port of the i.MX audio muxer
+
+Note: The AUDMUX port numbering should start at 1, which is consistent with
+hardware manual.
+
+Example:
+
+sound {
+	compatible = "fsl,imx-audio-wm8974";
+	model = "wm8974";
+	ssi-controller = <&ssi1>;
+	audio-codec = <&wm8974>;
+	audio-routing =
+		"Mic Jack", "Mic Bias",
+	mux-int-port = <1>;
+	mux-ext-port = <4>;
+};
diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 4563b28..19d9b31 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -179,4 +179,16 @@ config SND_SOC_IMX_MC13783
 	select SND_SOC_MC13783
 	select SND_SOC_IMX_PCM_DMA
 
+config SND_SOC_IMX_WM8974
+	tristate "SoC Audio support for i.MX boards with WM8974"
+	depends on OF && SPI
+	select SND_SOC_IMX_AUDMUX
+	select SND_SOC_IMX_PCM_DMA
+	select SND_SOC_FSL_SSI
+	select SND_SOC_FSL_UTILS
+	select SND_SOC_WM8974
+	help
+	  Say Y here if you want to add support for SoC audio on an i.MX board with
+	  a wm8974 codec.
+
 endif # SND_IMX_SOC
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index 5f3cf3f..1a8ac3d 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -42,6 +42,7 @@ snd-soc-mx27vis-aic32x4-objs := mx27vis-aic32x4.o
 snd-soc-wm1133-ev1-objs := wm1133-ev1.o
 snd-soc-imx-sgtl5000-objs := imx-sgtl5000.o
 snd-soc-imx-mc13783-objs := imx-mc13783.o
+snd-soc-imx-wm8974-objs := imx-wm8974.o
 
 obj-$(CONFIG_SND_SOC_EUKREA_TLV320) += snd-soc-eukrea-tlv320.o
 obj-$(CONFIG_SND_SOC_PHYCORE_AC97) += snd-soc-phycore-ac97.o
@@ -49,3 +50,4 @@ obj-$(CONFIG_SND_SOC_MX27VIS_AIC32X4) += snd-soc-mx27vis-aic32x4.o
 obj-$(CONFIG_SND_MXC_SOC_WM1133_EV1) += snd-soc-wm1133-ev1.o
 obj-$(CONFIG_SND_SOC_IMX_SGTL5000) += snd-soc-imx-sgtl5000.o
 obj-$(CONFIG_SND_SOC_IMX_MC13783) += snd-soc-imx-mc13783.o
+obj-$(CONFIG_SND_SOC_IMX_WM8974) += snd-soc-imx-wm8974.o
diff --git a/sound/soc/fsl/imx-wm8974.c b/sound/soc/fsl/imx-wm8974.c
new file mode 100644
index 0000000..02b239d
--- /dev/null
+++ b/sound/soc/fsl/imx-wm8974.c
@@ -0,0 +1,233 @@
+/*
+ * Copyright (C) 2012 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ * Steffen Trumtrar <s.trumtrar@pengutronix.de>
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <linux/module.h>
+#include <sound/soc.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/spi/spi.h>
+#include <linux/clk.h>
+
+#include "imx-audmux.h"
+#include "../codecs/wm8974.h"
+
+#define DRIVER_NAME "imx-wm8974"
+
+#define DAI_NAME_SIZE	32
+
+struct imx_wm8974_data {
+	struct snd_soc_dai_link dai;
+	struct snd_soc_card card;
+	char codec_dai_name[DAI_NAME_SIZE];
+	char platform_name[DAI_NAME_SIZE];
+	struct clk *codec_clk;
+	unsigned int clk_frequency;
+};
+
+static int imx_wm8974_dai_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct imx_wm8974_data *data = container_of(rtd->card,
+					struct imx_wm8974_data, card);
+	struct device *dev = rtd->card->dev;
+	int ret;
+
+	/* the pll stability peaks at N=8 and around 90MHz.
+	 * This values are best reached with a 12.288MHz or
+	 * 11.289MHz clock. As the first is closer to N=8 in
+	 * more situations, chose 12.288MHz as the target clock
+	 * (ref: datasheet section "Master Clock and Phase Locked Loop")*/
+	ret = snd_soc_dai_set_pll(rtd->codec_dai, 0, 0, data->clk_frequency,
+		12288000);
+	if (ret) {
+		dev_err(dev, "couldn't set pll: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget imx_wm8974_dapm_widgets[] = {
+	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+	SND_SOC_DAPM_SPK("Ext Spk", NULL),
+};
+
+static int __devinit imx_wm8974_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *ssi_np, *codec_np;
+	struct device_node *audmux_np;
+	struct platform_device *ssi_pdev;
+	struct spi_device *codec_pdev;
+	struct imx_wm8974_data *data;
+	int int_port, ext_port;
+	int ret;
+
+	ret = of_property_read_u32(np, "mux-int-port", &int_port);
+	if (ret) {
+		dev_err(&pdev->dev, "mux-int-port missing or invalid\n");
+		return ret;
+	}
+	ret = of_property_read_u32(np, "mux-ext-port", &ext_port);
+	if (ret) {
+		dev_err(&pdev->dev, "mux-ext-port missing or invalid\n");
+		return ret;
+	}
+
+	/*
+	 * The port numbering in the hardware manual starts at 1, while
+	 * the audmux API expects it starts at 0.
+	 */
+	int_port--;
+	ext_port--;
+
+	audmux_np = of_find_node_by_name(NULL, "audmux");
+	if (!audmux_np) {
+		dev_err(&pdev->dev, "audmux missing or invalid\n");
+		return ret;
+	}
+
+	if (of_device_is_compatible(audmux_np, "fsl,imx21-audmux")) {
+		ret = imx_audmux_v1_configure_port(int_port,
+					IMX_AUDMUX_V1_PCR_TFSDIR |
+					IMX_AUDMUX_V1_PCR_TCLKDIR |
+					IMX_AUDMUX_V1_PCR_TFCSEL(ext_port) |
+					IMX_AUDMUX_V1_PCR_RXDSEL(ext_port) |
+					IMX_AUDMUX_V1_PCR_SYN);
+		if (ret) {
+			dev_err(&pdev->dev, "audmux internal port setup failed\n");
+			return ret;
+		}
+		ret = imx_audmux_v1_configure_port(ext_port,
+					IMX_AUDMUX_V1_PCR_RXDSEL(int_port) |
+					IMX_AUDMUX_V1_PCR_SYN);
+		if (ret) {
+			dev_err(&pdev->dev, "audmux external port setup failed\n");
+			return ret;
+		}
+	} else {
+		dev_err(&pdev->dev, "audmux not compatible\n");
+	}
+	of_node_put(audmux_np);
+
+	ssi_np = of_parse_phandle(np, "ssi-controller", 0);
+	codec_np = of_parse_phandle(np, "audio-codec", 0);
+	if (!ssi_np || !codec_np) {
+		dev_err(&pdev->dev, "phandle missing or invalid\n");
+		ret = -EINVAL;
+		goto fail;
+	}
+
+	ssi_pdev = of_find_device_by_node(ssi_np);
+	if (!ssi_pdev) {
+		dev_err(&pdev->dev, "failed to find SSI platform device\n");
+		ret = -EINVAL;
+		goto fail;
+	}
+
+	codec_pdev = of_find_spi_device_by_node(codec_np);
+	if (!codec_pdev) {
+		dev_err(&pdev->dev, "failed to find codec platform device\n");
+		ret = -EINVAL;
+		goto fail;
+	}
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	data->codec_clk = clk_get(&codec_pdev->dev, NULL);
+	if (IS_ERR(data->codec_clk)) {
+		data->codec_clk = NULL;
+		ret = of_property_read_u32(codec_np, "clock-frequency",
+					&data->clk_frequency);
+		if (ret) {
+			dev_err(&codec_pdev->dev,
+				"clock-frequency missing or invalid\n");
+			goto fail;
+		}
+	} else {
+		data->clk_frequency = clk_get_rate(data->codec_clk);
+		clk_prepare_enable(data->codec_clk);
+	}
+
+	data->dai.name = "HiFi";
+	data->dai.stream_name = "HiFi";
+	data->dai.codec_dai_name = "wm8974-hifi";
+	data->dai.codec_of_node = codec_np;
+	data->dai.cpu_dai_name = dev_name(&ssi_pdev->dev);
+	data->dai.platform_name = "imx-pcm-audio";
+	data->dai.init = &imx_wm8974_dai_init;
+	data->dai.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			    SND_SOC_DAIFMT_CBM_CFM;
+
+	data->card.dev = &pdev->dev;
+	ret = snd_soc_of_parse_card_name(&data->card, "model");
+	if (ret)
+		goto clk_fail;
+	ret = snd_soc_of_parse_audio_routing(&data->card, "audio-routing");
+	if (ret)
+		goto clk_fail;
+
+	data->card.name = "wm8974-hifi";
+	data->card.num_links = 1;
+	data->card.dai_link = &data->dai;
+	data->card.dapm_widgets = imx_wm8974_dapm_widgets;
+	data->card.num_dapm_widgets = ARRAY_SIZE(imx_wm8974_dapm_widgets);
+
+	ret = snd_soc_register_card(&data->card);
+	if (ret) {
+		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
+		goto clk_fail;
+	}
+
+	platform_set_drvdata(pdev, data);
+
+clk_fail:
+	clk_put(data->codec_clk);
+fail:
+	if (ssi_np)
+		of_node_put(ssi_np);
+	if (codec_np)
+		of_node_put(codec_np);
+	if (codec_pdev)
+		spi_dev_put(codec_pdev);
+	return ret;
+}
+
+static int __devexit imx_wm8974_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_card(card);
+
+	return 0;
+}
+
+static const struct of_device_id imx_wm8974_of_match[] __devinitconst = {
+	{ .compatible = "fsl,imx-audio-wm8974", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx_wm8974_of_match);
+
+static struct platform_driver imx_wm8974_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.owner = THIS_MODULE,
+		.of_match_table = imx_wm8974_of_match,
+	},
+	.probe = imx_wm8974_probe,
+	.remove = __devexit_p(imx_wm8974_remove),
+};
+module_platform_driver(imx_wm8974_driver);
+
+MODULE_AUTHOR("Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>");
+MODULE_AUTHOR("Steffen Trumtrar <s.trumtrar@pengutronix.de>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
1.7.10.4
