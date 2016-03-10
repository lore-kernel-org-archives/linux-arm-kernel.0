From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 10 Mar 2016 15:28:47 +0200
Subject: [PATCH v2 2/2] dmaengine: omap-dma: Do not suppress interrupts for
 memcpy
In-Reply-To: <1457616527-979-1-git-send-email-peter.ujfalusi@ti.com>
References: <1457616527-979-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1457616527-979-3-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the client queues up more transfers the driver will not able to move to
the next transfer without knowing that the previous descriptor is
completed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index a37001f72ebf..f7498681be82 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -953,9 +953,7 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_memcpy(
 	d->ccr = c->ccr;
 	d->ccr |= CCR_DST_AMODE_POSTINC | CCR_SRC_AMODE_POSTINC;
 
-	d->cicr = CICR_DROP_IE;
-	if (tx_flags & DMA_PREP_INTERRUPT)
-		d->cicr |= CICR_FRAME_IE;
+	d->cicr = CICR_DROP_IE | CICR_FRAME_IE;
 
 	d->csdp = data_type;
 
-- 
2.7.2
