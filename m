From: firogm@gmail.com (Firo Yang)
Date: Mon,  8 Jun 2015 16:06:43 +0800
Subject: [PATCH v2] ARM: pxa: ssp: remove unnessary free for devm_xxx
Message-ID: <1433750803-26439-1-git-send-email-firogm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A Coccinelle warning.
It's not necessary to free memory allocated with devm_xxx
and using these free functions maybe lead to a double free that
will corrupt the resource subsys. So, I just remove them.

By the way, I replace devm_request_mem_region and devm_ioremap with
devm_ioremap_resource as Julia's suggestion.

Signed-off-by: Firo Yang <firogm@gmail.com>
---
 arch/arm/plat-pxa/ssp.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index ad9529c..a278ea0 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -182,21 +182,12 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	res = devm_request_mem_region(dev, res->start, resource_size(res),
-				      pdev->name);
-	if (res == NULL) {
-		dev_err(dev, "failed to request memory resource\n");
-		return -EBUSY;
-	}
+	ssp->mmio_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(ssp->mmio_base))
+		return PTR_ERR(ssp->mmio_base);
 
 	ssp->phys_base = res->start;
 
-	ssp->mmio_base = devm_ioremap(dev, res->start, resource_size(res));
-	if (ssp->mmio_base == NULL) {
-		dev_err(dev, "failed to ioremap() registers\n");
-		return -ENODEV;
-	}
-
 	ssp->irq = platform_get_irq(pdev, 0);
 	if (ssp->irq < 0) {
 		dev_err(dev, "no IRQ resource defined\n");
@@ -232,25 +223,16 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 
 static int pxa_ssp_remove(struct platform_device *pdev)
 {
-	struct resource *res;
 	struct ssp_device *ssp;
 
 	ssp = platform_get_drvdata(pdev);
 	if (ssp == NULL)
 		return -ENODEV;
 
-	iounmap(ssp->mmio_base);
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, resource_size(res));
-
-	clk_put(ssp->clk);
-
 	mutex_lock(&ssp_lock);
 	list_del(&ssp->node);
 	mutex_unlock(&ssp_lock);
 
-	kfree(ssp);
 	return 0;
 }
 
-- 
2.4.2
