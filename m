From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 19 Mar 2018 22:42:29 -0400
Subject: [PATCH v4 14/17] net: qlge: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <1521513753-7325-1-git-send-email-okaya@codeaurora.org>
References: <1521513753-7325-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1521513753-7325-15-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Code includes wmb() followed by writel(). writel() already has a barrier on
some architectures like arm64.

This ends up CPU observing two barriers back to back before executing the
register write.

Create a new wrapper function with relaxed write operator. Use the new
wrapper when a write is following a wmb().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/net/ethernet/qlogic/qlge/qlge.h      | 18 ++++++++++++++++++
 drivers/net/ethernet/qlogic/qlge/qlge_main.c |  2 +-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qlge/qlge.h b/drivers/net/ethernet/qlogic/qlge/qlge.h
index 84ac50f..1465986 100644
--- a/drivers/net/ethernet/qlogic/qlge/qlge.h
+++ b/drivers/net/ethernet/qlogic/qlge/qlge.h
@@ -2185,6 +2185,24 @@ static inline void ql_write_db_reg(u32 val, void __iomem *addr)
 }
 
 /*
+ * Doorbell Registers:
+ * Doorbell registers are virtual registers in the PCI memory space.
+ * The space is allocated by the chip during PCI initialization.  The
+ * device driver finds the doorbell address in BAR 3 in PCI config space.
+ * The registers are used to control outbound and inbound queues. For
+ * example, the producer index for an outbound queue.  Each queue uses
+ * 1 4k chunk of memory.  The lower half of the space is for outbound
+ * queues. The upper half is for inbound queues.
+ * Caller has to guarantee ordering.
+ */
+static inline void ql_write_db_reg_relaxed(u32 val, void __iomem *addr)
+{
+	writel_relaxed(val, addr);
+	mmiowb();
+}
+
+
+/*
  * Shadow Registers:
  * Outbound queues have a consumer index that is maintained by the chip.
  * Inbound queues have a producer index that is maintained by the chip.
diff --git a/drivers/net/ethernet/qlogic/qlge/qlge_main.c b/drivers/net/ethernet/qlogic/qlge/qlge_main.c
index 50038d9..c222b7c 100644
--- a/drivers/net/ethernet/qlogic/qlge/qlge_main.c
+++ b/drivers/net/ethernet/qlogic/qlge/qlge_main.c
@@ -2700,7 +2700,7 @@ static netdev_tx_t qlge_send(struct sk_buff *skb, struct net_device *ndev)
 		tx_ring->prod_idx = 0;
 	wmb();
 
-	ql_write_db_reg(tx_ring->prod_idx, tx_ring->prod_idx_db_reg);
+	ql_write_db_reg_relaxed(tx_ring->prod_idx, tx_ring->prod_idx_db_reg);
 	netif_printk(qdev, tx_queued, KERN_DEBUG, qdev->ndev,
 		     "tx queued, slot %d, len %d\n",
 		     tx_ring->prod_idx, skb->len);
-- 
2.7.4
