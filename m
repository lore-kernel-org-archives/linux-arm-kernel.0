From: jaccon.bastiaansen@gmail.com (Jaccon Bastiaansen)
Date: Mon, 27 Aug 2012 23:53:51 +0200
Subject: [PATCH v2] cs89x0 : packet reception not working
Message-ID: <1346104431-3784-1-git-send-email-jaccon.bastiaansen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RxCFG register of the CS89x0 could be configured incorrectly
(because of misplaced parentheses), resulting in the disabling
of packet reception.

Signed-off-by: Jaccon Bastiaansen <jaccon.bastiaansen@gmail.com>
---
 drivers/net/ethernet/cirrus/cs89x0.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cirrus/cs89x0.c b/drivers/net/ethernet/cirrus/cs89x0.c
index 845b202..1384469 100644
--- a/drivers/net/ethernet/cirrus/cs89x0.c
+++ b/drivers/net/ethernet/cirrus/cs89x0.c
@@ -1243,6 +1243,7 @@ static void set_multicast_list(struct net_device *dev)
 {
 	struct net_local *lp = netdev_priv(dev);
 	unsigned long flags;
+	u16 cfg;
 
 	spin_lock_irqsave(&lp->lock, flags);
 	if (dev->flags & IFF_PROMISC)
@@ -1260,11 +1261,10 @@ static void set_multicast_list(struct net_device *dev)
 	/* in promiscuous mode, we accept errored packets,
 	 * so we have to enable interrupts on them also
 	 */
-	writereg(dev, PP_RxCFG,
-		 (lp->curr_rx_cfg |
-		  (lp->rx_mode == RX_ALL_ACCEPT)
-		  ? (RX_CRC_ERROR_ENBL | RX_RUNT_ENBL | RX_EXTRA_DATA_ENBL)
-		  : 0));
+	cfg = lp->curr_rx_cfg;
+	if (lp->rx_mode == RX_ALL_ACCEPT)
+		cfg |= RX_CRC_ERROR_ENBL | RX_RUNT_ENBL | RX_EXTRA_DATA_ENBL;
+	writereg(dev, PP_RxCFG, cfg);
 	spin_unlock_irqrestore(&lp->lock, flags);
 }
 
-- 
1.7.1
