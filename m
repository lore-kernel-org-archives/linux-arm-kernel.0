From: maxime.chevallier@bootlin.com (Maxime Chevallier)
Date: Fri,  9 Nov 2018 09:17:33 +0100
Subject: [PATCH net] net: mvneta: Don't advertise 2.5G modes
Message-ID: <20181109081733.24458-1-maxime.chevallier@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using 2.5G speed relies on the SerDes lanes being configured
accordingly. The lanes have to be reconfigured to switch between
1G and 2.5G, and for now only the bootloader does this configuration.

In the case we add a Comphy driver to handle switching the lanes
dynamically, it's better for now to stick with supporting only 1G and
add advertisement for 2.5G once we really are capable of handling both
speeds without problem.

Since the interface mode is initialy taken from the DT, we want to make
sure that adding comphy support won't break boards that don't update
their dtb.

Fixes: da58a931f248 ("net: mvneta: Add support for 2500Mbps SGMII")
Reported-by: Andrew Lunn <andrew@lunn.ch>
Reported-by: Russell King <linux@armlinux.org.uk>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 5bfd349bf41a..c19ecd153499 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -3343,7 +3343,6 @@ static void mvneta_validate(struct net_device *ndev, unsigned long *supported,
 	if (state->interface != PHY_INTERFACE_MODE_NA &&
 	    state->interface != PHY_INTERFACE_MODE_QSGMII &&
 	    state->interface != PHY_INTERFACE_MODE_SGMII &&
-	    state->interface != PHY_INTERFACE_MODE_2500BASEX &&
 	    !phy_interface_mode_is_8023z(state->interface) &&
 	    !phy_interface_mode_is_rgmii(state->interface)) {
 		bitmap_zero(supported, __ETHTOOL_LINK_MODE_MASK_NBITS);
@@ -3357,14 +3356,9 @@ static void mvneta_validate(struct net_device *ndev, unsigned long *supported,
 	/* Asymmetric pause is unsupported */
 	phylink_set(mask, Pause);
 
-	/* We cannot use 1Gbps when using the 2.5G interface. */
-	if (state->interface == PHY_INTERFACE_MODE_2500BASEX) {
-		phylink_set(mask, 2500baseT_Full);
-		phylink_set(mask, 2500baseX_Full);
-	} else {
-		phylink_set(mask, 1000baseT_Full);
-		phylink_set(mask, 1000baseX_Full);
-	}
+	/* Half-duplex at speeds higher than 100Mbit is unsupported */
+	phylink_set(mask, 1000baseT_Full);
+	phylink_set(mask, 1000baseX_Full);
 
 	if (!phy_interface_mode_is_8023z(state->interface)) {
 		/* 10M and 100M are only supported in non-802.3z mode */
-- 
2.11.0
