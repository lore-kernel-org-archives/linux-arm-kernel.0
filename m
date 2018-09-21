From: yuehaibing@huawei.com (YueHaibing)
Date: Fri, 21 Sep 2018 11:44:05 +0800
Subject: [PATCH net-next] net: i825xx: fix return type of ndo_start_xmit
 function
Message-ID: <20180921034405.20052-1-yuehaibing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, so make sure the implementation in
this driver has returns 'netdev_tx_t' value, and change the function
return type to netdev_tx_t.

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/i825xx/ether1.c     | 5 +++--
 drivers/net/ethernet/i825xx/lib82596.c   | 4 ++--
 drivers/net/ethernet/i825xx/sun3_82586.c | 6 ++++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/i825xx/ether1.c b/drivers/net/ethernet/i825xx/ether1.c
index dc98345..35f6291 100644
--- a/drivers/net/ethernet/i825xx/ether1.c
+++ b/drivers/net/ethernet/i825xx/ether1.c
@@ -64,7 +64,8 @@
 #define RX_AREA_END	0x0fc00
 
 static int ether1_open(struct net_device *dev);
-static int ether1_sendpacket(struct sk_buff *skb, struct net_device *dev);
+static netdev_tx_t ether1_sendpacket(struct sk_buff *skb,
+				     struct net_device *dev);
 static irqreturn_t ether1_interrupt(int irq, void *dev_id);
 static int ether1_close(struct net_device *dev);
 static void ether1_setmulticastlist(struct net_device *dev);
@@ -667,7 +668,7 @@
 	netif_wake_queue(dev);
 }
 
-static int
+static netdev_tx_t
 ether1_sendpacket (struct sk_buff *skb, struct net_device *dev)
 {
 	int tmp, tst, nopaddr, txaddr, tbdaddr, dataddr;
diff --git a/drivers/net/ethernet/i825xx/lib82596.c b/drivers/net/ethernet/i825xx/lib82596.c
index f00a1dc..2f7ae11 100644
--- a/drivers/net/ethernet/i825xx/lib82596.c
+++ b/drivers/net/ethernet/i825xx/lib82596.c
@@ -347,7 +347,7 @@ struct i596_private {
 	0x7f /*  *multi IA */ };
 
 static int i596_open(struct net_device *dev);
-static int i596_start_xmit(struct sk_buff *skb, struct net_device *dev);
+static netdev_tx_t i596_start_xmit(struct sk_buff *skb, struct net_device *dev);
 static irqreturn_t i596_interrupt(int irq, void *dev_id);
 static int i596_close(struct net_device *dev);
 static void i596_add_cmd(struct net_device *dev, struct i596_cmd *cmd);
@@ -966,7 +966,7 @@ static void i596_tx_timeout (struct net_device *dev)
 }
 
 
-static int i596_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t i596_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct i596_private *lp = netdev_priv(dev);
 	struct tx_cmd *tx_cmd;
diff --git a/drivers/net/ethernet/i825xx/sun3_82586.c b/drivers/net/ethernet/i825xx/sun3_82586.c
index 8bb15a8..1a86184 100644
--- a/drivers/net/ethernet/i825xx/sun3_82586.c
+++ b/drivers/net/ethernet/i825xx/sun3_82586.c
@@ -121,7 +121,8 @@
 static irqreturn_t sun3_82586_interrupt(int irq,void *dev_id);
 static int     sun3_82586_open(struct net_device *dev);
 static int     sun3_82586_close(struct net_device *dev);
-static int     sun3_82586_send_packet(struct sk_buff *,struct net_device *);
+static netdev_tx_t     sun3_82586_send_packet(struct sk_buff *,
+					      struct net_device *);
 static struct  net_device_stats *sun3_82586_get_stats(struct net_device *dev);
 static void    set_multicast_list(struct net_device *dev);
 static void    sun3_82586_timeout(struct net_device *dev);
@@ -1002,7 +1003,8 @@ static void sun3_82586_timeout(struct net_device *dev)
  * send frame
  */
 
-static int sun3_82586_send_packet(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+sun3_82586_send_packet(struct sk_buff *skb, struct net_device *dev)
 {
 	int len,i;
 #ifndef NO_NOPCOMMANDS
-- 
1.8.3.1
