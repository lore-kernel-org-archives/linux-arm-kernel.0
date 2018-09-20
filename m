From: yuehaibing@huawei.com (YueHaibing)
Date: Thu, 20 Sep 2018 20:32:59 +0800
Subject: [PATCH net-next 15/22] net: hamradio: fix return type of
 ndo_start_xmit function
In-Reply-To: <20180920123306.14772-1-yuehaibing@huawei.com>
References: <20180920123306.14772-1-yuehaibing@huawei.com>
Message-ID: <20180920123306.14772-16-yuehaibing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, so make sure the implementation in
this driver has returns 'netdev_tx_t' value, and change the function
return type to netdev_tx_t.

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/hamradio/baycom_epp.c | 3 ++-
 drivers/net/hamradio/dmascc.c     | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/hamradio/baycom_epp.c b/drivers/net/hamradio/baycom_epp.c
index 1e62d00..f4ceccf 100644
--- a/drivers/net/hamradio/baycom_epp.c
+++ b/drivers/net/hamradio/baycom_epp.c
@@ -772,7 +772,8 @@ static void epp_bh(struct work_struct *work)
  * ===================== network driver interface =========================
  */
 
-static int baycom_send_packet(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+baycom_send_packet(struct sk_buff *skb, struct net_device *dev)
 {
 	struct baycom_state *bc = netdev_priv(dev);
 
diff --git a/drivers/net/hamradio/dmascc.c b/drivers/net/hamradio/dmascc.c
index cde4120..2798870 100644
--- a/drivers/net/hamradio/dmascc.c
+++ b/drivers/net/hamradio/dmascc.c
@@ -239,7 +239,7 @@ struct scc_info {
 static int scc_open(struct net_device *dev);
 static int scc_close(struct net_device *dev);
 static int scc_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd);
-static int scc_send_packet(struct sk_buff *skb, struct net_device *dev);
+static netdev_tx_t scc_send_packet(struct sk_buff *skb, struct net_device *dev);
 static int scc_set_mac_address(struct net_device *dev, void *sa);
 
 static inline void tx_on(struct scc_priv *priv);
@@ -921,7 +921,7 @@ static int scc_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 }
 
 
-static int scc_send_packet(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t scc_send_packet(struct sk_buff *skb, struct net_device *dev)
 {
 	struct scc_priv *priv = dev->ml_priv;
 	unsigned long flags;
-- 
1.8.3.1
