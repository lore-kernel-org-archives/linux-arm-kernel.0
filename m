From: tremyfr@gmail.com (Philippe Reynes)
Date: Sun, 18 Sep 2016 16:59:07 +0200
Subject: [PATCH 2/2] net: ethernet: broadcom: bcm63xx: use new api
 ethtool_{get|set}_link_ksettings
In-Reply-To: <1474210747-19627-1-git-send-email-tremyfr@gmail.com>
References: <1474210747-19627-1-git-send-email-tremyfr@gmail.com>
Message-ID: <1474210747-19627-2-git-send-email-tremyfr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ethtool api {get|set}_settings is deprecated.
We move this driver to new api {get|set}_link_ksettings.

Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
---
 drivers/net/ethernet/broadcom/bcm63xx_enet.c |   52 ++++++++++++++------------
 1 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index 082f3f0..ae364c7 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -1442,39 +1442,40 @@ static int bcm_enet_nway_reset(struct net_device *dev)
 	return -EOPNOTSUPP;
 }
 
-static int bcm_enet_get_settings(struct net_device *dev,
-				 struct ethtool_cmd *cmd)
+static int bcm_enet_get_link_ksettings(struct net_device *dev,
+				       struct ethtool_link_ksettings *cmd)
 {
 	struct bcm_enet_priv *priv;
+	u32 supported, advertising;
 
 	priv = netdev_priv(dev);
 
-	cmd->maxrxpkt = 0;
-	cmd->maxtxpkt = 0;
-
 	if (priv->has_phy) {
 		if (!dev->phydev)
 			return -ENODEV;
-		return phy_ethtool_gset(dev->phydev, cmd);
+		return phy_ethtool_ksettings_get(dev->phydev, cmd);
 	} else {
-		cmd->autoneg = 0;
-		ethtool_cmd_speed_set(cmd, ((priv->force_speed_100)
-					    ? SPEED_100 : SPEED_10));
-		cmd->duplex = (priv->force_duplex_full) ?
+		cmd->base.autoneg = 0;
+		cmd->base.speed = (priv->force_speed_100) ?
+			SPEED_100 : SPEED_10;
+		cmd->base.duplex = (priv->force_duplex_full) ?
 			DUPLEX_FULL : DUPLEX_HALF;
-		cmd->supported = ADVERTISED_10baseT_Half  |
+		supported = ADVERTISED_10baseT_Half |
 			ADVERTISED_10baseT_Full |
 			ADVERTISED_100baseT_Half |
 			ADVERTISED_100baseT_Full;
-		cmd->advertising = 0;
-		cmd->port = PORT_MII;
-		cmd->transceiver = XCVR_EXTERNAL;
+		advertising = 0;
+		ethtool_convert_legacy_u32_to_link_mode(
+			cmd->link_modes.supported, supported);
+		ethtool_convert_legacy_u32_to_link_mode(
+			cmd->link_modes.advertising, advertising);
+		cmd->base.port = PORT_MII;
 	}
 	return 0;
 }
 
-static int bcm_enet_set_settings(struct net_device *dev,
-				 struct ethtool_cmd *cmd)
+static int bcm_enet_set_link_ksettings(struct net_device *dev,
+				       const struct ethtool_link_ksettings *cmd)
 {
 	struct bcm_enet_priv *priv;
 
@@ -1482,16 +1483,19 @@ static int bcm_enet_set_settings(struct net_device *dev,
 	if (priv->has_phy) {
 		if (!dev->phydev)
 			return -ENODEV;
-		return phy_ethtool_sset(dev->phydev, cmd);
+		return phy_ethtool_ksettings_set(dev->phydev, cmd);
 	} else {
 
-		if (cmd->autoneg ||
-		    (cmd->speed != SPEED_100 && cmd->speed != SPEED_10) ||
-		    cmd->port != PORT_MII)
+		if (cmd->base.autoneg ||
+		    (cmd->base.speed != SPEED_100 &&
+		     cmd->base.speed != SPEED_10) ||
+		    cmd->base.port != PORT_MII)
 			return -EINVAL;
 
-		priv->force_speed_100 = (cmd->speed == SPEED_100) ? 1 : 0;
-		priv->force_duplex_full = (cmd->duplex == DUPLEX_FULL) ? 1 : 0;
+		priv->force_speed_100 =
+			(cmd->base.speed == SPEED_100) ? 1 : 0;
+		priv->force_duplex_full =
+			(cmd->base.duplex == DUPLEX_FULL) ? 1 : 0;
 
 		if (netif_running(dev))
 			bcm_enet_adjust_link(dev);
@@ -1585,14 +1589,14 @@ static const struct ethtool_ops bcm_enet_ethtool_ops = {
 	.get_sset_count		= bcm_enet_get_sset_count,
 	.get_ethtool_stats      = bcm_enet_get_ethtool_stats,
 	.nway_reset		= bcm_enet_nway_reset,
-	.get_settings		= bcm_enet_get_settings,
-	.set_settings		= bcm_enet_set_settings,
 	.get_drvinfo		= bcm_enet_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_ringparam		= bcm_enet_get_ringparam,
 	.set_ringparam		= bcm_enet_set_ringparam,
 	.get_pauseparam		= bcm_enet_get_pauseparam,
 	.set_pauseparam		= bcm_enet_set_pauseparam,
+	.get_link_ksettings	= bcm_enet_get_link_ksettings,
+	.set_link_ksettings	= bcm_enet_set_link_ksettings,
 };
 
 static int bcm_enet_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
-- 
1.7.4.4
