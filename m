From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 08 Jul 2014 12:40:28 +0100
Subject: [PATCH B 07/10] net: fec: quiesce packet processing before stopping
 device in fec_set_features()
In-Reply-To: <20140708113911.GH21766@n2100.arm.linux.org.uk>
References: <20140708113911.GH21766@n2100.arm.linux.org.uk>
Message-ID: <E1X4Tl6-0005oJ-AD@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fec_set_features() calls fec_stop() to stop the transmit ring while the
transmit queue is still active.  This can lead to the transmit ring
being restarted by an intervening packet queued for transmission, or
by the tx quirk timer expiring.

Fix this by disabling NAPI (which ensures that the NAPI handlers are
not running), and then take the transmit lock while we stop and
restart the adapter (which prevents new packets being queued).

Acked-by: Fugang Duan <B38611@freescale.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index fc9f6f465e7a..2945cf6e65cf 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2362,9 +2362,9 @@ static int fec_set_features(struct net_device *netdev,
 			fep->csum_flags &= ~FLAG_RX_CSUM_ENABLED;
 
 		if (netif_running(netdev)) {
-			fec_stop(netdev);
 			napi_disable(&fep->napi);
 			netif_tx_lock_bh(netdev);
+			fec_stop(netdev);
 			fec_restart(netdev, fep->phy_dev->duplex);
 			netif_wake_queue(netdev);
 			netif_tx_unlock_bh(netdev);
-- 
1.8.3.1
