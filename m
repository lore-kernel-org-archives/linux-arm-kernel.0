From: jiada_wang@mentor.com (jiada_wang at mentor.com)
Date: Wed, 14 May 2014 18:22:13 -0700
Subject: [PATCH] dma: imx: correct sdmac->status for cyclic dma tx
Message-ID: <1400116933-14063-1-git-send-email-jiada_wang@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiada Wang <jiada_wang@mentor.com>

In cyclic dma tx's handler sdma_handle_channel_loop(),
SDMA channel statue is set to either DMA_ERROR or DMA_IN_PROGRESS
based on each period's status. This has the following issues:

1) If one period's status is BD_RROR, then channel status
   will be set to DMA_ERROR, but it will be overwritten to DMA_IN_PROGRESS
   if the following periods are OK.
2) DMA client may call sdma_control(DMA_TERMINATE_ALL) to stop the cyclic dma
   operation, sdma channel status will be set to DMA_ERROR,
   but if after this handler is called, then again the channel status will be overwritten
   to DMA_IN_PROGRESS. Then the following dmaengine_prep_dma_cyclic() will always fail,
   as channel status is DMA_IN_PROGRESS.

As in cyclic dma tx, channel status will be initially set to DMA_IN_PROGRESS,
driver only needs to change it to DMA_ERROR, when something wrong happens
(one period status is wrong, or stoped by client explicitly).

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/dma/imx-sdma.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 19041ce..1287146 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -607,8 +607,6 @@ static void sdma_handle_channel_loop(struct sdma_channel *sdmac)
 
 		if (bd->mode.status & BD_RROR)
 			sdmac->status = DMA_ERROR;
-		else
-			sdmac->status = DMA_IN_PROGRESS;
 
 		bd->mode.status |= BD_DONE;
 		sdmac->buf_tail++;
-- 
1.7.9.5
