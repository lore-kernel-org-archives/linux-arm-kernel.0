From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 14 Nov 2017 16:32:05 +0200
Subject: [PATCH 03/10] dmaengine: omap-dma: Use vchan_terminate_vdesc()
 instead of desc_free
In-Reply-To: <20171114143212.8311-1-peter.ujfalusi@ti.com>
References: <20171114143212.8311-1-peter.ujfalusi@ti.com>
Message-ID: <20171114143212.8311-4-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To avoid race with vchan_complete, use the race free way to terminate
running transfer.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index f6dd849159d8..d21c19822feb 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -1311,7 +1311,7 @@ static int omap_dma_terminate_all(struct dma_chan *chan)
 	 * c->desc is NULL and exit.)
 	 */
 	if (c->desc) {
-		omap_dma_desc_free(&c->desc->vd);
+		vchan_terminate_vdesc(&c->desc->vd);
 		c->desc = NULL;
 		/* Avoid stopping the dma twice */
 		if (!c->paused)
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
