From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 20 Jan 2011 05:50:38 +0800
Subject: [PATCH 4/6] dmaengine: imxs-sdma: correct sdmac->status in
	sdma_handle_channel_loop()
In-Reply-To: <1295473840-17295-1-git-send-email-shawn.guo@freescale.com>
References: <1295473840-17295-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1295473840-17295-5-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sdma_handle_channel_loop() is the handler of cyclic tx.  One period
success does not really mean the success of the tx.  Instead of
DMA_SUCCESS, DMA_IN_PROGRESS should be the one to tell.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 drivers/dma/imx-sdma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index ccdafa4..e5af547 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -449,7 +449,7 @@ static void sdma_handle_channel_loop(struct sdma_channel *sdmac)
 		if (bd->mode.status & BD_RROR)
 			sdmac->status = DMA_ERROR;
 		else
-			sdmac->status = DMA_SUCCESS;
+			sdmac->status = DMA_IN_PROGRESS;
 
 		bd->mode.status |= BD_DONE;
 		sdmac->buf_tail++;
-- 
1.7.1
