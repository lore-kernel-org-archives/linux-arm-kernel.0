From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:41:19 +0100
Subject: [PATCH 116/222] net:fec: remove unnecessary code
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeVL-0007Ky-VA@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fec_enet_bd_init() already frees the transmit skbuffs, so there's no
need for fec_restart() to do this again.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec.h      | 1 -
 drivers/net/ethernet/freescale/fec_main.c | 8 --------
 2 files changed, 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 29f607a2d9b0..70ef32c965e5 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -252,7 +252,6 @@ union bufdesc_u {
 #define FEC_ENET_TX_FRSIZE	2048
 #define FEC_ENET_TX_FRPPG	(PAGE_SIZE / FEC_ENET_TX_FRSIZE)
 #define TX_RING_SIZE		64	/* Must be power of two */
-#define TX_RING_MOD_MASK	63	/*   for this to work */
 
 #define BD_ENET_RX_INT          0x00800000
 #define BD_ENET_RX_PTP          ((ushort)0x0400)
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 9471abb189bc..40ab7b7ccacf 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -581,7 +581,6 @@ fec_restart(struct net_device *ndev)
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	const struct platform_device_id *id_entry =
 				platform_get_device_id(fep->pdev);
-	int i;
 	u32 val;
 	u32 temp_mac[2];
 	u32 rcntl = OPT_FRAME_SIZE | 0x04;
@@ -615,13 +614,6 @@ fec_restart(struct net_device *ndev)
 	writel(fep->rx_bd_dma, fep->hwp + FEC_R_DES_START);
 	writel(fep->tx_bd_dma, fep->hwp + FEC_X_DES_START);
 
-	for (i = 0; i <= TX_RING_MOD_MASK; i++) {
-		if (fep->tx_skbuff[i]) {
-			dev_kfree_skb_any(fep->tx_skbuff[i]);
-			fep->tx_skbuff[i] = NULL;
-		}
-	}
-
 	/* Enable MII mode */
 	if (fep->full_duplex == DUPLEX_FULL) {
 		/* FD enable */
-- 
1.8.3.1
