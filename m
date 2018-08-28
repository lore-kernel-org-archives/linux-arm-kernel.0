From: mkubecek@suse.cz (Michal Kubecek)
Date: Tue, 28 Aug 2018 19:56:53 +0200 (CEST)
Subject: [PATCH net-next 1/2] 8390/etherh: convert to
 ethtool_{get,set}_link_ksettings
In-Reply-To: <cover.1535477409.git.mkubecek@suse.cz>
References: <cover.1535477409.git.mkubecek@suse.cz>
Message-ID: <33df6a13852258285819ffe3940d3d14ece9bbe8.1535477409.git.mkubecek@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the last in-tree driver using the old {get,set}_settings API.

Note: this is only build tested. I don't have the hardware at hand; as it's
10Mb/s half duplex device and driver can be built only for one subplatform
of 32-bit ARM (Acorn RiscPC), it may be difficult to find someone who does.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 drivers/net/ethernet/8390/etherh.c | 35 ++++++++++++++++--------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/8390/etherh.c b/drivers/net/ethernet/8390/etherh.c
index 32e9627e3880..77191a281866 100644
--- a/drivers/net/ethernet/8390/etherh.c
+++ b/drivers/net/ethernet/8390/etherh.c
@@ -564,26 +564,29 @@ static void etherh_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *i
 		sizeof(info->bus_info));
 }
 
-static int etherh_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
+static int etherh_get_link_ksettings(struct net_device *dev,
+				     struct ethtool_link_ksettings *cmd)
 {
-	cmd->supported	= etherh_priv(dev)->supported;
-	ethtool_cmd_speed_set(cmd, SPEED_10);
-	cmd->duplex	= DUPLEX_HALF;
-	cmd->port	= dev->if_port == IF_PORT_10BASET ? PORT_TP : PORT_BNC;
-	cmd->autoneg	= (dev->flags & IFF_AUTOMEDIA ?
-			   AUTONEG_ENABLE : AUTONEG_DISABLE);
+	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
+						etherh_priv(dev)->supported);
+	cmd->base.speed = SPEED_10;
+	cmd->base.duplex = DUPLEX_HALF;
+	cmd->base.port = dev->if_port == IF_PORT_10BASET ? PORT_TP : PORT_BNC;
+	cmd->base.autoneg = (dev->flags & IFF_AUTOMEDIA ? AUTONEG_ENABLE :
+							  AUTONEG_DISABLE);
 	return 0;
 }
 
-static int etherh_set_settings(struct net_device *dev, struct ethtool_cmd *cmd)
+static int etherh_set_link_ksettings(struct net_device *dev,
+				     const struct ethtool_link_ksettings *cmd)
 {
-	switch (cmd->autoneg) {
+	switch (cmd->base.autoneg) {
 	case AUTONEG_ENABLE:
 		dev->flags |= IFF_AUTOMEDIA;
 		break;
 
 	case AUTONEG_DISABLE:
-		switch (cmd->port) {
+		switch (cmd->base.port) {
 		case PORT_TP:
 			dev->if_port = IF_PORT_10BASET;
 			break;
@@ -622,12 +625,12 @@ static void etherh_set_msglevel(struct net_device *dev, u32 v)
 }
 
 static const struct ethtool_ops etherh_ethtool_ops = {
-	.get_settings	= etherh_get_settings,
-	.set_settings	= etherh_set_settings,
-	.get_drvinfo	= etherh_get_drvinfo,
-	.get_ts_info	= ethtool_op_get_ts_info,
-	.get_msglevel	= etherh_get_msglevel,
-	.set_msglevel	= etherh_set_msglevel,
+	.get_drvinfo		= etherh_get_drvinfo,
+	.get_ts_info		= ethtool_op_get_ts_info,
+	.get_msglevel		= etherh_get_msglevel,
+	.set_msglevel		= etherh_set_msglevel,
+	.get_link_ksettings	= etherh_get_link_ksettings,
+	.set_link_ksettings	= etherh_set_link_ksettings,
 };
 
 static const struct net_device_ops etherh_netdev_ops = {
-- 
2.18.0
