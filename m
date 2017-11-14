From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 14 Nov 2017 16:32:11 +0200
Subject: [PATCH 09/10] dmaengine: k3dma: Use vchan_terminate_vdesc() instead
 of desc_free
In-Reply-To: <20171114143212.8311-1-peter.ujfalusi@ti.com>
References: <20171114143212.8311-1-peter.ujfalusi@ti.com>
Message-ID: <20171114143212.8311-10-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To avoid race with vchan_complete, use the race free way to terminate
running transfer.

Implement the device_synchronize callback to make sure that the terminated
descriptor is freed.

CC: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/k3dma.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index 01d2a750a621..26b67455208f 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -719,7 +719,7 @@ static int k3_dma_terminate_all(struct dma_chan *chan)
 		c->phy = NULL;
 		p->vchan = NULL;
 		if (p->ds_run) {
-			k3_dma_free_desc(&p->ds_run->vd);
+			vchan_terminate_vdesc(&p->ds_run->vd);
 			p->ds_run = NULL;
 		}
 		p->ds_done = NULL;
@@ -730,6 +730,13 @@ static int k3_dma_terminate_all(struct dma_chan *chan)
 	return 0;
 }
 
+static void k3_dma_synchronize(struct dma_chan *chan)
+{
+	struct k3_dma_chan *c = to_k3_chan(chan);
+
+	vchan_synchronize(&c->vc);
+}
+
 static int k3_dma_transfer_pause(struct dma_chan *chan)
 {
 	struct k3_dma_chan *c = to_k3_chan(chan);
@@ -868,6 +875,7 @@ static int k3_dma_probe(struct platform_device *op)
 	d->slave.device_pause = k3_dma_transfer_pause;
 	d->slave.device_resume = k3_dma_transfer_resume;
 	d->slave.device_terminate_all = k3_dma_terminate_all;
+	d->slave.device_synchronize = k3_dma_synchronize;
 	d->slave.copy_align = DMAENGINE_ALIGN_8_BYTES;
 
 	/* init virtual channel */
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
