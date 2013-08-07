From: zonque@gmail.com (Daniel Mack)
Date: Wed,  7 Aug 2013 17:33:54 +0200
Subject: [PATCH 05/20] ARM: pxa: ssp: use devm_ functions
In-Reply-To: <1375889649-14638-1-git-send-email-zonque@gmail.com>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
Message-ID: <1375889649-14638-6-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_ functions to allocate memory, ioremap, clk_get etc to clean up
the error unwind path.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/plat-pxa/ssp.c | 40 ++++++++++++----------------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index 7628e85..29fe314 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -95,20 +95,17 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct ssp_device *ssp;
 	struct device *dev = &pdev->dev;
-	int ret = 0;
 
-	ssp = kzalloc(sizeof(struct ssp_device), GFP_KERNEL);
+	ssp = devm_kzalloc(dev, sizeof(struct ssp_device), GFP_KERNEL);
 	if (ssp == NULL) {
 		dev_err(dev, "failed to allocate memory");
 		return -ENOMEM;
 	}
 	ssp->pdev = pdev;
 
-	ssp->clk = clk_get(dev, NULL);
-	if (IS_ERR(ssp->clk)) {
-		ret = PTR_ERR(ssp->clk);
-		goto err_free;
-	}
+	ssp->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(ssp->clk))
+		return PTR_ERR(ssp->clk);
 
 	if (dev->of_node) {
 		struct of_phandle_args dma_spec;
@@ -150,32 +147,28 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res == NULL) {
 		dev_err(dev, "no memory resource defined\n");
-		ret = -ENODEV;
-		goto err_free_clk;
+		return -ENODEV;
 	}
 
-	res = request_mem_region(res->start, resource_size(res),
-			pdev->name);
+	res = devm_request_mem_region(dev, res->start, resource_size(res),
+				      pdev->name);
 	if (res == NULL) {
 		dev_err(dev, "failed to request memory resource\n");
-		ret = -EBUSY;
-		goto err_free_clk;
+		return -EBUSY;
 	}
 
 	ssp->phys_base = res->start;
 
-	ssp->mmio_base = ioremap(res->start, resource_size(res));
+	ssp->mmio_base = devm_ioremap(dev, res->start, resource_size(res));
 	if (ssp->mmio_base == NULL) {
 		dev_err(dev, "failed to ioremap() registers\n");
-		ret = -ENODEV;
-		goto err_free_mem;
+		return -ENODEV;
 	}
 
 	ssp->irq = platform_get_irq(pdev, 0);
 	if (ssp->irq < 0) {
 		dev_err(dev, "no IRQ resource defined\n");
-		ret = -ENODEV;
-		goto err_free_io;
+		return -ENODEV;
 	}
 
 	if (dev->of_node) {
@@ -202,17 +195,8 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 	mutex_unlock(&ssp_lock);
 
 	platform_set_drvdata(pdev, ssp);
-	return 0;
 
-err_free_io:
-	iounmap(ssp->mmio_base);
-err_free_mem:
-	release_mem_region(res->start, resource_size(res));
-err_free_clk:
-	clk_put(ssp->clk);
-err_free:
-	kfree(ssp);
-	return ret;
+	return 0;
 }
 
 static int pxa_ssp_remove(struct platform_device *pdev)
-- 
1.8.3.1
