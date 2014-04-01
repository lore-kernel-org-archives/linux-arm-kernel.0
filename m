From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 1 Apr 2014 16:06:09 +0300
Subject: [PATCH v2 08/14] DMA: edma: Use different eventq for cyclic channels
In-Reply-To: <1396357575-30585-1-git-send-email-peter.ujfalusi@ti.com>
References: <1396357575-30585-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1396357575-30585-9-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To improve latency with cyclic DMA operation it is preferred to
use different eventq/tc than the default which is used by all
other drivers (mmc, spi, i2c, etc).
When preparing the cyclic dma ask for non default queue for the
channel which is going to be used with cyclic mode.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 1dd9e8806975..10048b40fac8 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -628,6 +628,9 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 		edesc->pset[i].opt |= TCINTEN;
 	}
 
+	/* Use different eventq/tc for cyclic DMA to reduce latency */
+	edma_request_non_default_queue(echan->ch_num);
+
 	return vchan_tx_prep(&echan->vchan, &edesc->vdesc, tx_flags);
 }
 
-- 
1.9.1
