From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:39:43 +0100
Subject: [PATCH 103/222] net:fec: remove useless status check in tx reap path
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeTn-0007K5-CX@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove a useless status check in the transmit reap path - we have
already checked that the DB_ENET_TX_READY bit is clear, so there is
no way this test can ever be true.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 51b00c77bf00..c7fe6eb8be12 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -827,9 +827,6 @@ fec_enet_tx(struct net_device *ndev)
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
