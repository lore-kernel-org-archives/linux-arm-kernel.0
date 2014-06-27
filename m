From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 27 Jun 2014 16:21:21 +0100
Subject: [PATCH CFT 29/30] net: fec: remove useless status check in tx reap
 path
In-Reply-To: <20140627151542.GL32514@n2100.arm.linux.org.uk>
References: <20140627151542.GL32514@n2100.arm.linux.org.uk>
Message-ID: <E1X0Xxp-0001P6-FJ@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove a useless status check in the transmit reap path - we have
already checked that the BD_ENET_TX_READY bit is clear, and as the
hardware only ever clears this bit, there is no way this test can ever
be true.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 1e0eeb43ff6a..916b9ab97da4 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1133,9 +1133,6 @@ fec_enet_tx(struct net_device *ndev)
 			skb_tstamp_tx(skb, &shhwtstamps);
 		}
 
-		if (status & BD_ENET_TX_READY)
-			netdev_err(ndev, "HEY! Enet xmit interrupt and TX_READY\n");
-
 		/* Deferred means some collisions occurred during transmit,
 		 * but we eventually sent the packet OK.
 		 */
-- 
1.8.3.1
