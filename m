From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Fri, 10 Aug 2018 11:36:27 +0800
Subject: [PATCH net-next] net: mvneta: fix mvneta_config_rss on armada 3700
Message-ID: <20180810113627.5dec5d40@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mvneta Ethernet driver is used on a few different Marvell SoCs.
Some SoCs have per cpu interrupts for Ethernet events, the driver uses
a per CPU napi structure for this case. Some SoCs such as armada 3700
have a single interrupt for Ethernet events, the driver uses a global
napi structure for this case.

Current mvneta_config_rss() always operates the per cpu napi structure.
Fix it by operating a global napi for "single interrupt" case, and per
cpu napi structure for remaining cases.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Fixes: 2636ac3cc2b4 ("net: mvneta: Add network support for Armada 3700 SoC")
---
 drivers/net/ethernet/marvell/mvneta.c | 31 +++++++++++++++++----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 55c2a56c5dae..bc80a678abc3 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -4107,13 +4107,18 @@ static int  mvneta_config_rss(struct mvneta_port *pp)
 
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
@@ -4130,12 +4135,16 @@ static int  mvneta_config_rss(struct mvneta_port *pp)
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
