From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:38:57 +0100
Subject: [PATCH 094/222] net:fec: fix ethtool set_pauseparam duplex bug
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeT3-0007JT-Cr@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setting the pause parameters causes a running network interface to be
restarted.  However, the restart forces the FEC into half-duplex mode,
whether or not the remote end is in half-duplex mode.  Misconfigured
duplex mode is a known source of problems on a link.

Fix this by always preserving the duplex mode on configuration changes.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 6156d423a6a9..c79d604372a4 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1572,7 +1572,7 @@ static int fec_enet_set_pauseparam(struct net_device *ndev,
 	if (netif_running(ndev)) {
 		napi_disable(&fep->napi);
 		netif_tx_lock_bh(ndev);
-		fec_restart(ndev, 0);
+		fec_restart(ndev, fep->full_duplex);
 		netif_wake_queue(ndev);
 		netif_tx_unlock_bh(ndev);
 		napi_enable(&fep->napi);
-- 
1.8.3.1
