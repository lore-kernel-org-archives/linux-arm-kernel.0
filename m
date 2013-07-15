From: denis@eukrea.com (Denis Carikli)
Date: Mon, 15 Jul 2013 16:56:53 +0200
Subject: [PATCH 08/22] ASoC: eukrea-tlv320: Add DT support.
In-Reply-To: <1373900227-341-1-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
Message-ID: <1373900227-341-9-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 sound/soc/fsl/Kconfig         |    5 +-
 sound/soc/fsl/eukrea-tlv320.c |  105 +++++++++++++++++++++++++++++++++--------
 2 files changed, 90 insertions(+), 20 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index aa43854..de21f48 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -158,12 +158,15 @@ config SND_SOC_EUKREA_TLV320
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
index 9a4a0ca..090e1c9 100644
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -17,6 +17,8 @@
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/device.h>
 #include <linux/i2c.h>
 #include <sound/core.h>
@@ -26,24 +28,33 @@
 
 #include "../codecs/tlv320aic23.h"
 #include "imx-ssi.h"
+#include "fsl_ssi.h"
 #include "imx-audmux.h"
 
 #define CODEC_CLOCK 12000000
 
+struct eukrea_tlv320 {
+	char of;
+};
+
 static int eukrea_tlv320_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct eukrea_tlv320 *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret;
 
-	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
-				  SND_SOC_DAIFMT_NB_NF |
-				  SND_SOC_DAIFMT_CBM_CFM);
-	if (ret) {
-		pr_err("%s: failed set cpu dai format\n", __func__);
-		return ret;
+	/* fsl_ssi lacks the set_fmt ops. */
+	if (!priv->of) {
+		ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+					  SND_SOC_DAIFMT_NB_NF |
+					  SND_SOC_DAIFMT_CBM_CFM);
+		if (ret) {
+			pr_err("%s: failed set cpu dai format\n", __func__);
+			return ret;
+		}
 	}
 
 	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
@@ -60,15 +71,18 @@ static int eukrea_tlv320_hw_params(struct snd_pcm_substream *substream,
 		pr_err("%s: failed setting codec sysclk\n", __func__);
 		return ret;
 	}
-	snd_soc_dai_set_tdm_slot(cpu_dai, 0xffffffc, 0xffffffc, 2, 0);
 
-	ret = snd_soc_dai_set_sysclk(cpu_dai, IMX_SSP_SYS_CLK, 0,
-				SND_SOC_CLOCK_IN);
-	if (ret) {
-		pr_err("can't set CPU system clock IMX_SSP_SYS_CLK\n");
-		return ret;
-	}
+	/* fsl_ssi lacks the set_sysclk ops */
+	if (!priv->of) {
+		snd_soc_dai_set_tdm_slot(cpu_dai, 0xffffffc, 0xffffffc, 2, 0);
 
+		ret = snd_soc_dai_set_sysclk(cpu_dai, IMX_SSP_SYS_CLK, 0,
+					SND_SOC_CLOCK_IN);
+		if (ret) {
+			pr_err("can't set CPU system clock IMX_SSP_SYS_CLK\n");
+			return ret;
+		}
+	}
 	return 0;
 }
 
@@ -80,7 +94,6 @@ static struct snd_soc_dai_link eukrea_tlv320_dai = {
 	.name		= "tlv320aic23",
 	.stream_name	= "TLV320AIC23",
 	.codec_dai_name	= "tlv320aic23-hifi",
-	.platform_name	= "imx-ssi.0",
 	.codec_name	= "tlv320aic23-codec.0-001a",
 	.cpu_dai_name	= "imx-ssi.0",
 	.ops		= &eukrea_tlv320_snd_ops,
@@ -97,8 +110,49 @@ static int eukrea_tlv320_probe(struct platform_device *pdev)
 {
 	int ret;
 	int int_port = 0, ext_port;
-
-	if (machine_is_eukrea_cpuimx27()) {
+	struct platform_device *ssi_pdev;
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *ssi_np;
+	struct eukrea_tlv320 *priv;
+
+	priv = devm_kzalloc(&pdev->dev,
+				sizeof(struct eukrea_tlv320), GFP_KERNEL);
+	if (priv == NULL)
+		return -ENOMEM;
+
+	if (np) {
+		ssi_np = of_parse_phandle(pdev->dev.of_node,
+					  "ssi-controller", 0);
+		ssi_pdev = of_find_device_by_node(ssi_np);
+
+		ret = of_property_read_u32(np, "mux-int-port", &int_port);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"mux-int-port missing or invalid\n");
+			return ret;
+		}
+		ret = of_property_read_u32(np, "mux-ext-port", &ext_port);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"mux-ext-port missing or invalid\n");
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
+		eukrea_tlv320_dai.cpu_dai_name = dev_name(&ssi_pdev->dev);
+		eukrea_tlv320_dai.platform_of_node = ssi_np;
+		priv->of = 1;
+	} else
+		eukrea_tlv320_dai.platform_name = "imx-ssi.0";
+
+	if (machine_is_eukrea_cpuimx27() ||
+	    of_machine_is_compatible("fsl,eukrea_cpuimx27")) {
 		imx_audmux_v1_configure_port(MX27_AUDMUX_HPCR1_SSI0,
 			IMX_AUDMUX_V1_PCR_SYN |
 			IMX_AUDMUX_V1_PCR_TFSDIR |
@@ -115,8 +169,14 @@ static int eukrea_tlv320_probe(struct platform_device *pdev)
 		);
 	} else if (machine_is_eukrea_cpuimx25sd() ||
 		   machine_is_eukrea_cpuimx35sd() ||
-		   machine_is_eukrea_cpuimx51sd()) {
-		ext_port = machine_is_eukrea_cpuimx25sd() ? 4 : 3;
+		   machine_is_eukrea_cpuimx51sd() ||
+		   of_machine_is_compatible("fsl,eukrea_cpuimx25") ||
+		   of_machine_is_compatible("fsl,eukrea_cpuimx35") ||
+		   of_machine_is_compatible("fsl,eukrea_cpuimx51")) {
+		ext_port = (machine_is_eukrea_cpuimx25sd() ||
+			    of_machine_is_compatible("fsl,eukrea_cpuimx25")) ?
+				4 : 3;
+
 		imx_audmux_v2_configure_port(int_port,
 			IMX_AUDMUX_V2_PTCR_SYN |
 			IMX_AUDMUX_V2_PTCR_TFSDIR |
@@ -133,8 +193,8 @@ static int eukrea_tlv320_probe(struct platform_device *pdev)
 		/* return happy. We might run on a totally different machine */
 		return 0;
 	}
-
 	eukrea_tlv320.dev = &pdev->dev;
+	snd_soc_card_set_drvdata(&eukrea_tlv320, priv);
 	ret = snd_soc_register_card(&eukrea_tlv320);
 	if (ret)
 		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
@@ -149,10 +209,17 @@ static int eukrea_tlv320_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id imx_tlv320_dt_ids[] = {
+	{ .compatible = "fsl,eukrea-tlv320"},
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
 	.remove = eukrea_tlv320_remove,};
-- 
1.7.9.5
