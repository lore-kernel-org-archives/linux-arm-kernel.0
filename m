From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:42:00 +0100
Subject: [PATCH 124/222] net:fec: add ethtool support for tx/rx ring sizes
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeW0-0007LV-Qg@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ethtool support to retrieve and set the transmit and receive ring
sizes.  This allows runtime tuning of these parameters, which can
result in better throughput with gigabit parts.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 47 +++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 11176d483db4..12d48b997744 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1631,6 +1631,51 @@ static int fec_enet_get_ts_info(struct net_device *ndev,
 	}
 }
 
+static void fec_enet_get_ringparam(struct net_device *ndev,
+				   struct ethtool_ringparam *ring)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+
+	ring->rx_max_pending = RX_RING_SIZE;
+	ring->tx_max_pending = TX_RING_SIZE;
+	ring->rx_pending = fep->rx_ring_size;
+	ring->tx_pending = fep->tx_ring_size;
+}
+
+static int fec_enet_set_ringparam(struct net_device *ndev,
+				   struct ethtool_ringparam *ring)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	unsigned rx, tx, tx_min;
+
+	tx_min = ndev->features & NETIF_F_SG ? TX_RING_SIZE_MIN_SG : 16;
+
+	rx = clamp_t(u32, ring->rx_pending, 16, RX_RING_SIZE);
+	tx = clamp_t(u32, ring->tx_pending, tx_min, TX_RING_SIZE);
+
+	if (tx == fep->tx_ring_size && rx == fep->rx_ring_size)
+		return 0;
+
+	/* Setting the ring size while the interface is down is easy */
+	if (!netif_running(ndev)) {
+		fep->tx_ring_size = tx;
+		fep->rx_ring_size = rx;
+	} else {
+		return -EINVAL;
+
+		napi_disable(&fep->napi);
+		netif_tx_lock_bh(ndev);
+		fec_stop(ndev);
+		/* reallocate ring */
+		fec_restart(ndev);
+		netif_wake_queue(ndev);
+		netif_tx_unlock_bh(ndev);
+		napi_enable(&fep->napi);
+	}
+
+	return 0;
+}
+
 #if !defined(CONFIG_M5272)
 
 static void fec_enet_get_pauseparam(struct net_device *ndev,
@@ -1835,6 +1880,8 @@ static const struct ethtool_ops fec_enet_ethtool_ops = {
 	.get_drvinfo		= fec_enet_get_drvinfo,
 	.nway_reset		= fec_enet_nway_reset,
 	.get_link		= ethtool_op_get_link,
+	.get_ringparam		= fec_enet_get_ringparam,
+	.set_ringparam		= fec_enet_set_ringparam,
 #ifndef CONFIG_M5272
 	.get_pauseparam		= fec_enet_get_pauseparam,
 	.set_pauseparam		= fec_enet_set_pauseparam,
-- 
1.8.3.1
