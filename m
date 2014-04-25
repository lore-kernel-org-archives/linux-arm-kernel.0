From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:41:55 +0100
Subject: [PATCH 123/222] net:fec: move vlan receive flag into our private flags
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeVv-0007LR-NM@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 7f05866acee3..11176d483db4 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -233,6 +233,7 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
 /* flags */
 #define FEC_FLAG_BUFDESC_EX	BIT(0)
 #define FEC_FLAG_RX_CSUM	BIT(1)
+#define FEC_FLAG_RX_VLAN	BIT(2)
 
 static int mii_cnt;
 
@@ -1002,8 +1003,8 @@ fec_enet_rx(struct net_device *ndev, int budget)
 
 		/* If this is a VLAN packet remove the VLAN Tag */
 		vlan_packet_rcvd = false;
-		if ((ndev->features & NETIF_F_HW_VLAN_CTAG_RX) &&
-		    fep->flags & FEC_FLAG_BUFDESC_EX && (bdp->ebd.cbd_esc & BD_ENET_RX_VLAN)) {
+		if (fep->flags & FEC_FLAG_RX_VLAN &&
+		    bdp->ebd.cbd_esc & BD_ENET_RX_VLAN) {
 			/* Push and remove the vlan tag */
 			struct vlan_hdr *vlan_header =
 					(struct vlan_hdr *) (data + ETH_HLEN);
@@ -2195,6 +2196,13 @@ static int fec_set_features(struct net_device *netdev,
 			fep->flags &= ~FEC_FLAG_RX_CSUM;
 	}
 
+	if (changed & NETIF_F_HW_VLAN_CTAG_RX) {
+		if (features & NETIF_F_HW_VLAN_CTAG_RX)
+			fep->flags |= FEC_FLAG_RX_VLAN;
+		else
+			fep->flags &= ~FEC_FLAG_RX_VLAN;
+	}
+
 	/* Set the appropriate minimum transmit ring free threshold */
 	if (features & NETIF_F_SG)
 		fep->tx_min = MAX_SKB_FRAGS + 1;
@@ -2263,6 +2271,7 @@ static void fec_enet_init(struct net_device *ndev)
 			/* enable hw VLAN support */
 			ndev->features |= NETIF_F_HW_VLAN_CTAG_RX;
 			ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
+			fep->flags |= FEC_FLAG_RX_VLAN;
 		}
 
 		if (id_entry->driver_data & FEC_QUIRK_HAS_CSUM) {
-- 
1.8.3.1
