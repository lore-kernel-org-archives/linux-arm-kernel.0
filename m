From: denis@eukrea.com (Denis Carikli)
Date: Wed, 27 Nov 2013 16:54:20 +0100
Subject: [PATCHv8][ 1/5] ASoC: eukrea-tlv320: Add DT support.
Message-ID: <1385567664-758-1-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel at alsa-project.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v7->v8:
- fixed the vendor prefixes in the dts bindings.
- updated the code and the documentation accordingly.
- removed the need of an audio-codec property, since it's available in the ssi bindings.
- the dai codec is now retrived trough the dt in order to support machines that have its 
  codec on another i2c bus number.
- driver compatible is now similar to the ones of the other drivers.

ChangeLog v6->v7:
- The cleanups went into another patch.
- The support for fsl_ssi doesn't depend on dt anymore.
- platform_name = "imx-ssi.0" is still set when in non-dt mode.
---
 .../devicetree/bindings/sound/eukrea-tlv320.txt    |   21 ++++
 sound/soc/fsl/Kconfig                              |    5 +-
 sound/soc/fsl/eukrea-tlv320.c                      |  108 +++++++++++++++++---
 3 files changed, 121 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/eukrea-tlv320.txt

diff --git a/Documentation/devicetree/bindings/sound/eukrea-tlv320.txt b/Documentation/devicetree/bindings/sound/eukrea-tlv320.txt
new file mode 100644
index 0000000..0d7985c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/eukrea-tlv320.txt
@@ -0,0 +1,21 @@
+Audio complex for Eukrea boards with tlv320aic23 codec.
+
+Required properties:
+- compatible : "eukrea,asoc-tlv320"
+- eukrea,model : The user-visible name of this sound complex.
+- ssi-controller : The phandle of the SSI controller.
+- fsl,mux-int-port : The internal port of the i.MX audio muxer (AUDMUX).
+- fsl,mux-ext-port : The external port of the i.MX audio muxer.
+
+Note: The AUDMUX port numbering should start at 1, which is consistent with
+hardware manual.
+
+Example:
+
+	sound {
+		compatible = "eukrea,asoc-tlv320";
+		eukrea,model = "imx51-eukrea-tlv320aic23";
+		ssi-controller = <&ssi2>;
+		fsl,mux-int-port = <2>;
+		fsl,mux-ext-port = <3>;
+	};
diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index b7ab71f..9c3cd64 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -161,12 +161,15 @@ config SND_SOC_EUKREA_TLV320
 	depends on MACH_EUKREA_MBIMX27_BASEBOARD \
 		|| MACH_EUKREA_MBIMXSD25_BASEBOARD \
 		|| MACH_EUKREA_MBIMXSD35_BASEBOARD \
-		|| MACH_EUKREA_MBIMXSD51_BASEBOARD
+		|| MACH_EUKREA_MBIMXSD51_BASEBOARD \
+		|| OF
 	depends on I2C
 	select SND_SOC_TLV320AIC23
 	select SND_SOC_IMX_PCM_FIQ
 	select SND_SOC_IMX_AUDMUX
 	select SND_SOC_IMX_SSI
+	select SND_SOC_FSL_SSI
+	select SND_SOC_IMX_PCM_DMA
 	help
 	  Enable I2S based access to the TLV320AIC23B codec attached
 	  to the SSI interface
diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv320.c
index 5983740..eb093d5 100644
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -15,8 +15,11 @@
  *
  */
 
+#include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/device.h>
 #include <linux/i2c.h>
 #include <sound/core.h>
@@ -26,6 +29,7 @@
 
 #include "../codecs/tlv320aic23.h"
 #include "imx-ssi.h"
+#include "fsl_ssi.h"
 #include "imx-audmux.h"
 
 #define CODEC_CLOCK 12000000
@@ -41,7 +45,8 @@ static int eukrea_tlv320_hw_params(struct snd_pcm_substream *substream,
 	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
 				  SND_SOC_DAIFMT_NB_NF |
 				  SND_SOC_DAIFMT_CBM_CFM);
-	if (ret) {
+	/* fsl_ssi lacks the set_fmt ops. */
+	if (ret && ret != -ENOTSUPP) {
 		dev_err(cpu_dai->dev,
 			"Failed to set the cpu dai format.\n");
 		return ret;
@@ -63,11 +68,13 @@ static int eukrea_tlv320_hw_params(struct snd_pcm_substream *substream,
 			"Failed to set the codec sysclk.\n");
 		return ret;
 	}
+
 	snd_soc_dai_set_tdm_slot(cpu_dai, 0xffffffc, 0xffffffc, 2, 0);
 
 	ret = snd_soc_dai_set_sysclk(cpu_dai, IMX_SSP_SYS_CLK, 0,
 				SND_SOC_CLOCK_IN);
-	if (ret) {
+	/* fsl_ssi lacks the set_sysclk ops */
+	if (ret && ret != -EINVAL) {
 		dev_err(cpu_dai->dev,
 			"Can't set the IMX_SSP_SYS_CLK CPU system clock.\n");
 		return ret;
@@ -84,14 +91,10 @@ static struct snd_soc_dai_link eukrea_tlv320_dai = {
 	.name		= "tlv320aic23",
 	.stream_name	= "TLV320AIC23",
 	.codec_dai_name	= "tlv320aic23-hifi",
-	.platform_name	= "imx-ssi.0",
-	.codec_name	= "tlv320aic23-codec.0-001a",
-	.cpu_dai_name	= "imx-ssi.0",
 	.ops		= &eukrea_tlv320_snd_ops,
 };
 
 static struct snd_soc_card eukrea_tlv320 = {
-	.name		= "cpuimx-audio",
 	.owner		= THIS_MODULE,
 	.dai_link	= &eukrea_tlv320_dai,
 	.num_links	= 1,
@@ -101,8 +104,65 @@ static int eukrea_tlv320_probe(struct platform_device *pdev)
 {
 	int ret;
 	int int_port = 0, ext_port;
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *ssi_np, *codec_np;
 
-	if (machine_is_eukrea_cpuimx27()) {
+	eukrea_tlv320.dev = &pdev->dev;
+	if (np) {
+		ret = snd_soc_of_parse_card_name(&eukrea_tlv320,
+						 "eukrea,model");
+		if (ret) {
+			dev_err(&pdev->dev,
+				"eukrea,model node missing or invalid.\n");
+			goto err;
+		}
+
+		ssi_np = of_parse_phandle(pdev->dev.of_node,
+					  "ssi-controller", 0);
+		if (!ssi_np) {
+			dev_err(&pdev->dev,
+				"ssi-controller missing or invalid.\n");
+			ret = -ENODEV;
+			goto err;
+		}
+
+		codec_np = of_parse_phandle(ssi_np, "codec-handle", 0);
+		if (codec_np)
+			eukrea_tlv320_dai.codec_of_node = codec_np;
+		else
+			dev_err(&pdev->dev, "codec-handle node missing or invalid.\n");
+
+		ret = of_property_read_u32(np, "fsl,mux-int-port", &int_port);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"fsl,mux-int-port node missing or invalid.\n");
+			return ret;
+		}
+		ret = of_property_read_u32(np, "fsl,mux-ext-port", &ext_port);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"fsl,mux-ext-port node missing or invalid.\n");
+			return ret;
+		}
+
+		/*
+		 * The port numbering in the hardware manual starts at 1, while
+		 * the audmux API expects it starts at 0.
+		 */
+		int_port--;
+		ext_port--;
+
+		eukrea_tlv320_dai.cpu_of_node = ssi_np;
+		eukrea_tlv320_dai.platform_of_node = ssi_np;
+	} else {
+		eukrea_tlv320_dai.cpu_dai_name = "imx-ssi.0";
+		eukrea_tlv320_dai.platform_name = "imx-ssi.0";
+		eukrea_tlv320_dai.codec_name = "tlv320aic23-codec.0-001a";
+		eukrea_tlv320.name = "cpuimx-audio";
+	}
+
+	if (machine_is_eukrea_cpuimx27() ||
+	    of_find_compatible_node(NULL, NULL, "fsl,imx21-audmux")) {
 		imx_audmux_v1_configure_port(MX27_AUDMUX_HPCR1_SSI0,
 			IMX_AUDMUX_V1_PCR_SYN |
 			IMX_AUDMUX_V1_PCR_TFSDIR |
@@ -119,8 +179,12 @@ static int eukrea_tlv320_probe(struct platform_device *pdev)
 		);
 	} else if (machine_is_eukrea_cpuimx25sd() ||
 		   machine_is_eukrea_cpuimx35sd() ||
-		   machine_is_eukrea_cpuimx51sd()) {
-		ext_port = machine_is_eukrea_cpuimx25sd() ? 4 : 3;
+		   machine_is_eukrea_cpuimx51sd() ||
+		   of_find_compatible_node(NULL, NULL, "fsl,imx31-audmux")) {
+		if (!np)
+			ext_port = machine_is_eukrea_cpuimx25sd() ?
+				4 : 3;
+
 		imx_audmux_v2_configure_port(int_port,
 			IMX_AUDMUX_V2_PTCR_SYN |
 			IMX_AUDMUX_V2_PTCR_TFSDIR |
@@ -134,14 +198,27 @@ static int eukrea_tlv320_probe(struct platform_device *pdev)
 			IMX_AUDMUX_V2_PDCR_RXDSEL(int_port)
 		);
 	} else {
-		/* return happy. We might run on a totally different machine */
-		return 0;
+		if (np) {
+			/* The eukrea,asoc-tlv320 driver was explicitely
+			 * requested (through the device tree).
+			 */
+			dev_err(&pdev->dev,
+				"Missing or invalid audmux DT node.\n");
+			return -ENODEV;
+		} else {
+			/* Return happy.
+			 * We might run on a totally different machine.
+			 */
+			return 0;
+		}
 	}
 
-	eukrea_tlv320.dev = &pdev->dev;
 	ret = snd_soc_register_card(&eukrea_tlv320);
+err:
 	if (ret)
 		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
+	if (np)
+		of_node_put(ssi_np);
 
 	return ret;
 }
@@ -153,10 +230,17 @@ static int eukrea_tlv320_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id imx_tlv320_dt_ids[] = {
+	{ .compatible = "eukrea,asoc-tlv320"},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx_tlv320_dt_ids);
+
 static struct platform_driver eukrea_tlv320_driver = {
 	.driver = {
 		.name = "eukrea_tlv320",
 		.owner = THIS_MODULE,
+		.of_match_table = imx_tlv320_dt_ids,
 	},
 	.probe = eukrea_tlv320_probe,
 	.remove = eukrea_tlv320_remove,
-- 
1.7.9.5
