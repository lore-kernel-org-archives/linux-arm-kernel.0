From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 23 Feb 2012 16:56:44 +0530
Subject: [PATCH v2 1/6] mmc: omap_hsmmc: use platform_get_resource_byname for
 tx/rx DMA channels
In-Reply-To: <1329996409-26861-1-git-send-email-rnayak@ti.com>
References: <1329996409-26861-1-git-send-email-rnayak@ti.com>
Message-ID: <1329996409-26861-2-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Balaji T K <balajitk@ti.com>

Git rid of hardcoded tx/rx DMA channels based on pdev->id
and use platform_get_resource_byname() to retrieve them
instead.

Signed-off-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Tested-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   35 +++++++++++------------------------
 1 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index fd0c661..2a660ab 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1977,32 +1977,19 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 
 	omap_hsmmc_conf_bus_power(host);
 
-	/* Select DMA lines */
-	switch (host->id) {
-	case OMAP_MMC1_DEVID:
-		host->dma_line_tx = OMAP24XX_DMA_MMC1_TX;
-		host->dma_line_rx = OMAP24XX_DMA_MMC1_RX;
-		break;
-	case OMAP_MMC2_DEVID:
-		host->dma_line_tx = OMAP24XX_DMA_MMC2_TX;
-		host->dma_line_rx = OMAP24XX_DMA_MMC2_RX;
-		break;
-	case OMAP_MMC3_DEVID:
-		host->dma_line_tx = OMAP34XX_DMA_MMC3_TX;
-		host->dma_line_rx = OMAP34XX_DMA_MMC3_RX;
-		break;
-	case OMAP_MMC4_DEVID:
-		host->dma_line_tx = OMAP44XX_DMA_MMC4_TX;
-		host->dma_line_rx = OMAP44XX_DMA_MMC4_RX;
-		break;
-	case OMAP_MMC5_DEVID:
-		host->dma_line_tx = OMAP44XX_DMA_MMC5_TX;
-		host->dma_line_rx = OMAP44XX_DMA_MMC5_RX;
-		break;
-	default:
-		dev_err(mmc_dev(host->mmc), "Invalid MMC id\n");
+	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
+	if (!res) {
+		dev_err(mmc_dev(host->mmc), "cannot get DMA TX channel\n");
+		goto err_irq;
+	}
+	host->dma_line_tx = res->start;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
+	if (!res) {
+		dev_err(mmc_dev(host->mmc), "cannot get DMA RX channel\n");
 		goto err_irq;
 	}
+	host->dma_line_rx = res->start;
 
 	/* Request IRQ for MMC operations */
 	ret = request_irq(host->irq, omap_hsmmc_irq, 0,
-- 
1.7.1
