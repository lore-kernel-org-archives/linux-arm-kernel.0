From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Apr 2012 15:45:20 +0200
Subject: [PATCH 07/40] net fec: do not depend on grouped clocks
In-Reply-To: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1334065553-7565-8-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the current i.MX clock support groups together unrelated clocks
to a single clock which is then used by the driver. This can't
be accomplished with the generic clock framework so we instead
request the individual clocks in the driver. For i.MX there are
generally three different clocks:

ipg: bus clock (needed to access registers)
ahb: dma relevant clock, sometimes referred to as hclk in the datasheet
per: bit clock, pixel clock

This patch changes the driver to request the individual clocks.
Currently all clk_get will get the same clock until the SoCs
are converted to the generic clock framework

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec.c |   35 ++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.c b/drivers/net/ethernet/freescale/fec.c
index a12b3f5..b249463 100644
--- a/drivers/net/ethernet/freescale/fec.c
+++ b/drivers/net/ethernet/freescale/fec.c
@@ -206,7 +206,8 @@ struct fec_enet_private {
 
 	struct net_device *netdev;
 
-	struct clk *clk;
+	struct clk *clk_ipg;
+	struct clk *clk_ahb;
 
 	/* The saved address of a sent-in-place packet/buffer, for skfree(). */
 	unsigned char *tx_bounce[TX_RING_SIZE];
@@ -1064,7 +1065,7 @@ static int fec_enet_mii_init(struct platform_device *pdev)
 	 * Reference Manual has an error on this, and gets fixed on i.MX6Q
 	 * document.
 	 */
-	fep->phy_speed = DIV_ROUND_UP(clk_get_rate(fep->clk), 5000000);
+	fep->phy_speed = DIV_ROUND_UP(clk_get_rate(fep->clk_ahb), 5000000);
 	if (id_entry->driver_data & FEC_QUIRK_ENET_MAC)
 		fep->phy_speed--;
 	fep->phy_speed <<= 1;
@@ -1609,12 +1610,20 @@ fec_probe(struct platform_device *pdev)
 		}
 	}
 
-	fep->clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(fep->clk)) {
-		ret = PTR_ERR(fep->clk);
+	fep->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(fep->clk_ipg)) {
+		ret = PTR_ERR(fep->clk_ipg);
 		goto failed_clk;
 	}
-	clk_prepare_enable(fep->clk);
+
+	fep->clk_ahb = devm_clk_get(&pdev->dev, "ahb");
+	if (IS_ERR(fep->clk_ahb)) {
+		ret = PTR_ERR(fep->clk_ahb);
+		goto failed_clk;
+	}
+
+	clk_prepare_enable(fep->clk_ahb);
+	clk_prepare_enable(fep->clk_ipg);
 
 	ret = fec_enet_init(ndev);
 	if (ret)
@@ -1637,8 +1646,8 @@ failed_register:
 	fec_enet_mii_remove(fep);
 failed_mii_init:
 failed_init:
-	clk_disable_unprepare(fep->clk);
-	clk_put(fep->clk);
+	clk_disable_unprepare(fep->clk_ahb);
+	clk_disable_unprepare(fep->clk_ipg);
 failed_clk:
 	for (i = 0; i < FEC_IRQ_NUM; i++) {
 		irq = platform_get_irq(pdev, i);
@@ -1670,8 +1679,8 @@ fec_drv_remove(struct platform_device *pdev)
 		if (irq > 0)
 			free_irq(irq, ndev);
 	}
-	clk_disable_unprepare(fep->clk);
-	clk_put(fep->clk);
+	clk_disable_unprepare(fep->clk_ahb);
+	clk_disable_unprepare(fep->clk_ipg);
 	iounmap(fep->hwp);
 	free_netdev(ndev);
 
@@ -1695,7 +1704,8 @@ fec_suspend(struct device *dev)
 		fec_stop(ndev);
 		netif_device_detach(ndev);
 	}
-	clk_disable_unprepare(fep->clk);
+	clk_disable_unprepare(fep->clk_ahb);
+	clk_disable_unprepare(fep->clk_ipg);
 
 	return 0;
 }
@@ -1706,7 +1716,8 @@ fec_resume(struct device *dev)
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct fec_enet_private *fep = netdev_priv(ndev);
 
-	clk_prepare_enable(fep->clk);
+	clk_prepare_enable(fep->clk_ahb);
+	clk_prepare_enable(fep->clk_ipg);
 	if (netif_running(ndev)) {
 		fec_restart(ndev, fep->full_duplex);
 		netif_device_attach(ndev);
-- 
1.7.9.5
