From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Thu, 15 Nov 2012 00:37:57 +0530
Subject: [PATCH V5 4/7] net: cpsw: halt network stack before halting the
 device during suspend
In-Reply-To: <1352920080-6179-1-git-send-email-mugunthanvnm@ti.com>
References: <1352920080-6179-1-git-send-email-mugunthanvnm@ti.com>
Message-ID: <1352920080-6179-5-git-send-email-mugunthanvnm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move network stack halt APIs before halting the hardware to ensure no
packets are queued to hardware during closing the device during
suspend sequence.

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
Acked-by: Richard Cochran <richardcochran@gmail.com>
---
 drivers/net/ethernet/ti/cpsw.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 0da9c75..02c2477 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -698,12 +698,12 @@ static int cpsw_ndo_stop(struct net_device *ndev)
 	struct cpsw_priv *priv = netdev_priv(ndev);
 
 	cpsw_info(priv, ifdown, "shutting down cpsw device\n");
-	cpsw_intr_disable(priv);
-	cpdma_ctlr_int_ctrl(priv->dma, false);
-	cpdma_ctlr_stop(priv->dma);
 	netif_stop_queue(priv->ndev);
 	napi_disable(&priv->napi);
 	netif_carrier_off(priv->ndev);
+	cpsw_intr_disable(priv);
+	cpdma_ctlr_int_ctrl(priv->dma, false);
+	cpdma_ctlr_stop(priv->dma);
 	cpsw_ale_stop(priv->ale);
 	for_each_slave(priv, cpsw_slave_stop, priv);
 	pm_runtime_put_sync(&priv->pdev->dev);
-- 
1.7.0.4
