From: ruxandra.radulescu@nxp.com (Ioana Radulescu)
Date: Tue, 6 Jun 2017 10:00:41 -0500
Subject: [PATCH 18/18] staging: fsl-dpaa2/eth: Update number of netdev queues
In-Reply-To: <20170606150041.10955-1-ruxandra.radulescu@nxp.com>
References: <20170606150041.10955-1-ruxandra.radulescu@nxp.com>
Message-ID: <20170606150041.10955-19-ruxandra.radulescu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the netdevice is allocated with a default number of Rx/Tx
queues equal to CONFIG_NR_CPUS, meaning the maximum number of cores
supported by the current kernel. The actual number of queues is
reflected by the DPNI object attribute, so update the netdevice
configuration based on that.

Signed-off-by: Bogdan Purcareata <bogdan.purcareata@nxp.com>
Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index 3f7f61b9c462..224f3937f313 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -2232,6 +2232,7 @@ static int netdev_init(struct net_device *net_dev)
 	struct device *dev = net_dev->dev.parent;
 	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
 	u8 bcast_addr[ETH_ALEN];
+	u8 num_queues;
 	int err;
 
 	net_dev->netdev_ops = &dpaa2_eth_ops;
@@ -2257,6 +2258,19 @@ static int netdev_init(struct net_device *net_dev)
 	net_dev->min_mtu = 68;
 	net_dev->max_mtu = DPAA2_ETH_MAX_MTU;
 
+	/* Set actual number of queues in the net device */
+	num_queues = dpaa2_eth_queue_count(priv);
+	err = netif_set_real_num_tx_queues(net_dev, num_queues);
+	if (err) {
+		dev_err(dev, "netif_set_real_num_tx_queues() failed\n");
+		return err;
+	}
+	err = netif_set_real_num_rx_queues(net_dev, num_queues);
+	if (err) {
+		dev_err(dev, "netif_set_real_num_rx_queues() failed\n");
+		return err;
+	}
+
 	/* Our .ndo_init will be called herein */
 	err = register_netdev(net_dev);
 	if (err < 0) {
-- 
2.11.0
