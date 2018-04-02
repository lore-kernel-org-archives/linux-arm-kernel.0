From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon,  2 Apr 2018 15:06:27 -0400
Subject: [PATCH v8 4/7] igb: eliminate duplicate barriers on weakly-ordered
 archs
In-Reply-To: <1522695990-31082-1-git-send-email-okaya@codeaurora.org>
References: <1522695990-31082-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1522695990-31082-5-git-send-email-okaya@codeaurora.org>
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
 drivers/net/ethernet/intel/igb/igb_main.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index c1c0bc3..c3f7130 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -5652,11 +5652,7 @@ static int igb_tx_map(struct igb_ring *tx_ring,
 	/* set the timestamp */
 	first->time_stamp = jiffies;
 
-	/* Force memory writes to complete before letting h/w know there
-	 * are new descriptors to fetch.  (Only applicable for weak-ordered
-	 * memory model archs, such as IA-64).
-	 *
-	 * We also need this memory barrier to make certain all of the
+	/* We need this memory barrier to make certain all of the
 	 * status bits have been updated before next_to_watch is written.
 	 */
 	wmb();
@@ -5674,7 +5670,7 @@ static int igb_tx_map(struct igb_ring *tx_ring,
 	igb_maybe_stop_tx(tx_ring, DESC_NEEDED);
 
 	if (netif_xmit_stopped(txring_txq(tx_ring)) || !skb->xmit_more) {
-		writel(i, tx_ring->tail);
+		writel_relaxed(i, tx_ring->tail);
 
 		/* we need this if more than one processor can write to our tail
 		 * at a time, it synchronizes IO on IA64/Altix systems
@@ -8073,12 +8069,6 @@ void igb_alloc_rx_buffers(struct igb_ring *rx_ring, u16 cleaned_count)
 		/* update next to alloc since we have filled the ring */
 		rx_ring->next_to_alloc = i;
 
-		/* Force memory writes to complete before letting h/w
-		 * know there are new descriptors to fetch.  (Only
-		 * applicable for weak-ordered memory model archs,
-		 * such as IA-64).
-		 */
-		wmb();
 		writel(i, rx_ring->tail);
 	}
 }
-- 
2.7.4
