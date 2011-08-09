From: jamie@jamieiles.com (Jamie Iles)
Date: Tue,  9 Aug 2011 10:16:44 +0100
Subject: [PATCHv3 2/9] macb: remove conditional clk handling
In-Reply-To: <1312881411-2376-1-git-send-email-jamie@jamieiles.com>
References: <1312881411-2376-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1312881411-2376-3-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AT91 now provides both "pclk" and "hclk" aliases for the the macb
device so we can use the same clk handling paths for both AT91 and
AVR32.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/net/macb.c |   23 ++---------------------
 1 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/net/macb.c b/drivers/net/macb.c
index dc4e305..6e57567 100644
--- a/drivers/net/macb.c
+++ b/drivers/net/macb.c
@@ -1152,28 +1152,19 @@ static int __init macb_probe(struct platform_device *pdev)
 
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
 
 	bp->regs = ioremap(regs->start, resource_size(regs));
 	if (!bp->regs) {
@@ -1256,14 +1247,10 @@ err_out_free_irq:
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
@@ -1289,10 +1276,8 @@ static int __exit macb_remove(struct platform_device *pdev)
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
@@ -1310,9 +1295,7 @@ static int macb_suspend(struct platform_device *pdev, pm_message_t state)
 
 	netif_device_detach(netdev);
 
-#ifndef CONFIG_ARCH_AT91
 	clk_disable(bp->hclk);
-#endif
 	clk_disable(bp->pclk);
 
 	return 0;
@@ -1324,9 +1307,7 @@ static int macb_resume(struct platform_device *pdev)
 	struct macb *bp = netdev_priv(netdev);
 
 	clk_enable(bp->pclk);
-#ifndef CONFIG_ARCH_AT91
 	clk_enable(bp->hclk);
-#endif
 
 	netif_device_attach(netdev);
 
-- 
1.7.4.1
