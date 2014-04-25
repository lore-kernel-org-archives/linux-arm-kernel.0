From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:39:22 +0100
Subject: [PATCH 099/222] net:fec: avoid hitting transmitter if it is still
 running
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeTS-0007Jo-Us@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 7e48d1960bf0..bf186cc54891 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -462,7 +462,8 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		netif_stop_queue(ndev);
 
 	/* Trigger transmission start */
-	writel(0, fep->hwp + FEC_X_DES_ACTIVE);
+	if (readl(fep->hwp + FEC_X_DES_ACTIVE) == 0)
+		writel(0, fep->hwp + FEC_X_DES_ACTIVE);
 
 	return NETDEV_TX_OK;
 }
-- 
1.8.3.1
