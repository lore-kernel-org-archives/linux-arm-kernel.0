From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 08 Jul 2014 00:23:25 +0100
Subject: [PATCH A 11/12] net: fec: ensure fec_enet_free_buffers() properly
 cleans the rings
In-Reply-To: <20140707232148.GG21766@n2100.arm.linux.org.uk>
References: <20140707232148.GG21766@n2100.arm.linux.org.uk>
Message-ID: <E1X4IFp-0004xM-2c@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure that we do not double-free any allocations, and that any transmit
skbuffs are properly freed when we clean up the rings.

Acked-by: Fugang Duan <B38611@freescale.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 9c5570a3e32e..5499bd8ad0a5 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2079,8 +2079,13 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 	}
 
 	bdp = fep->tx_bd_base;
-	for (i = 0; i < fep->tx_ring_size; i++)
+	for (i = 0; i < fep->tx_ring_size; i++) {
 		kfree(fep->tx_bounce[i]);
+		fep->tx_bounce[i] = NULL;
+		skb = fep->tx_skbuff[i];
+		fep->tx_skbuff[i] = NULL;
+		dev_kfree_skb(skb);
+	}
 }
 
 static int fec_enet_alloc_buffers(struct net_device *ndev)
-- 
1.8.3.1
