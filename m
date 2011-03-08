From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 8 Mar 2011 20:19:23 +0000
Subject: [PATCH 2/2] macb: remove conditional clk handling
Message-ID: <mailman.168.1299757305.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AT91 now provides both "pclk" and "hclk" aliases for the the macb
device so we can use the same clk handling paths for both AT91 and
AVR32.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 drivers/net/macb.c |   27 +++------------------------
 1 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/net/macb.c b/drivers/net/macb.c
index bfd3601..8e6d8e3 100644
--- a/drivers/net/macb.c
+++ b/drivers/net/macb.c
@@ -246,9 +246,7 @@ static int macb_mii_init(struct macb *bp)
 	bp->mii_bus->parent = &bp->dev->dev;
 	pdata = bp->pdev->dev.platform_data;
 
-	if (pdata)
-		bp->mii_bus->phy_mask = pdata->phy_mask;
-
+	bp->mii_bus->phy_mask = pdata->phy_mask;
 	bp->mii_bus->irq = kmalloc(sizeof(int)*PHY_MAX_ADDR, GFP_KERNEL);
 	if (!bp->mii_bus->irq) {
 		err = -ENOMEM;
@@ -1138,28 +1136,19 @@ static int __init macb_probe(struct platform_device *pdev)
 
 	spin_lock_init(&bp->lock);
 
-#if defined(CONFIG_ARCH_AT91)
-	bp->pclk = clk_get(&pdev->dev, "macb_clk");
+	bp->pclk = clk_get(&pdev->dev, "pclk");
 	if (IS_ERR(bp->pclk)) {
 		dev_err(&pdev->dev, "failed to get macb_clk\n");
 		goto err_out_free_dev;
 	}
 	clk_enable(bp->pclk);
-#else
-	bp->pclk = clk_get(&pdev->dev, "pclk");
-	if (IS_ERR(bp->pclk)) {
-		dev_err(&pdev->dev, "failed to get pclk\n");
-		goto err_out_free_dev;
-	}
+
 	bp->hclk = clk_get(&pdev->dev, "hclk");
 	if (IS_ERR(bp->hclk)) {
 		dev_err(&pdev->dev, "failed to get hclk\n");
 		goto err_out_put_pclk;
 	}
-
-	clk_enable(bp->pclk);
 	clk_enable(bp->hclk);
-#endif
 
 	bp->regs = ioremap(regs->start, regs->end - regs->start + 1);
 	if (!bp->regs) {
@@ -1243,14 +1232,10 @@ err_out_free_irq:
 err_out_iounmap:
 	iounmap(bp->regs);
 err_out_disable_clocks:
-#ifndef CONFIG_ARCH_AT91
 	clk_disable(bp->hclk);
 	clk_put(bp->hclk);
-#endif
 	clk_disable(bp->pclk);
-#ifndef CONFIG_ARCH_AT91
 err_out_put_pclk:
-#endif
 	clk_put(bp->pclk);
 err_out_free_dev:
 	free_netdev(dev);
@@ -1276,10 +1261,8 @@ static int __exit macb_remove(struct platform_device *pdev)
 		unregister_netdev(dev);
 		free_irq(dev->irq, dev);
 		iounmap(bp->regs);
-#ifndef CONFIG_ARCH_AT91
 		clk_disable(bp->hclk);
 		clk_put(bp->hclk);
-#endif
 		clk_disable(bp->pclk);
 		clk_put(bp->pclk);
 		free_netdev(dev);
@@ -1297,9 +1280,7 @@ static int macb_suspend(struct platform_device *pdev, pm_message_t state)
 
 	netif_device_detach(netdev);
 
-#ifndef CONFIG_ARCH_AT91
 	clk_disable(bp->hclk);
-#endif
 	clk_disable(bp->pclk);
 
 	return 0;
@@ -1311,9 +1292,7 @@ static int macb_resume(struct platform_device *pdev)
 	struct macb *bp = netdev_priv(netdev);
 
 	clk_enable(bp->pclk);
-#ifndef CONFIG_ARCH_AT91
 	clk_enable(bp->hclk);
-#endif
 
 	netif_device_attach(netdev);
 
-- 
1.7.4
