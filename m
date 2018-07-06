From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Fri,  6 Jul 2018 15:19:46 +0200
Subject: [PATCH net-next 3/6] net: mvneta: discriminate error cause for missed
 packet
In-Reply-To: <20180706131949.2684-1-gregory.clement@bootlin.com>
References: <20180706131949.2684-1-gregory.clement@bootlin.com>
Message-ID: <20180706131949.2684-4-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yelena Krivosheev <yelena@marvell.com>

In order to improve the diagnostic in case of error, make the distinction
between refill error and skb allocation error.

Signed-off-by: Yelena Krivosheev <yelena@marvell.com>
[gregory: extract from a larger patch]
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 531227e2e48e..2c575c6732ce 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -589,9 +589,6 @@ struct mvneta_rx_queue {
 	/* num of rx descriptors in the rx descriptor ring */
 	int size;
 
-	/* counter of times when mvneta_refill() failed */
-	int missed;
-
 	u32 pkts_coal;
 	u32 time_coal;
 
@@ -609,6 +606,10 @@ struct mvneta_rx_queue {
 
 	/* Index of the next RX DMA descriptor to process */
 	int next_desc_to_proc;
+
+	/* error counters */
+	u32 skb_alloc_err;
+	u32 refill_err;
 };
 
 static enum cpuhp_state online_hpstate;
@@ -1946,8 +1947,13 @@ static int mvneta_rx_swbm(struct mvneta_port *pp, int rx_todo,
 		if (rx_bytes <= rx_copybreak) {
 		/* better copy a small frame and not unmap the DMA region */
 			skb = netdev_alloc_skb_ip_align(dev, rx_bytes);
-			if (unlikely(!skb))
+			if (unlikely(!skb)) {
+				netdev_err(dev,
+					   "Can't allocate skb on queue %d\n",
+					   rxq->id);
+				rxq->skb_alloc_err++;
 				goto err_drop_frame;
+			}
 
 			dma_sync_single_range_for_cpu(dev->dev.parent,
 						      phys_addr,
@@ -1972,7 +1978,7 @@ static int mvneta_rx_swbm(struct mvneta_port *pp, int rx_todo,
 		err = mvneta_rx_refill(pp, rx_desc, rxq);
 		if (err) {
 			netdev_err(dev, "Linux processing - Can't refill\n");
-			rxq->missed++;
+			rxq->refill_err++;
 			goto err_drop_frame;
 		}
 
@@ -2102,7 +2108,7 @@ static int mvneta_rx_hwbm(struct mvneta_port *pp, int rx_todo,
 		err = hwbm_pool_refill(&bm_pool->hwbm_pool, GFP_ATOMIC);
 		if (err) {
 			netdev_err(dev, "Linux processing - Can't refill\n");
-			rxq->missed++;
+			rxq->refill_err++;
 			goto err_drop_frame_ret_pool;
 		}
 
-- 
2.17.1
