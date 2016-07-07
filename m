From: isubramanian@apm.com (Iyappan Subramanian)
Date: Thu,  7 Jul 2016 16:02:56 -0700
Subject: [PATCH v5 08/11] drivers: net: xgene: ethtool: Use phy_ethtool_gset
 and sset
In-Reply-To: <1467932579-14320-1-git-send-email-isubramanian@apm.com>
References: <1467932579-14320-1-git-send-email-isubramanian@apm.com>
Message-ID: <1467932579-14320-9-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changed SGMII 1G get_settings to use phy_ethtool_gset.
Changed SGMII 1G set_settings to use phy_ethtool_sset.

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
Tested-by: Fushen Chen <fchen@apm.com>
Tested-by: Toan Le <toanle@apm.com>
---
 .../net/ethernet/apm/xgene/xgene_enet_ethtool.c    | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.c b/drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.c
index 416d6eb..22a7b26 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.c
@@ -65,8 +65,15 @@ static int xgene_get_settings(struct net_device *ndev, struct ethtool_cmd *cmd)
 
 		return phy_ethtool_gset(phydev, cmd);
 	} else if (pdata->phy_mode == PHY_INTERFACE_MODE_SGMII) {
-		cmd->supported = SUPPORTED_1000baseT_Full |
-				 SUPPORTED_Autoneg | SUPPORTED_MII;
+		if (pdata->mdio_driver) {
+			if (!phydev)
+				return -ENODEV;
+
+			return phy_ethtool_gset(phydev, cmd);
+		}
+
+		cmd->supported = SUPPORTED_1000baseT_Full | SUPPORTED_Autoneg |
+				 SUPPORTED_MII;
 		cmd->advertising = cmd->supported;
 		ethtool_cmd_speed_set(cmd, SPEED_1000);
 		cmd->duplex = DUPLEX_FULL;
@@ -92,12 +99,21 @@ static int xgene_set_settings(struct net_device *ndev, struct ethtool_cmd *cmd)
 	struct phy_device *phydev = pdata->phy_dev;
 
 	if (pdata->phy_mode == PHY_INTERFACE_MODE_RGMII) {
-		if (phydev == NULL)
+		if (!phydev)
 			return -ENODEV;
 
 		return phy_ethtool_sset(phydev, cmd);
 	}
 
+	if (pdata->phy_mode == PHY_INTERFACE_MODE_SGMII) {
+		if (pdata->mdio_driver) {
+			if (!phydev)
+				return -ENODEV;
+
+			return phy_ethtool_sset(phydev, cmd);
+		}
+	}
+
 	return -EINVAL;
 }
 
-- 
1.9.1
