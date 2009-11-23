From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 23 Nov 2009 12:12:22 -0500
Subject: arm/mach-pxa/ssp.c: use resource size()
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901EE5BCE@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use resource_size for {request/release}_mem_region and ioremap.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/arch/arm/mach-pxa/ssp.c b/arch/arm/mach-pxa/ssp.c
index 965e38c..a997ce3 100644
--- a/arch/arm/mach-pxa/ssp.c
+++ b/arch/arm/mach-pxa/ssp.c
@@ -368,8 +368,7 @@ static int __devinit ssp_probe(struct platform_device *pdev, int type)
 		goto err_free_clk;
 	}
 
-	res = request_mem_region(res->start, res->end - res->start + 1,
-			pdev->name);
+	res = request_mem_region(res->start, resource_size(res), pdev->name);
 	if (res == NULL) {
 		dev_err(&pdev->dev, "failed to request memory resource\n");
 		ret = -EBUSY;
@@ -378,7 +377,7 @@ static int __devinit ssp_probe(struct platform_device *pdev, int type)
 
 	ssp->phys_base = res->start;
 
-	ssp->mmio_base = ioremap(res->start, res->end - res->start + 1);
+	ssp->mmio_base = ioremap(res->start, resource_size(res));
 	if (ssp->mmio_base == NULL) {
 		dev_err(&pdev->dev, "failed to ioremap() registers\n");
 		ret = -ENODEV;
@@ -425,7 +424,7 @@ static int __devinit ssp_probe(struct platform_device *pdev, int type)
 err_free_io:
 	iounmap(ssp->mmio_base);
 err_free_mem:
-	release_mem_region(res->start, res->end - res->start + 1);
+	release_mem_region(res->start, resource_size(res));
 err_free_clk:
 	clk_put(ssp->clk);
 err_free:
@@ -445,7 +444,7 @@ static int __devexit ssp_remove(struct platform_device *pdev)
 	iounmap(ssp->mmio_base);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, res->end - res->start + 1);
+	release_mem_region(res->start, resource_size(res));
 
 	clk_put(ssp->clk);
  
