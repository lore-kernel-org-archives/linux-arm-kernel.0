From: isubramanian@apm.com (Iyappan Subramanian)
Date: Thu,  2 Oct 2014 17:02:48 -0700
Subject: [PATCH v2 6/6] drivers: net: xgene: Add 10GbE ethtool support
In-Reply-To: <1412294568-26747-1-git-send-email-isubramanian@apm.com>
References: <1412294568-26747-1-git-send-email-isubramanian@apm.com>
Message-ID: <1412294568-26747-7-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
Signed-off-by: Keyur Chudgar <kchudgar@apm.com>
---
 .../net/ethernet/apm/xgene/xgene_enet_ethtool.c    | 28 +++++++++++++++++-----
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.c b/drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.c
index 63f2aa5..c1c997b 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.c
@@ -59,10 +59,22 @@ static int xgene_get_settings(struct net_device *ndev, struct ethtool_cmd *cmd)
 	struct xgene_enet_pdata *pdata = netdev_priv(ndev);
 	struct phy_device *phydev = pdata->phy_dev;
 
-	if (phydev == NULL)
-		return -ENODEV;
+	if (pdata->phy_mode == PHY_INTERFACE_MODE_RGMII) {
+		if (phydev == NULL)
+			return -ENODEV;
 
-	return phy_ethtool_gset(phydev, cmd);
+		return phy_ethtool_gset(phydev, cmd);
+	}
+
+	cmd->supported = SUPPORTED_10000baseT_Full | SUPPORTED_FIBRE;
+	cmd->advertising = cmd->supported;
+	ethtool_cmd_speed_set(cmd, SPEED_10000);
+	cmd->duplex = DUPLEX_FULL;
+	cmd->port = PORT_FIBRE;
+	cmd->transceiver = XCVR_EXTERNAL;
+	cmd->autoneg = AUTONEG_DISABLE;
+
+	return 0;
 }
 
 static int xgene_set_settings(struct net_device *ndev, struct ethtool_cmd *cmd)
@@ -70,10 +82,14 @@ static int xgene_set_settings(struct net_device *ndev, struct ethtool_cmd *cmd)
 	struct xgene_enet_pdata *pdata = netdev_priv(ndev);
 	struct phy_device *phydev = pdata->phy_dev;
 
-	if (phydev == NULL)
-		return -ENODEV;
+	if (pdata->phy_mode == PHY_INTERFACE_MODE_RGMII) {
+		if (phydev == NULL)
+			return -ENODEV;
+
+		return phy_ethtool_sset(phydev, cmd);
+	}
 
-	return phy_ethtool_sset(phydev, cmd);
+	return -EINVAL;
 }
 
 static void xgene_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
-- 
1.9.1
