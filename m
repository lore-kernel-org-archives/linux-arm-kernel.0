From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 29 Jan 2016 17:26:07 +0100
Subject: [PATCH net 6/6] net: mvneta: Fix race condition during stopping
In-Reply-To: <1454084767-24715-1-git-send-email-gregory.clement@free-electrons.com>
References: <1454084767-24715-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1454084767-24715-7-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When stopping the port, the CPU notifier are still there whereas the
mvneta_stop_dev function calls mvneta_percpu_disable() on each CPUs.
It was possible to have a new CPU coming at this point which could be
racy.

This patch adds a flag preventing executing the code notifier for a new CPU
when the port is stopping.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 3358c9a70467..22962fac47c2 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -372,6 +372,7 @@ struct mvneta_port {
 	int rxq_def;
 	/* protect  */
 	spinlock_t lock;
+	bool is_stopping;
 
 	/* Core clock */
 	struct clk *clk;
@@ -2914,6 +2915,11 @@ static int mvneta_percpu_notifier(struct notifier_block *nfb,
 	switch (action) {
 	case CPU_ONLINE:
 	case CPU_ONLINE_FROZEN:
+		/* Configuring the driver for a new CPU while the
+		 * driver is stopping is racy, so just avoid it.
+		 */
+		if (pp->is_stopping)
+			break;
 		netif_tx_stop_all_queues(pp->dev);
 
 		/* We have to synchronise on tha napi of each CPU
@@ -3052,9 +3058,17 @@ static int mvneta_stop(struct net_device *dev)
 {
 	struct mvneta_port *pp = netdev_priv(dev);
 
+	/* Inform that we are stopping so we don't want to setup the
+	 * driver for new CPUs in the notifiers
+	 */
+	pp->is_stopping = true;
 	mvneta_stop_dev(pp);
 	mvneta_mdio_remove(pp);
 	unregister_cpu_notifier(&pp->cpu_notifier);
+	/* Now that the notifier are unregistered, we can clear the
+	 * flag
+	 */
+	pp->is_stopping = false;
 	on_each_cpu(mvneta_percpu_disable, pp, true);
 	free_percpu_irq(dev->irq, pp->ports);
 	mvneta_cleanup_rxqs(pp);
-- 
2.5.0
