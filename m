From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:38:21 +0100
Subject: [PATCH 087/222] net:fec: only run a restart or stop if the device is
 present and running
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeST-0007J0-KX@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid calling fec_restart() or fec_stop() while the device is down
or not present (iow suspended.)

Although the ndo_timeout method will only be called if the device is
present and running, we defer this to a work queue.  The work queue
can run independently, and so needs to repeat these checks to ensure
that a restart doesn't occur after the device has been taken down or
detached for suspend.  In this case, we call fec_restart() in the
resume path, so nothing is lost.

For fec_set_features, we add a call to fec_restart() in fec_enet_open()
to ensure that the hardware is appropriate programmed when the interface
is opened.  fec_set_features() call should not occur while we're
suspended, so we don't have to worry about that case.

The adjust_link needs similar treatment - this also is called from a
work queue, which may be run independently after we have taken the
device down and detached it.  In this case, we just mark the link
down and take no further action.  We will reset things appropriately
once the device is up and running again, at which point we will receive
another adjust_link callback.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index f65c1f1d8770..723a645dfeb3 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -764,12 +764,15 @@ static void fec_enet_work(struct work_struct *work)
 		container_of(work,
 			     struct fec_enet_private,
 			     delay_work.delay_work.work);
+	struct net_device *ndev = fep->netdev;
 
 	if (fep->delay_work.timeout) {
 		fep->delay_work.timeout = false;
 		rtnl_lock();
-		fec_restart(fep->netdev, fep->full_duplex);
-		netif_wake_queue(fep->netdev);
+		if (netif_device_present(ndev) || netif_running(ndev)) {
+			fec_restart(ndev, fep->full_duplex);
+			netif_wake_queue(ndev);
+		}
 		rtnl_unlock();
 	}
 
@@ -1200,7 +1203,14 @@ static void fec_enet_adjust_link(struct net_device *ndev)
 		return;
 	}
 
-	if (phy_dev->link) {
+	/*
+	 * If the netdev is down, or is going down, we're not interested
+	 * in link state events, so just mark our idea of the link as down
+	 * and ignore the event.
+	 */
+	if (!netif_running(ndev) || !netif_device_present(ndev)) {
+		fep->link = 0;
+	} else if (phy_dev->link) {
 		if (!fep->link) {
 			fep->link = phy_dev->link;
 			status_change = 1;
@@ -1833,6 +1843,7 @@ fec_enet_open(struct net_device *ndev)
 		return ret;
 	}
 
+	fec_restart(ndev, fep->full_duplex);
 	napi_enable(&fep->napi);
 	phy_start(fep->phy_dev);
 	netif_start_queue(ndev);
@@ -1997,8 +2008,6 @@ static int fec_set_features(struct net_device *netdev,
 			fec_stop(netdev);
 			fec_restart(netdev, fep->phy_dev->duplex);
 			netif_wake_queue(netdev);
-		} else {
-			fec_restart(netdev, fep->phy_dev->duplex);
 		}
 	}
 
-- 
1.8.3.1
