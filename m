From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:37:30 +0100
Subject: [PATCH 077/222] net:fec: iMX6 FEC does not support half-duplex gigabit
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeRe-0007IL-Hz@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The iMX6 gigabit FEC does not support half-duplex gigabit operation.
Phys attacked to the FEC may support this, and we currently do nothing
to disable this feature.  This may result in an invalid configuration.
Mask out phy support for gigabit half-duplex operation.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 1c84f3a6f3a7..d9109acc934d 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1316,6 +1316,7 @@ static int fec_enet_mii_probe(struct net_device *ndev)
 	/* mask with MAC supported features */
 	if (id_entry->driver_data & FEC_QUIRK_HAS_GBIT) {
 		phy_dev->supported &= PHY_GBIT_FEATURES;
+		phy_dev->supported &= ~SUPPORTED_1000baseT_Half;
 #if !defined(CONFIG_M5272)
 		phy_dev->supported |= SUPPORTED_Pause;
 #endif
-- 
1.8.3.1
