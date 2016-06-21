From: Yisen.Zhuang@huawei.com (Yisen Zhuang)
Date: Tue, 21 Jun 2016 11:56:39 +0800
Subject: [PATCH net-next 19/19] net: hns: bug fix about TSO on|off when there
 is traffic
In-Reply-To: <1466481399-70080-1-git-send-email-Yisen.Zhuang@huawei.com>
References: <1466481399-70080-1-git-send-email-Yisen.Zhuang@huawei.com>
Message-ID: <1466481399-70080-20-git-send-email-Yisen.Zhuang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daode Huang <huangdaode@hisilicon.com>

When enable/disable tso, the driver tries to access the hardware register,
but this operation will cause the port unavalible when there is traffic.
This patch tries to enable TSO when initialize, then control tso through
TSE bit in transmit descriptor.

Signed-off-by: Daode Huang <huangdaode@hisilicon.com>
Signed-off-by: Yisen Zhuang <Yisen.Zhuang@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index c0ce37b..d5297ec 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -1441,7 +1441,6 @@ static int hns_nic_set_features(struct net_device *netdev,
 				netdev_features_t features)
 {
 	struct hns_nic_priv *priv = netdev_priv(netdev);
-	struct hnae_handle *h = priv->ae_handle;
 
 	switch (priv->enet_ver) {
 	case AE_VERSION_1:
@@ -1454,11 +1453,9 @@ static int hns_nic_set_features(struct net_device *netdev,
 			priv->ops.maybe_stop_tx = hns_nic_maybe_stop_tso;
 			/* The chip only support 7*4096 */
 			netif_set_gso_max_size(netdev, 7 * 4096);
-			h->dev->ops->set_tso_stats(h, 1);
 		} else {
 			priv->ops.fill_desc = fill_v2_desc;
 			priv->ops.maybe_stop_tx = hns_nic_maybe_stop_tx;
-			h->dev->ops->set_tso_stats(h, 0);
 		}
 		break;
 	}
@@ -1804,11 +1801,14 @@ static void hns_nic_set_priv_ops(struct net_device *netdev)
 			priv->ops.maybe_stop_tx = hns_nic_maybe_stop_tso;
 			/* This chip only support 7*4096 */
 			netif_set_gso_max_size(netdev, 7 * 4096);
-			h->dev->ops->set_tso_stats(h, 1);
 		} else {
 			priv->ops.fill_desc = fill_v2_desc;
 			priv->ops.maybe_stop_tx = hns_nic_maybe_stop_tx;
 		}
+		/* enable tso when init
+		 * control tso on/off through TSE bit in bd
+		 */
+		h->dev->ops->set_tso_stats(h, 1);
 	}
 }
 
-- 
1.9.1
