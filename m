From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:37:50 +0100
Subject: [PATCH 081/222] net:fec: fix missing kmalloc() failure check in
 fec_enet_alloc_buffers()
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeRy-0007Ib-Vr@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fec_enet_alloc_buffers() appears to assume that kmalloc() will never
fail.  This is an unreasonable assumption.  Add a proper check and
failure cleanup path.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 08a5004970c9..7f7d9dcb485e 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1744,19 +1744,16 @@ static int fec_enet_alloc_buffers(struct net_device *ndev)
 		dma_addr_t addr;
 
 		skb = netdev_alloc_skb(ndev, FEC_ENET_RX_FRSIZE);
-		if (!skb) {
-			fec_enet_free_buffers(ndev);
-			return -ENOMEM;
-		}
+		if (!skb)
+			goto err_alloc;
 
 		addr = dma_map_single(&fep->pdev->dev, skb->data,
 				FEC_ENET_RX_FRSIZE, DMA_FROM_DEVICE);
 		if (dma_mapping_error(&fep->pdev->dev, addr)) {
 			dev_kfree_skb(skb);
-			fec_enet_free_buffers(ndev);
 			if (net_ratelimit())
 				netdev_err(ndev, "Rx DMA memory map failed\n");
-			return -ENOMEM;
+			goto err_alloc;
 		}
 
 		fep->rx_skbuff[i] = skb;
@@ -1778,6 +1775,8 @@ static int fec_enet_alloc_buffers(struct net_device *ndev)
 	bdp = fep->tx_bd_base;
 	for (i = 0; i < fep->tx_ring_size; i++) {
 		fep->tx_bounce[i] = kmalloc(FEC_ENET_TX_FRSIZE, GFP_KERNEL);
+		if (!fep->tx_bounce[i])
+			goto err_alloc;
 
 		bdp->cbd_sc = 0;
 		bdp->cbd_bufaddr = 0;
@@ -1795,6 +1794,10 @@ static int fec_enet_alloc_buffers(struct net_device *ndev)
 	bdp->cbd_sc |= BD_SC_WRAP;
 
 	return 0;
+
+ err_alloc:
+	fec_enet_free_buffers(ndev);
+	return -ENOMEM;
 }
 
 static int
-- 
1.8.3.1
