From: ruxandra.radulescu@nxp.com (Ioana Radulescu)
Date: Tue, 6 Jun 2017 10:00:40 -0500
Subject: [PATCH 17/18] staging: fsl-dpaa2/eth: Refactor MAC address setup
In-Reply-To: <20170606150041.10955-1-ruxandra.radulescu@nxp.com>
References: <20170606150041.10955-1-ruxandra.radulescu@nxp.com>
Message-ID: <20170606150041.10955-18-ruxandra.radulescu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver logic for allocating a MAC address to a net device
is complicated enough to deserve a function of its own. While
here, cleanup a bit the code comments.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 46 ++++++++++++++++----------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index 7dca8c2e5ff9..3f7f61b9c462 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -2162,15 +2162,12 @@ static void free_rings(struct dpaa2_eth_priv *priv)
 		dpaa2_io_store_destroy(priv->channel[i]->store);
 }
 
-static int netdev_init(struct net_device *net_dev)
+static int set_mac_addr(struct dpaa2_eth_priv *priv)
 {
-	int err;
+	struct net_device *net_dev = priv->net_dev;
 	struct device *dev = net_dev->dev.parent;
-	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
 	u8 mac_addr[ETH_ALEN], dpni_mac_addr[ETH_ALEN];
-	u8 bcast_addr[ETH_ALEN];
-
-	net_dev->netdev_ops = &dpaa2_eth_ops;
+	int err;
 
 	/* Get firmware address, if any */
 	err = dpni_get_port_mac_addr(priv->mc_io, 0, priv->mc_token, mac_addr);
@@ -2183,7 +2180,7 @@ static int netdev_init(struct net_device *net_dev)
 	err = dpni_get_primary_mac_addr(priv->mc_io, 0, priv->mc_token,
 					dpni_mac_addr);
 	if (err) {
-		dev_err(dev, "dpni_get_primary_mac_addr() failed (%d)\n", err);
+		dev_err(dev, "dpni_get_primary_mac_addr() failed\n");
 		return err;
 	}
 
@@ -2201,18 +2198,19 @@ static int netdev_init(struct net_device *net_dev)
 		}
 		memcpy(net_dev->dev_addr, mac_addr, net_dev->addr_len);
 	} else if (is_zero_ether_addr(dpni_mac_addr)) {
-		/* Fills in net_dev->dev_addr, as required by
-		 * register_netdevice()
+		/* No MAC address configured, fill in net_dev->dev_addr
+		 * with a random one
 		 */
 		eth_hw_addr_random(net_dev);
-		/* Make the user aware, without cluttering the boot log */
-		dev_dbg_once(dev, " device(s) have all-zero hwaddr, replaced with random\n");
+		dev_dbg_once(dev, "device(s) have all-zero hwaddr, replaced with random\n");
+
 		err = dpni_set_primary_mac_addr(priv->mc_io, 0, priv->mc_token,
 						net_dev->dev_addr);
 		if (err) {
-			dev_err(dev, "dpni_set_primary_mac_addr(): %d\n", err);
+			dev_err(dev, "dpni_set_primary_mac_addr() failed\n");
 			return err;
 		}
+
 		/* Override NET_ADDR_RANDOM set by eth_hw_addr_random(); for all
 		 * practical purposes, this will be our "permanent" mac address,
 		 * at least until the next reboot. This move will also permit
@@ -2226,14 +2224,28 @@ static int netdev_init(struct net_device *net_dev)
 		memcpy(net_dev->dev_addr, dpni_mac_addr, net_dev->addr_len);
 	}
 
-	/* Explicitly add the broadcast address to the MAC filtering table;
-	 * the MC won't do that for us.
-	 */
+	return 0;
+}
+
+static int netdev_init(struct net_device *net_dev)
+{
+	struct device *dev = net_dev->dev.parent;
+	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
+	u8 bcast_addr[ETH_ALEN];
+	int err;
+
+	net_dev->netdev_ops = &dpaa2_eth_ops;
+
+	err = set_mac_addr(priv);
+	if (err)
+		return err;
+
+	/* Explicitly add the broadcast address to the MAC filtering table */
 	eth_broadcast_addr(bcast_addr);
 	err = dpni_add_mac_addr(priv->mc_io, 0, priv->mc_token, bcast_addr);
 	if (err) {
-		dev_warn(dev, "dpni_add_mac_addr() failed (%d)\n", err);
-		/* Won't return an error; at least, we'd have egress traffic */
+		dev_err(dev, "dpni_add_mac_addr() failed\n");
+		return err;
 	}
 
 	/* Reserve enough space to align buffer as per hardware requirement;
-- 
2.11.0
