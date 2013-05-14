From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 14 May 2013 11:54:20 +0200
Subject: [PATCHv2] mv643xx_eth: fix NAPI weight being > 64
Message-ID: <1368525260-17556-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

3.10-rc1 issues the following warning:

netif_napi_add() called with weight 128 on device eth%d

This patch reduce the weight to 64, using NAPI_POLL_WEIGHT.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
v1->v2: Use NAPI_POLL_WEIGHT.

 drivers/net/ethernet/marvell/mv643xx_eth.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index d0afeea..8f63c36 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2745,7 +2745,7 @@ static int mv643xx_eth_probe(struct platform_device *pdev)
 
 	INIT_WORK(&mp->tx_timeout_task, tx_timeout_task);
 
-	netif_napi_add(dev, &mp->napi, mv643xx_eth_poll, 128);
+	netif_napi_add(dev, &mp->napi, mv643xx_eth_poll, NAPI_POLL_WEIGHT);
 
 	init_timer(&mp->rx_oom);
 	mp->rx_oom.data = (unsigned long)mp;
-- 
1.7.10.4
