From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Wed, 29 Aug 2018 16:27:06 +0800
Subject: [PATCH 1/5] net: mvneta: fix rx_offset_correction set and usage
In-Reply-To: <20180829162456.2bd69796@xhacker.debian>
References: <20180829162456.2bd69796@xhacker.debian>
Message-ID: <20180829162706.24111f9c@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rx_offset_correction is RX packet offset correction for platforms,
it's not related with SW BM, instead, it's only related with the
platform's NET_SKB_PAD.

Fix the issue by reverting to the original behavior.

Fixes: 562e2f467e71 ("net: mvneta: Improve the buffer allocation method for SWBM")
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index bc80a678abc3..0ce94f6587a5 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2899,21 +2899,18 @@ static void mvneta_rxq_hw_init(struct mvneta_port *pp,
 	mvreg_write(pp, MVNETA_RXQ_BASE_ADDR_REG(rxq->id), rxq->descs_phys);
 	mvreg_write(pp, MVNETA_RXQ_SIZE_REG(rxq->id), rxq->size);
 
+	/* Set Offset */
+	mvneta_rxq_offset_set(pp, rxq, NET_SKB_PAD - pp->rx_offset_correction);
+
 	/* Set coalescing pkts and time */
 	mvneta_rx_pkts_coal_set(pp, rxq, rxq->pkts_coal);
 	mvneta_rx_time_coal_set(pp, rxq, rxq->time_coal);
 
 	if (!pp->bm_priv) {
-		/* Set Offset */
-		mvneta_rxq_offset_set(pp, rxq, 0);
 		mvneta_rxq_buf_size_set(pp, rxq, pp->frag_size);
 		mvneta_rxq_bm_disable(pp, rxq);
 		mvneta_rxq_fill(pp, rxq, rxq->size);
 	} else {
-		/* Set Offset */
-		mvneta_rxq_offset_set(pp, rxq,
-				      NET_SKB_PAD - pp->rx_offset_correction);
-
 		mvneta_rxq_bm_enable(pp, rxq);
 		/* Fill RXQ with buffers from RX pool */
 		mvneta_rxq_long_pool_set(pp, rxq);
@@ -4547,7 +4544,13 @@ static int mvneta_probe(struct platform_device *pdev)
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
 	pp->id = global_port_id++;
-	pp->rx_offset_correction = 0; /* not relevant for SW BM */
+
+	/* Set RX packet offset correction for platforms, whose
+	 * NET_SKB_PAD, exceeds 64B. It should be 64B for 64-bit
+	 * platforms and 0B for 32-bit ones.
+	 */
+	pp->rx_offset_correction =
+		max(0, NET_SKB_PAD - MVNETA_RX_PKT_OFFSET_CORRECTION);
 
 	/* Obtain access to BM resources if enabled and already initialized */
 	bm_node = of_parse_phandle(dn, "buffer-manager", 0);
@@ -4562,13 +4565,6 @@ static int mvneta_probe(struct platform_device *pdev)
 				pp->bm_priv = NULL;
 			}
 		}
-		/* Set RX packet offset correction for platforms, whose
-		 * NET_SKB_PAD, exceeds 64B. It should be 64B for 64-bit
-		 * platforms and 0B for 32-bit ones.
-		 */
-		pp->rx_offset_correction = max(0,
-					       NET_SKB_PAD -
-					       MVNETA_RX_PKT_OFFSET_CORRECTION);
 	}
 	of_node_put(bm_node);
 
-- 
2.18.0
