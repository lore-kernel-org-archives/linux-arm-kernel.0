From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Thu, 29 Mar 2018 18:15:36 +0800
Subject: [PATCH 2/2] net: mvneta: improve suspend/resume
In-Reply-To: <20180329181220.61d63c92@xhacker.debian>
References: <20180329181220.61d63c92@xhacker.debian>
Message-ID: <20180329181536.46e065d2@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current suspend/resume implementation reuses the mvneta_open() and
mvneta_close(), but it could be optimized to take only necessary
actions during suspend/resume.

One obvious problem of current implementation is: after hundreds of
system suspend/resume cycles, the resume of mvneta could fail due to
fragmented dma coherent memory. After this patch, the non-necessary
memory alloc/free is optimized out.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 76 ++++++++++++++++++++++++++++++-----
 1 file changed, 66 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 4ec69bbd1eb4..1870f1dd7093 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -4575,14 +4575,46 @@ static int mvneta_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int mvneta_suspend(struct device *device)
 {
+	int queue;
 	struct net_device *dev = dev_get_drvdata(device);
 	struct mvneta_port *pp = netdev_priv(dev);
 
-	rtnl_lock();
-	if (netif_running(dev))
-		mvneta_stop(dev);
-	rtnl_unlock();
+	if (!netif_running(dev))
+		return 0;
+
 	netif_device_detach(dev);
+
+	mvneta_stop_dev(pp);
+
+	if (!pp->neta_armada3700) {
+		spin_lock(&pp->lock);
+		pp->is_stopped = true;
+		spin_unlock(&pp->lock);
+
+		cpuhp_state_remove_instance_nocalls(online_hpstate,
+						    &pp->node_online);
+		cpuhp_state_remove_instance_nocalls(CPUHP_NET_MVNETA_DEAD,
+						    &pp->node_dead);
+	}
+
+	for (queue = 0; queue < rxq_number; queue++) {
+		struct mvneta_rx_queue *rxq = &pp->rxqs[queue];
+
+		mvneta_rxq_drop_pkts(pp, rxq);
+	}
+
+	for (queue = 0; queue < txq_number; queue++) {
+		struct mvneta_tx_queue *txq = &pp->txqs[queue];
+
+		/* Set minimum bandwidth for disabled TXQs */
+		mvreg_write(pp, MVETH_TXQ_TOKEN_CFG_REG(txq->id), 0);
+		mvreg_write(pp, MVETH_TXQ_TOKEN_COUNT_REG(txq->id), 0);
+
+		/* Set Tx descriptors queue starting address and size */
+		mvreg_write(pp, MVNETA_TXQ_BASE_ADDR_REG(txq->id), 0);
+		mvreg_write(pp, MVNETA_TXQ_SIZE_REG(txq->id), 0);
+	}
+
 	clk_disable_unprepare(pp->clk_bus);
 	clk_disable_unprepare(pp->clk);
 	return 0;
@@ -4593,7 +4625,7 @@ static int mvneta_resume(struct device *device)
 	struct platform_device *pdev = to_platform_device(device);
 	struct net_device *dev = dev_get_drvdata(device);
 	struct mvneta_port *pp = netdev_priv(dev);
-	int err;
+	int err, queue;
 
 	clk_prepare_enable(pp->clk);
 	if (!IS_ERR(pp->clk_bus))
@@ -4614,13 +4646,37 @@ static int mvneta_resume(struct device *device)
 		return err;
 	}
 
+	if (!netif_running(dev))
+		return 0;
+
 	netif_device_attach(dev);
-	rtnl_lock();
-	if (netif_running(dev)) {
-		mvneta_open(dev);
-		mvneta_set_rx_mode(dev);
+
+	for (queue = 0; queue < rxq_number; queue++) {
+		struct mvneta_rx_queue *rxq = &pp->rxqs[queue];
+
+		rxq->next_desc_to_proc = 0;
+		mvneta_rxq_hw_init(pp, rxq);
 	}
-	rtnl_unlock();
+
+	for (queue = 0; queue < txq_number; queue++) {
+		struct mvneta_tx_queue *txq = &pp->txqs[queue];
+
+		txq->next_desc_to_proc = 0;
+		mvneta_txq_hw_init(pp, txq);
+	}
+
+	if (!pp->neta_armada3700) {
+		spin_lock(&pp->lock);
+		pp->is_stopped = false;
+		spin_unlock(&pp->lock);
+		cpuhp_state_add_instance_nocalls(online_hpstate,
+						 &pp->node_online);
+		cpuhp_state_add_instance_nocalls(CPUHP_NET_MVNETA_DEAD,
+						 &pp->node_dead);
+	}
+
+	mvneta_set_rx_mode(dev);
+	mvneta_start_dev(pp);
 
 	return 0;
 }
-- 
2.16.3
