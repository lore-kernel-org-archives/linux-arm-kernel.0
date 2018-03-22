From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 22 Mar 2018 11:42:32 -0400
Subject: [PATCH v5 2/2] ixgbevf: eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <1521733352-25266-1-git-send-email-okaya@codeaurora.org>
References: <1521733352-25266-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1521733352-25266-2-git-send-email-okaya@codeaurora.org>
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
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 815cb1a..eaa930e 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -725,7 +725,7 @@ static void ixgbevf_alloc_rx_buffers(struct ixgbevf_ring *rx_ring,
 		 * such as IA-64).
 		 */
 		wmb();
-		writel(i, rx_ring->tail);
+		writel_relaxed(i, rx_ring->tail);
 	}
 }
 
@@ -1232,7 +1232,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 		 * know there are new descriptors to fetch.
 		 */
 		wmb();
-		writel(xdp_ring->next_to_use, xdp_ring->tail);
+		writel_relaxed(xdp_ring->next_to_use, xdp_ring->tail);
 	}
 
 	u64_stats_update_begin(&rx_ring->syncp);
@@ -4004,7 +4004,7 @@ static void ixgbevf_tx_map(struct ixgbevf_ring *tx_ring,
 	tx_ring->next_to_use = i;
 
 	/* notify HW of packet */
-	writel(i, tx_ring->tail);
+	writel_relaxed(i, tx_ring->tail);
 
 	return;
 dma_error:
-- 
2.7.4
