From: tony@atomide.com (Tony Lindgren)
Date: Mon, 18 Nov 2013 10:47:24 -0800
Subject: [PATCH 2/8] mmc: omap: Fix DMA configuration to not rely on
 device id
In-Reply-To: <1384396537-3486-3-git-send-email-tony@atomide.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
 <1384396537-3486-3-git-send-email-tony@atomide.com>
Message-ID: <20131118184723.GR10317@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [131113 18:36]:
> We are wrongly relying on device id for the DMA configuration
> which can lead to wrong DMA channel being selected.
> 
> Fix the issue by using the standard resources like we should.
> 
> Cc: Chris Ball <cjb@laptop.org>
> Cc: linux-mmc at vger.kernel.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> If this looks OK, I'd like to merge this as a fix via arm-soc tree
> along with the other patches in this series as my later patches
> depend on patches in this series.

Looks like we need sig initialized in this patch to avoid some
uninitialized warnings.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Thu, 14 Nov 2013 15:25:06 -0800
Subject: [PATCH] mmc: omap: Fix DMA configuration to not rely on device id

We are wrongly relying on device id for the DMA configuration
which can lead to wrong DMA channel being selected.

Fix the issue by using the standard resources like we should.

Cc: Chris Ball <cjb@laptop.org>
Cc: linux-mmc at vger.kernel.org
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -90,17 +90,6 @@
 #define OMAP_MMC_CMDTYPE_AC	2
 #define OMAP_MMC_CMDTYPE_ADTC	3
 
-#define OMAP_DMA_MMC_TX		21
-#define OMAP_DMA_MMC_RX		22
-#define OMAP_DMA_MMC2_TX	54
-#define OMAP_DMA_MMC2_RX	55
-
-#define OMAP24XX_DMA_MMC2_TX	47
-#define OMAP24XX_DMA_MMC2_RX	48
-#define OMAP24XX_DMA_MMC1_TX	61
-#define OMAP24XX_DMA_MMC1_RX	62
-
-
 #define DRIVER_NAME "mmci-omap"
 
 /* Specifies how often in millisecs to poll for card status changes
@@ -1331,7 +1320,7 @@ static int mmc_omap_probe(struct platform_device *pdev)
 	struct mmc_omap_host *host = NULL;
 	struct resource *res;
 	dma_cap_mask_t mask;
-	unsigned sig;
+	unsigned sig = 0;
 	int i, ret = 0;
 	int irq;
 
@@ -1408,19 +1397,20 @@ static int mmc_omap_probe(struct platform_device *pdev)
 	host->dma_tx_burst = -1;
 	host->dma_rx_burst = -1;
 
-	if (mmc_omap2())
-		sig = host->id == 0 ? OMAP24XX_DMA_MMC1_TX : OMAP24XX_DMA_MMC2_TX;
-	else
-		sig = host->id == 0 ? OMAP_DMA_MMC_TX : OMAP_DMA_MMC2_TX;
-	host->dma_tx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
+	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
+	if (res)
+		sig = res->start;
+	host->dma_tx = dma_request_slave_channel_compat(mask,
+				omap_dma_filter_fn, &sig, &pdev->dev, "tx");
 	if (!host->dma_tx)
 		dev_warn(host->dev, "unable to obtain TX DMA engine channel %u\n",
 			sig);
-	if (mmc_omap2())
-		sig = host->id == 0 ? OMAP24XX_DMA_MMC1_RX : OMAP24XX_DMA_MMC2_RX;
-	else
-		sig = host->id == 0 ? OMAP_DMA_MMC_RX : OMAP_DMA_MMC2_RX;
-	host->dma_rx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
+	if (res)
+		sig = res->start;
+	host->dma_rx = dma_request_slave_channel_compat(mask,
+				omap_dma_filter_fn, &sig, &pdev->dev, "rx");
 	if (!host->dma_rx)
 		dev_warn(host->dev, "unable to obtain RX DMA engine channel %u\n",
 			sig);
