From: petr@barix.com (Petr Kulhavy)
Date: Mon,  9 May 2016 16:35:20 +0200
Subject: [PATCH v5 2/4] ASoC: Davinci: McBSP: add device tree support for McBSP
In-Reply-To: <1462804522-29544-1-git-send-email-petr@barix.com>
References: <1462804522-29544-1-git-send-email-petr@barix.com>
Message-ID: <1462804522-29544-3-git-send-email-petr@barix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds DT support for the TI DA8xx/OMAP-L1x/AM17xx/AM18xx McBSP driver.

Signed-off-by: Petr Kulhavy <petr@barix.com>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
v1: initial
v2: remove "-audio" postfix from the compatible string
    of_match_table renamed consistently with the rest of the file (davinci_i2s_match)
    "channel-combine" property removed
    devicetree DMA configuration in probe simplified
v3: remove the unused platform data
v4: no change
v5: no change

 sound/soc/davinci/Kconfig       |  6 +++-
 sound/soc/davinci/davinci-i2s.c | 80 +++++++++++++++++++++++++++--------------
 2 files changed, 59 insertions(+), 27 deletions(-)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index 50ca291cc225..6b732d8e5896 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -16,7 +16,11 @@ config SND_EDMA_SOC
 	  - DRA7xx family
 
 config SND_DAVINCI_SOC_I2S
-	tristate
+	tristate "DaVinci Multichannel Buffered Serial Port (McBSP) support"
+	depends on SND_EDMA_SOC
+	help
+	  Say Y or M here if you want to have support for McBSP IP found in
+	  Texas Instruments DaVinci DA850 SoCs.
 
 config SND_DAVINCI_SOC_MCASP
 	tristate "Multichannel Audio Serial Port (McASP) support"
diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index ec98548a5fc9..384961651904 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -4,9 +4,15 @@
  * Author:      Vladimir Barinov, <vbarinov@embeddedalley.com>
  * Copyright:   (C) 2007 MontaVista Software, Inc., <source@mvista.com>
  *
+ * DT support	(c) 2016 Petr Kulhavy, Barix AG <petr@barix.com>
+ *		based on davinci-mcasp.c DT support
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
+ *
+ * TODO:
+ * on DA850 implement HW FIFOs instead of DMA into DXR and DRR registers
  */
 
 #include <linux/init.h>
@@ -650,13 +656,24 @@ static const struct snd_soc_component_driver davinci_i2s_component = {
 
 static int davinci_i2s_probe(struct platform_device *pdev)
 {
+	struct snd_dmaengine_dai_dma_data *dma_data;
 	struct davinci_mcbsp_dev *dev;
 	struct resource *mem, *res;
 	void __iomem *io_base;
 	int *dma;
 	int ret;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
+	if (!mem) {
+		dev_warn(&pdev->dev,
+			 "\"mpu\" mem resource not found, using index 0\n");
+		mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (!mem) {
+			dev_err(&pdev->dev, "no mem resource?\n");
+			return -ENODEV;
+		}
+	}
+
 	io_base = devm_ioremap_resource(&pdev->dev, mem);
 	if (IS_ERR(io_base))
 		return PTR_ERR(io_base);
@@ -666,39 +683,43 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 	if (!dev)
 		return -ENOMEM;
 
-	dev->clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(dev->clk))
-		return -ENODEV;
-	clk_enable(dev->clk);
-
 	dev->base = io_base;
 
-	dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK].addr =
-	    (dma_addr_t)(mem->start + DAVINCI_MCBSP_DXR_REG);
+	/* setup DMA, first TX, then RX */
+	dma_data = &dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK];
+	dma_data->addr = (dma_addr_t)(mem->start + DAVINCI_MCBSP_DXR_REG);
 
-	dev->dma_data[SNDRV_PCM_STREAM_CAPTURE].addr =
-	    (dma_addr_t)(mem->start + DAVINCI_MCBSP_DRR_REG);
-
-	/* first TX, then RX */
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "no DMA resource\n");
-		ret = -ENXIO;
-		goto err_release_clk;
+	if (res) {
+		dma = &dev->dma_request[SNDRV_PCM_STREAM_PLAYBACK];
+		*dma = res->start;
+		dma_data->filter_data = dma;
+	} else if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node) {
+		dma_data->filter_data = "tx";
+	} else {
+		dev_err(&pdev->dev, "Missing DMA tx resource\n");
+		return -ENODEV;
 	}
-	dma = &dev->dma_request[SNDRV_PCM_STREAM_PLAYBACK];
-	*dma = res->start;
-	dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK].filter_data = dma;
+
+	dma_data = &dev->dma_data[SNDRV_PCM_STREAM_CAPTURE];
+	dma_data->addr = (dma_addr_t)(mem->start + DAVINCI_MCBSP_DRR_REG);
 
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
-	if (!res) {
-		dev_err(&pdev->dev, "no DMA resource\n");
-		ret = -ENXIO;
-		goto err_release_clk;
+	if (res) {
+		dma = &dev->dma_request[SNDRV_PCM_STREAM_CAPTURE];
+		*dma = res->start;
+		dma_data->filter_data = dma;
+	} else if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node) {
+		dma_data->filter_data = "rx";
+	} else {
+		dev_err(&pdev->dev, "Missing DMA rx resource\n");
+		return -ENODEV;
 	}
-	dma = &dev->dma_request[SNDRV_PCM_STREAM_CAPTURE];
-	*dma = res->start;
-	dev->dma_data[SNDRV_PCM_STREAM_CAPTURE].filter_data = dma;
+
+	dev->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(dev->clk))
+		return -ENODEV;
+	clk_enable(dev->clk);
 
 	dev->dev = &pdev->dev;
 	dev_set_drvdata(&pdev->dev, dev);
@@ -737,11 +758,18 @@ static int davinci_i2s_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id davinci_i2s_match[] = {
+	{ .compatible = "ti,da850-mcbsp" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, davinci_i2s_match);
+
 static struct platform_driver davinci_mcbsp_driver = {
 	.probe		= davinci_i2s_probe,
 	.remove		= davinci_i2s_remove,
 	.driver		= {
 		.name	= "davinci-mcbsp",
+		.of_match_table = of_match_ptr(davinci_i2s_match),
 	},
 };
 
-- 
1.9.1
