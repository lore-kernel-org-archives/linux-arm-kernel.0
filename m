From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon,  2 Apr 2018 15:06:26 -0400
Subject: [PATCH v8 3/7] igbvf: eliminate duplicate barriers on weakly-ordered
 archs
In-Reply-To: <1522695990-31082-1-git-send-email-okaya@codeaurora.org>
References: <1522695990-31082-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1522695990-31082-4-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

memory-barriers.txt has been updated as follows:

"When using writel(), a prior wmb() is not needed to guarantee that the
cache coherent memory writes have completed before writing to the MMIO
region."

Remove old IA-64 comments in the code along with unneeded wmb() in front
of writel().

There are places in the code where wmb() has been used as a double barrier
for CPU and IO in place of smp_wmb() and wmb() as an optimization. For
such places, keep the wmb() but replace the following writel() with
writel_relaxed() to have a sequence as

wmb()
writel_relaxed()
mmio_wb()

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/net/ethernet/intel/igbvf/netdev.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index e2b7502..d9f186a 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -246,12 +246,6 @@ static void igbvf_alloc_rx_buffers(struct igbvf_ring *rx_ring,
 		else
 			i--;
 
-		/* Force memory writes to complete before letting h/w
-		 * know there are new descriptors to fetch.  (Only
-		 * applicable for weak-ordered memory model archs,
-		 * such as IA-64).
-		*/
-		wmb();
 		writel(i, adapter->hw.hw_addr + rx_ring->tail);
 	}
 }
@@ -2289,16 +2283,16 @@ static inline void igbvf_tx_queue_adv(struct igbvf_adapter *adapter,
 	}
 
 	tx_desc->read.cmd_type_len |= cpu_to_le32(adapter->txd_cmd);
-	/* Force memory writes to complete before letting h/w
-	 * know there are new descriptors to fetch.  (Only
-	 * applicable for weak-ordered memory model archs,
-	 * such as IA-64).
+
+	/* We use this memory barrier to make certain all of the
+	 * status bits have been updated before next_to_watch is
+	 * written.
 	 */
 	wmb();
 
 	tx_ring->buffer_info[first].next_to_watch = tx_desc;
 	tx_ring->next_to_use = i;
-	writel(i, adapter->hw.hw_addr + tx_ring->tail);
+	writel_relaxed(i, adapter->hw.hw_addr + tx_ring->tail);
 	/* we need this if more than one processor can write to our tail
 	 * at a time, it synchronizes IO on IA64/Altix systems
 	 */
-- 
2.7.4
