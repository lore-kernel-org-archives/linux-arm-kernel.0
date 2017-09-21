From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 21 Sep 2017 14:35:32 +0300
Subject: [PATCH] dmaengine: ti-dma-crossbar: Fix possible race condition with
 dma_inuse
Message-ID: <20170921113532.15297-1-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?When looking for unused xbar_out lane we should also protect the set_bit()
call with the same mutex to protect against concurrent threads picking the
same ID.

Fixes: ec9bfa1e1a796 ("dmaengine: ti-dma-crossbar: dra7: Use bitops instead of idr")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: stable at vger.kernel.org
---
 drivers/dma/ti-dma-crossbar.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/ti-dma-crossbar.c b/drivers/dma/ti-dma-crossbar.c
index 10ef9d5d5a66..7df910e7c348 100644
--- a/drivers/dma/ti-dma-crossbar.c
+++ b/drivers/dma/ti-dma-crossbar.c
@@ -262,13 +262,14 @@ static void *ti_dra7_xbar_route_allocate(struct of_phandle_args *dma_spec,
 	mutex_lock(&xbar->mutex);
 	map->xbar_out = find_first_zero_bit(xbar->dma_inuse,
 					    xbar->dma_requests);
-	mutex_unlock(&xbar->mutex);
 	if (map->xbar_out == xbar->dma_requests) {
+		mutex_unlock(&xbar->mutex);
 		dev_err(&pdev->dev, "Run out of free DMA requests\n");
 		kfree(map);
 		return ERR_PTR(-ENOMEM);
 	}
 	set_bit(map->xbar_out, xbar->dma_inuse);
+	mutex_unlock(&xbar->mutex);
 
 	map->xbar_in = (u16)dma_spec->args[0];
 
-- 
2.14.1


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
