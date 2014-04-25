From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:38:42 +0100
Subject: [PATCH 091/222] net:fec: quiesce packet processing before stopping
 device in fec_set_features()
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeSo-0007JH-2U@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fec_set_features() calls fec_stop() to stop the transmit ring while the
transmit queue is still active.  This can lead to the transmit ring
being restarted by an intervening packet queued for transmission, or
by the tx quirk timer expiring.  Fix this by moving the call to
fec_enet_netif_quiesce() before fec_stop().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 927c283e43b1..789678c6f6d4 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2009,9 +2009,9 @@ static int fec_set_features(struct net_device *netdev,
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
