From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 28 Nov 2014 15:08:03 +0100
Subject: [PATCH v3 1/4] mmc: atmel-mci: remove useless DMA stuff for non-dt
 devices
In-Reply-To: <1417183686-31481-1-git-send-email-ludovic.desroches@atmel.com>
References: <1417183686-31481-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1417183686-31481-2-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All devices with a DMA controller are DT compliant and legacy support
has been removed. For those reasons, some DMA stuff is useless.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/atmel-mci.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index de2287c..f187e75 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2274,17 +2274,9 @@ static void atmci_cleanup_slot(struct atmel_mci_slot *slot,
 
 static bool atmci_configure_dma(struct atmel_mci *host)
 {
-	struct mci_platform_data	*pdata;
-	dma_cap_mask_t mask;
-
 	if (host == NULL)
 		return false;
 
-	pdata = host->pdev->dev.platform_data;
-
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-
 	host->dma.chan = dma_request_slave_channel(&host->pdev->dev, "rxtx");
 	if (!host->dma.chan) {
 		dev_warn(&host->pdev->dev, "no DMA channel available\n");
-- 
2.0.3
