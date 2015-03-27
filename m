From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 27 Mar 2015 13:35:53 +0200
Subject: [PATCH 3/5] dmaengine: bcm2835-dma: Fix memory leak when stopping a
 running transfer
In-Reply-To: <1427456155-28990-1-git-send-email-peter.ujfalusi@ti.com>
References: <1427456155-28990-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1427456155-28990-4-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vd->node is removed from the lists when the transfer started so the
vchan_get_all_descriptors() will not find it. This results memory leak.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
CC: Stephen Warren <swarren@wwwdotorg.org>
CC: Lee Jones <lee@kernel.org>
---
 drivers/dma/bcm2835-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 0723096fb50a..c92d6a70ccf3 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -475,6 +475,7 @@ static int bcm2835_dma_terminate_all(struct dma_chan *chan)
 	 * c->desc is NULL and exit.)
 	 */
 	if (c->desc) {
+		bcm2835_dma_desc_free(&c->desc->vd);
 		c->desc = NULL;
 		bcm2835_dma_abort(c->chan_base);
 
-- 
2.3.3
