From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 14 Nov 2017 16:32:09 +0200
Subject: [PATCH 07/10] dmaengine: amba-pl08x: Use vchan_terminate_vdesc()
 instead of desc_free
In-Reply-To: <20171114143212.8311-1-peter.ujfalusi@ti.com>
References: <20171114143212.8311-1-peter.ujfalusi@ti.com>
Message-ID: <20171114143212.8311-8-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To avoid race with vchan_complete, use the race free way to terminate
running transfer.

Implement the device_synchronize callback to make sure that the terminated
descriptor is freed.

CC: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/amba-pl08x.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index b52b0d55247e..97483df1f82e 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -2182,7 +2182,7 @@ static int pl08x_terminate_all(struct dma_chan *chan)
 	}
 	/* Dequeue jobs and free LLIs */
 	if (plchan->at) {
-		pl08x_desc_free(&plchan->at->vd);
+		vchan_terminate_vdesc(&plchan->at->vd);
 		plchan->at = NULL;
 	}
 	/* Dequeue jobs not yet fired as well */
@@ -2193,6 +2193,13 @@ static int pl08x_terminate_all(struct dma_chan *chan)
 	return 0;
 }
 
+static void pl08x_synchronize(struct dma_chan *chan)
+{
+	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
+
+	vchan_synchronize(&plchan->vc);
+}
+
 static int pl08x_pause(struct dma_chan *chan)
 {
 	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
@@ -2773,6 +2780,7 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 	pl08x->memcpy.device_pause = pl08x_pause;
 	pl08x->memcpy.device_resume = pl08x_resume;
 	pl08x->memcpy.device_terminate_all = pl08x_terminate_all;
+	pl08x->memcpy.device_synchronize = pl08x_synchronize;
 	pl08x->memcpy.src_addr_widths = PL80X_DMA_BUSWIDTHS;
 	pl08x->memcpy.dst_addr_widths = PL80X_DMA_BUSWIDTHS;
 	pl08x->memcpy.directions = BIT(DMA_MEM_TO_MEM);
@@ -2802,6 +2810,7 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 		pl08x->slave.device_pause = pl08x_pause;
 		pl08x->slave.device_resume = pl08x_resume;
 		pl08x->slave.device_terminate_all = pl08x_terminate_all;
+		pl08x->slave.device_synchronize = pl08x_synchronize;
 		pl08x->slave.src_addr_widths = PL80X_DMA_BUSWIDTHS;
 		pl08x->slave.dst_addr_widths = PL80X_DMA_BUSWIDTHS;
 		pl08x->slave.directions =
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
