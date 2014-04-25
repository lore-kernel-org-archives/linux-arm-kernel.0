From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:39:17 +0100
Subject: [PATCH 098/222] net:fec: better implementation of iMX6 ERR006358 quirk
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeTN-0007Jk-RT@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using a (delayed) workqueue for ERR006358 is not correct - a work queue
is a single-trigger device.  Once the work queue has been scheduled, it
can't be re-scheduled until it has been run.  This can cause problems -
with an appropriate packet timing, we can end up with packets queued,
but not sent by the hardware, resulting in the transmit timeout firing.

Re-implement this as per the workaround detailed in the ERR006358
documentation - if there are packets waiting to be sent when we service
the transmit ring, and we see that the transmitter is not running,
kick the transmitter to run the pending entries in the ring.

Testing here with a 10Mbit half duplex link sees the resulting iperf
TCP bandwidth increase from between 1 to 2Mbps to between 8 to 9Mbps.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec.h      |  1 -
 drivers/net/ethernet/freescale/fec_main.c | 20 +++++++-------------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 88ef53b18ae7..d124a19e3fe8 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -259,7 +259,6 @@ struct bufdesc_ex {
 struct fec_enet_delayed_work {
 	struct delayed_work delay_work;
 	bool timeout;
-	bool trig_tx;
 };
 
 /* The FEC buffer descriptors track the ring buffers.  The rx_bd_base and
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 9d2023b3e5ce..7e48d1960bf0 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -344,7 +344,7 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	const struct platform_device_id *id_entry =
 				platform_get_device_id(fep->pdev);
-	struct bufdesc *bdp, *bdp_pre;
+	struct bufdesc *bdp;
 	void *bufaddr;
 	unsigned short	status;
 	unsigned int index;
@@ -450,13 +450,6 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 			| BD_ENET_TX_LAST | BD_ENET_TX_TC);
 	bdp->cbd_sc = status;
 
-	bdp_pre = fec_enet_get_prevdesc(bdp, fep);
-	if ((id_entry->driver_data & FEC_QUIRK_ERR006358) &&
-	    !(bdp_pre->cbd_sc & BD_ENET_TX_READY)) {
-		fep->delay_work.trig_tx = true;
-		schedule_delayed_work(&(fep->delay_work.delay_work),
-					msecs_to_jiffies(1));
-	}
 
 	/* If this was the last BD in the ring, start at the beginning again. */
 	bdp = fec_enet_get_nextdesc(bdp, fep);
@@ -771,11 +764,6 @@ static void fec_enet_work(struct work_struct *work)
 		}
 		rtnl_unlock();
 	}
-
-	if (fep->delay_work.trig_tx) {
-		fep->delay_work.trig_tx = false;
-		writel(0, fep->hwp + FEC_X_DES_ACTIVE);
-	}
 }
 
 static void
@@ -868,6 +856,12 @@ fec_enet_tx(struct net_device *ndev)
 				netif_wake_queue(ndev);
 		}
 	}
+
+	/* ERR006538: Keep the transmitter going */
+	if (fep->dirty_tx != fep->cur_tx &&
+	    readl(fep->hwp + FEC_X_DES_ACTIVE) == 0)
+		writel(0, fep->hwp + FEC_X_DES_ACTIVE);
+
 	return;
 }
 
-- 
1.8.3.1
