From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 21 May 2013 18:41:42 +0200
Subject: [PATCH v4 04/12] net: mv643xx_eth: use of_phy_connect if phy_node
 present
In-Reply-To: <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1367854420-8006-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1369154510-4927-5-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This connects to a phy node passed to the port device instead of probing
the phy by phy_addr.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: David Miller <davem@davemloft.net>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: netdev at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linuxppc-dev at lists.ozlabs.org
Cc: linux-kernel at vger.kernel.org       
---
 drivers/net/ethernet/marvell/mv643xx_eth.c |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index e658ebd..0f5c3c2 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -60,6 +60,7 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
+#include <linux/of_mdio.h>
 
 static char mv643xx_eth_driver_name[] = "mv643xx_eth";
 static char mv643xx_eth_driver_version[] = "1.4";
@@ -2715,17 +2716,27 @@ static int mv643xx_eth_probe(struct platform_device *pdev)
 	netif_set_real_num_tx_queues(dev, mp->txq_count);
 	netif_set_real_num_rx_queues(dev, mp->rxq_count);
 
-	if (pd->phy_addr != MV643XX_ETH_PHY_NONE) {
+	err = 0;
+	if (pd->phy_node) {
+		mp->phy = of_phy_connect(mp->dev, pd->phy_node,
+					 mv643xx_eth_adjust_link, 0,
+					 PHY_INTERFACE_MODE_GMII);
+		if (!mp->phy)
+			err = -ENODEV;
+	} else if (pd->phy_addr != MV643XX_ETH_PHY_NONE) {
 		mp->phy = phy_scan(mp, pd->phy_addr);
 
-		if (IS_ERR(mp->phy)) {
+		if (IS_ERR(mp->phy))
 			err = PTR_ERR(mp->phy);
-			if (err == -ENODEV)
-				err = -EPROBE_DEFER;
-			goto out;
-		}
-		phy_init(mp, pd->speed, pd->duplex);
+		else
+			phy_init(mp, pd->speed, pd->duplex);
 	}
+	if (err == -ENODEV) {
+		err = -EPROBE_DEFER;
+		goto out;
+	}
+	if (err)
+		goto out;
 
 	SET_ETHTOOL_OPS(dev, &mv643xx_eth_ethtool_ops);
 
-- 
1.7.10.4
