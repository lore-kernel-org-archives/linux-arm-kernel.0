From: tony@atomide.com (Tony Lindgren)
Date: Mon, 23 Apr 2012 17:13:30 -0700
Subject: [PATCH 07/12] mmc: omap: add DMA engine support
In-Reply-To: <E1SMLmZ-0002WS-Rd@rmk-PC.arm.linux.org.uk>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
 <E1SMLmZ-0002WS-Rd@rmk-PC.arm.linux.org.uk>
Message-ID: <20120424001330.GD3739@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King <rmk+kernel@arm.linux.org.uk> [120423 09:11]:
> Add DMA engine support to the OMAP driver.  This supplements the
> private DMA API implementation contained within this driver, and the
> driver can be switched at build time between using DMA engine and the
> private DMA API.

Below is what's needed to use DMA request lines from platform data.
Note also the release_mem_region change that we'll now need for
this one also (but not as a fix).

I've posted a cleanup patch series to mostly remove plat-omap/devices.c
that takes care of passing the DMA request lines in platform data.
That series should get merged before the driver changes for this
driver to keep DMA working.

Regards,

Tony


--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1313,7 +1313,7 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
 	struct mmc_omap_host *host = NULL;
 	struct resource *res;
 	dma_cap_mask_t mask;
-	unsigned sig;
+	unsigned tx_req, rx_req;
 	int i, ret = 0;
 	int irq;
 
@@ -1389,37 +1389,44 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
 	host->dma_tx_burst = -1;
 	host->dma_rx_burst = -1;
 
-	if (cpu_is_omap24xx())
-		sig = host->id == 0 ? OMAP24XX_DMA_MMC1_TX : OMAP24XX_DMA_MMC2_TX;
-	else
-		sig = host->id == 0 ? OMAP_DMA_MMC_TX : OMAP_DMA_MMC2_TX;
-	host->dma_tx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
+	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
+	if (!res) {
+		dev_err(host->dev, "cannot get DMA TX channel\n");
+		goto err_free_dma;
+	}
+	tx_req = res->start;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
+	if (!res) {
+		dev_err(host->dev, "cannot get DMA RX channel\n");
+		goto err_free_dma;
+	}
+	rx_req = res->start;
+
+	host->dma_tx = dma_request_channel(mask, omap_dma_filter_fn, &tx_req);
 #if 0
 	if (!host->dma_tx) {
 		dev_err(host->dev, "unable to obtain TX DMA engine channel %u\n",
-			sig);
-		goto err_dma;
+			tx_req);
+		goto err_free_dma;
 	}
 #else
 	if (!host->dma_tx)
 		dev_warn(host->dev, "unable to obtain TX DMA engine channel %u\n",
-			sig);
+			tx_req);
 #endif
-	if (cpu_is_omap24xx())
-		sig = host->id == 0 ? OMAP24XX_DMA_MMC1_RX : OMAP24XX_DMA_MMC2_RX;
-	else
-		sig = host->id == 0 ? OMAP_DMA_MMC_RX : OMAP_DMA_MMC2_RX;
-	host->dma_rx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
+
+	host->dma_rx = dma_request_channel(mask, omap_dma_filter_fn, &rx_req);
 #if 0
 	if (!host->dma_rx) {
 		dev_err(host->dev, "unable to obtain RX DMA engine channel %u\n",
-			sig);
-		goto err_dma;
+			rx_req);
+		goto err_free_dma;
 	}
 #else
 	if (!host->dma_rx)
 		dev_warn(host->dev, "unable to obtain RX DMA engine channel %u\n",
-			sig);
+			rx_req);
 #endif
 
 	ret = request_irq(host->irq, mmc_omap_irq, 0, DRIVER_NAME, host);
@@ -1466,7 +1473,9 @@ err_free_mmc_host:
 err_ioremap:
 	kfree(host);
 err_free_mem_region:
-	release_mem_region(res->start, resource_size(res));
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res)
+		release_mem_region(res->start, resource_size(res));
 	return ret;
 }
 
