From: yuehaibing@huawei.com (YueHaibing)
Date: Thu, 20 Sep 2018 20:33:03 +0800
Subject: [PATCH net-next 19/22] net: plip: fix return type of ndo_start_xmit
 function
In-Reply-To: <20180920123306.14772-1-yuehaibing@huawei.com>
References: <20180920123306.14772-1-yuehaibing@huawei.com>
Message-ID: <20180920123306.14772-20-yuehaibing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, so make sure the implementation in
this driver has returns 'netdev_tx_t' value, and change the function
return type to netdev_tx_t.

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/plip/plip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/plip/plip.c b/drivers/net/plip/plip.c
index feb92ec..0b354e6 100644
--- a/drivers/net/plip/plip.c
+++ b/drivers/net/plip/plip.c
@@ -146,7 +146,7 @@
 static void plip_interrupt(void *dev_id);
 
 /* Functions for DEV methods */
-static int plip_tx_packet(struct sk_buff *skb, struct net_device *dev);
+static netdev_tx_t plip_tx_packet(struct sk_buff *skb, struct net_device *dev);
 static int plip_hard_header(struct sk_buff *skb, struct net_device *dev,
                             unsigned short type, const void *daddr,
 			    const void *saddr, unsigned len);
@@ -962,7 +962,7 @@ static __be16 plip_type_trans(struct sk_buff *skb, struct net_device *dev)
 	spin_unlock_irqrestore(&nl->lock, flags);
 }
 
-static int
+static netdev_tx_t
 plip_tx_packet(struct sk_buff *skb, struct net_device *dev)
 {
 	struct net_local *nl = netdev_priv(dev);
-- 
1.8.3.1
