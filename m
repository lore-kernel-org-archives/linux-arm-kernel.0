From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 14 Nov 2017 16:32:10 +0200
Subject: [PATCH 08/10] dmaengine: img-mdc-dma: Use vchan_terminate_vdesc()
 instead of desc_free
In-Reply-To: <20171114143212.8311-1-peter.ujfalusi@ti.com>
References: <20171114143212.8311-1-peter.ujfalusi@ti.com>
Message-ID: <20171114143212.8311-9-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To avoid race with vchan_complete, use the race free way to terminate
running transfer.

Implement the device_synchronize callback to make sure that the terminated
descriptor is freed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/img-mdc-dma.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/img-mdc-dma.c b/drivers/dma/img-mdc-dma.c
index 0391f930aecc..25cec9c243e1 100644
--- a/drivers/dma/img-mdc-dma.c
+++ b/drivers/dma/img-mdc-dma.c
@@ -694,7 +694,6 @@ static unsigned int mdc_get_new_events(struct mdc_chan *mchan)
 static int mdc_terminate_all(struct dma_chan *chan)
 {
 	struct mdc_chan *mchan = to_mdc_chan(chan);
-	struct mdc_tx_desc *mdesc;
 	unsigned long flags;
 	LIST_HEAD(head);
 
@@ -703,21 +702,28 @@ static int mdc_terminate_all(struct dma_chan *chan)
 	mdc_chan_writel(mchan, MDC_CONTROL_AND_STATUS_CANCEL,
 			MDC_CONTROL_AND_STATUS);
 
-	mdesc = mchan->desc;
-	mchan->desc = NULL;
+	if (mchan->desc) {
+		vchan_terminate_vdesc(&mchan->desc->vd);
+		mchan->desc = NULL;
+	}
 	vchan_get_all_descriptors(&mchan->vc, &head);
 
 	mdc_get_new_events(mchan);
 
 	spin_unlock_irqrestore(&mchan->vc.lock, flags);
 
-	if (mdesc)
-		mdc_desc_free(&mdesc->vd);
 	vchan_dma_desc_free_list(&mchan->vc, &head);
 
 	return 0;
 }
 
+static void mdc_synchronize(struct dma_chan *chan)
+{
+	struct mdc_chan *mchan = to_mdc_chan(chan);
+
+	vchan_synchronize(&mchan->vc);
+}
+
 static int mdc_slave_config(struct dma_chan *chan,
 			    struct dma_slave_config *config)
 {
@@ -952,6 +958,7 @@ static int mdc_dma_probe(struct platform_device *pdev)
 	mdma->dma_dev.device_tx_status = mdc_tx_status;
 	mdma->dma_dev.device_issue_pending = mdc_issue_pending;
 	mdma->dma_dev.device_terminate_all = mdc_terminate_all;
+	mdma->dma_dev.device_synchronize = mdc_synchronize;
 	mdma->dma_dev.device_config = mdc_slave_config;
 
 	mdma->dma_dev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
