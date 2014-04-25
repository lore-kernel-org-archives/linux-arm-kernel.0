From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:41:30 +0100
Subject: [PATCH 118/222] net:fec: add locking for MDIO bus access
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeVW-0007L6-62@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both fec_restart() and fec_stop() both perform a reset of the FEC.  This
reset can result in an in-process MDIO transfer being terminated, which
can lead to the MDIO read/write functions timing out.  Add some locking
to prevent this occuring.

We can't use a spinlock for this as the MDIO accessor functions use
wait_for_completion_timeout(), which sleeps.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec.h      |  3 +++
 drivers/net/ethernet/freescale/fec_main.c | 30 +++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 70ef32c965e5..11717d2fd520 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -14,6 +14,7 @@
 /****************************************************************************/
 
 #include <linux/clocksource.h>
+#include <linux/mutex.h>
 #include <linux/net_tstamp.h>
 #include <linux/ptp_clock_kernel.h>
 
@@ -300,6 +301,8 @@ struct fec_enet_private {
 	unsigned short tx_ring_size;
 	unsigned short rx_ring_size;
 
+	struct mutex mutex;
+
 	struct	platform_device *pdev;
 
 	int	dev_id;
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index f6763686d5a9..afbcd7f14951 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -795,12 +795,14 @@ static void fec_enet_timeout_work(struct work_struct *work)
 
 	rtnl_lock();
 	if (netif_device_present(ndev) || netif_running(ndev)) {
+		mutex_lock(&fep->mutex);
 		napi_disable(&fep->napi);
 		netif_tx_lock_bh(ndev);
 		fec_restart(ndev);
 		netif_wake_queue(ndev);
 		netif_tx_unlock_bh(ndev);
 		napi_enable(&fep->napi);
+		mutex_unlock(&fep->mutex);
 	}
 	rtnl_unlock();
 }
@@ -1282,20 +1284,24 @@ static void fec_enet_adjust_link(struct net_device *ndev)
 
 		/* if any of the above changed restart the FEC */
 		if (status_change) {
+			mutex_lock(&fep->mutex);
 			napi_disable(&fep->napi);
 			netif_tx_lock_bh(ndev);
 			fec_restart(ndev);
 			netif_wake_queue(ndev);
 			netif_tx_unlock_bh(ndev);
 			napi_enable(&fep->napi);
+			mutex_unlock(&fep->mutex);
 		}
 	} else {
 		if (fep->link) {
+			mutex_lock(&fep->mutex);
 			napi_disable(&fep->napi);
 			netif_tx_lock_bh(ndev);
 			fec_stop(ndev);
 			netif_tx_unlock_bh(ndev);
 			napi_enable(&fep->napi);
+			mutex_unlock(&fep->mutex);
 			fep->link = phy_dev->link;
 			status_change = 1;
 		}
@@ -1308,15 +1314,23 @@ static void fec_enet_adjust_link(struct net_device *ndev)
 static unsigned long fec_enet_mdio_op(struct fec_enet_private *fep,
 	unsigned data)
 {
+	unsigned long time_left;
+
 	fep->mii_timeout = 0;
 	init_completion(&fep->mdio_done);
 
+	mutex_lock(&fep->mutex);
+
 	/* start operation */
 	writel(data, fep->hwp + FEC_MII_DATA);
 
 	/* wait for end of transfer */
-	return wait_for_completion_timeout(&fep->mdio_done,
+	time_left = wait_for_completion_timeout(&fep->mdio_done,
 			usecs_to_jiffies(FEC_MII_TIMEOUT));
+
+	mutex_unlock(&fep->mutex);
+
+	return time_left;
 }
 
 static int fec_enet_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
@@ -1683,6 +1697,7 @@ static int fec_enet_set_pauseparam(struct net_device *ndev,
 			fep->pause_mode = fep->pause_flag;
 
 			if (netif_running(ndev)) {
+				mutex_lock(&fep->mutex);
 				napi_disable(&fep->napi);
 				netif_tx_lock_bh(ndev);
 				fec_stop(ndev);
@@ -1690,6 +1705,7 @@ static int fec_enet_set_pauseparam(struct net_device *ndev,
 				netif_wake_queue(ndev);
 				netif_tx_unlock_bh(ndev);
 				napi_enable(&fep->napi);
+				mutex_unlock(&fep->mutex);
 			}
 		}
 	}
@@ -1983,7 +1999,9 @@ fec_enet_open(struct net_device *ndev)
 		return ret;
 	}
 
+	mutex_lock(&fep->mutex);
 	fec_restart(ndev);
+	mutex_unlock(&fep->mutex);
 	napi_enable(&fep->napi);
 	phy_start(fep->phy_dev);
 	netif_start_queue(ndev);
@@ -2000,7 +2018,9 @@ fec_enet_close(struct net_device *ndev)
 	if (netif_device_present(ndev)) {
 		napi_disable(&fep->napi);
 		netif_tx_disable(ndev);
+		mutex_lock(&fep->mutex);
 		fec_stop(ndev);
+		mutex_unlock(&fep->mutex);
 	}
 
 	phy_disconnect(fep->phy_dev);
@@ -2155,6 +2175,7 @@ static int fec_set_features(struct net_device *netdev,
 
 	/* Quiesce the device if necessary */
 	if (netif_running(netdev) && changed & FEATURES_NEED_QUIESCE) {
+		mutex_lock(&fep->mutex);
 		napi_disable(&fep->napi);
 		netif_tx_lock_bh(netdev);
 		fec_stop(netdev);
@@ -2182,6 +2203,7 @@ static int fec_set_features(struct net_device *netdev,
 		netif_wake_queue(netdev);
 		netif_tx_unlock_bh(netdev);
 		napi_enable(&fep->napi);
+		mutex_unlock(&fep->mutex);
 	}
 
 	return 0;
@@ -2324,6 +2346,8 @@ fec_probe(struct platform_device *pdev)
 	/* setup board info structure */
 	fep = netdev_priv(ndev);
 
+	mutex_init(&fep->mutex);
+
 #if !defined(CONFIG_M5272)
 	/* default enable pause frame auto negotiation */
 	if (pdev->id_entry &&
@@ -2515,7 +2539,9 @@ fec_suspend(struct device *dev)
 		netif_tx_lock_bh(ndev);
 		netif_device_detach(ndev);
 		netif_tx_unlock_bh(ndev);
+		mutex_lock(&fep->mutex);
 		fec_stop(ndev);
+		mutex_unlock(&fep->mutex);
 	}
 	rtnl_unlock();
 
@@ -2567,7 +2593,9 @@ fec_resume(struct device *dev)
 
 	rtnl_lock();
 	if (netif_running(ndev)) {
+		mutex_lock(&fep->mutex);
 		fec_restart(ndev);
+		mutex_unlock(&fep->mutex);
 		netif_tx_lock_bh(ndev);
 		netif_device_attach(ndev);
 		netif_tx_unlock_bh(ndev);
-- 
1.8.3.1
