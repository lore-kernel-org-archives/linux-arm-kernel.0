From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 27 Feb 2013 23:25:41 +0800
Subject: [PATCH 05/12] spi: mxs-spi: move to use generic DMA helper
In-Reply-To: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1361978748-25281-6-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the generic DMA device tree helper supported by mxs-dma driver,
client devices only need to call dma_request_slave_channel() for
requesting a DMA channel from dmaengine.

Since mxs is a DT only platform now, along with the changes, the non-DT
case handling in probe function also gets removed.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: spi-devel-general at lists.sourceforge.net
---
 Documentation/devicetree/bindings/spi/mxs-spi.txt |   12 +++--
 drivers/spi/spi-mxs.c                             |   60 ++++-----------------
 include/linux/spi/mxs-spi.h                       |    4 +-
 3 files changed, 18 insertions(+), 58 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/mxs-spi.txt b/Documentation/devicetree/bindings/spi/mxs-spi.txt
index e2e1395..166d33b 100644
--- a/Documentation/devicetree/bindings/spi/mxs-spi.txt
+++ b/Documentation/devicetree/bindings/spi/mxs-spi.txt
@@ -3,8 +3,11 @@
 Required properties:
 - compatible: Should be "fsl,<soc>-spi", where soc is "imx23" or "imx28"
 - reg: Offset and length of the register set for the device
-- interrupts: Should contain SSP interrupts (error irq first, dma irq second)
-- fsl,ssp-dma-channel: APBX DMA channel for the SSP
+- interrupts: Should contain SSP ERROR interrupt
+- dmas: DMA specifier, consisting of a phandle to DMA controller node
+  and SSP DMA channel ID.
+  Refer to dma.txt and fsl-mxs-dma.txt for details.
+- dma-names: Must be "ssp".
 
 Optional properties:
 - clock-frequency : Input clock frequency to the SPI block in Hz.
@@ -17,6 +20,7 @@ ssp0: ssp at 80010000 {
 	#size-cells = <0>;
 	compatible = "fsl,imx28-spi";
 	reg = <0x80010000 0x2000>;
-	interrupts = <96 82>;
-	fsl,ssp-dma-channel = <0>;
+	interrupts = <96>;
+	dmas = <&dma_apbh 0>;
+	dma-names = "ssp";
 };
diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 22a0af0..5481b1a 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -490,21 +490,6 @@ static int mxs_spi_transfer_one(struct spi_master *master,
 	return status;
 }
 
-static bool mxs_ssp_dma_filter(struct dma_chan *chan, void *param)
-{
-	struct mxs_ssp *ssp = param;
-
-	if (!mxs_dma_is_apbh(chan))
-		return false;
-
-	if (chan->chan_id != ssp->dma_channel)
-		return false;
-
-	chan->private = &ssp->dma_data;
-
-	return true;
-}
-
 static const struct of_device_id mxs_spi_dt_ids[] = {
 	{ .compatible = "fsl,imx23-spi", .data = (void *) IMX23_SSP, },
 	{ .compatible = "fsl,imx28-spi", .data = (void *) IMX28_SSP, },
@@ -520,13 +505,12 @@ static int mxs_spi_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct mxs_spi *spi;
 	struct mxs_ssp *ssp;
-	struct resource *iores, *dmares;
+	struct resource *iores;
 	struct pinctrl *pinctrl;
 	struct clk *clk;
 	void __iomem *base;
-	int devid, dma_channel, clk_freq;
-	int ret = 0, irq_err, irq_dma;
-	dma_cap_mask_t mask;
+	int devid, clk_freq;
+	int ret = 0, irq_err;
 
 	/*
 	 * Default clock speed for the SPI core. 160MHz seems to
@@ -537,8 +521,7 @@ static int mxs_spi_probe(struct platform_device *pdev)
 
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq_err = platform_get_irq(pdev, 0);
-	irq_dma = platform_get_irq(pdev, 1);
-	if (!iores || irq_err < 0 || irq_dma < 0)
+	if (!iores || irq_err < 0)
 		return -EINVAL;
 
 	base = devm_ioremap_resource(&pdev->dev, iores);
@@ -553,32 +536,11 @@ static int mxs_spi_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	if (np) {
-		devid = (enum mxs_ssp_id) of_id->data;
-		/*
-		 * TODO: This is a temporary solution and should be changed
-		 * to use generic DMA binding later when the helpers get in.
-		 */
-		ret = of_property_read_u32(np, "fsl,ssp-dma-channel",
-					   &dma_channel);
-		if (ret) {
-			dev_err(&pdev->dev,
-				"Failed to get DMA channel\n");
-			return -EINVAL;
-		}
-
-		ret = of_property_read_u32(np, "clock-frequency",
-					   &clk_freq);
-		if (ret)
-			clk_freq = clk_freq_default;
-	} else {
-		dmares = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-		if (!dmares)
-			return -EINVAL;
-		devid = pdev->id_entry->driver_data;
-		dma_channel = dmares->start;
+	devid = (enum mxs_ssp_id) of_id->data;
+	ret = of_property_read_u32(np, "clock-frequency",
+				   &clk_freq);
+	if (ret)
 		clk_freq = clk_freq_default;
-	}
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*spi));
 	if (!master)
@@ -597,7 +559,6 @@ static int mxs_spi_probe(struct platform_device *pdev)
 	ssp->clk = clk;
 	ssp->base = base;
 	ssp->devid = devid;
-	ssp->dma_channel = dma_channel;
 
 	init_completion(&spi->c);
 
@@ -606,10 +567,7 @@ static int mxs_spi_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_master_free;
 
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-	ssp->dma_data.chan_irq = irq_dma;
-	ssp->dmach = dma_request_channel(mask, mxs_ssp_dma_filter, ssp);
+	ssp->dmach = dma_request_slave_channel(&pdev->dev, "ssp");
 	if (!ssp->dmach) {
 		dev_err(ssp->dev, "Failed to request DMA\n");
 		goto out_master_free;
diff --git a/include/linux/spi/mxs-spi.h b/include/linux/spi/mxs-spi.h
index 61ae130..4835486 100644
--- a/include/linux/spi/mxs-spi.h
+++ b/include/linux/spi/mxs-spi.h
@@ -24,7 +24,7 @@
 #ifndef __LINUX_SPI_MXS_SPI_H__
 #define __LINUX_SPI_MXS_SPI_H__
 
-#include <linux/fsl/mxs-dma.h>
+#include <linux/dmaengine.h>
 
 #define ssp_is_old(host)	((host)->devid == IMX23_SSP)
 
@@ -137,9 +137,7 @@ struct mxs_ssp {
 	unsigned int			clk_rate;
 	enum mxs_ssp_id			devid;
 
-	int				dma_channel;
 	struct dma_chan			*dmach;
-	struct mxs_dma_data		dma_data;
 	unsigned int			dma_dir;
 	enum dma_transfer_direction	slave_dirn;
 	u32				ssp_pio_words[SSP_PIO_NUM];
-- 
1.7.9.5
