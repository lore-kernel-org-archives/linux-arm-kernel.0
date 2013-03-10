From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 10 Mar 2013 19:33:11 +0100
Subject: [PATCH 10/10] ASoC: imx-ssi: Add imx27 and pca100 DT support
In-Reply-To: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1362940391-8338-11-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add devicetree bindings for generic imx-ssi support and specifically for
pca100 with two custom reset functions. At the moment those functions
are defined in mach-pca100.c. So until DT is the only method for
booting, the ac97 reset functions have to be exported in mach-pca100.c.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 .../devicetree/bindings/sound/fsl-imx-ssi          | 34 +++++++++
 arch/arm/mach-imx/mach-pca100.c                    |  7 +-
 sound/soc/fsl/imx-ssi.c                            | 85 +++++++++++++++++++---
 3 files changed, 115 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl-imx-ssi

diff --git a/Documentation/devicetree/bindings/sound/fsl-imx-ssi b/Documentation/devicetree/bindings/sound/fsl-imx-ssi
new file mode 100644
index 0000000..853afeb
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl-imx-ssi
@@ -0,0 +1,34 @@
+Freescale imx ssi driver
+
+Required properties:
+- compatible : "fsl,imx27-ssi" or "phytec,imx27-pca100-ssi"
+- reg : Should contain registers location and length
+- interrupts : Should be the ssi interrupt
+- clocks : Define at least one clock to be used.
+
+Optional properties:
+- dmas : DMA client request phandle list with arguements as defined by the DMA
+	controller used. See generic DMA devicetree bindings for more information.
+- dma-names : Names of the defined DMA client requests. "rx0" and "tx0" have to
+	be defined.
+- imx-ssi-ac97 : Use AC97
+- imx-ssi-i2s-slave : Use I2S slave
+- imx-ssi-net
+- imx-ssi-syn
+
+
+Example:
+ssi1: ssi at 10010000 {
+	compatible = "fsl,imx27-ssi";
+	reg = <0x10010000 0x1000>;
+	interrupts = <14>;
+	dmas = <&dma 8
+		&dma 9
+		&dma 10
+		&dma 11>;
+	dma-names = "rx0", "tx0", "rx1", "tx1";
+	clocks = <&clks 25>;
+	clock-names = "ipg";
+	imx-ssi-ac97;
+	status = "disabled";
+};
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index b8b15bb..0d54921 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -25,6 +25,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/eeprom.h>
 #include <linux/irq.h>
+#include <linux/export.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/usb/otg.h>
@@ -208,7 +209,7 @@ static const struct spi_imx_master pca100_spi0_data __initconst = {
 	.num_chipselect = ARRAY_SIZE(pca100_spi_cs),
 };
 
-static void pca100_ac97_warm_reset(struct snd_ac97 *ac97)
+void pca100_ac97_warm_reset(struct snd_ac97 *ac97)
 {
 	mxc_gpio_mode(GPIO_PORTC | 20 | GPIO_GPIO | GPIO_OUT);
 	gpio_set_value(GPIO_PORTC + 20, 1);
@@ -217,8 +218,9 @@ static void pca100_ac97_warm_reset(struct snd_ac97 *ac97)
 	mxc_gpio_mode(PC20_PF_SSI1_FS);
 	msleep(2);
 }
+EXPORT_SYMBOL(pca100_ac97_warm_reset);
 
-static void pca100_ac97_cold_reset(struct snd_ac97 *ac97)
+void pca100_ac97_cold_reset(struct snd_ac97 *ac97)
 {
 	mxc_gpio_mode(GPIO_PORTC | 20 | GPIO_GPIO | GPIO_OUT);  /* FS */
 	gpio_set_value(GPIO_PORTC + 20, 0);
@@ -232,6 +234,7 @@ static void pca100_ac97_cold_reset(struct snd_ac97 *ac97)
 	mxc_gpio_mode(PC22_PF_SSI1_TXD);
 	msleep(2);
 }
+EXPORT_SYMBOL(pca100_ac97_cold_reset);
 
 static const struct imx_ssi_platform_data pca100_ssi_pdata __initconst = {
 	.ac97_reset		= pca100_ac97_cold_reset,
diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index 96e24a3..58de760 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -38,6 +38,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
@@ -53,6 +54,46 @@
 
 #define SSI_SACNT_DEFAULT (SSI_SACNT_AC97EN | SSI_SACNT_FV)
 
+#ifdef CONFIG_MACH_PCA100
+extern void pca100_ac97_cold_reset(struct snd_ac97 *ac97);
+extern void pca100_ac97_warm_reset(struct snd_ac97 *ac97);
+#else
+void pca100_ac97_cold_reset(struct snd_ac97 *ac97) { }
+void pca100_ac97_warm_reset(struct snd_ac97 *ac97) { }
+#endif
+
+
+enum imx_ssi_type {
+	IMX27_SSI = 0,
+	IMX27_PCA100_SSI,
+};
+
+static const struct imx_ssi_platform_data imx_ssi_devtype[] = {
+	{
+		.ac97_reset = NULL,
+		.ac97_warm_reset = NULL,
+	},
+	{
+		.ac97_reset = pca100_ac97_cold_reset,
+		.ac97_warm_reset = pca100_ac97_warm_reset,
+	}, {
+		/* sentinel */
+	}
+};
+
+static const struct of_device_id imx_ssi_of_dev_id[] = {
+	{
+		.compatible = "fsl,imx27-ssi",
+		.data = &imx_ssi_devtype[IMX27_SSI],
+	}, {
+		.compatible = "phytec,imx27-pca100-ssi",
+		.data = &imx_ssi_devtype[IMX27_PCA100_SSI],
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(of, imx_ssi_of_dev_id);
+
 /*
  * SSI Network Mode or TDM slots configuration.
  * Should only be called when port is inactive (i.e. SSIEN = 0).
@@ -528,9 +569,12 @@ static int imx_ssi_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct imx_ssi *ssi;
-	struct imx_ssi_platform_data *pdata = pdev->dev.platform_data;
+	const struct imx_ssi_platform_data *pdata = pdev->dev.platform_data;
 	int ret = 0;
 	struct snd_soc_dai_driver *dai;
+	const struct of_device_id *of_id;
+
+	of_id = of_match_device(imx_ssi_of_dev_id, &pdev->dev);
 
 	ssi = devm_kzalloc(&pdev->dev, sizeof(*ssi), GFP_KERNEL);
 	if (!ssi)
@@ -538,10 +582,25 @@ static int imx_ssi_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, ssi);
 
 	if (pdata) {
-		ssi->ac97_reset = pdata->ac97_reset;
-		ssi->ac97_warm_reset = pdata->ac97_warm_reset;
 		ssi->flags = pdata->flags;
+	} else {
+		pdata = of_id->data;
+		ssi->flags = 0;
+
+		if (of_property_read_bool(pdev->dev.of_node, "dmas"))
+			ssi->flags |= IMX_SSI_DMA;
+		if (of_property_read_bool(pdev->dev.of_node, "imx-ssi-ac97"))
+			ssi->flags |= IMX_SSI_USE_AC97;
+		if (of_property_read_bool(pdev->dev.of_node, "imx-ssi-net"))
+			ssi->flags |= IMX_SSI_NET;
+		if (of_property_read_bool(pdev->dev.of_node, "imx-ssi-syn"))
+			ssi->flags |= IMX_SSI_SYN;
+		if (of_property_read_bool(pdev->dev.of_node,
+					"imx-ssi-i2s-slave"))
+			ssi->flags |= IMX_SSI_USE_I2S_SLAVE;
 	}
+	ssi->ac97_reset = pdata->ac97_reset;
+	ssi->ac97_warm_reset = pdata->ac97_warm_reset;
 
 	ssi->irq = platform_get_irq(pdev, 0);
 
@@ -586,13 +645,20 @@ static int imx_ssi_probe(struct platform_device *pdev)
 	ssi->dma_params_tx.burstsize = 6;
 	ssi->dma_params_rx.burstsize = 4;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx0");
-	if (res)
-		ssi->dma_params_tx.dma = res->start;
+	if (pdev->dev.platform_data) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx0");
+		if (res)
+			ssi->dma_params_tx.dma = res->start;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx0");
-	if (res)
-		ssi->dma_params_rx.dma = res->start;
+		res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx0");
+		if (res)
+			ssi->dma_params_rx.dma = res->start;
+	} else {
+		ssi->dma_params_rx.dma_client_node = pdev->dev.of_node;
+		ssi->dma_params_rx.dma_req_name = "rx0";
+		ssi->dma_params_tx.dma_client_node = pdev->dev.of_node;
+		ssi->dma_params_tx.dma_req_name = "tx0";
+	}
 
 	platform_set_drvdata(pdev, ssi);
 
@@ -673,6 +739,7 @@ static struct platform_driver imx_ssi_driver = {
 	.driver = {
 		.name = "imx-ssi",
 		.owner = THIS_MODULE,
+		.of_match_table = imx_ssi_of_dev_id,
 	},
 };
 
-- 
1.8.1.5
