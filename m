From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:41:45 +0100
Subject: [PATCH 121/222] net:fec: only enable CTAG_RX and IP checksumming if
 we have enhanced buffer descriptors
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeVl-0007LJ-GE@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only set the vlan tag and ip checksumming options if we have enhanced
buffer descriptors - enhanced descriptors are required for these
features.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 81ade95c06e0..7cb852991bf1 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2259,19 +2259,21 @@ static void fec_enet_init(struct net_device *ndev)
 	writel(FEC_RX_DISABLED_IMASK, fep->hwp + FEC_IMASK);
 	netif_napi_add(ndev, &fep->napi, fec_enet_rx_napi, NAPI_POLL_WEIGHT);
 
-	if (id_entry->driver_data & FEC_QUIRK_HAS_VLAN) {
-		/* enable hw VLAN support */
-		ndev->features |= NETIF_F_HW_VLAN_CTAG_RX;
-		ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
-	}
-
-	if (id_entry->driver_data & FEC_QUIRK_HAS_CSUM) {
-		/* enable hw accelerator */
-		ndev->features |= (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM
-				| NETIF_F_RXCSUM);
-		ndev->hw_features |= (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM
-				| NETIF_F_RXCSUM);
-		fep->flags |= FEC_FLAG_RX_CSUM;
+	if (fep->flags & FEC_FLAG_BUFDESC_EX) {
+		if (id_entry->driver_data & FEC_QUIRK_HAS_VLAN) {
+			/* enable hw VLAN support */
+			ndev->features |= NETIF_F_HW_VLAN_CTAG_RX;
+			ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
+		}
+
+		if (id_entry->driver_data & FEC_QUIRK_HAS_CSUM) {
+			/* enable hw accelerator */
+			ndev->features |= (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM
+					| NETIF_F_RXCSUM);
+			ndev->hw_features |= (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM
+					| NETIF_F_RXCSUM);
+			fep->flags |= FEC_FLAG_RX_CSUM;
+		}
 	}
 
 	if (!(id_entry->driver_data & FEC_QUIRK_SWAP_FRAME)) {
-- 
1.8.3.1
