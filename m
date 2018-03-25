From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 25 Mar 2018 10:39:20 -0400
Subject: [PATCH v7 6/7] bnxt_en: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <1521988761-30344-1-git-send-email-okaya@codeaurora.org>
References: <1521988761-30344-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1521988761-30344-7-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Code includes wmb() followed by writel(). writel() already has a barrier on
some architectures like arm64.

This ends up CPU observing two barriers back to back before executing the
register write.

Create a new wrapper function with relaxed write operator. Use the new
wrapper when a write is following a wmb().

Since code already has an explicit barrier call, changing writel() to
writel_relaxed().

Also add mmiowb() so that write code doesn't move outside of scope.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1500243..befb538 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1922,7 +1922,7 @@ static int bnxt_poll_work(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 		/* Sync BD data before updating doorbell */
 		wmb();
 
-		bnxt_db_write(bp, db, DB_KEY_TX | prod);
+		bnxt_db_write_relaxed(bp, db, DB_KEY_TX | prod);
 	}
 
 	cpr->cp_raw_cons = raw_cons;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 1989c47..5e453b9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1401,6 +1401,15 @@ static inline u32 bnxt_tx_avail(struct bnxt *bp, struct bnxt_tx_ring_info *txr)
 		((txr->tx_prod - txr->tx_cons) & bp->tx_ring_mask);
 }
 
+/* For TX and RX ring doorbells with no ordering guarantee*/
+static inline void bnxt_db_write_relaxed(struct bnxt *bp, void __iomem *db,
+					 u32 val)
+{
+	writel_relaxed(val, db);
+	if (bp->flags & BNXT_FLAG_DOUBLE_DB)
+		writel_relaxed(val, db);
+}
+
 /* For TX and RX ring doorbells */
 static inline void bnxt_db_write(struct bnxt *bp, void __iomem *db, u32 val)
 {
-- 
2.7.4
