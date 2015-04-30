From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 30 Apr 2015 17:07:50 +0200
Subject: [PATCH] net: fec: Fix RGMII-ID mode
Message-ID: <1430406470-26907-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RGMII-ID uses an internal delay within the transmitter or receiver. This
feature is phy specific. The rest of the communication is normal RGMII.

So the fec driver has to check for all RGMII modes, not only
'PHY_INTERFACE_MODE_RGMII'.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index f6a3a7abd468..66d47e448e4d 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -988,7 +988,10 @@ fec_restart(struct net_device *ndev)
 		rcntl |= 0x40000000 | 0x00000020;
 
 		/* RGMII, RMII or MII */
-		if (fep->phy_interface == PHY_INTERFACE_MODE_RGMII)
+		if (fep->phy_interface == PHY_INTERFACE_MODE_RGMII ||
+		    fep->phy_interface == PHY_INTERFACE_MODE_RGMII_ID ||
+		    fep->phy_interface == PHY_INTERFACE_MODE_RGMII_RXID ||
+		    fep->phy_interface == PHY_INTERFACE_MODE_RGMII_TXID)
 			rcntl |= (1 << 6);
 		else if (fep->phy_interface == PHY_INTERFACE_MODE_RMII)
 			rcntl |= (1 << 8);
-- 
2.1.4
