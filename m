From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 13 Oct 2013 21:17:01 +0200
Subject: [PATCH] net/ethernet: cpsw: Bugfix interrupts before enabling napi
Message-ID: <1381691821-25498-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If interrupts happen before napi_enable was called, the driver will not
work as expected. Network transmissions are impossible in this state.
This bug can be reproduced easily by restarting the network interface in
a loop. After some time any network transmissions on the network
interface will fail.

This patch fixes the bug by enabling napi before enabling the network
interface interrupts.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/net/ethernet/ti/cpsw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 804846e..fccd9d4 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1169,9 +1169,9 @@ static int cpsw_ndo_open(struct net_device *ndev)
 		}
 	}
 
+	napi_enable(&priv->napi);
 	cpdma_ctlr_start(priv->dma);
 	cpsw_intr_enable(priv);
-	napi_enable(&priv->napi);
 	cpdma_ctlr_eoi(priv->dma, CPDMA_EOI_RX);
 	cpdma_ctlr_eoi(priv->dma, CPDMA_EOI_TX);
 
-- 
1.8.4.rc3
