From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 23 Nov 2009 12:24:32 -0500
Subject: arm/plat-pxa/pwm.c: use resource_size()
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901EE5BD7@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use resource_size for {request/release}_mem_region and ioremap.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/arch/arm/plat-pxa/pwm.c b/arch/arm/plat-pxa/pwm.c
index a9eabdc..51dc5c8 100644
--- a/arch/arm/plat-pxa/pwm.c
+++ b/arch/arm/plat-pxa/pwm.c
@@ -204,14 +204,14 @@ static int __devinit pwm_probe(struct platform_device *pdev)
 		goto err_free_clk;
 	}
 
-	r = request_mem_region(r->start, r->end - r->start + 1, pdev->name);
+	r = request_mem_region(r->start, resource_size(r), pdev->name);
 	if (r == NULL) {
 		dev_err(&pdev->dev, "failed to request memory resource\n");
 		ret = -EBUSY;
 		goto err_free_clk;
 	}
 
-	pwm->mmio_base = ioremap(r->start, r->end - r->start + 1);
+	pwm->mmio_base = ioremap(r->start, resource_size(r));
 	if (pwm->mmio_base == NULL) {
 		dev_err(&pdev->dev, "failed to ioremap() registers\n");
 		ret = -ENODEV;
@@ -241,7 +241,7 @@ static int __devinit pwm_probe(struct platform_device *pdev)
 	return 0;
 
 err_free_mem:
-	release_mem_region(r->start, r->end - r->start + 1);
+	release_mem_region(r->start, resource_size(r));
 err_free_clk:
 	clk_put(pwm->clk);
 err_free:
@@ -271,7 +271,7 @@ static int __devexit pwm_remove(struct platform_device *pdev)
 	iounmap(pwm->mmio_base);
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(r->start, r->end - r->start + 1);
+	release_mem_region(r->start, resource_size(r));
 
 	clk_put(pwm->clk);
 	kfree(pwm); 
