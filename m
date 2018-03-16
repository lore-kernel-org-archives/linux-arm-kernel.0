From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 16 Mar 2018 12:16:27 -0400
Subject: [PATCH v3 14/18] net: cxgb3: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <1521216991-28706-1-git-send-email-okaya@codeaurora.org>
References: <1521216991-28706-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1521216991-28706-15-git-send-email-okaya@codeaurora.org>
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
 drivers/net/ethernet/chelsio/cxgb3/adapter.h |  7 +++++++
 drivers/net/ethernet/chelsio/cxgb3/sge.c     | 19 ++++++++++---------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/adapter.h b/drivers/net/ethernet/chelsio/cxgb3/adapter.h
index 087ff0f..0e21e66 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/adapter.h
+++ b/drivers/net/ethernet/chelsio/cxgb3/adapter.h
@@ -281,6 +281,13 @@ static inline void t3_write_reg(struct adapter *adapter, u32 reg_addr, u32 val)
 	writel(val, adapter->regs + reg_addr);
 }
 
+static inline void t3_write_reg_relaxed(struct adapter *adapter, u32 reg_addr,
+					u32 val)
+{
+	CH_DBG(adapter, MMIO, "setting register 0x%x to 0x%x\n", reg_addr, val);
+	writel_relaxed(val, adapter->regs + reg_addr);
+}
+
 static inline struct port_info *adap2pinfo(struct adapter *adap, int idx)
 {
 	return netdev_priv(adap->port[idx]);
diff --git a/drivers/net/ethernet/chelsio/cxgb3/sge.c b/drivers/net/ethernet/chelsio/cxgb3/sge.c
index e988caa..0baab06 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/sge.c
@@ -487,7 +487,8 @@ static inline void ring_fl_db(struct adapter *adap, struct sge_fl *q)
 	if (q->pend_cred >= q->credits / 4) {
 		q->pend_cred = 0;
 		wmb();
-		t3_write_reg(adap, A_SG_KDOORBELL, V_EGRCNTX(q->cntxt_id));
+		t3_write_reg_relaxed(adap, A_SG_KDOORBELL,
+				     V_EGRCNTX(q->cntxt_id));
 	}
 }
 
@@ -1058,8 +1059,8 @@ static inline void check_ring_tx_db(struct adapter *adap, struct sge_txq *q)
 	}
 #else
 	wmb();			/* write descriptors before telling HW */
-	t3_write_reg(adap, A_SG_KDOORBELL,
-		     F_SELEGRCNTX | V_EGRCNTX(q->cntxt_id));
+	t3_write_reg_relaxed(adap, A_SG_KDOORBELL,
+			     F_SELEGRCNTX | V_EGRCNTX(q->cntxt_id));
 #endif
 }
 
@@ -1510,8 +1511,8 @@ static int ctrl_xmit(struct adapter *adap, struct sge_txq *q,
 	}
 	spin_unlock(&q->lock);
 	wmb();
-	t3_write_reg(adap, A_SG_KDOORBELL,
-		     F_SELEGRCNTX | V_EGRCNTX(q->cntxt_id));
+	t3_write_reg_relaxed(adap, A_SG_KDOORBELL,
+			     F_SELEGRCNTX | V_EGRCNTX(q->cntxt_id));
 	return NET_XMIT_SUCCESS;
 }
 
@@ -1554,8 +1555,8 @@ static void restart_ctrlq(unsigned long data)
 
 	spin_unlock(&q->lock);
 	wmb();
-	t3_write_reg(qs->adap, A_SG_KDOORBELL,
-		     F_SELEGRCNTX | V_EGRCNTX(q->cntxt_id));
+	t3_write_reg_relaxed(qs->adap, A_SG_KDOORBELL,
+			     F_SELEGRCNTX | V_EGRCNTX(q->cntxt_id));
 }
 
 /*
@@ -1793,8 +1794,8 @@ again:	reclaim_completed_tx(adap, q, TX_RECLAIM_CHUNK);
 #endif
 	wmb();
 	if (likely(written))
-		t3_write_reg(adap, A_SG_KDOORBELL,
-			     F_SELEGRCNTX | V_EGRCNTX(q->cntxt_id));
+		t3_write_reg_relaxed(adap, A_SG_KDOORBELL,
+				     F_SELEGRCNTX | V_EGRCNTX(q->cntxt_id));
 }
 
 /**
-- 
2.7.4
