From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 22 Jul 2015 16:12:29 +0200
Subject: [PATCH] dmaengine: at_xdmac: fix bug in prep_dma_cyclic
Message-ID: <1437574349-13816-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In cyclic mode, the round chaining has been broken by the introduction
of at_xdmac_queue_desc(): AT_XDMAC_MBR_UBC_NDE is set for all descriptors
excepted for the last one. at_xdmac_queue_desc() has to be called one
more time to chain the last and the first descriptors.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Fixes: 0d0ee751f7f7 ("dmaengine: xdmac: Rework the chaining logic")
---
 drivers/dma/at_xdmac.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index d51ef6d..df75db4 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -797,10 +797,7 @@ at_xdmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
 		list_add_tail(&desc->desc_node, &first->descs_list);
 	}
 
-	prev->lld.mbr_nda = first->tx_dma_desc.phys;
-	dev_dbg(chan2dev(chan),
-		"%s: chain lld: prev=0x%p, mbr_nda=%pad\n",
-		__func__, prev, &prev->lld.mbr_nda);
+	at_xdmac_queue_desc(chan, prev, first);
 	first->tx_dma_desc.flags = flags;
 	first->xfer_size = buf_len;
 	first->direction = direction;
-- 
2.2.0
