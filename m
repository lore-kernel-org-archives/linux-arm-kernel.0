From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 20 Jan 2011 05:50:37 +0800
Subject: [PATCH 3/6] dmaengine: imx-sdma: return sdmac->status in
	sdma_tx_status()
In-Reply-To: <1295473840-17295-1-git-send-email-shawn.guo@freescale.com>
References: <1295473840-17295-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1295473840-17295-4-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sdmac->status was designed to reflect the status of the tx,
so simply return it in sdma_tx_status().  Then dma client can call
dma_async_is_tx_complete() to know the status of the tx.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 drivers/dma/imx-sdma.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 2aa5131..ccdafa4 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1061,14 +1061,12 @@ static enum dma_status sdma_tx_status(struct dma_chan *chan,
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	dma_cookie_t last_used;
-	enum dma_status ret;
 
 	last_used = chan->cookie;
 
-	ret = dma_async_is_complete(cookie, sdmac->last_completed, last_used);
 	dma_set_tx_state(txstate, sdmac->last_completed, last_used, 0);
 
-	return ret;
+	return sdmac->status;
 }
 
 static void sdma_issue_pending(struct dma_chan *chan)
-- 
1.7.1
