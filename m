From: yuehaibing@huawei.com (YueHaibing)
Date: Thu, 20 Sep 2018 20:32:45 +0800
Subject: [PATCH net-next 01/22] net: micrel: fix return type of ndo_start_xmit
 function
In-Reply-To: <20180920123306.14772-1-yuehaibing@huawei.com>
References: <20180920123306.14772-1-yuehaibing@huawei.com>
Message-ID: <20180920123306.14772-2-yuehaibing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, so make sure the implementation in
this driver has returns 'netdev_tx_t' value, and change the function
return type to netdev_tx_t.

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/micrel/ks8695net.c  | 2 +-
 drivers/net/ethernet/micrel/ks8851_mll.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/micrel/ks8695net.c b/drivers/net/ethernet/micrel/ks8695net.c
index bd51e05..b881f5d 100644
--- a/drivers/net/ethernet/micrel/ks8695net.c
+++ b/drivers/net/ethernet/micrel/ks8695net.c
@@ -1164,7 +1164,7 @@ static int ks8695_poll(struct napi_struct *napi, int budget)
  *	sk_buff and adds it to the TX ring. It then kicks the TX DMA
  *	engine to ensure transmission begins.
  */
-static int
+static netdev_tx_t
 ks8695_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct ks8695_priv *ksp = netdev_priv(ndev);
diff --git a/drivers/net/ethernet/micrel/ks8851_mll.c b/drivers/net/ethernet/micrel/ks8851_mll.c
index 0e9719f..35f8c9e 100644
--- a/drivers/net/ethernet/micrel/ks8851_mll.c
+++ b/drivers/net/ethernet/micrel/ks8851_mll.c
@@ -1021,9 +1021,9 @@ static void ks_write_qmu(struct ks_net *ks, u8 *pdata, u16 len)
  * spin_lock_irqsave is required because tx and rx should be mutual exclusive.
  * So while tx is in-progress, prevent IRQ interrupt from happenning.
  */
-static int ks_start_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t ks_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
-	int retv = NETDEV_TX_OK;
+	netdev_tx_t retv = NETDEV_TX_OK;
 	struct ks_net *ks = netdev_priv(netdev);
 
 	disable_irq(netdev->irq);
-- 
1.8.3.1
