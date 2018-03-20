From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 19 Mar 2018 22:42:17 -0400
Subject: [PATCH v4 02/17] ixgbe: eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <1521513753-7325-1-git-send-email-okaya@codeaurora.org>
References: <1521513753-7325-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1521513753-7325-3-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Code includes wmb() followed by writel() in multiple places. writel()
already has a barrier on some architectures like arm64.

This ends up CPU observing two barriers back to back before executing the
register write.

Since code already has an explicit barrier call, changing writel() to
writel_relaxed().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 0da5aa2..58ed70f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1692,7 +1692,7 @@ void ixgbe_alloc_rx_buffers(struct ixgbe_ring *rx_ring, u16 cleaned_count)
 		 * such as IA-64).
 		 */
 		wmb();
-		writel(i, rx_ring->tail);
+		writel_relaxed(i, rx_ring->tail);
 	}
 }
 
@@ -2453,7 +2453,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 		 * know there are new descriptors to fetch.
 		 */
 		wmb();
-		writel(ring->next_to_use, ring->tail);
+		writel_relaxed(ring->next_to_use, ring->tail);
 
 		xdp_do_flush_map();
 	}
@@ -8078,7 +8078,7 @@ static int ixgbe_tx_map(struct ixgbe_ring *tx_ring,
 	ixgbe_maybe_stop_tx(tx_ring, DESC_NEEDED);
 
 	if (netif_xmit_stopped(txring_txq(tx_ring)) || !skb->xmit_more) {
-		writel(i, tx_ring->tail);
+		writel_relaxed(i, tx_ring->tail);
 
 		/* we need this if more than one processor can write to our tail
 		 * at a time, it synchronizes IO on IA64/Altix systems
@@ -10014,7 +10014,7 @@ static void ixgbe_xdp_flush(struct net_device *dev)
 	 * are new descriptors to fetch.
 	 */
 	wmb();
-	writel(ring->next_to_use, ring->tail);
+	writel_relaxed(ring->next_to_use, ring->tail);
 
 	return;
 }
-- 
2.7.4
