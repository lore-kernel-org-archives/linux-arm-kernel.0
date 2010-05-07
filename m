From: jassi.brar@samsung.com (Jassi Brar)
Date: Fri,  7 May 2010 16:00:12 +0900
Subject: [PATCH 1/2] DMA ENGINE: Do not reset 'private' of channel
Message-ID: <1273215612-3058-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The member 'private' of 'struct dma_chan' is meant for passing
data between client and the controller driver.

The DMA client driver may point it to platform specific stuff after
acquiring the channel. So, it is the responsiblity of the same code
to reset it, if it must.

The DMA engine doesn't set it and hence, shouldn't reset it either.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 drivers/dma/dmaengine.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index d18b5d0..3b4dab5 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -515,7 +515,6 @@ struct dma_chan *__dma_request_channel(dma_cap_mask_t *mask, dma_filter_fn fn, v
 				break;
 			if (--device->privatecnt == 0)
 				dma_cap_clear(DMA_PRIVATE, device->cap_mask);
-			chan->private = NULL;
 			chan = NULL;
 		}
 	}
@@ -537,7 +536,6 @@ void dma_release_channel(struct dma_chan *chan)
 	/* drop PRIVATE cap enabled by __dma_request_channel() */
 	if (--chan->device->privatecnt == 0)
 		dma_cap_clear(DMA_PRIVATE, chan->device->cap_mask);
-	chan->private = NULL;
 	mutex_unlock(&dma_list_mutex);
 }
 EXPORT_SYMBOL_GPL(dma_release_channel);
-- 
1.6.2.5
