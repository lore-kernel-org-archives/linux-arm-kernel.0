From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 14 Jul 2016 15:42:38 +0300
Subject: [PATCH 3/7] dmaengine: omap-dma: Simplify omap_dma_callback
In-Reply-To: <20160714124242.7579-1-peter.ujfalusi@ti.com>
References: <20160714124242.7579-1-peter.ujfalusi@ti.com>
Message-ID: <20160714124242.7579-4-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Flatten the indentation level of the function which gives better view on
the cases we handle here.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index f7b0b0c668fb..6d134252ed61 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -445,15 +445,13 @@ static void omap_dma_callback(int ch, u16 status, void *data)
 	spin_lock_irqsave(&c->vc.lock, flags);
 	d = c->desc;
 	if (d) {
-		if (!c->cyclic) {
-			if (c->sgidx < d->sglen) {
-				omap_dma_start_sg(c, d);
-			} else {
-				vchan_cookie_complete(&d->vd);
-				omap_dma_start_desc(c);
-			}
-		} else {
+		if (c->cyclic) {
 			vchan_cyclic_callback(&d->vd);
+		} else if (c->sgidx == d->sglen) {
+			vchan_cookie_complete(&d->vd);
+			omap_dma_start_desc(c);
+		} else {
+			omap_dma_start_sg(c, d);
 		}
 	}
 	spin_unlock_irqrestore(&c->vc.lock, flags);
-- 
2.9.1
