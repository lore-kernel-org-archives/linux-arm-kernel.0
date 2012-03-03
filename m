From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat,  3 Mar 2012 23:20:01 +0800
Subject: [PATCH 20/20] ASoC: fsl: add imx-sgtl5000 machine driver
In-Reply-To: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1330788001-10158-21-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the initial imx-sgtl5000 machine driver support with only
playback dai link implemented.  More features can be added on top
of it later.

It's a device tree only machine driver working with fsl_ssi driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../bindings/sound/imx-audio-sgtl5000.txt          |   24 +++
 sound/soc/fsl/Kconfig                              |   12 ++
 sound/soc/fsl/Makefile                             |    2 +
 sound/soc/fsl/imx-sgtl5000.c                       |  210 ++++++++++++++++++++
 4 files changed, 248 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
 create mode 100644 sound/soc/fsl/imx-sgtl5000.c

diff --git a/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt b/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
new file mode 100644
index 0000000..22b3f03
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
@@ -0,0 +1,24 @@
+Freescale i.MX audio complex with SGTL5000 codec
+
+Required properties:
+- compatible : "fsl,imx-audio-sgtl5000"
+- fsl,model : The user-visible name of this sound complex
+- fsl,ssi-controller : The phandle of the i.MX SSI controller
+- fsl,audio-codec : The phandle of the SGTL5000 audio codec
+- fsl,mux-int-port : The internal port of the i.MX audio muxer (AUDMUX)
+- fsl,mux-ext-port : The external port of the i.MX audio muxer
+
+Note: The AUDMUX port numbering should start at 1, which is consistent with
+hardware manual.
+
+Example:
+
+sound {
+	compatible = "fsl,imx51-babbage-sgtl5000",
+		     "fsl,imx-audio-sgtl5000";
+	fsl,model = "imx51-babbage-sgtl5000";
+	fsl,ssi-controller = <&ssi1>;
+	fsl,audio-codec = <&sgtl5000>;
+	fsl,mux-int-port = <1>;
+	fsl,mux-ext-port = <3>;
+};
diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index e579671..42a3842 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -164,4 +164,16 @@ config SND_SOC_EUKREA_TLV320
 	  Enable I2S based access to the TLV320AIC23B codec attached
 	  to the SSI interface
 
+config SND_SOC_IMX_SGTL5000
+	tristate "SoC Audio support for i.MX boards with sgtl5000"
+	depends on OF && I2C
+	select SND_SOC_SGTL5000
+	select SND_MXC_SOC_MX2
+	select SND_SOC_IMX_AUDMUX
+	select SND_SOC_FSL_SSI
+	select SND_SOC_FSL_UTILS
+	help
+	  Say Y if you want to add support for SoC audio on an i.MX board with
+	  a sgtl5000 codec.
+
 endif # SND_IMX_SOC
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index 02b3e53..5ae854b 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -40,8 +40,10 @@ snd-soc-eukrea-tlv320-objs := eukrea-tlv320.o
 snd-soc-phycore-ac97-objs := phycore-ac97.o
 snd-soc-mx27vis-aic32x4-objs := mx27vis-aic32x4.o
 snd-soc-wm1133-ev1-objs := wm1133-ev1.o
+snd-soc-imx-sgtl5000-objs := imx-sgtl5000.o
 
 obj-$(CONFIG_SND_SOC_EUKREA_TLV320) += snd-soc-eukrea-tlv320.o
 obj-$(CONFIG_SND_SOC_PHYCORE_AC97) += snd-soc-phycore-ac97.o
 obj-$(CONFIG_SND_SOC_MX27VIS_AIC32X4) += snd-soc-mx27vis-aic32x4.o
 obj-$(CONFIG_SND_MXC_SOC_WM1133_EV1) += snd-soc-wm1133-ev1.o
+obj-$(CONFIG_SND_SOC_IMX_SGTL5000) += snd-soc-imx-sgtl5000.o
diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
new file mode 100644
index 0000000..483733f
--- /dev/null
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -0,0 +1,210 @@
+/*
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright 2012 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <sound/soc.h>
+
+#include "../codecs/sgtl5000.h"
+#include "fsl_utils.h"
+#include "imx-audmux.h"
+
+struct imx_sgtl5000_data {
+	struct snd_soc_dai_link dai[2];
+	struct snd_soc_card card;
+	struct platform_device *pcm_audio_pdev;
+	struct platform_device *soc_audio_pdev;
+	char codec_name[DAI_NAME_SIZE];
+	char codec_dai_name[DAI_NAME_SIZE];
+	char platform_name[DAI_NAME_SIZE];
+	unsigned int clk_frequency;
+};
+
+static int imx_sgtl5000_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct imx_sgtl5000_data *data = container_of(rtd->card,
+					struct imx_sgtl5000_data, card);
+	struct device *dev = rtd->card->dev;
+	int ret;
+
+	ret = snd_soc_dai_set_fmt(rtd->codec_dai, SND_SOC_DAIFMT_I2S |
+						  SND_SOC_DAIFMT_NB_NF |
+						  SND_SOC_DAIFMT_CBM_CFM);
+	if (ret) {
+		dev_err(dev, "could not set codec driver audio format\n");
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_sysclk(rtd->codec_dai, SGTL5000_SYSCLK,
+				     data->clk_frequency, SND_SOC_CLOCK_IN);
+	if (ret) {
+		dev_err(dev, "could not set codec driver clock params\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops imx_sgtl5000_ops = {
+	.startup = imx_sgtl5000_startup,
+};
+
+static int __devinit imx_sgtl5000_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *ssi_np, *codec_np;
+	struct platform_device *ssi_pdev;
+	struct imx_sgtl5000_data *data;
+	int int_port, ext_port;
+	int ret;
+
+	ret = of_property_read_u32(np, "fsl,mux-int-port", &int_port);
+	if (ret) {
+		dev_err(&pdev->dev, "mux-int-port missing or invalid\n");
+		return -EINVAL;
+	}
+	ret = of_property_read_u32(np, "fsl,mux-ext-port", &ext_port);
+	if (ret) {
+		dev_err(&pdev->dev, "mux-ext-port missing or invalid\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * The port numbering in the hardware manual starts at 1, while
+	 * the audmux API expects it starts at 0.
+	 */
+	int_port--;
+	ext_port--;
+	imx_audmux_v2_configure_port(int_port,
+			IMX_AUDMUX_V2_PTCR_SYN |
+			IMX_AUDMUX_V2_PTCR_TFSEL(ext_port) |
+			IMX_AUDMUX_V2_PTCR_TCSEL(ext_port) |
+			IMX_AUDMUX_V2_PTCR_TFSDIR |
+			IMX_AUDMUX_V2_PTCR_TCLKDIR,
+			IMX_AUDMUX_V2_PDCR_RXDSEL(ext_port));
+	imx_audmux_v2_configure_port(ext_port,
+			IMX_AUDMUX_V2_PTCR_SYN |
+			IMX_AUDMUX_V2_PTCR_TCSEL(int_port),
+			IMX_AUDMUX_V2_PDCR_RXDSEL(int_port));
+
+	ssi_np = of_parse_phandle(pdev->dev.of_node, "fsl,ssi-controller", 0);
+	codec_np = of_parse_phandle(pdev->dev.of_node, "fsl,audio-codec", 0);
+	if (!ssi_np || !codec_np) {
+		dev_err(&pdev->dev, "phandle missing or invalid\n");
+		return -EINVAL;
+	}
+
+	ssi_pdev = of_find_device_by_node(ssi_np);
+	if (!ssi_pdev) {
+		dev_err(&pdev->dev, "failed to find SSI platform device\n");
+		return -EINVAL;
+	}
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	ret = of_property_read_u32(codec_np, "clock-frequency",
+				   &data->clk_frequency);
+	if (ret) {
+		dev_err(&pdev->dev, "clock-frequency missing or invalid\n");
+		return -EINVAL;
+	}
+
+	ret = fsl_asoc_get_codec_dev_name(codec_np, data->codec_name,
+					  DAI_NAME_SIZE);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to get codec name\n");
+		return -EINVAL;
+	}
+
+	data->dai[0].name = "HiFi Tx";
+	data->dai[0].stream_name = "HiFi Playback";
+	data->dai[0].codec_dai_name = "sgtl5000";
+	data->dai[0].codec_name = data->codec_name;
+	data->dai[0].cpu_dai_name = dev_name(&ssi_pdev->dev);
+	data->dai[0].platform_name = "imx-pcm-audio";
+	data->dai[0].ops = &imx_sgtl5000_ops;
+
+	ret = of_property_read_string(np, "fsl,model", &data->card.name);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to get audio card name\n");
+		return -EINVAL;
+	}
+	data->card.num_links = 1;
+	data->card.dai_link = data->dai;
+
+	/* Add imx-pcm-audio device */
+	data->pcm_audio_pdev = platform_device_alloc("imx-pcm-audio", -1);
+	if (!data->pcm_audio_pdev)
+		return -ENOMEM;
+	ret = platform_device_add(data->pcm_audio_pdev);
+	if (ret) {
+		platform_device_put(data->pcm_audio_pdev);
+		return ret;
+	}
+
+	/* Add soc-audio device */
+	data->soc_audio_pdev = platform_device_alloc("soc-audio", -1);
+	if (!data->soc_audio_pdev) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	platform_set_drvdata(data->soc_audio_pdev, &data->card);
+	ret = platform_device_add(data->soc_audio_pdev);
+	if (ret) {
+		platform_device_put(data->soc_audio_pdev);
+		goto err;
+	}
+
+	dev_set_drvdata(&pdev->dev, data);
+	of_node_put(codec_np);
+
+	return 0;
+err:
+	platform_device_unregister(data->pcm_audio_pdev);
+	return ret;
+}
+
+static int __devexit imx_sgtl5000_remove(struct platform_device *pdev)
+{
+	struct imx_sgtl5000_data *data = dev_get_drvdata(&pdev->dev);
+
+	platform_device_unregister(data->pcm_audio_pdev);
+	platform_device_unregister(data->soc_audio_pdev);
+
+	return 0;
+}
+
+static const struct of_device_id imx_sgtl5000_dt_ids[] = {
+	{ .compatible = "fsl,imx-audio-sgtl5000", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx_sgtl5000_dt_ids);
+
+static struct platform_driver imx_sgtl5000_driver = {
+	.driver = {
+		.name = "imx-sgtl5000",
+		.owner = THIS_MODULE,
+		.of_match_table = imx_sgtl5000_dt_ids,
+	},
+	.probe = imx_sgtl5000_probe,
+	.remove = __devexit_p(imx_sgtl5000_remove),
+};
+module_platform_driver(imx_sgtl5000_driver);
+
+MODULE_AUTHOR("Freescale Semiconductor, Inc.");
+MODULE_DESCRIPTION("Freescale i.MX SGTL5000 ASoC machine driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:imx-sgtl5000");
-- 
1.7.5.4
