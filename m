From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 23 Mar 2018 18:23:08 -0400
Subject: [PATCH v6 3/6] bnx2x: Replace doorbell barrier() with wmb()
In-Reply-To: <1521843791-21201-1-git-send-email-okaya@codeaurora.org>
References: <1521843791-21201-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1521843791-21201-4-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

barrier() doesn't guarantee memory writes to be observed by the hardware on
all architectures. barrier() only tells compiler not to move this code
with respect to other read/writes.

If memory write needs to be observed by the HW, wmb() is the right choice.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c     | 3 ++-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index d7c98e8..b97820f 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -4153,7 +4153,8 @@ netdev_tx_t bnx2x_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	wmb();
 
 	txdata->tx_db.data.prod += nbd;
-	barrier();
+	/* make sur edescriptor update is observed by HW */
+	wmb();
 
 	DOORBELL(bp, txdata->cid, txdata->tx_db.raw);
 
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
index 1e33abd..39af4f8 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
@@ -2591,7 +2591,8 @@ static int bnx2x_run_loopback(struct bnx2x *bp, int loopback_mode)
 	wmb();
 
 	txdata->tx_db.data.prod += 2;
-	barrier();
+	/* make sure descriptor update is observed by the HW */
+	wmb();
 	DOORBELL(bp, txdata->cid, txdata->tx_db.raw);
 
 	mmiowb();
-- 
2.7.4
