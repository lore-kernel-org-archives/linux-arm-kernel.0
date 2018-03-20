From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 19 Mar 2018 22:42:22 -0400
Subject: [PATCH v4 07/17] fm10k: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <1521513753-7325-1-git-send-email-okaya@codeaurora.org>
References: <1521513753-7325-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1521513753-7325-8-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Code includes wmb() followed by writel(). writel() already has a
barrier on some architectures like arm64.

This ends up CPU observing two barriers back to back before executing
the register write.

Since code already has an explicit barrier call, changing writel() to
writel_relaxed().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 8e12aae..eebef01 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -179,7 +179,7 @@ void fm10k_alloc_rx_buffers(struct fm10k_ring *rx_ring, u16 cleaned_count)
 		wmb();
 
 		/* notify hardware of new descriptors */
-		writel(i, rx_ring->tail);
+		writel_relaxed(i, rx_ring->tail);
 	}
 }
 
@@ -1054,7 +1054,7 @@ static void fm10k_tx_map(struct fm10k_ring *tx_ring,
 
 	/* notify HW of packet */
 	if (netif_xmit_stopped(txring_txq(tx_ring)) || !skb->xmit_more) {
-		writel(i, tx_ring->tail);
+		writel_relaxed(i, tx_ring->tail);
 
 		/* we need this if more than one processor can write to our tail
 		 * at a time, it synchronizes IO on IA64/Altix systems
-- 
2.7.4
