From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 14 Apr 2013 13:42:49 +0200
Subject: [PATCH v3 05/15] ASoC: phycore-ac97: Add DT support
In-Reply-To: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
References: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1365939779-4507-6-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add devicetree support for this audio soc fabric driver.

DT initialized drivers do not have real device ids, so
imx-pcm-fiq-audio.0 is used without '.0'.

This patch also simplifies the way audmux ports are configured. Before
there was knowledge about the used board. As the audmux driver knows the
used board, we know use the returned errorcodes to correctly set the
audmux port. So this driver does not have to know which board it is
running on.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---

Notes:
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
    
    Changes in v2:
     - Simplify the driver, by combining audmux port configurations. The
       audmux driver actually knows on which platform he is running and
       will return the appropriate error code if we use functions for
       another platform. So we don't need to have the knowledge about it
       in phycore-ac97 and can try both functions. This removes the need
       of different compatibilities and renames it to imx27-ac97.
     - Use a phandle for the cpu_dai link.
     - Add devicetree binding documentation.
     - Rename binding to phytec,phycore-ac97 and fsl,ssi to phytec,ssi

 .../bindings/sound/phytec,phycore-ac97.txt         |  12 ++
 sound/soc/fsl/phycore-ac97.c                       | 184 ++++++++++++++++++---
 2 files changed, 174 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/phytec,phycore-ac97.txt

diff --git a/Documentation/devicetree/bindings/sound/phytec,phycore-ac97.txt b/Documentation/devicetree/bindings/sound/phytec,phycore-ac97.txt
new file mode 100644
index 0000000..e04221d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/phytec,phycore-ac97.txt
@@ -0,0 +1,12 @@
+Phytec phycore AC97
+
+Required properties:
+- compatible: "phytec,phycore-ac97"
+- phytec,ssi: A phandle to the ssi device that is connected to ac97.
+
+Example:
+
+sound {
+	compatible = "phytec,phycore-ac97";
+	phytec,ssi = <&ssi1>;
+};
diff --git a/sound/soc/fsl/phycore-ac97.c b/sound/soc/fsl/phycore-ac97.c
index f8da6dd..cebd93f 100644
--- a/sound/soc/fsl/phycore-ac97.c
+++ b/sound/soc/fsl/phycore-ac97.c
@@ -21,7 +21,10 @@
 
 #include "imx-audmux.h"
 
+#define DRV_NAME "phycore-audio-fabric"
+
 static struct snd_soc_card imx_phycore;
+static struct device_node *phycore_dai_cpu_node;
 
 static struct snd_soc_ops imx_phycore_hifi_ops = {
 };
@@ -32,8 +35,12 @@ static struct snd_soc_dai_link imx_phycore_dai_ac97[] = {
 		.stream_name	= "HiFi",
 		.codec_dai_name		= "wm9712-hifi",
 		.codec_name	= "wm9712-codec",
+#ifdef CONFIG_MACH_IMX27_DT
+		.platform_name	= "imx-fiq-pcm-audio",
+#else
 		.cpu_dai_name	= "imx-ssi.0",
 		.platform_name	= "imx-fiq-pcm-audio.0",
+#endif
 		.ops		= &imx_phycore_hifi_ops,
 	},
 };
@@ -45,35 +52,78 @@ static struct snd_soc_card imx_phycore = {
 	.num_links	= ARRAY_SIZE(imx_phycore_dai_ac97),
 };
 
-static struct platform_device *imx_phycore_snd_ac97_device;
+static int phycore_ac97_pca100_audmux(void)
+{
+	int ret;
+
+	ret = imx_audmux_v1_configure_port(MX27_AUDMUX_HPCR1_SSI0,
+		IMX_AUDMUX_V1_PCR_SYN | /* 4wire mode */
+		IMX_AUDMUX_V1_PCR_TFCSEL(3) |
+		IMX_AUDMUX_V1_PCR_TCLKDIR | /* clock is output */
+		IMX_AUDMUX_V1_PCR_RXDSEL(3));
+	if (ret)
+		return ret;
+
+	ret = imx_audmux_v1_configure_port(3,
+		IMX_AUDMUX_V1_PCR_SYN | /* 4wire mode */
+		IMX_AUDMUX_V1_PCR_TFCSEL(0) |
+		IMX_AUDMUX_V1_PCR_TFSDIR |
+		IMX_AUDMUX_V1_PCR_RXDSEL(0));
+	return ret;
+}
+
+static int phycore_ac97_pcm043_audmux(void)
+{
+	int ret;
+
+	ret = imx_audmux_v2_configure_port(3,
+		IMX_AUDMUX_V2_PTCR_SYN | /* 4wire mode */
+		IMX_AUDMUX_V2_PTCR_TFSEL(0) |
+		IMX_AUDMUX_V2_PTCR_TFSDIR,
+		IMX_AUDMUX_V2_PDCR_RXDSEL(0));
+	if (ret)
+		return ret;
+
+	ret = imx_audmux_v2_configure_port(0,
+		IMX_AUDMUX_V2_PTCR_SYN | /* 4wire mode */
+		IMX_AUDMUX_V2_PTCR_TCSEL(3) |
+		IMX_AUDMUX_V2_PTCR_TCLKDIR, /* clock is output */
+		IMX_AUDMUX_V2_PDCR_RXDSEL(3));
+	return ret;
+}
+
+static __maybe_unused int phycore_ac97_init_audmux(void)
+{
+	int ret;
+
+	/*
+	 * This driver doesn't need to know which actual hardware is used.
+	 * The audmux driver has knowledge about it's type, and returns
+	 * an error if executed on the wrong type of hardware.
+	 */
+	ret = phycore_ac97_pca100_audmux();
+	if (!ret)
+		return 0;
+
+	ret = phycore_ac97_pcm043_audmux();
+
+	return ret;
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
@@ -120,6 +170,96 @@ static void __exit imx_phycore_exit(void)
 late_initcall(imx_phycore_init);
 module_exit(imx_phycore_exit);
 
+#else  /* !CONFIG_MACH_IMX27_DT */
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
+
+	imx_phycore.dev = &pdev->dev;
+
+	ret = phycore_ac97_init_audmux();
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to initialize audmux\n");
+		return ret;
+	}
+
+	ssi_np = of_parse_phandle(pdev->dev.of_node, "phytec,ssi", 0);
+	if (!ssi_np) {
+		dev_err(&pdev->dev, "No valid ssi phandle found\n");
+		return -EINVAL;
+	}
+
+	imx_phycore_dai_ac97[0].cpu_of_node = ssi_np;
+	phycore_dai_cpu_node = ssi_np;
+
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
