From: radhey.shyam.pandey@xilinx.com (Radhey Shyam Pandey)
Date: Thu, 28 Jun 2018 18:41:47 +0530
Subject: [PATCH v3 net-next 2/5] net: emaclite: Simplify if-else statements
In-Reply-To: <1530191510-10310-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1530191510-10310-1-git-send-email-radhey.shyam.pandey@xilinx.com>
Message-ID: <1530191510-10310-3-git-send-email-radhey.shyam.pandey@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove else as it is not required with if doing a return.
It also coalesce the format onto a single line and add the
missing space after the comma. Fixes below checkpatch warning-

WARNING: else is not generally useful after a break or return

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
Changes from v2:
	- Refactor to make failure path return early as suggested
	  by Joe Perches <joe@perches.com>
	- Coalesce the format onto a single line as suggested by
	  by Joe Perches <joe@perches.com>
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c |   34 +++++++++++-------------
 1 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 0544134..b2c7afe 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -564,19 +564,18 @@ static void xemaclite_tx_handler(struct net_device *dev)
 	struct net_local *lp = netdev_priv(dev);
 
 	dev->stats.tx_packets++;
-	if (lp->deferred_skb) {
-		if (xemaclite_send_data(lp,
-					(u8 *) lp->deferred_skb->data,
-					lp->deferred_skb->len) != 0)
-			return;
-		else {
-			dev->stats.tx_bytes += lp->deferred_skb->len;
-			dev_kfree_skb_irq(lp->deferred_skb);
-			lp->deferred_skb = NULL;
-			netif_trans_update(dev); /* prevent tx timeout */
-			netif_wake_queue(dev);
-		}
-	}
+	if (!lp->deferred_skb)
+		return;
+
+	if (xemaclite_send_data(lp, (u8 *) lp->deferred_skb->data,
+				lp->deferred_skb->len))
+		return;
+
+	dev->stats.tx_bytes += lp->deferred_skb->len;
+	dev_kfree_skb_irq(lp->deferred_skb);
+	lp->deferred_skb = NULL;
+	netif_trans_update(dev); /* prevent tx timeout */
+	netif_wake_queue(dev);
 }
 
 /**
@@ -1052,13 +1051,12 @@ static bool get_bool(struct platform_device *ofdev, const char *s)
 {
 	u32 *p = (u32 *)of_get_property(ofdev->dev.of_node, s, NULL);
 
-	if (p) {
-		return (bool)*p;
-	} else {
-		dev_warn(&ofdev->dev, "Parameter %s not found,"
-			"defaulting to false\n", s);
+	if (!p) {
+		dev_warn(&ofdev->dev, "Parameter %s not found, defaulting to false\n", s);
 		return false;
 	}
+
+	return (bool)*p;
 }
 
 static const struct net_device_ops xemaclite_netdev_ops;
-- 
1.7.1
