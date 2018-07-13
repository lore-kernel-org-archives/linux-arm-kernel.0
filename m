From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Fri, 13 Jul 2018 18:18:35 +0200
Subject: [PATCH net-next v2 1/7] net: ethernet: mvneta: Fix napi structure
 mixup on armada 3700
In-Reply-To: <20180713161841.11202-1-gregory.clement@bootlin.com>
References: <20180713161841.11202-1-gregory.clement@bootlin.com>
Message-ID: <20180713161841.11202-2-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Lunn <andrew@lunn.ch>

The mvneta Ethernet driver is used on a few different Marvell SoCs.
Some SoCs have per cpu interrupts for Ethernet events. Some SoCs have
a single interrupt, independent of the CPU. The driver handles this by
having a per CPU napi structure when there are per CPU interrupts, and
a global napi structure when there is a single interrupt.

When the napi core calls mvneta_poll(), it passes the napi
instance. This was not being propagated through the call chain, and
instead the per-cpu napi instance was passed to napi_gro_receive()
call. This breaks when there is a single global napi instance.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Fixes: 2636ac3cc2b4 ("net: mvneta: Add network support for Armada 3700 SoC")
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 0ad2f3f7da85..ec84db47d82d 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1901,10 +1901,10 @@ static void mvneta_rxq_drop_pkts(struct mvneta_port *pp,
 }
 
 /* Main rx processing when using software buffer management */
-static int mvneta_rx_swbm(struct mvneta_port *pp, int rx_todo,
+static int mvneta_rx_swbm(struct napi_struct *napi,
+			  struct mvneta_port *pp, int rx_todo,
 			  struct mvneta_rx_queue *rxq)
 {
-	struct mvneta_pcpu_port *port = this_cpu_ptr(pp->ports);
 	struct net_device *dev = pp->dev;
 	int rx_done;
 	u32 rcvd_pkts = 0;
@@ -1959,7 +1959,7 @@ static int mvneta_rx_swbm(struct mvneta_port *pp, int rx_todo,
 
 			skb->protocol = eth_type_trans(skb, dev);
 			mvneta_rx_csum(pp, rx_status, skb);
-			napi_gro_receive(&port->napi, skb);
+			napi_gro_receive(napi, skb);
 
 			rcvd_pkts++;
 			rcvd_bytes += rx_bytes;
@@ -2001,7 +2001,7 @@ static int mvneta_rx_swbm(struct mvneta_port *pp, int rx_todo,
 
 		mvneta_rx_csum(pp, rx_status, skb);
 
-		napi_gro_receive(&port->napi, skb);
+		napi_gro_receive(napi, skb);
 	}
 
 	if (rcvd_pkts) {
@@ -2020,10 +2020,10 @@ static int mvneta_rx_swbm(struct mvneta_port *pp, int rx_todo,
 }
 
 /* Main rx processing when using hardware buffer management */
-static int mvneta_rx_hwbm(struct mvneta_port *pp, int rx_todo,
+static int mvneta_rx_hwbm(struct napi_struct *napi,
+			  struct mvneta_port *pp, int rx_todo,
 			  struct mvneta_rx_queue *rxq)
 {
-	struct mvneta_pcpu_port *port = this_cpu_ptr(pp->ports);
 	struct net_device *dev = pp->dev;
 	int rx_done;
 	u32 rcvd_pkts = 0;
@@ -2085,7 +2085,7 @@ static int mvneta_rx_hwbm(struct mvneta_port *pp, int rx_todo,
 
 			skb->protocol = eth_type_trans(skb, dev);
 			mvneta_rx_csum(pp, rx_status, skb);
-			napi_gro_receive(&port->napi, skb);
+			napi_gro_receive(napi, skb);
 
 			rcvd_pkts++;
 			rcvd_bytes += rx_bytes;
@@ -2129,7 +2129,7 @@ static int mvneta_rx_hwbm(struct mvneta_port *pp, int rx_todo,
 
 		mvneta_rx_csum(pp, rx_status, skb);
 
-		napi_gro_receive(&port->napi, skb);
+		napi_gro_receive(napi, skb);
 	}
 
 	if (rcvd_pkts) {
@@ -2722,9 +2722,11 @@ static int mvneta_poll(struct napi_struct *napi, int budget)
 	if (rx_queue) {
 		rx_queue = rx_queue - 1;
 		if (pp->bm_priv)
-			rx_done = mvneta_rx_hwbm(pp, budget, &pp->rxqs[rx_queue]);
+			rx_done = mvneta_rx_hwbm(napi, pp, budget,
+						 &pp->rxqs[rx_queue]);
 		else
-			rx_done = mvneta_rx_swbm(pp, budget, &pp->rxqs[rx_queue]);
+			rx_done = mvneta_rx_swbm(napi, pp, budget,
+						 &pp->rxqs[rx_queue]);
 	}
 
 	if (rx_done < budget) {
-- 
2.18.0
