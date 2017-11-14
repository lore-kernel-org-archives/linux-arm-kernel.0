From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 14 Nov 2017 16:32:08 +0200
Subject: [PATCH 06/10] dmaengine: dma-jz4780: Use vchan_terminate_vdesc()
 instead of desc_free
In-Reply-To: <20171114143212.8311-1-peter.ujfalusi@ti.com>
References: <20171114143212.8311-1-peter.ujfalusi@ti.com>
Message-ID: <20171114143212.8311-7-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To avoid race with vchan_complete, use the race free way to terminate
running transfer.

Implement the device_synchronize callback to make sure that the terminated
descriptor is freed.

CC: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/dma-jz4780.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 7373b7a555ec..85820a2d69d4 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -511,7 +511,7 @@ static int jz4780_dma_terminate_all(struct dma_chan *chan)
 	/* Clear the DMA status and stop the transfer. */
 	jz4780_dma_writel(jzdma, JZ_DMA_REG_DCS(jzchan->id), 0);
 	if (jzchan->desc) {
-		jz4780_dma_desc_free(&jzchan->desc->vdesc);
+		vchan_terminate_vdesc(&jzchan->desc->vdesc);
 		jzchan->desc = NULL;
 	}
 
@@ -523,6 +523,13 @@ static int jz4780_dma_terminate_all(struct dma_chan *chan)
 	return 0;
 }
 
+static void jz4780_dma_synchronize(struct dma_chan *chan)
+{
+	struct jz4780_dma_chan *jzchan = to_jz4780_dma_chan(chan);
+
+	vchan_synchronize(&jzchan->vchan);
+}
+
 static int jz4780_dma_config(struct dma_chan *chan,
 	struct dma_slave_config *config)
 {
@@ -813,6 +820,7 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 	dd->device_prep_dma_memcpy = jz4780_dma_prep_dma_memcpy;
 	dd->device_config = jz4780_dma_config;
 	dd->device_terminate_all = jz4780_dma_terminate_all;
+	dd->device_synchronize = jz4780_dma_synchronize;
 	dd->device_tx_status = jz4780_dma_tx_status;
 	dd->device_issue_pending = jz4780_dma_issue_pending;
 	dd->src_addr_widths = JZ_DMA_BUSWIDTHS;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
