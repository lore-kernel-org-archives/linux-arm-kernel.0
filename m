From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Apr 2013 15:21:06 +0900
Subject: [PATCH] irqchip: irqc: Add runtime PM support
Message-ID: <1365056466-23710-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was tested using the SMSC LAN on the APE6EVM board.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/irqchip/irq-renesas-irqc.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index 927bff3..649cd69 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -19,6 +19,7 @@
 
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
@@ -181,6 +182,9 @@ static int irqc_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
+
 	/* allow any number of IRQs between 1 and IRQC_IRQ_MAX */
 	for (k = 0; k < IRQC_IRQ_MAX; k++) {
 		irq = platform_get_resource(pdev, IORESOURCE_IRQ, k);
@@ -255,6 +259,8 @@ err3:
 err2:
 	iounmap(p->iomem);
 err1:
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	kfree(p);
 err0:
 	return ret;
@@ -270,6 +276,8 @@ static int irqc_remove(struct platform_device *pdev)
 
 	irq_domain_remove(p->irq_domain);
 	iounmap(p->iomem);
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	kfree(p);
 	return 0;
 }
-- 
1.7.10.4
