From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 23 Mar 2018 14:21:14 -0400
Subject: [PATCH v6 4/7] igb: eliminate duplicate barriers on weakly-ordered
 archs
In-Reply-To: <1521829277-9398-1-git-send-email-okaya@codeaurora.org>
References: <1521829277-9398-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1521829277-9398-5-git-send-email-okaya@codeaurora.org>
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
 drivers/net/ethernet/intel/igb/igb_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 3d4ff3c..570af25 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -5674,7 +5674,7 @@ static int igb_tx_map(struct igb_ring *tx_ring,
 	igb_maybe_stop_tx(tx_ring, DESC_NEEDED);
 
 	if (netif_xmit_stopped(txring_txq(tx_ring)) || !skb->xmit_more) {
-		writel(i, tx_ring->tail);
+		writel_relaxed(i, tx_ring->tail);
 
 		/* we need this if more than one processor can write to our tail
 		 * at a time, it synchronizes IO on IA64/Altix systems
@@ -8079,7 +8079,12 @@ void igb_alloc_rx_buffers(struct igb_ring *rx_ring, u16 cleaned_count)
 		 * such as IA-64).
 		 */
 		wmb();
-		writel(i, rx_ring->tail);
+		writel_relaxed(i, rx_ring->tail);
+
+		/* We need this if more than one processor can write to our tail
+		 * at a time, it synchronizes IO on IA64/Altix systems
+		 */
+		mmiowb();
 	}
 }
 
-- 
2.7.4
