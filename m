From: mw@semihalf.com (Marcin Wojtas)
Date: Thu,  3 Dec 2015 15:20:49 +0100
Subject: [PATCH net 1/3] net: mvpp2: fix missing DMA region unmap in egress
 processing
In-Reply-To: <1449152451-2939-1-git-send-email-mw@semihalf.com>
References: <1449152451-2939-1-git-send-email-mw@semihalf.com>
Message-ID: <1449152451-2939-2-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Tx descriptor release code currently calls dma_unmap_single() and
dev_kfree_skb_any() if the descriptor is associated with a non-NULL skb.
This condition is true only for the last fragment of the packet.

Since every descriptor's buffer is DMA-mapped it has to be properly
unmapped.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>

Fixes: 3f518509dedc ("ethernet: Add new driver for Marvell Armada 375
network unit")

Cc: <stable@vger.kernel.org> # v3.18+
---
 drivers/net/ethernet/marvell/mvpp2.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index d9884fd..95db519 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -4401,11 +4401,10 @@ static void mvpp2_txq_bufs_free(struct mvpp2_port *port,
 
 		mvpp2_txq_inc_get(txq_pcpu);
 
-		if (!skb)
-			continue;
-
 		dma_unmap_single(port->dev->dev.parent, buf_phys_addr,
 				 skb_headlen(skb), DMA_TO_DEVICE);
+		if (!skb)
+			continue;
 		dev_kfree_skb_any(skb);
 	}
 }
-- 
1.8.3.1
