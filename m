From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 6 Jun 2011 13:44:57 -0700
Subject: [PATCH] plat-mxc/pwm.c: use resource_size()
Message-ID: <201106061344.58017.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Sascha Hauer <kernel@pengutronix.de>

---

diff --git a/arch/arm/plat-mxc/pwm.c b/arch/arm/plat-mxc/pwm.c
index 7a61ef8..761c3c9 100644
--- a/arch/arm/plat-mxc/pwm.c
+++ b/arch/arm/plat-mxc/pwm.c
@@ -214,14 +214,14 @@ static int __devinit mxc_pwm_probe(struct platform_device *pdev)
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
@@ -236,7 +236,7 @@ static int __devinit mxc_pwm_probe(struct platform_device *pdev)
 	return 0;
 
 err_free_mem:
-	release_mem_region(r->start, r->end - r->start + 1);
+	release_mem_region(r->start, resource_size(r));
 err_free_clk:
 	clk_put(pwm->clk);
 err_free:
@@ -260,7 +260,7 @@ static int __devexit mxc_pwm_remove(struct platform_device *pdev)
 	iounmap(pwm->mmio_base);
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(r->start, r->end - r->start + 1);
+	release_mem_region(r->start, resource_size(r));
 
 	clk_put(pwm->clk);
 
