From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  4 Feb 2016 22:09:25 +0100
Subject: [PATCH v3 net 3/7] net: mvneta: Use on_each_cpu when possible
In-Reply-To: <1454620169-8156-1-git-send-email-gregory.clement@free-electrons.com>
References: <1454620169-8156-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1454620169-8156-4-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of using a for_each_* loop in which we just call the
smp_call_function_single macro, it is more simple to directly use the
on_each_cpu macro. Moreover, this macro ensures that the calls will be
done all at once.

Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 4c2d12423750..f496f9716569 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2555,7 +2555,7 @@ static void mvneta_percpu_mask_interrupt(void *arg)
 
 static void mvneta_start_dev(struct mvneta_port *pp)
 {
-	unsigned int cpu;
+	int cpu;
 
 	mvneta_max_rx_size_set(pp, pp->pkt_size);
 	mvneta_txq_max_tx_size_set(pp, pp->pkt_size);
@@ -2571,9 +2571,8 @@ static void mvneta_start_dev(struct mvneta_port *pp)
 	}
 
 	/* Unmask interrupts. It has to be done from each CPU */
-	for_each_online_cpu(cpu)
-		smp_call_function_single(cpu, mvneta_percpu_unmask_interrupt,
-					 pp, true);
+	on_each_cpu(mvneta_percpu_unmask_interrupt, pp, true);
+
 	mvreg_write(pp, MVNETA_INTR_MISC_MASK,
 		    MVNETA_CAUSE_PHY_STATUS_CHANGE |
 		    MVNETA_CAUSE_LINK_CHANGE |
@@ -2993,7 +2992,7 @@ static int mvneta_percpu_notifier(struct notifier_block *nfb,
 static int mvneta_open(struct net_device *dev)
 {
 	struct mvneta_port *pp = netdev_priv(dev);
-	int ret, cpu;
+	int ret;
 
 	pp->pkt_size = MVNETA_RX_PKT_SIZE(pp->dev->mtu);
 	pp->frag_size = SKB_DATA_ALIGN(MVNETA_RX_BUF_SIZE(pp->pkt_size)) +
@@ -3026,9 +3025,7 @@ static int mvneta_open(struct net_device *dev)
 	/* Enable per-CPU interrupt on all the CPU to handle our RX
 	 * queue interrupts
 	 */
-	for_each_online_cpu(cpu)
-		smp_call_function_single(cpu, mvneta_percpu_enable,
-					 pp, true);
+	on_each_cpu(mvneta_percpu_enable, pp, true);
 
 
 	/* Register a CPU notifier to handle the case where our CPU
@@ -3315,9 +3312,7 @@ static int  mvneta_config_rss(struct mvneta_port *pp)
 
 	netif_tx_stop_all_queues(pp->dev);
 
-	for_each_online_cpu(cpu)
-		smp_call_function_single(cpu, mvneta_percpu_mask_interrupt,
-					 pp, true);
+	on_each_cpu(mvneta_percpu_mask_interrupt, pp, true);
 
 	/* We have to synchronise on the napi of each CPU */
 	for_each_online_cpu(cpu) {
-- 
2.5.0
