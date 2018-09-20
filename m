From: yuehaibing@huawei.com (YueHaibing)
Date: Thu, 20 Sep 2018 20:32:52 +0800
Subject: [PATCH net-next 08/22] net: apple: fix return type of ndo_start_xmit
 function
In-Reply-To: <20180920123306.14772-1-yuehaibing@huawei.com>
References: <20180920123306.14772-1-yuehaibing@huawei.com>
Message-ID: <20180920123306.14772-9-yuehaibing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, so make sure the implementation in
this driver has returns 'netdev_tx_t' value, and change the function
return type to netdev_tx_t.

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/apple/bmac.c    | 4 ++--
 drivers/net/ethernet/apple/mace.c    | 4 ++--
 drivers/net/ethernet/apple/macmace.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/apple/bmac.c b/drivers/net/ethernet/apple/bmac.c
index 024998d..6a8e256 100644
--- a/drivers/net/ethernet/apple/bmac.c
+++ b/drivers/net/ethernet/apple/bmac.c
@@ -154,7 +154,7 @@ struct bmac_data {
 static irqreturn_t bmac_rxdma_intr(int irq, void *dev_id);
 static void bmac_set_timeout(struct net_device *dev);
 static void bmac_tx_timeout(struct timer_list *t);
-static int bmac_output(struct sk_buff *skb, struct net_device *dev);
+static netdev_tx_t bmac_output(struct sk_buff *skb, struct net_device *dev);
 static void bmac_start(struct net_device *dev);
 
 #define	DBDMA_SET(x)	( ((x) | (x) << 16) )
@@ -1456,7 +1456,7 @@ static int bmac_close(struct net_device *dev)
 	spin_unlock_irqrestore(&bp->lock, flags);
 }
 
-static int
+static netdev_tx_t
 bmac_output(struct sk_buff *skb, struct net_device *dev)
 {
 	struct bmac_data *bp = netdev_priv(dev);
diff --git a/drivers/net/ethernet/apple/mace.c b/drivers/net/ethernet/apple/mace.c
index 0b5429d..68b9ee4 100644
--- a/drivers/net/ethernet/apple/mace.c
+++ b/drivers/net/ethernet/apple/mace.c
@@ -78,7 +78,7 @@ struct mace_data {
 
 static int mace_open(struct net_device *dev);
 static int mace_close(struct net_device *dev);
-static int mace_xmit_start(struct sk_buff *skb, struct net_device *dev);
+static netdev_tx_t mace_xmit_start(struct sk_buff *skb, struct net_device *dev);
 static void mace_set_multicast(struct net_device *dev);
 static void mace_reset(struct net_device *dev);
 static int mace_set_address(struct net_device *dev, void *addr);
@@ -525,7 +525,7 @@ static inline void mace_set_timeout(struct net_device *dev)
     mp->timeout_active = 1;
 }
 
-static int mace_xmit_start(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t mace_xmit_start(struct sk_buff *skb, struct net_device *dev)
 {
     struct mace_data *mp = netdev_priv(dev);
     volatile struct dbdma_regs __iomem *td = mp->tx_dma;
diff --git a/drivers/net/ethernet/apple/macmace.c b/drivers/net/ethernet/apple/macmace.c
index 137cbb4..376f2c2 100644
--- a/drivers/net/ethernet/apple/macmace.c
+++ b/drivers/net/ethernet/apple/macmace.c
@@ -89,7 +89,7 @@ struct mace_frame {
 
 static int mace_open(struct net_device *dev);
 static int mace_close(struct net_device *dev);
-static int mace_xmit_start(struct sk_buff *skb, struct net_device *dev);
+static netdev_tx_t mace_xmit_start(struct sk_buff *skb, struct net_device *dev);
 static void mace_set_multicast(struct net_device *dev);
 static int mace_set_address(struct net_device *dev, void *addr);
 static void mace_reset(struct net_device *dev);
@@ -444,7 +444,7 @@ static int mace_close(struct net_device *dev)
  * Transmit a frame
  */
 
-static int mace_xmit_start(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t mace_xmit_start(struct sk_buff *skb, struct net_device *dev)
 {
 	struct mace_data *mp = netdev_priv(dev);
 	unsigned long flags;
-- 
1.8.3.1
