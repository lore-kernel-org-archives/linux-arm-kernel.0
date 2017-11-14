From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Tue, 14 Nov 2017 11:55:40 +0100
Subject: [PATCH v3 2/4] net: nb8800: Simplify nb8800_pause_config()
In-Reply-To: <230165aa-eaf1-6e2b-7ff3-45b3ee4ffc62@sigmadesigns.com>
References: <230165aa-eaf1-6e2b-7ff3-45b3ee4ffc62@sigmadesigns.com>
Message-ID: <dd0c2014-8ef9-749c-16d3-6a56f4161658@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "flow control enable" bit can be tweaked, even if DMA is enabled.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 drivers/net/ethernet/aurora/nb8800.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/aurora/nb8800.c b/drivers/net/ethernet/aurora/nb8800.c
index 26f719e2d6ca..09b8001e1ecc 100644
--- a/drivers/net/ethernet/aurora/nb8800.c
+++ b/drivers/net/ethernet/aurora/nb8800.c
@@ -633,7 +633,6 @@ static void nb8800_pause_config(struct net_device *dev)
 {
 	struct nb8800_priv *priv = netdev_priv(dev);
 	struct phy_device *phydev = dev->phydev;
-	u32 rxcr;
 
 	if (priv->pause_aneg) {
 		if (!phydev || !phydev->link)
@@ -644,22 +643,7 @@ static void nb8800_pause_config(struct net_device *dev)
 	}
 
 	nb8800_modb(priv, NB8800_RX_CTL, RX_PAUSE_EN, priv->pause_rx);
-
-	rxcr = nb8800_readl(priv, NB8800_RXC_CR);
-	if (!!(rxcr & RCR_FL) == priv->pause_tx)
-		return;
-
-	if (netif_running(dev)) {
-		napi_disable(&priv->napi);
-		netif_tx_lock_bh(dev);
-		nb8800_dma_stop(dev);
-		nb8800_modl(priv, NB8800_RXC_CR, RCR_FL, priv->pause_tx);
-		nb8800_start_rx(dev);
-		netif_tx_unlock_bh(dev);
-		napi_enable(&priv->napi);
-	} else {
-		nb8800_modl(priv, NB8800_RXC_CR, RCR_FL, priv->pause_tx);
-	}
+	nb8800_modl(priv, NB8800_RXC_CR, RCR_FL, priv->pause_tx);
 }
 
 static void nb8800_link_reconfigure(struct net_device *dev)
-- 
2.15.0
