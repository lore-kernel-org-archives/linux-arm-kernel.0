From: brouer@redhat.com (Jesper Dangaard Brouer)
Date: Fri, 22 Dec 2017 18:12:20 +0100
Subject: [bpf-next V2 PATCH 09/14] thunderx: setup xdp_rxq_info
In-Reply-To: <151396262289.20006.1429172971820409456.stgit@firesoul>
References: <151396262289.20006.1429172971820409456.stgit@firesoul>
Message-ID: <151396274076.20006.11668081217289933505.stgit@firesoul>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver uses a bool scheme for "enable"/"disable" when setting up
different resources.  Thus, the hook points for xdp_rxq_info is done
in the same function call nicvf_rcv_queue_config().  This is activated
through enable/disable via nicvf_config_data_transfer(), which is tied
into nicvf_stop()/nicvf_open().

Extending driver packet handler call-path nicvf_rcv_pkt_handler() with
a pointer to the given struct rcv_queue, in-order to access the
xdp_rxq_info data area (in nicvf_xdp_rx()).

V2: Driver have no proper error path for failed XDP RX-queue info reg,
as nicvf_rcv_queue_config is a void function.

Cc: linux-arm-kernel at lists.infradead.org
Cc: Sunil Goutham <sgoutham@cavium.com>
Cc: Robert Richter <rric@kernel.org>
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 drivers/net/ethernet/cavium/thunder/nicvf_main.c   |   11 +++++++----
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c |    4 ++++
 drivers/net/ethernet/cavium/thunder/nicvf_queues.h |    2 ++
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index 52b3a6044f85..21618d0d694f 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -521,7 +521,7 @@ static void nicvf_unmap_page(struct nicvf *nic, struct page *page, u64 dma_addr)
 
 static inline bool nicvf_xdp_rx(struct nicvf *nic, struct bpf_prog *prog,
 				struct cqe_rx_t *cqe_rx, struct snd_queue *sq,
-				struct sk_buff **skb)
+				struct rcv_queue *rq, struct sk_buff **skb)
 {
 	struct xdp_buff xdp;
 	struct page *page;
@@ -545,6 +545,7 @@ static inline bool nicvf_xdp_rx(struct nicvf *nic, struct bpf_prog *prog,
 	xdp.data = (void *)cpu_addr;
 	xdp_set_data_meta_invalid(&xdp);
 	xdp.data_end = xdp.data + len;
+	xdp.rxq = &rq->xdp_rxq;
 	orig_data = xdp.data;
 
 	rcu_read_lock();
@@ -698,7 +699,8 @@ static inline void nicvf_set_rxhash(struct net_device *netdev,
 
 static void nicvf_rcv_pkt_handler(struct net_device *netdev,
 				  struct napi_struct *napi,
-				  struct cqe_rx_t *cqe_rx, struct snd_queue *sq)
+				  struct cqe_rx_t *cqe_rx,
+				  struct snd_queue *sq, struct rcv_queue *rq)
 {
 	struct sk_buff *skb = NULL;
 	struct nicvf *nic = netdev_priv(netdev);
@@ -724,7 +726,7 @@ static void nicvf_rcv_pkt_handler(struct net_device *netdev,
 	/* For XDP, ignore pkts spanning multiple pages */
 	if (nic->xdp_prog && (cqe_rx->rb_cnt == 1)) {
 		/* Packet consumed by XDP */
-		if (nicvf_xdp_rx(snic, nic->xdp_prog, cqe_rx, sq, &skb))
+		if (nicvf_xdp_rx(snic, nic->xdp_prog, cqe_rx, sq, rq, &skb))
 			return;
 	} else {
 		skb = nicvf_get_rcv_skb(snic, cqe_rx,
@@ -781,6 +783,7 @@ static int nicvf_cq_intr_handler(struct net_device *netdev, u8 cq_idx,
 	struct cqe_rx_t *cq_desc;
 	struct netdev_queue *txq;
 	struct snd_queue *sq = &qs->sq[cq_idx];
+	struct rcv_queue *rq = &qs->rq[cq_idx];
 	unsigned int tx_pkts = 0, tx_bytes = 0, txq_idx;
 
 	spin_lock_bh(&cq->lock);
@@ -811,7 +814,7 @@ static int nicvf_cq_intr_handler(struct net_device *netdev, u8 cq_idx,
 
 		switch (cq_desc->cqe_type) {
 		case CQE_TYPE_RX:
-			nicvf_rcv_pkt_handler(netdev, napi, cq_desc, sq);
+			nicvf_rcv_pkt_handler(netdev, napi, cq_desc, sq, rq);
 			work_done++;
 		break;
 		case CQE_TYPE_SEND:
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
index f38ea349aa00..14e62c6ac342 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
@@ -760,6 +760,7 @@ static void nicvf_rcv_queue_config(struct nicvf *nic, struct queue_set *qs,
 
 	if (!rq->enable) {
 		nicvf_reclaim_rcv_queue(nic, qs, qidx);
+		xdp_rxq_info_unreg(&rq->xdp_rxq);
 		return;
 	}
 
@@ -772,6 +773,9 @@ static void nicvf_rcv_queue_config(struct nicvf *nic, struct queue_set *qs,
 	/* all writes of RBDR data to be loaded into L2 Cache as well*/
 	rq->caching = 1;
 
+	/* Driver have no proper error path for failed XDP RX-queue info reg */
+	WARN_ON(xdp_rxq_info_reg(&rq->xdp_rxq, nic->netdev, qidx) < 0);
+
 	/* Send a mailbox msg to PF to config RQ */
 	mbx.rq.msg = NIC_MBOX_MSG_RQ_CFG;
 	mbx.rq.qs_num = qs->vnic_id;
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.h b/drivers/net/ethernet/cavium/thunder/nicvf_queues.h
index 178ab6e8e3c5..7d1e4e2aaad0 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.h
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.h
@@ -12,6 +12,7 @@
 #include <linux/netdevice.h>
 #include <linux/iommu.h>
 #include <linux/bpf.h>
+#include <net/xdp.h>
 #include "q_struct.h"
 
 #define MAX_QUEUE_SET			128
@@ -255,6 +256,7 @@ struct rcv_queue {
 	u8		start_qs_rbdr_idx; /* RBDR idx in the above QS */
 	u8		caching;
 	struct		rx_tx_queue_stats stats;
+	struct xdp_rxq_info xdp_rxq;
 } ____cacheline_aligned_in_smp;
 
 struct cmp_queue {
