From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 13 Nov 2014 11:52:43 +0100
Subject: [PATCH 5/7] dmaengine: at_xdmac: fix missing spin_unlock
In-Reply-To: <1415875965-6905-1-git-send-email-ludovic.desroches@atmel.com>
References: <1415875965-6905-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1415875965-6905-6-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lock taken when entering the function but unlock missing before it
returns.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/dma/at_xdmac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index bf2aacb..586275f 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -901,6 +901,7 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	 */
 	if (!desc->active_xfer) {
 		dma_set_residue(txstate, desc->xfer_size);
+		spin_unlock_bh(&atchan->lock);
 		return ret;
 	}
 
-- 
2.0.3
