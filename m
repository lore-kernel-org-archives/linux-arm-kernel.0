From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 10 Mar 2013 19:33:08 +0100
Subject: [PATCH 07/10] ASoC: phycore-ac97: Add DT support
In-Reply-To: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1362940391-8338-8-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add devicetree support for this audio soc fabric driver.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/phycore-ac97.c | 148 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 125 insertions(+), 23 deletions(-)

diff --git a/sound/soc/fsl/phycore-ac97.c b/sound/soc/fsl/phycore-ac97.c
index d146cec..a898ce3 100644
--- a/sound/soc/fsl/phycore-ac97.c
+++ b/sound/soc/fsl/phycore-ac97.c
@@ -21,6 +21,8 @@
 
 #include "imx-audmux.h"
 
+#define DRV_NAME "phycore-audio-fabric"
+
 static struct snd_soc_card imx_phycore;
 
 static struct snd_soc_ops imx_phycore_hifi_ops = {
@@ -32,8 +34,13 @@ static struct snd_soc_dai_link imx_phycore_dai_ac97[] = {
 		.stream_name	= "HiFi",
 		.codec_dai_name		= "wm9712-hifi",
 		.codec_name	= "wm9712-codec",
+#ifdef CONFIG_MACH_IMX27_DT
+		.cpu_dai_name	= "10010000.ssi",
+		.platform_name	= "imx-fiq-pcm-audio",
+#else
 		.cpu_dai_name	= "imx-ssi.0",
 		.platform_name	= "imx-fiq-pcm-audio.0",
+#endif
 		.ops		= &imx_phycore_hifi_ops,
 	},
 };
@@ -45,41 +52,53 @@ static struct snd_soc_card imx_phycore = {
 	.num_links	= ARRAY_SIZE(imx_phycore_dai_ac97),
 };
 
-static struct platform_device *imx_phycore_snd_ac97_device;
+static void phycore_ac97_pca100_audmux(void)
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
+static void phycore_ac97_pcm043_audmux(void)
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
 static struct platform_device *imx_phycore_snd_device;
 
+#ifndef CONFIG_MACH_IMX27_DT
+
+static struct platform_device *imx_phycore_snd_ac97_device;
+
 static int __init imx_phycore_init(void)
 {
 	int ret;
 
 	if (machine_is_pca100()) {
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
+		phycore_ac97_pca100_audmux();
 	} else if (machine_is_pcm043()) {
-		imx_audmux_v2_configure_port(3,
-			IMX_AUDMUX_V2_PTCR_SYN | /* 4wire mode */
-			IMX_AUDMUX_V2_PTCR_TFSEL(0) |
-			IMX_AUDMUX_V2_PTCR_TFSDIR,
-			IMX_AUDMUX_V2_PDCR_RXDSEL(0));
-		imx_audmux_v2_configure_port(0,
-			IMX_AUDMUX_V2_PTCR_SYN | /* 4wire mode */
-			IMX_AUDMUX_V2_PTCR_TCSEL(3) |
-			IMX_AUDMUX_V2_PTCR_TCLKDIR, /* clock is output */
-			IMX_AUDMUX_V2_PDCR_RXDSEL(3));
+		phycore_ac97_pcm043_audmux();
 	} else {
 		/* return happy. We might run on a totally different machine */
 		return 0;
 	}
 
-
 	/*
 	 * First add codec driver, otherwise soc-audio may be deferred and fails
 	 * to load.
@@ -125,6 +144,89 @@ static void __exit imx_phycore_exit(void)
 late_initcall(imx_phycore_init);
 module_exit(imx_phycore_exit);
 
+#else  /* !CONFIG_MACH_IMX27_DT */
+
+enum dev_type {
+	MX27_PCA100,
+	MX27_PCM043,
+};
+
+static const struct of_device_id imx_phycore_ac97_of_dev_id[] = {
+	{
+		.compatible = "phytec,imx27-pca100-ac97",
+		.data = (void *)MX27_PCA100,
+	}, {
+		.compatible = "phytec,imx27-pcm043-ac97",
+		.data = (void *)MX27_PCM043
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(of, imx_phycore_ac97_of_dev_id);
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
+
+	imx_phycore.dev = &pdev->dev;
+
+	if (pdev->dev.of_node->data == MX27_PCA100)
+		phycore_ac97_pca100_audmux();
+	else
+		phycore_ac97_pcm043_audmux();
+
+	ret = phycore_ac97_setup_devices(pdev);
+	return ret;
+}
+
+static int imx_phycore_ac97_remove(struct platform_device *pdev)
+{
+	platform_device_unregister(imx_phycore_snd_device);
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
+#endif  /* CONFIG_MACH_IMX27_DT */
+
 MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
-MODULE_DESCRIPTION("PhyCORE ALSA SoC driver");
+MODULE_DESCRIPTION(DRV_NAME ": PhyCORE ALSA SoC fabric driver");
 MODULE_LICENSE("GPL");
-- 
1.8.1.5
