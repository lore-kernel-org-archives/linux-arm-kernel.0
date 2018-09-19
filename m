From: yuehaibing@huawei.com (YueHaibing)
Date: Wed, 19 Sep 2018 18:32:40 +0800
Subject: [PATCH net-next] net: xilinx: fix return type of ndo_start_xmit
 function
In-Reply-To: <20180919103240.27708-1-yuehaibing@huawei.com>
References: <20180919103240.27708-1-yuehaibing@huawei.com>
Message-ID: <20180919103240.27708-2-yuehaibing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, so make sure the implementation in
this driver has returns 'netdev_tx_t' value, and change the function
return type to netdev_tx_t.

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/xilinx/ll_temac_main.c       | 3 ++-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 3 ++-
 drivers/net/ethernet/xilinx/xilinx_emaclite.c     | 9 +++++----
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index 60abc92..2241f98 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -674,7 +674,8 @@ static inline int temac_check_tx_bd_space(struct temac_local *lp, int num_frag)
 	return 0;
 }
 
-static int temac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t
+temac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct temac_local *lp = netdev_priv(ndev);
 	struct cdmac_bd *cur_p;
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index f24f48f..12a1460 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -653,7 +653,8 @@ static inline int axienet_check_tx_bd_space(struct axienet_local *lp,
  * start the transmission. Additionally if checksum offloading is supported,
  * it populates AXI Stream Control fields with appropriate values.
  */
-static int axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t
+axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	u32 ii;
 	u32 num_frag;
diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 46d3092..639e3e9 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -1019,9 +1019,10 @@ static int xemaclite_close(struct net_device *dev)
  * deferred and the Tx queue is stopped so that the deferred socket buffer can
  * be transmitted when the Emaclite device is free to transmit data.
  *
- * Return:	0, always.
+ * Return:	NETDEV_TX_OK, always.
  */
-static int xemaclite_send(struct sk_buff *orig_skb, struct net_device *dev)
+static netdev_tx_t
+xemaclite_send(struct sk_buff *orig_skb, struct net_device *dev)
 {
 	struct net_local *lp = netdev_priv(dev);
 	struct sk_buff *new_skb;
@@ -1043,7 +1044,7 @@ static int xemaclite_send(struct sk_buff *orig_skb, struct net_device *dev)
 		/* Take the time stamp now, since we can't do this in an ISR. */
 		skb_tx_timestamp(new_skb);
 		spin_unlock_irqrestore(&lp->reset_lock, flags);
-		return 0;
+		return NETDEV_TX_OK;
 	}
 	spin_unlock_irqrestore(&lp->reset_lock, flags);
 
@@ -1052,7 +1053,7 @@ static int xemaclite_send(struct sk_buff *orig_skb, struct net_device *dev)
 	dev->stats.tx_bytes += len;
 	dev_consume_skb_any(new_skb);
 
-	return 0;
+	return NETDEV_TX_OK;
 }
 
 /**
-- 
1.8.3.1
