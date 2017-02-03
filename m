From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri,  3 Feb 2017 19:12:14 +0100
Subject: [PATCH net-next 6/8] net: ethernet: annapurna: add wol helpers to the
 Alpine driver
In-Reply-To: <20170203181216.30214-1-antoine.tenart@free-electrons.com>
References: <20170203181216.30214-1-antoine.tenart@free-electrons.com>
Message-ID: <20170203181216.30214-7-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement the get_wol() and set_wol() helpers in the Annapurna Labs
Alpine Ethernet driver.
---
 drivers/net/ethernet/annapurna/al_eth.c | 44 +++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/net/ethernet/annapurna/al_eth.c b/drivers/net/ethernet/annapurna/al_eth.c
index 8dd84f66b5d1..d06a75a49ce5 100644
--- a/drivers/net/ethernet/annapurna/al_eth.c
+++ b/drivers/net/ethernet/annapurna/al_eth.c
@@ -2519,10 +2519,54 @@ static u32 al_eth_get_rxfh_indir_size(struct net_device *netdev)
 	return AL_ETH_RX_RSS_TABLE_SIZE;
 }
 
+static void al_eth_get_wol(struct net_device *netdev,
+			   struct ethtool_wolinfo *wol)
+{
+	struct al_eth_adapter *adapter = netdev_priv(netdev);
+	struct phy_device *phydev;
+
+	wol->wolopts = adapter->wol;
+
+	if ((adapter) && (adapter->phy_exist) && (adapter->mdio_bus)) {
+		phydev = mdiobus_get_phy(adapter->mdio_bus, adapter->phy_addr);
+		if (phydev) {
+			phy_ethtool_get_wol(phydev, wol);
+			wol->supported |= WAKE_PHY;
+			return;
+		}
+	}
+
+	wol->supported |= WAKE_UCAST | WAKE_MCAST | WAKE_BCAST;
+}
+
+static int al_eth_set_wol(struct net_device *netdev,
+			  struct ethtool_wolinfo *wol)
+{
+	struct al_eth_adapter *adapter = netdev_priv(netdev);
+	struct phy_device *phydev;
+
+	if (wol->wolopts & (WAKE_ARP | WAKE_MAGICSECURE))
+		return -EOPNOTSUPP;
+
+	adapter->wol = wol->wolopts;
+
+	if ((adapter) && (adapter->phy_exist) && (adapter->mdio_bus)) {
+		phydev = mdiobus_get_phy(adapter->mdio_bus, adapter->phy_addr);
+		if (phydev)
+			return phy_ethtool_set_wol(phydev, wol);
+	}
+
+	device_set_wakeup_enable(&adapter->pdev->dev, adapter->wol);
+
+	return 0;
+}
+
 static const struct ethtool_ops al_eth_ethtool_ops = {
 	.get_settings		= al_eth_get_settings,
 	.set_settings		= al_eth_set_settings,
 	.get_drvinfo		= al_eth_get_drvinfo,
+	.get_wol		= al_eth_get_wol,
+	.set_wol		= al_eth_set_wol,
 	.get_msglevel		= al_eth_get_msglevel,
 	.set_msglevel		= al_eth_set_msglevel,
 
-- 
2.11.0
