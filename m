From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Thu, 12 Jan 2012 17:10:28 +0100
Subject: [PATCH v2] net: fsl: fec: handle 10Mbps speed in RMII mode
Message-ID: <1326384628-7967-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

when the link is 10 Mbps and the mode is RMII, it's necessary
to set FRCONT to 1 in MIIGSK_CFGR to divide the RMII source
clock by 10 in order to support 10 Mbps operations.

Signed-off-by: Eric B?nard <eric@eukrea.com>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
---
v2: rework following Shawn's comments

 drivers/net/ethernet/freescale/fec.c |    9 ++++++---
 drivers/net/ethernet/freescale/fec.h |    4 ++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.c b/drivers/net/ethernet/freescale/fec.c
index ddcbbb3..9a96aea 100644
--- a/drivers/net/ethernet/freescale/fec.c
+++ b/drivers/net/ethernet/freescale/fec.c
@@ -476,6 +476,7 @@ fec_restart(struct net_device *ndev, int duplex)
 	} else {
 #ifdef FEC_MIIGSK_ENR
 		if (id_entry->driver_data & FEC_QUIRK_USE_GASKET) {
+			u32 cfgr;
 			/* disable the gasket and wait */
 			writel(0, fep->hwp + FEC_MIIGSK_ENR);
 			while (readl(fep->hwp + FEC_MIIGSK_ENR) & 4)
@@ -486,9 +487,11 @@ fec_restart(struct net_device *ndev, int duplex)
 			 *   RMII, 50 MHz, no loopback, no echo
 			 *   MII, 25 MHz, no loopback, no echo
 			 */
-			writel((fep->phy_interface == PHY_INTERFACE_MODE_RMII) ?
-					1 : 0, fep->hwp + FEC_MIIGSK_CFGR);
-
+			cfgr = (fep->phy_interface == PHY_INTERFACE_MODE_RMII)
+				? BM_MIIGSK_CFGR_RMII : BM_MIIGSK_CFGR_MII;
+			if (fep->phy_dev && fep->phy_dev->speed == SPEED_10)
+				cfgr |= BM_MIIGSK_CFGR_FRCONT_10M;
+			writel(cfgr, fep->hwp + FEC_MIIGSK_CFGR);
 
 			/* re-enable the gasket */
 			writel(2, fep->hwp + FEC_MIIGSK_ENR);
diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 8b2c6d7..8408c62 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -47,6 +47,10 @@
 #define FEC_MIIGSK_CFGR		0x300 /* MIIGSK Configuration reg */
 #define FEC_MIIGSK_ENR		0x308 /* MIIGSK Enable reg */
 
+#define BM_MIIGSK_CFGR_MII		0x00
+#define BM_MIIGSK_CFGR_RMII		0x01
+#define BM_MIIGSK_CFGR_FRCONT_10M	0x40
+
 #else
 
 #define FEC_ECNTRL		0x000 /* Ethernet control reg */
-- 
1.7.7.5
