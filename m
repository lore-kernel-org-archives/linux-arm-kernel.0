From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Wed, 11 Jan 2012 17:29:36 +0100
Subject: [PATCH] net: fsl: fec: handle 10Mbps speed in RMII mode
Message-ID: <1326299376-22853-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

when the link is 10 Mbps and the mode is RMII, it's necessary
to set FRCONT to 1 in MIIGSK_CFGR to divide the RMII source
clock by 10 in order to support 10 Mbps operations.

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 drivers/net/ethernet/freescale/fec.c |   10 ++++++++--
 drivers/net/ethernet/freescale/fec.h |    4 ++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.c b/drivers/net/ethernet/freescale/fec.c
index ddcbbb3..89532ab 100644
--- a/drivers/net/ethernet/freescale/fec.c
+++ b/drivers/net/ethernet/freescale/fec.c
@@ -476,6 +476,7 @@ fec_restart(struct net_device *ndev, int duplex)
 	} else {
 #ifdef FEC_MIIGSK_ENR
 		if (id_entry->driver_data & FEC_QUIRK_USE_GASKET) {
+			u32 miigsk;
 			/* disable the gasket and wait */
 			writel(0, fep->hwp + FEC_MIIGSK_ENR);
 			while (readl(fep->hwp + FEC_MIIGSK_ENR) & 4)
@@ -486,8 +487,13 @@ fec_restart(struct net_device *ndev, int duplex)
 			 *   RMII, 50 MHz, no loopback, no echo
 			 *   MII, 25 MHz, no loopback, no echo
 			 */
-			writel((fep->phy_interface == PHY_INTERFACE_MODE_RMII) ?
-					1 : 0, fep->hwp + FEC_MIIGSK_CFGR);
+			miigsk = (fep->phy_interface == PHY_INTERFACE_MODE_RMII)
+				? FEC_MIIGSK_RMII_MODE : FEC_MIIGSK_MII_MODE;
+			if (fep->phy_dev) {
+				if (fep->phy_dev->speed == SPEED_10)
+					miigsk |= FEC_MIIGSK_FRCONT_10M;
+			}
+			writel(miigsk, fep->hwp + FEC_MIIGSK_CFGR);
 
 
 			/* re-enable the gasket */
diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 8b2c6d7..6870d9e 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -47,6 +47,10 @@
 #define FEC_MIIGSK_CFGR		0x300 /* MIIGSK Configuration reg */
 #define FEC_MIIGSK_ENR		0x308 /* MIIGSK Enable reg */
 
+#define FEC_MIIGSK_MII_MODE		0x00
+#define FEC_MIIGSK_RMII_MODE	0x01
+#define FEC_MIIGSK_FRCONT_10M	0x40
+
 #else
 
 #define FEC_ECNTRL		0x000 /* Ethernet control reg */
-- 
1.7.7.5
