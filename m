From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 13 Mar 2018 23:20:23 -0400
Subject: [PATCH 2/7] ixgbe: eliminate duplicate barriers on weakly-ordered
 archs
In-Reply-To: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
References: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1520997629-17361-2-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Code includes wmb() followed by writel() in multiple places. writel()
already has a barrier on some architectures like arm64.

This ends up CPU observing two barriers back to back before executing the
register write.

Since code already has an explicit barrier call, changing writel() to
writel_relaxed().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 0da5aa2..35ca1d8 100644
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
