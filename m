From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Tue,  5 Apr 2016 19:26:02 -0700
Subject: [PATCH net-next V3 16/16] net: fec: don't set cbd_bufaddr unless no
 mapping error
In-Reply-To: <1459909562-22865-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1459909562-22865-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1459909562-22865-17-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not assigning cbd_bufaddr on error will prevent trying to
unmap the error in case the FEC is reset.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

---
v3: no change
---
 drivers/net/ethernet/freescale/fec_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 101d820..c2ed8be 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -600,7 +600,7 @@ fec_enet_txq_put_hdr_tso(struct fec_enet_priv_tx_q *txq,
 	int hdr_len = skb_transport_offset(skb) + tcp_hdrlen(skb);
 	struct bufdesc_ex *ebdp = container_of(bdp, struct bufdesc_ex, desc);
 	void *bufaddr;
-	unsigned long dmabuf;
+	dma_addr_t dmabuf;
 	unsigned int estatus = 0;
 
 	bufaddr = txq->tso_hdrs + index * TSO_HEADER_SIZE;
@@ -1295,17 +1295,21 @@ fec_enet_new_rxbdp(struct net_device *ndev, struct bufdesc *bdp, struct sk_buff
 {
 	struct  fec_enet_private *fep = netdev_priv(ndev);
 	int off;
+	dma_addr_t dmabuf;
 
 	off = ((unsigned long)skb->data) & fep->rx_align;
 	if (off)
 		skb_reserve(skb, fep->rx_align + 1 - off);
 
-	bdp->cbd_bufaddr = cpu_to_fec32(dma_map_single(&fep->pdev->dev, skb->data, FEC_ENET_RX_FRSIZE - fep->rx_align, DMA_FROM_DEVICE));
-	if (dma_mapping_error(&fep->pdev->dev, fec32_to_cpu(bdp->cbd_bufaddr))) {
+	dmabuf = dma_map_single(&fep->pdev->dev, skb->data,
+				FEC_ENET_RX_FRSIZE - fep->rx_align,
+				DMA_FROM_DEVICE);
+	if (dma_mapping_error(&fep->pdev->dev, dmabuf)) {
 		if (net_ratelimit())
 			netdev_err(ndev, "Rx DMA memory map failed\n");
 		return -ENOMEM;
 	}
+	bdp->cbd_bufaddr = cpu_to_fec32(dmabuf);
 
 	return 0;
 }
-- 
2.5.0
