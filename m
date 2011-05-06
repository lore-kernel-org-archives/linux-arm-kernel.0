From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri,  6 May 2011 19:56:51 +0200
Subject: [PATCH v2 1/3] dmaengine: at_hdmac: set residue as total len in
	atc_tx_status
In-Reply-To: <f4341d4672a23a958398b75cb4305e0e680f2e32.1304532833.git.nicolas.ferre@atmel.com>
References: <f4341d4672a23a958398b75cb4305e0e680f2e32.1304532833.git.nicolas.ferre@atmel.com>
Message-ID: <f4341d4672a23a958398b75cb4305e0e680f2e32.1304704588.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If transfer status is !=DMA_SUCCESS, return total transfer len as residue,
instead of zero.

Idea from dw_dmac patch by Viresh Kumar.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/dma/at_hdmac.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index f52c9e3..ba0b5ec 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1026,7 +1026,12 @@ atc_tx_status(struct dma_chan *chan,
 
 	spin_unlock_bh(&atchan->lock);
 
-	dma_set_tx_state(txstate, last_complete, last_used, 0);
+	if (ret != DMA_SUCCESS)
+		dma_set_tx_state(txstate, last_complete, last_used,
+			atc_first_active(atchan)->len);
+	else
+		dma_set_tx_state(txstate, last_complete, last_used, 0);
+
 	dev_vdbg(chan2dev(chan), "tx_status: %d (d%d, u%d)\n",
 		 cookie, last_complete ? last_complete : 0,
 		 last_used ? last_used : 0);
-- 
1.7.3
