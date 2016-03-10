From: yankejian@huawei.com (Kejian Yan)
Date: Thu, 10 Mar 2016 10:16:29 +0800
Subject: [patch net 2/2] net: hns: fixes a bug of RSS
In-Reply-To: <1457576189-22924-1-git-send-email-yankejian@huawei.com>
References: <1457576189-22924-1-git-send-email-yankejian@huawei.com>
Message-ID: <1457576189-22924-3-git-send-email-yankejian@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If trying to get receive flow hash indirection table by ethtool, it needs
to call .get_rxnfc to get ring number first. So this patch implements the
.get_rxnfc of ethtool. And the data type of rss_indir_table is u32, it has
to be multiply by the width of data type when using memcpy.

Signed-off-by: Kejian Yan <yankejian@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c |  6 ++++--
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c  | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c b/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
index 3b8f301..c733a5a 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
@@ -779,7 +779,8 @@ static int hns_ae_get_rss(struct hnae_handle *handle, u32 *indir, u8 *key,
 		memcpy(key, ppe_cb->rss_key, HNS_PPEV2_RSS_KEY_SIZE);
 
 	/* update the current hash->queue mappings from the shadow RSS table */
-	memcpy(indir, ppe_cb->rss_indir_table, HNS_PPEV2_RSS_IND_TBL_SIZE);
+	memcpy(indir, ppe_cb->rss_indir_table,
+	       HNS_PPEV2_RSS_IND_TBL_SIZE * sizeof(*indir));
 
 	return 0;
 }
@@ -794,7 +795,8 @@ static int hns_ae_set_rss(struct hnae_handle *handle, const u32 *indir,
 		hns_ppe_set_rss_key(ppe_cb, (u32 *)key);
 
 	/* update the shadow RSS table with user specified qids */
-	memcpy(ppe_cb->rss_indir_table, indir, HNS_PPEV2_RSS_IND_TBL_SIZE);
+	memcpy(ppe_cb->rss_indir_table, indir,
+	       HNS_PPEV2_RSS_IND_TBL_SIZE * sizeof(*indir));
 
 	/* now update the hardware */
 	hns_ppe_set_indir_table(ppe_cb, ppe_cb->rss_indir_table);
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
index ada8e04..a070392 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
@@ -1244,6 +1244,25 @@ hns_set_rss(struct net_device *netdev, const u32 *indir, const u8 *key,
 	return ret;
 }
 
+static int hns_get_rxnfc(struct net_device *netdev,
+			 struct ethtool_rxnfc *cmd,
+			 u32 *rule_locs)
+{
+	struct hns_nic_priv *priv = netdev_priv(netdev);
+	int ret = 0;
+
+	switch (cmd->cmd) {
+	case ETHTOOL_GRXRINGS:
+		cmd->data = priv->ae_handle->q_num;
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
+
 static struct ethtool_ops hns_ethtool_ops = {
 	.get_drvinfo = hns_nic_get_drvinfo,
 	.get_link  = hns_nic_get_link,
@@ -1267,6 +1286,7 @@ static struct ethtool_ops hns_ethtool_ops = {
 	.get_rxfh_indir_size = hns_get_rss_indir_size,
 	.get_rxfh = hns_get_rss,
 	.set_rxfh = hns_set_rss,
+	.get_rxnfc = hns_get_rxnfc,
 };
 
 void hns_ethtool_set_ops(struct net_device *ndev)
-- 
1.9.1
