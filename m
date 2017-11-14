From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 14 Nov 2017 16:32:06 +0200
Subject: [PATCH 04/10] dmaengine: edma: Use vchan_terminate_vdesc() instead of
 desc_free
In-Reply-To: <20171114143212.8311-1-peter.ujfalusi@ti.com>
References: <20171114143212.8311-1-peter.ujfalusi@ti.com>
Message-ID: <20171114143212.8311-5-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To avoid race with vchan_complete, use the race free way to terminate
running transfer.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 9364a3ed345a..948df1ab5f1a 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -860,11 +860,8 @@ static int edma_terminate_all(struct dma_chan *chan)
 		/* Move the cyclic channel back to default queue */
 		if (!echan->tc && echan->edesc->cyclic)
 			edma_assign_channel_eventq(echan, EVENTQ_DEFAULT);
-		/*
-		 * free the running request descriptor
-		 * since it is not in any of the vdesc lists
-		 */
-		edma_desc_free(&echan->edesc->vdesc);
+
+		vchan_terminate_vdesc(&echan->edesc->vdesc);
 		echan->edesc = NULL;
 	}
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
