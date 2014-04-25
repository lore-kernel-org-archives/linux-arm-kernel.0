From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:38:26 +0100
Subject: [PATCH 088/222] net:fec: move calls to quiesce/resume packet
 processing out of fec_restart()
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeSY-0007J4-O8@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the calls to quiesce and resume packet processing out of
fec_restart() to its call sites.  This is the first step in a two stage
clean up of this code, where we just move the calls out of fec_restart()
without changing them.  Not everywhere needs to issue these calls, and
not everywhere needs all of these calls to be issued.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 64 ++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 723a645dfeb3..1da67d4fdd0a 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -515,9 +515,10 @@ static void fec_enet_bd_init(struct net_device *dev)
 	fep->dirty_tx = bdp;
 }
 
-/* This function is called to start or restart the FEC during a link
- * change.  This only happens when switching between half and full
- * duplex.
+/*
+ * This function is called to start or restart the FEC during a link
+ * change, transmit timeout, or to reconfigure the FEC.  The network
+ * packet processing for this device must be stopped before this call.
  */
 static void
 fec_restart(struct net_device *ndev, int duplex)
@@ -531,13 +532,6 @@ fec_restart(struct net_device *ndev, int duplex)
 	u32 rcntl = OPT_FRAME_SIZE | 0x04;
 	u32 ecntl = 0x2; /* ETHEREN */
 
-	if (netif_running(ndev)) {
-		netif_device_detach(ndev);
-		napi_disable(&fep->napi);
-		netif_tx_disable(ndev);
-		netif_tx_lock_bh(ndev);
-	}
-
 	/* Whack a reset.  We should wait for this. */
 	writel(1, fep->hwp + FEC_ECNTRL);
 	udelay(10);
@@ -706,13 +700,6 @@ fec_restart(struct net_device *ndev, int duplex)
 
 	/* Enable interrupts we wish to service */
 	writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
-
-	if (netif_running(ndev)) {
-		netif_tx_unlock_bh(ndev);
-		netif_wake_queue(ndev);
-		napi_enable(&fep->napi);
-		netif_device_attach(ndev);
-	}
 }
 
 static void
@@ -770,8 +757,15 @@ static void fec_enet_work(struct work_struct *work)
 		fep->delay_work.timeout = false;
 		rtnl_lock();
 		if (netif_device_present(ndev) || netif_running(ndev)) {
+			netif_device_detach(ndev);
+			napi_disable(&fep->napi);
+			netif_tx_disable(ndev);
+			netif_tx_lock_bh(ndev);
 			fec_restart(ndev, fep->full_duplex);
+			netif_tx_unlock_bh(ndev);
 			netif_wake_queue(ndev);
+			napi_enable(&fep->napi);
+			netif_device_attach(ndev);
 		}
 		rtnl_unlock();
 	}
@@ -1225,8 +1219,17 @@ static void fec_enet_adjust_link(struct net_device *ndev)
 		}
 
 		/* if any of the above changed restart the FEC */
-		if (status_change)
+		if (status_change) {
+			netif_device_detach(ndev);
+			napi_disable(&fep->napi);
+			netif_tx_disable(ndev);
+			netif_tx_lock_bh(ndev);
 			fec_restart(ndev, phy_dev->duplex);
+			netif_tx_unlock_bh(ndev);
+			netif_wake_queue(ndev);
+			napi_enable(&fep->napi);
+			netif_device_attach(ndev);
+		}
 	} else {
 		if (fep->link) {
 			fec_stop(ndev);
@@ -1568,8 +1571,17 @@ static int fec_enet_set_pauseparam(struct net_device *ndev,
 			fec_stop(ndev);
 		phy_start_aneg(fep->phy_dev);
 	}
-	if (netif_running(ndev))
+	if (netif_running(ndev)) {
+		netif_device_detach(ndev);
+		napi_disable(&fep->napi);
+		netif_tx_disable(ndev);
+		netif_tx_lock_bh(ndev);
 		fec_restart(ndev, 0);
+		netif_tx_unlock_bh(ndev);
+		netif_wake_queue(ndev);
+		napi_enable(&fep->napi);
+		netif_device_attach(ndev);
+	}
 
 	return 0;
 }
@@ -2006,8 +2018,15 @@ static int fec_set_features(struct net_device *netdev,
 
 		if (netif_running(netdev)) {
 			fec_stop(netdev);
+			netif_device_detach(netdev);
+			napi_disable(&fep->napi);
+			netif_tx_disable(netdev);
+			netif_tx_lock_bh(netdev);
 			fec_restart(netdev, fep->phy_dev->duplex);
+			netif_tx_unlock_bh(netdev);
 			netif_wake_queue(netdev);
+			napi_enable(&fep->napi);
+			netif_device_attach(netdev);
 		}
 	}
 
@@ -2400,7 +2419,14 @@ fec_resume(struct device *dev)
 
 	rtnl_lock();
 	if (netif_running(ndev)) {
+		netif_device_detach(ndev);
+		napi_disable(&fep->napi);
+		netif_tx_disable(ndev);
+		netif_tx_lock_bh(ndev);
 		fec_restart(ndev, fep->full_duplex);
+		netif_tx_unlock_bh(ndev);
+		netif_wake_queue(ndev);
+		napi_enable(&fep->napi);
 		netif_device_attach(ndev);
 		phy_start(fep->phy_dev);
 	}
-- 
1.8.3.1
