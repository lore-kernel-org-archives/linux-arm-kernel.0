From: yuehaibing@huawei.com (YueHaibing)
Date: Wed, 19 Sep 2018 18:50:17 +0800
Subject: [PATCH net-next] net: amd: fix return type of ndo_start_xmit function
Message-ID: <20180919105017.15304-1-yuehaibing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, so make sure the implementation in
this driver has returns 'netdev_tx_t' value, and change the function
return type to netdev_tx_t.

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/amd/am79c961a.c     | 2 +-
 drivers/net/ethernet/amd/atarilance.c    | 6 ++++--
 drivers/net/ethernet/amd/declance.c      | 2 +-
 drivers/net/ethernet/amd/sun3lance.c     | 6 ++++--
 drivers/net/ethernet/amd/sunlance.c      | 2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c | 4 ++--
 6 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/amd/am79c961a.c b/drivers/net/ethernet/amd/am79c961a.c
index 01d132c..265039c 100644
--- a/drivers/net/ethernet/amd/am79c961a.c
+++ b/drivers/net/ethernet/amd/am79c961a.c
@@ -440,7 +440,7 @@ static void am79c961_timeout(struct net_device *dev)
 /*
  * Transmit a packet
  */
-static int
+static netdev_tx_t
 am79c961_sendpacket(struct sk_buff *skb, struct net_device *dev)
 {
 	struct dev_priv *priv = netdev_priv(dev);
diff --git a/drivers/net/ethernet/amd/atarilance.c b/drivers/net/ethernet/amd/atarilance.c
index c5b8126..d3d44e0 100644
--- a/drivers/net/ethernet/amd/atarilance.c
+++ b/drivers/net/ethernet/amd/atarilance.c
@@ -339,7 +339,8 @@ static unsigned long lance_probe1( struct net_device *dev, struct lance_addr
                                    *init_rec );
 static int lance_open( struct net_device *dev );
 static void lance_init_ring( struct net_device *dev );
-static int lance_start_xmit( struct sk_buff *skb, struct net_device *dev );
+static netdev_tx_t lance_start_xmit(struct sk_buff *skb,
+				    struct net_device *dev);
 static irqreturn_t lance_interrupt( int irq, void *dev_id );
 static int lance_rx( struct net_device *dev );
 static int lance_close( struct net_device *dev );
@@ -769,7 +770,8 @@ static void lance_tx_timeout (struct net_device *dev)
 
 /* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX */
 
-static int lance_start_xmit( struct sk_buff *skb, struct net_device *dev )
+static netdev_tx_t
+lance_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct lance_private *lp = netdev_priv(dev);
 	struct lance_ioreg	 *IO = lp->iobase;
diff --git a/drivers/net/ethernet/amd/declance.c b/drivers/net/ethernet/amd/declance.c
index 116997a..29ebbf5 100644
--- a/drivers/net/ethernet/amd/declance.c
+++ b/drivers/net/ethernet/amd/declance.c
@@ -894,7 +894,7 @@ static void lance_tx_timeout(struct net_device *dev)
 	netif_wake_queue(dev);
 }
 
-static int lance_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t lance_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct lance_private *lp = netdev_priv(dev);
 	volatile struct lance_regs *ll = lp->ll;
diff --git a/drivers/net/ethernet/amd/sun3lance.c b/drivers/net/ethernet/amd/sun3lance.c
index 77b1db2..da7e3d4 100644
--- a/drivers/net/ethernet/amd/sun3lance.c
+++ b/drivers/net/ethernet/amd/sun3lance.c
@@ -236,7 +236,8 @@ struct lance_private {
 static int lance_probe( struct net_device *dev);
 static int lance_open( struct net_device *dev );
 static void lance_init_ring( struct net_device *dev );
-static int lance_start_xmit( struct sk_buff *skb, struct net_device *dev );
+static netdev_tx_t lance_start_xmit(struct sk_buff *skb,
+				    struct net_device *dev);
 static irqreturn_t lance_interrupt( int irq, void *dev_id);
 static int lance_rx( struct net_device *dev );
 static int lance_close( struct net_device *dev );
@@ -511,7 +512,8 @@ static void lance_init_ring( struct net_device *dev )
 }
 
 
-static int lance_start_xmit( struct sk_buff *skb, struct net_device *dev )
+static netdev_tx_t
+lance_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct lance_private *lp = netdev_priv(dev);
 	int entry, len;
diff --git a/drivers/net/ethernet/amd/sunlance.c b/drivers/net/ethernet/amd/sunlance.c
index cdd7a61..b4fc0ed 100644
--- a/drivers/net/ethernet/amd/sunlance.c
+++ b/drivers/net/ethernet/amd/sunlance.c
@@ -1106,7 +1106,7 @@ static void lance_tx_timeout(struct net_device *dev)
 	netif_wake_queue(dev);
 }
 
-static int lance_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t lance_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct lance_private *lp = netdev_priv(dev);
 	int entry, skblen, len;
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 24f1053..d96a84a 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -2009,7 +2009,7 @@ static int xgbe_close(struct net_device *netdev)
 	return 0;
 }
 
-static int xgbe_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t xgbe_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct xgbe_prv_data *pdata = netdev_priv(netdev);
 	struct xgbe_hw_if *hw_if = &pdata->hw_if;
@@ -2018,7 +2018,7 @@ static int xgbe_xmit(struct sk_buff *skb, struct net_device *netdev)
 	struct xgbe_ring *ring;
 	struct xgbe_packet_data *packet;
 	struct netdev_queue *txq;
-	int ret;
+	netdev_tx_t ret;
 
 	DBGPR("-->xgbe_xmit: skb->len = %d\n", skb->len);
 
-- 
1.8.3.1
