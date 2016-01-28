From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 28 Jan 2016 14:25:47 -0700
Subject: [PATCH net-next 23/40] net: fec: don't set cbd_bufaddr unless no
 mapping error
In-Reply-To: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1454016364-30985-24-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index da2e3c530..29c5781 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -597,7 +597,7 @@ fec_enet_txq_put_hdr_tso(struct fec_enet_priv_tx_q *txq,
 	int hdr_len = skb_transport_offset(skb) + tcp_hdrlen(skb);
 	struct bufdesc_ex *ebdp = container_of(bdp, struct bufdesc_ex, desc);
 	void *bufaddr;
-	unsigned long dmabuf;
+	dma_addr_t dmabuf;
 	unsigned short status;
 	unsigned int estatus = 0;
 
@@ -1287,19 +1287,21 @@ fec_enet_new_rxbdp(struct net_device *ndev, struct bufdesc *bdp, struct sk_buff
 {
 	struct  fec_enet_private *fep = netdev_priv(ndev);
 	int off;
+	dma_addr_t dmabuf;
 
 	off = ((unsigned long)skb->data) & fep->rx_align;
 	if (off)
 		skb_reserve(skb, fep->rx_align + 1 - off);
 
-	bdp->cbd_bufaddr = dma_map_single(&fep->pdev->dev, skb->data,
-					  FEC_ENET_RX_FRSIZE - fep->rx_align,
-					  DMA_FROM_DEVICE);
-	if (dma_mapping_error(&fep->pdev->dev, bdp->cbd_bufaddr)) {
+	dmabuf = dma_map_single(&fep->pdev->dev, skb->data,
+				FEC_ENET_RX_FRSIZE - fep->rx_align,
+				DMA_FROM_DEVICE);
+	if (dma_mapping_error(&fep->pdev->dev, dmabuf)) {
 		if (net_ratelimit())
 			netdev_err(ndev, "Rx DMA memory map failed\n");
 		return -ENOMEM;
 	}
+	bdp->cbd_bufaddr = dmabuf;
 
 	return 0;
 }
-- 
2.5.0
