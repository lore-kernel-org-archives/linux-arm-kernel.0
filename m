From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:42:05 +0100
Subject: [PATCH 125/222] net:fec: even larger rings
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeW5-0007LZ-UM@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec.h      |  4 +--
 drivers/net/ethernet/freescale/fec_main.c | 45 ++++++++++++++++---------------
 2 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index aaf5aaaf9e56..bfcab01131cc 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -246,13 +246,13 @@ union bufdesc_u {
  * the skbuffer directly.
  */
 
-#define FEC_ENET_RX_PAGES	32
+#define FEC_ENET_RX_PAGES	64
 #define FEC_ENET_RX_FRSIZE	2048
 #define FEC_ENET_RX_FRPPG	(PAGE_SIZE / FEC_ENET_RX_FRSIZE)
 #define RX_RING_SIZE		(FEC_ENET_RX_FRPPG * FEC_ENET_RX_PAGES)
 #define FEC_ENET_TX_FRSIZE	2048
 #define FEC_ENET_TX_FRPPG	(PAGE_SIZE / FEC_ENET_TX_FRSIZE)
-#define TX_RING_SIZE		64	/* Must be power of two */
+#define TX_RING_SIZE		128	/* Must be power of two */
 
 #define BD_ENET_RX_INT          0x00800000
 #define BD_ENET_RX_PTP          ((ushort)0x0400)
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 12d48b997744..441e472f7779 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -166,8 +166,11 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
 #endif
 #endif /* CONFIG_M5272 */
 
-#if (((RX_RING_SIZE + TX_RING_SIZE) * 32) > PAGE_SIZE)
-#error "FEC: descriptor ring size constants too large"
+#if RX_RING_SIZE * 32 > PAGE_SIZE
+#error "FEC: receive descriptor ring size too large"
+#endif
+#if TX_RING_SIZE * 32 > PAGE_SIZE
+#error "FEC: transmit descriptor ring size too large"
 #endif
 
 /* Minimum TX ring size when using NETIF_F_SG */
@@ -828,7 +831,7 @@ fec_enet_hwtstamp(struct fec_enet_private *fep, unsigned ts,
 	hwtstamps->hwtstamp = ns_to_ktime(ns);
 }
 
-static void
+static void noinline
 fec_enet_tx(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
@@ -1953,30 +1956,30 @@ static int fec_enet_alloc_buffers(struct net_device *ndev)
 	unsigned int i;
 	struct sk_buff *skb;
 	union bufdesc_u *bdp;
-	union bufdesc_u *cbd_base;
-	dma_addr_t cbd_dma;
+	union bufdesc_u *rx_cbd_cpu, *tx_cbd_cpu;
+	dma_addr_t rx_cbd_dma, tx_cbd_dma;
 
 	/* Allocate memory for buffer descriptors. */
-	cbd_base = dma_alloc_coherent(NULL, PAGE_SIZE, &cbd_dma, GFP_KERNEL);
-	if (!cbd_base)
+	rx_cbd_cpu = dma_alloc_coherent(NULL, PAGE_SIZE, &rx_cbd_dma,
+					GFP_KERNEL);
+	tx_cbd_cpu = dma_alloc_coherent(NULL, PAGE_SIZE, &tx_cbd_dma,
+					GFP_KERNEL);
+	if (!rx_cbd_cpu || !tx_cbd_cpu) {
+		if (rx_cbd_cpu)
+			dma_free_coherent(NULL, PAGE_SIZE, rx_cbd_cpu, rx_cbd_dma);
+		if (tx_cbd_cpu)
+			dma_free_coherent(NULL, PAGE_SIZE, tx_cbd_cpu, tx_cbd_dma);
 		return -ENOMEM;
+	}
 
-	memset(cbd_base, 0, PAGE_SIZE);
+	memset(rx_cbd_cpu, 0, PAGE_SIZE);
+	memset(tx_cbd_cpu, 0, PAGE_SIZE);
 
 	/* Set receive and transmit descriptor base. */
-	fep->rx_bd_base = cbd_base;
-	fep->rx_bd_dma = cbd_dma;
-	if (fep->flags & FEC_FLAG_BUFDESC_EX) {
-		fep->tx_bd_base = (union bufdesc_u *)
-			(&cbd_base->ebd + fep->rx_ring_size);
-		fep->tx_bd_dma = cbd_dma + sizeof(struct bufdesc_ex) *
-			fep->rx_ring_size;
-	} else {
-		fep->tx_bd_base = (union bufdesc_u *)
-			(&cbd_base->bd + fep->rx_ring_size);
-		fep->tx_bd_dma = cbd_dma + sizeof(struct bufdesc) *
-			fep->rx_ring_size;
-	}
+	fep->rx_bd_base = rx_cbd_cpu;
+	fep->rx_bd_dma = rx_cbd_dma;
+	fep->tx_bd_base = tx_cbd_cpu;
+	fep->tx_bd_dma = tx_cbd_dma;
 
 	for (i = 0; i < fep->rx_ring_size; i++) {
 		dma_addr_t addr;
-- 
1.8.3.1
