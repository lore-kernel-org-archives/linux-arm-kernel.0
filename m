From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Thu, 9 Aug 2018 20:02:42 +0800
Subject: [PATCH] net: mvneta: use the correct napi pointer
Message-ID: <20180809200242.1166f86c@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

if neta_armada3700 is true, the mvneta_pcpu_port's napi is invalid, we
should use pp->napi instead. Fix mvneta_config_rss() with this method.
Although we can fix mvneta_rx_hwbm() and mvneta_rx_swbm() in the same
manner, the napi parm of mvneta_poll() is always correct, so we can
pass the correct napi param to mvneta_rx_hwbm() and mvneta_rx_swbm()

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 55 ++++++++++++++++-----------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 0ad2f3f7da85..74b701fed5ef 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1901,10 +1901,9 @@ static void mvneta_rxq_drop_pkts(struct mvneta_port *pp,
 }
 
 /* Main rx processing when using software buffer management */
-static int mvneta_rx_swbm(struct mvneta_port *pp, int rx_todo,
-			  struct mvneta_rx_queue *rxq)
+static int mvneta_rx_swbm(struct mvneta_port *pp, struct napi_struct *napi,
+			  int rx_todo, struct mvneta_rx_queue *rxq)
 {
-	struct mvneta_pcpu_port *port = this_cpu_ptr(pp->ports);
 	struct net_device *dev = pp->dev;
 	int rx_done;
 	u32 rcvd_pkts = 0;
@@ -1959,7 +1958,7 @@ static int mvneta_rx_swbm(struct mvneta_port *pp, int rx_todo,
 
 			skb->protocol = eth_type_trans(skb, dev);
 			mvneta_rx_csum(pp, rx_status, skb);
-			napi_gro_receive(&port->napi, skb);
+			napi_gro_receive(napi, skb);
 
 			rcvd_pkts++;
 			rcvd_bytes += rx_bytes;
@@ -2001,7 +2000,7 @@ static int mvneta_rx_swbm(struct mvneta_port *pp, int rx_todo,
 
 		mvneta_rx_csum(pp, rx_status, skb);
 
-		napi_gro_receive(&port->napi, skb);
+		napi_gro_receive(napi, skb);
 	}
 
 	if (rcvd_pkts) {
@@ -2020,10 +2019,9 @@ static int mvneta_rx_swbm(struct mvneta_port *pp, int rx_todo,
 }
 
 /* Main rx processing when using hardware buffer management */
-static int mvneta_rx_hwbm(struct mvneta_port *pp, int rx_todo,
-			  struct mvneta_rx_queue *rxq)
+static int mvneta_rx_hwbm(struct mvneta_port *pp, struct napi_struct *napi,
+			  int rx_todo, struct mvneta_rx_queue *rxq)
 {
-	struct mvneta_pcpu_port *port = this_cpu_ptr(pp->ports);
 	struct net_device *dev = pp->dev;
 	int rx_done;
 	u32 rcvd_pkts = 0;
@@ -2085,7 +2083,7 @@ static int mvneta_rx_hwbm(struct mvneta_port *pp, int rx_todo,
 
 			skb->protocol = eth_type_trans(skb, dev);
 			mvneta_rx_csum(pp, rx_status, skb);
-			napi_gro_receive(&port->napi, skb);
+			napi_gro_receive(napi, skb);
 
 			rcvd_pkts++;
 			rcvd_bytes += rx_bytes;
@@ -2129,7 +2127,7 @@ static int mvneta_rx_hwbm(struct mvneta_port *pp, int rx_todo,
 
 		mvneta_rx_csum(pp, rx_status, skb);
 
-		napi_gro_receive(&port->napi, skb);
+		napi_gro_receive(napi, skb);
 	}
 
 	if (rcvd_pkts) {
@@ -2722,9 +2720,11 @@ static int mvneta_poll(struct napi_struct *napi, int budget)
 	if (rx_queue) {
 		rx_queue = rx_queue - 1;
 		if (pp->bm_priv)
-			rx_done = mvneta_rx_hwbm(pp, budget, &pp->rxqs[rx_queue]);
+			rx_done = mvneta_rx_hwbm(pp, napi, budget,
+						 &pp->rxqs[rx_queue]);
 		else
-			rx_done = mvneta_rx_swbm(pp, budget, &pp->rxqs[rx_queue]);
+			rx_done = mvneta_rx_swbm(pp, napi, budget,
+						 &pp->rxqs[rx_queue]);
 	}
 
 	if (rx_done < budget) {
@@ -4018,13 +4018,18 @@ static int  mvneta_config_rss(struct mvneta_port *pp)
 
 	on_each_cpu(mvneta_percpu_mask_interrupt, pp, true);
 
-	/* We have to synchronise on the napi of each CPU */
-	for_each_online_cpu(cpu) {
-		struct mvneta_pcpu_port *pcpu_port =
-			per_cpu_ptr(pp->ports, cpu);
+	if (!pp->neta_armada3700) {
+		/* We have to synchronise on the napi of each CPU */
+		for_each_online_cpu(cpu) {
+			struct mvneta_pcpu_port *pcpu_port =
+				per_cpu_ptr(pp->ports, cpu);
 
-		napi_synchronize(&pcpu_port->napi);
-		napi_disable(&pcpu_port->napi);
+			napi_synchronize(&pcpu_port->napi);
+			napi_disable(&pcpu_port->napi);
+		}
+	} else {
+		napi_synchronize(&pp->napi);
+		napi_disable(&pp->napi);
 	}
 
 	pp->rxq_def = pp->indir[0];
@@ -4041,12 +4046,16 @@ static int  mvneta_config_rss(struct mvneta_port *pp)
 	mvneta_percpu_elect(pp);
 	spin_unlock(&pp->lock);
 
-	/* We have to synchronise on the napi of each CPU */
-	for_each_online_cpu(cpu) {
-		struct mvneta_pcpu_port *pcpu_port =
-			per_cpu_ptr(pp->ports, cpu);
+	if (!pp->neta_armada3700) {
+		/* We have to synchronise on the napi of each CPU */
+		for_each_online_cpu(cpu) {
+			struct mvneta_pcpu_port *pcpu_port =
+				per_cpu_ptr(pp->ports, cpu);
 
-		napi_enable(&pcpu_port->napi);
+			napi_enable(&pcpu_port->napi);
+		}
+	} else {
+		napi_enable(&pp->napi);
 	}
 
 	netif_tx_start_all_queues(pp->dev);
-- 
2.18.0
