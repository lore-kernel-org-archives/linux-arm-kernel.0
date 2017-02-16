From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Thu, 16 Feb 2017 13:48:39 +0100
Subject: [PATCH 01/21] net-next: stmmac add optional init_phy function
In-Reply-To: <20170216124859.14346-1-clabbe.montjoie@gmail.com>
References: <20170216124859.14346-1-clabbe.montjoie@gmail.com>
Message-ID: <20170216124859.14346-2-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For dwmac-sun8i, some actions must be done for enabling attached PHY.
Thoses actions must be done after stmmac_probe_config_dt() and
at start of stmmac_init_phy().

The best way to handle that is to add an optional init_phy() function.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h      |  3 +++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 144fe84..daaafa9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -483,6 +483,9 @@ struct stmmac_ops {
 			     bool loopback);
 	void (*pcs_rane)(void __iomem *ioaddr, bool restart);
 	void (*pcs_get_adv_lp)(void __iomem *ioaddr, struct rgmii_adv *adv);
+	/* optional function for powering/init PHY */
+	int (*init_phy)(struct net_device *ndev);
+	void (*uninit_phy)(struct net_device *ndev);
 };
 
 /* PTP and HW Timer helpers */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3cbe096..942efb7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -820,10 +820,18 @@ static int stmmac_init_phy(struct net_device *dev)
 	char bus_id[MII_BUS_ID_SIZE];
 	int interface = priv->plat->interface;
 	int max_speed = priv->plat->max_speed;
+	int ret;
+
 	priv->oldlink = 0;
 	priv->speed = SPEED_UNKNOWN;
 	priv->oldduplex = DUPLEX_UNKNOWN;
 
+	if (priv->hw->mac->init_phy) {
+		ret = priv->hw->mac->init_phy(dev);
+		if (ret)
+			return ret;
+	}
+
 	if (priv->plat->phy_node) {
 		phydev = of_phy_connect(dev, priv->plat->phy_node,
 					&stmmac_adjust_link, 0, interface);
@@ -1892,6 +1900,9 @@ static int stmmac_release(struct net_device *dev)
 		phy_disconnect(dev->phydev);
 	}
 
+	if (priv->hw->mac->uninit_phy)
+		priv->hw->mac->uninit_phy(dev);
+
 	netif_stop_queue(dev);
 
 	napi_disable(&priv->napi);
-- 
2.10.2
