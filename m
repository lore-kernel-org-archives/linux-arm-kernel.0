From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 18 Jul 2018 18:10:54 +0200
Subject: [PATCH net-next v3 5/8] net: mvneta: discriminate error cause for
 missed packet
In-Reply-To: <20180718161057.28704-1-gregory.clement@bootlin.com>
References: <20180718161057.28704-1-gregory.clement@bootlin.com>
Message-ID: <20180718161057.28704-6-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to improve the diagnostic in case of error, make the distinction
between refill error and skb allocation error. Also make the information
available through the ethtool state.

Based on the work of Yelena Krivosheev <yelena@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 28 +++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index e519439bac97..da2d56826295 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -328,6 +328,8 @@
 
 enum {
 	ETHTOOL_STAT_EEE_WAKEUP,
+	ETHTOOL_STAT_SKB_ALLOC_ERR,
+	ETHTOOL_STAT_REFILL_ERR,
 	ETHTOOL_MAX_STATS,
 };
 
@@ -375,6 +377,8 @@ static const struct mvneta_statistic mvneta_statistics[] = {
 	{ 0x3054, T_REG_32, "fc_sent", },
 	{ 0x300c, T_REG_32, "internal_mac_transmit_err", },
 	{ ETHTOOL_STAT_EEE_WAKEUP, T_SW, "eee_wakeup_errors", },
+	{ ETHTOOL_STAT_SKB_ALLOC_ERR, T_SW, "skb_alloc_errors", },
+	{ ETHTOOL_STAT_REFILL_ERR, T_SW, "refill_errors", },
 };
 
 struct mvneta_pcpu_stats {
@@ -589,9 +593,6 @@ struct mvneta_rx_queue {
 	/* num of rx descriptors in the rx descriptor ring */
 	int size;
 
-	/* counter of times when mvneta_refill() failed */
-	int missed;
-
 	u32 pkts_coal;
 	u32 time_coal;
 
@@ -609,6 +610,10 @@ struct mvneta_rx_queue {
 
 	/* Index of the next RX DMA descriptor to process */
 	int next_desc_to_proc;
+
+	/* error counters */
+	u32 skb_alloc_err;
+	u32 refill_err;
 };
 
 static enum cpuhp_state online_hpstate;
@@ -1946,8 +1951,13 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
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
@@ -1972,7 +1982,7 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
 		err = mvneta_rx_refill(pp, rx_desc, rxq);
 		if (err) {
 			netdev_err(dev, "Linux processing - Can't refill\n");
-			rxq->missed++;
+			rxq->refill_err++;
 			goto err_drop_frame;
 		}
 
@@ -2102,7 +2112,7 @@ static int mvneta_rx_hwbm(struct napi_struct *napi,
 		err = hwbm_pool_refill(&bm_pool->hwbm_pool, GFP_ATOMIC);
 		if (err) {
 			netdev_err(dev, "Linux processing - Can't refill\n");
-			rxq->missed++;
+			rxq->refill_err++;
 			goto err_drop_frame_ret_pool;
 		}
 
@@ -3963,6 +3973,12 @@ static void mvneta_ethtool_update_stats(struct mvneta_port *pp)
 			case ETHTOOL_STAT_EEE_WAKEUP:
 				val = phylink_get_eee_err(pp->phylink);
 				break;
+			case ETHTOOL_STAT_SKB_ALLOC_ERR:
+				val = pp->rxqs[0].skb_alloc_err;
+				break;
+			case ETHTOOL_STAT_REFILL_ERR:
+				val = pp->rxqs[0].refill_err;
+				break;
 			}
 			break;
 		}
-- 
2.18.0
