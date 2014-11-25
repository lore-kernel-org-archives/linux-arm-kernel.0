From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 25 Nov 2014 15:25:41 +0100
Subject: [PATCH] mmc: atmel-mci: use probe deferring if dma controller is not
 ready yet
In-Reply-To: <CAPDyKFq-0EaGSf9Mn7aMa1s9CCP5hxqRCkKrZrAnSs-h5OFmxw@mail.gmail.com>
References: <CAPDyKFq-0EaGSf9Mn7aMa1s9CCP5hxqRCkKrZrAnSs-h5OFmxw@mail.gmail.com>
Message-ID: <1416925541-6857-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Return probe defer if requesting a dma channel without a dma controller
probed.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---

Hi Ulf,

I didn't send the whole set of patches for this small change, tell me if you
want a new series.

 drivers/mmc/host/atmel-mci.c | 49 ++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 28546c3..f4daef9 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2265,29 +2265,26 @@ static void atmci_cleanup_slot(struct atmel_mci_slot *slot,
 	mmc_free_host(slot->mmc);
 }
 
-static bool atmci_configure_dma(struct atmel_mci *host)
+static int atmci_configure_dma(struct atmel_mci *host)
 {
-	if (host == NULL)
-		return false;
+	int ret = 0;
 
-	host->dma.chan = dma_request_slave_channel(&host->pdev->dev, "rxtx");
-	if (!host->dma.chan) {
-		dev_warn(&host->pdev->dev, "no DMA channel available\n");
-		return false;
-	} else {
-		dev_info(&host->pdev->dev,
-					"using %s for DMA transfers\n",
-					dma_chan_name(host->dma.chan));
-
-		host->dma_conf.src_addr = host->mapbase + ATMCI_RDR;
-		host->dma_conf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		host->dma_conf.src_maxburst = 1;
-		host->dma_conf.dst_addr = host->mapbase + ATMCI_TDR;
-		host->dma_conf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		host->dma_conf.dst_maxburst = 1;
-		host->dma_conf.device_fc = false;
-		return true;
-	}
+	host->dma.chan = dma_request_slave_channel_reason(&host->pdev->dev, "rxtx");
+	if (IS_ERR(host->dma.chan))
+		return PTR_ERR(host->dma.chan);
+
+	dev_info(&host->pdev->dev, "using %s for DMA transfers\n",
+		 dma_chan_name(host->dma.chan));
+
+	host->dma_conf.src_addr = host->mapbase + ATMCI_RDR;
+	host->dma_conf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	host->dma_conf.src_maxburst = 1;
+	host->dma_conf.dst_addr = host->mapbase + ATMCI_TDR;
+	host->dma_conf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	host->dma_conf.dst_maxburst = 1;
+	host->dma_conf.device_fc = false;
+
+	return ret;
 }
 
 /*
@@ -2403,7 +2400,10 @@ static int atmci_probe(struct platform_device *pdev)
 
 	/* Get MCI capabilities and set operations according to it */
 	atmci_get_cap(host);
-	if (atmci_configure_dma(host)) {
+	ret = atmci_configure_dma(host);
+	if (ret == -EPROBE_DEFER)
+		goto err_dma_probe_defer;
+	if (ret == 0) {
 		host->prepare_data = &atmci_prepare_data_dma;
 		host->submit_data = &atmci_submit_data_dma;
 		host->stop_transfer = &atmci_stop_transfer_dma;
@@ -2474,8 +2474,9 @@ err_dma_alloc:
 	}
 err_init_slot:
 	del_timer_sync(&host->timer);
-	if (host->dma.chan)
+	if (!IS_ERR(host->dma.chan))
 		dma_release_channel(host->dma.chan);
+err_dma_probe_defer:
 	free_irq(irq, host);
 	return ret;
 }
@@ -2501,7 +2502,7 @@ static int atmci_remove(struct platform_device *pdev)
 	clk_disable_unprepare(host->mck);
 
 	del_timer_sync(&host->timer);
-	if (host->dma.chan)
+	if (!IS_ERR(host->dma.chan))
 		dma_release_channel(host->dma.chan);
 
 	free_irq(platform_get_irq(pdev, 0), host);
-- 
2.0.3
