From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 3 Apr 2013 13:17:42 +0200
Subject: [RFC v2] dmaengine: omap-dma: Start DMA without delay for cyclic
 channels
Message-ID: <1364987862-14597-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cyclic DMA is only used by audio which needs DMA to be started without a
delay.
If the DMA for audio is started using the tasklet we experience random
channel switch (to be more precise: channel shift).

Reported-by: Peter Meerwald <pmeerw@pmeerw.net>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi Russell,

Instead of removing the tasklet we can identify the DMA channel used by audio
based on the cyclic flag of the channel.
I think this can be used as a short term solution to fix the audio channel shift
issue and later when we have the dynamic DMA channel allocation we can adjust
the code.

Regards,
Peter

 drivers/dma/omap-dma.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 2ea3d7e..ec3fc4f 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -282,12 +282,20 @@ static void omap_dma_issue_pending(struct dma_chan *chan)
 
 	spin_lock_irqsave(&c->vc.lock, flags);
 	if (vchan_issue_pending(&c->vc) && !c->desc) {
-		struct omap_dmadev *d = to_omap_dma_dev(chan->device);
-		spin_lock(&d->lock);
-		if (list_empty(&c->node))
-			list_add_tail(&c->node, &d->pending);
-		spin_unlock(&d->lock);
-		tasklet_schedule(&d->task);
+		/*
+		 * c->cyclic is used only by audio and in this case the DMA need
+		 * to be started without delay.
+		 */
+		if (!c->cyclic) {
+			struct omap_dmadev *d = to_omap_dma_dev(chan->device);
+			spin_lock(&d->lock);
+			if (list_empty(&c->node))
+				list_add_tail(&c->node, &d->pending);
+			spin_unlock(&d->lock);
+			tasklet_schedule(&d->task);
+		} else {
+			omap_dma_start_desc(c);
+		}
 	}
 	spin_unlock_irqrestore(&c->vc.lock, flags);
 }
-- 
1.8.1.5
