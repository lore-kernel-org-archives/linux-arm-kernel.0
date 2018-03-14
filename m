From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 13 Mar 2018 23:20:28 -0400
Subject: [PATCH 7/7] ixgbevf: eliminate duplicate barriers on weakly-ordered
 archs
In-Reply-To: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
References: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1520997629-17361-7-git-send-email-okaya@codeaurora.org>
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
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      | 5 ++++-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 7 +++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index f695242..64d0e0b 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -244,9 +244,12 @@ static inline u16 ixgbevf_desc_unused(struct ixgbevf_ring *ring)
 	return ((ntc > ntu) ? 0 : ring->count) + ntc - ntu - 1;
 }
 
+/* Assumes caller has executed a write barrier to order memory and device
+ * requests.
+ */
 static inline void ixgbevf_write_tail(struct ixgbevf_ring *ring, u32 value)
 {
-	writel(value, ring->tail);
+	writel_relaxed(value, ring->tail);
 }
 
 #define IXGBEVF_RX_DESC(R, i)	\
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 9b3d43d..0ba7f59 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -3643,6 +3643,13 @@ static void ixgbevf_tx_map(struct ixgbevf_ring *tx_ring,
 
 	tx_ring->next_to_use = i;
 
+	/* Force memory writes to complete before letting h/w
+	 * know there are new descriptors to fetch.  (Only
+	 * applicable for weak-ordered memory model archs,
+	 * such as IA-64).
+	 */
+	wmb();
+
 	/* notify HW of packet */
 	ixgbevf_write_tail(tx_ring, i);
 
-- 
2.7.4
