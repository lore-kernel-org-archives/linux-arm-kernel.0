From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 20 Dec 2011 20:00:34 +0800
Subject: [PATCH 03/12] net: fec: add clk_prepare/clk_unprepare
In-Reply-To: <1324382443-4439-1-git-send-email-shawn.guo@linaro.org>
References: <1324382443-4439-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1324382443-4439-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Zhao <richard.zhao@linaro.org>

It's for migrating to generic clk framework API.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: David S. Miller <davem@davemloft.net>
---
 drivers/net/ethernet/freescale/fec.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.c b/drivers/net/ethernet/freescale/fec.c
index c136230..112af9b 100644
--- a/drivers/net/ethernet/freescale/fec.c
+++ b/drivers/net/ethernet/freescale/fec.c
@@ -1591,7 +1591,7 @@ fec_probe(struct platform_device *pdev)
 		ret = PTR_ERR(fep->clk);
 		goto failed_clk;
 	}
-	clk_enable(fep->clk);
+	clk_prepare_enable(fep->clk);
 
 	ret = fec_enet_init(ndev);
 	if (ret)
@@ -1614,7 +1614,7 @@ failed_register:
 	fec_enet_mii_remove(fep);
 failed_mii_init:
 failed_init:
-	clk_disable(fep->clk);
+	clk_disable_unprepare(fep->clk);
 	clk_put(fep->clk);
 failed_clk:
 	for (i = 0; i < FEC_IRQ_NUM; i++) {
@@ -1641,7 +1641,7 @@ fec_drv_remove(struct platform_device *pdev)
 
 	fec_stop(ndev);
 	fec_enet_mii_remove(fep);
-	clk_disable(fep->clk);
+	clk_disable_unprepare(fep->clk);
 	clk_put(fep->clk);
 	iounmap(fep->hwp);
 	unregister_netdev(ndev);
@@ -1667,7 +1667,7 @@ fec_suspend(struct device *dev)
 		fec_stop(ndev);
 		netif_device_detach(ndev);
 	}
-	clk_disable(fep->clk);
+	clk_disable_unprepare(fep->clk);
 
 	return 0;
 }
@@ -1678,7 +1678,7 @@ fec_resume(struct device *dev)
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct fec_enet_private *fep = netdev_priv(ndev);
 
-	clk_enable(fep->clk);
+	clk_prepare_enable(fep->clk);
 	if (netif_running(ndev)) {
 		fec_restart(ndev, fep->full_duplex);
 		netif_device_attach(ndev);
-- 
1.7.4.1
