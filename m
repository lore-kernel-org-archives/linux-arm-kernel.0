From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 30 Jun 2018 18:18:03 +0200
Subject: [PATCH net-next 2/5] net: gemini: Improve connection prints
In-Reply-To: <20180630161806.24312-1-linus.walleij@linaro.org>
References: <20180630161806.24312-1-linus.walleij@linaro.org>
Message-ID: <20180630161806.24312-2-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of just specify that a PHY is connected at some
speed, also specify which one. This is helpful with several
PHYs on the system.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 8fc31723f700..b49ed8964026 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -300,23 +300,26 @@ static void gmac_speed_set(struct net_device *netdev)
 		status.bits.speed = GMAC_SPEED_1000;
 		if (phydev->interface == PHY_INTERFACE_MODE_RGMII)
 			status.bits.mii_rmii = GMAC_PHY_RGMII_1000;
-		netdev_info(netdev, "connect to RGMII @ 1Gbit\n");
+		netdev_info(netdev, "connect %s to RGMII @ 1Gbit\n",
+			    phydev_name(phydev));
 		break;
 	case 100:
 		status.bits.speed = GMAC_SPEED_100;
 		if (phydev->interface == PHY_INTERFACE_MODE_RGMII)
 			status.bits.mii_rmii = GMAC_PHY_RGMII_100_10;
-		netdev_info(netdev, "connect to RGMII @ 100 Mbit\n");
+		netdev_info(netdev, "connect %s to RGMII @ 100 Mbit\n",
+			    phydev_name(phydev));
 		break;
 	case 10:
 		status.bits.speed = GMAC_SPEED_10;
 		if (phydev->interface == PHY_INTERFACE_MODE_RGMII)
 			status.bits.mii_rmii = GMAC_PHY_RGMII_100_10;
-		netdev_info(netdev, "connect to RGMII @ 10 Mbit\n");
+		netdev_info(netdev, "connect %s to RGMII @ 10 Mbit\n",
+			    phydev_name(phydev));
 		break;
 	default:
-		netdev_warn(netdev, "Not supported PHY speed (%d)\n",
-			    phydev->speed);
+		netdev_warn(netdev, "Unsupported PHY speed (%d) on %s\n",
+			    phydev->speed, phydev_name(phydev));
 	}
 
 	if (phydev->duplex == DUPLEX_FULL) {
-- 
2.17.1
