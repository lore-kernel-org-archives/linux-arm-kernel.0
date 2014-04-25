From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:41:40 +0100
Subject: [PATCH 120/222] net:fec: move receive checksum flags into new flags
 member
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeVg-0007LF-CX@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The receive checksum flag is mostly static, so move it into the flags
member.  In any case, this is checked alongside the BUFDESC_EX flag.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec.h      |  2 --
 drivers/net/ethernet/freescale/fec_main.c | 11 ++++++-----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index a5d38e4c770c..aaf5aaaf9e56 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -258,7 +258,6 @@ union bufdesc_u {
 #define BD_ENET_RX_PTP          ((ushort)0x0400)
 #define BD_ENET_RX_ICE		0x00000020
 #define BD_ENET_RX_PCR		0x00000010
-#define FLAG_RX_CSUM_ENABLED	(BD_ENET_RX_ICE | BD_ENET_RX_PCR)
 #define FLAG_RX_CSUM_ERROR	(BD_ENET_RX_ICE | BD_ENET_RX_PCR)
 
 /* The FEC buffer descriptors track the ring buffers.  The rx_bd_base and
@@ -324,7 +323,6 @@ struct fec_enet_private {
 	unsigned short pause_mode;
 
 	struct	napi_struct napi;
-	int	csum_flags;
 
 	struct work_struct tx_timeout_work;
 
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c35a1e00129c..81ade95c06e0 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -232,6 +232,7 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
 
 /* flags */
 #define FEC_FLAG_BUFDESC_EX	BIT(0)
+#define FEC_FLAG_RX_CSUM	BIT(1)
 
 static int mii_cnt;
 
@@ -634,7 +635,7 @@ fec_restart(struct net_device *ndev)
 #if !defined(CONFIG_M5272)
 	/* set RX checksum */
 	val = readl(fep->hwp + FEC_RACC);
-	if (fep->csum_flags & FLAG_RX_CSUM_ENABLED)
+	if (fep->flags & FEC_FLAG_RX_CSUM)
 		val |= FEC_RACC_OPTIONS;
 	else
 		val &= ~FEC_RACC_OPTIONS;
@@ -1042,7 +1043,7 @@ fec_enet_rx(struct net_device *ndev, int budget)
 						  skb_hwtstamps(skb));
 
 			if (fep->flags & FEC_FLAG_BUFDESC_EX &&
-			    (fep->csum_flags & FLAG_RX_CSUM_ENABLED)) {
+			    fep->flags & FEC_FLAG_RX_CSUM) {
 				if (!(bdp->ebd.cbd_esc & FLAG_RX_CSUM_ERROR)) {
 					/* don't check it */
 					skb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -2190,9 +2191,9 @@ static int fec_set_features(struct net_device *netdev,
 	/* Receive checksum has been changed */
 	if (changed & NETIF_F_RXCSUM) {
 		if (features & NETIF_F_RXCSUM)
-			fep->csum_flags |= FLAG_RX_CSUM_ENABLED;
+			fep->flags |= FEC_FLAG_RX_CSUM;
 		else
-			fep->csum_flags &= ~FLAG_RX_CSUM_ENABLED;
+			fep->flags &= ~FEC_FLAG_RX_CSUM;
 	}
 
 	/* Set the appropriate minimum transmit ring free threshold */
@@ -2270,7 +2271,7 @@ static void fec_enet_init(struct net_device *ndev)
 				| NETIF_F_RXCSUM);
 		ndev->hw_features |= (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM
 				| NETIF_F_RXCSUM);
-		fep->csum_flags |= FLAG_RX_CSUM_ENABLED;
+		fep->flags |= FEC_FLAG_RX_CSUM;
 	}
 
 	if (!(id_entry->driver_data & FEC_QUIRK_SWAP_FRAME)) {
-- 
1.8.3.1
