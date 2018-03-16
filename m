From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 15 Mar 2018 21:04:53 -0400
Subject: [PATCH v2 3/6] igbvf: eliminate duplicate barriers on weakly-ordered
 archs
In-Reply-To: <1521162296-19729-1-git-send-email-okaya@codeaurora.org>
References: <1521162296-19729-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1521162296-19729-4-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Code includes wmb() followed by writel(). writel() already has a barrier
on some architectures like arm64.

This ends up CPU observing two barriers back to back before executing the
register write.

Since code already has an explicit barrier call, changing writel() to
writel_relaxed().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/net/ethernet/intel/igbvf/netdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index 4214c15..edb1c34 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -251,7 +251,7 @@ static void igbvf_alloc_rx_buffers(struct igbvf_ring *rx_ring,
 		 * such as IA-64).
 		*/
 		wmb();
-		writel(i, adapter->hw.hw_addr + rx_ring->tail);
+		writel_relaxed(i, adapter->hw.hw_addr + rx_ring->tail);
 	}
 }
 
@@ -2297,7 +2297,7 @@ static inline void igbvf_tx_queue_adv(struct igbvf_adapter *adapter,
 
 	tx_ring->buffer_info[first].next_to_watch = tx_desc;
 	tx_ring->next_to_use = i;
-	writel(i, adapter->hw.hw_addr + tx_ring->tail);
+	writel_relaxed(i, adapter->hw.hw_addr + tx_ring->tail);
 	/* we need this if more than one processor can write to our tail
 	 * at a time, it synchronizes IO on IA64/Altix systems
 	 */
-- 
2.7.4
