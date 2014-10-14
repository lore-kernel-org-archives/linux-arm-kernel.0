From: isubramanian@apm.com (Iyappan Subramanian)
Date: Mon, 13 Oct 2014 17:05:35 -0700
Subject: [PATCH v2 4/4] drivers: net: xgene: Add SGMII based 1GbE ethtool
 support
In-Reply-To: <1413245135-2989-1-git-send-email-isubramanian@apm.com>
References: <1413245135-2989-1-git-send-email-isubramanian@apm.com>
Message-ID: <1413245135-2989-5-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
Signed-off-by: Keyur Chudgar <kchudgar@apm.com>
---
 .../net/ethernet/apm/xgene/xgene_enet_ethtool.c    | 25 +++++++++++++++-------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.c b/drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.c
index c1c997b..416d6eb 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.c
@@ -64,16 +64,25 @@ static int xgene_get_settings(struct net_device *ndev, struct ethtool_cmd *cmd)
 			return -ENODEV;
 
 		return phy_ethtool_gset(phydev, cmd);
+	} else if (pdata->phy_mode == PHY_INTERFACE_MODE_SGMII) {
+		cmd->supported = SUPPORTED_1000baseT_Full |
+				 SUPPORTED_Autoneg | SUPPORTED_MII;
+		cmd->advertising = cmd->supported;
+		ethtool_cmd_speed_set(cmd, SPEED_1000);
+		cmd->duplex = DUPLEX_FULL;
+		cmd->port = PORT_MII;
+		cmd->transceiver = XCVR_INTERNAL;
+		cmd->autoneg = AUTONEG_ENABLE;
+	} else {
+		cmd->supported = SUPPORTED_10000baseT_Full | SUPPORTED_FIBRE;
+		cmd->advertising = cmd->supported;
+		ethtool_cmd_speed_set(cmd, SPEED_10000);
+		cmd->duplex = DUPLEX_FULL;
+		cmd->port = PORT_FIBRE;
+		cmd->transceiver = XCVR_INTERNAL;
+		cmd->autoneg = AUTONEG_DISABLE;
 	}
 
-	cmd->supported = SUPPORTED_10000baseT_Full | SUPPORTED_FIBRE;
-	cmd->advertising = cmd->supported;
-	ethtool_cmd_speed_set(cmd, SPEED_10000);
-	cmd->duplex = DUPLEX_FULL;
-	cmd->port = PORT_FIBRE;
-	cmd->transceiver = XCVR_EXTERNAL;
-	cmd->autoneg = AUTONEG_DISABLE;
-
 	return 0;
 }
 
-- 
1.9.1
