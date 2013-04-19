From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Fri, 19 Apr 2013 11:11:22 +0200
Subject: [PATCH v3 5/6] mci: at91: convert to
 dma_request_slave_channel_compat()
In-Reply-To: <1366362683-14496-1-git-send-email-ludovic.desroches@atmel.com>
References: <1366362683-14496-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1366362683-14496-6-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Use generic DMA DT helper. Platforms booting with or without DT populated are
both supported.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/mmc/host/atmel-mci.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 10f8b73..ffbd0d3 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2224,10 +2224,15 @@ static void __exit atmci_cleanup_slot(struct atmel_mci_slot *slot,
 	mmc_free_host(slot->mmc);
 }
 
-static bool atmci_filter(struct dma_chan *chan, void *slave)
+static bool atmci_filter(struct dma_chan *chan, void *pdata)
 {
-	struct mci_dma_data	*sl = slave;
+	struct mci_platform_data *sl_pdata = pdata;
+	struct mci_dma_data *sl;
 
+	if (!sl_pdata)
+		return false;
+
+	sl = sl_pdata->dma_slave;
 	if (sl && find_slave_dev(sl) == chan->device->dev) {
 		chan->private = slave_data_ptr(sl);
 		return true;
@@ -2239,24 +2244,18 @@ static bool atmci_filter(struct dma_chan *chan, void *slave)
 static bool atmci_configure_dma(struct atmel_mci *host)
 {
 	struct mci_platform_data	*pdata;
+	dma_cap_mask_t mask;
 
 	if (host == NULL)
 		return false;
 
 	pdata = host->pdev->dev.platform_data;
 
-	if (!pdata)
-		return false;
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
 
-	if (pdata->dma_slave && find_slave_dev(pdata->dma_slave)) {
-		dma_cap_mask_t mask;
-
-		/* Try to grab a DMA channel */
-		dma_cap_zero(mask);
-		dma_cap_set(DMA_SLAVE, mask);
-		host->dma.chan =
-			dma_request_channel(mask, atmci_filter, pdata->dma_slave);
-	}
+	host->dma.chan = dma_request_slave_channel_compat(mask, atmci_filter, pdata,
+							  &host->pdev->dev, "rxtx");
 	if (!host->dma.chan) {
 		dev_warn(&host->pdev->dev, "no DMA channel available\n");
 		return false;
-- 
1.7.11.3
