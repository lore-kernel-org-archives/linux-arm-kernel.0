From: omar.ramirez@ti.com (Omar Ramirez Luna)
Date: Tue, 29 Mar 2011 11:20:18 -0600
Subject: [PATCH 4/5] OMAP4: l3: fix omap4_l3_probe error path
In-Reply-To: <1301419219-30547-1-git-send-email-omar.ramirez@ti.com>
References: <1301419219-30547-1-git-send-email-omar.ramirez@ti.com>
Message-ID: <1301419219-30547-5-git-send-email-omar.ramirez@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If kzalloc fails driver shouldn't continue with a NULL pointer.

Add missing free_irq and remove empty goto labels.

Safe to assume that if we reached the end point of execution
without errors, then return value is 0, so replacing instead
another goto.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/omap_l3_noc.c |   34 ++++++++++++++++------------------
 1 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_l3_noc.c b/arch/arm/mach-omap2/omap_l3_noc.c
index 82632c2..def3de8 100644
--- a/arch/arm/mach-omap2/omap_l3_noc.c
+++ b/arch/arm/mach-omap2/omap_l3_noc.c
@@ -132,49 +132,49 @@ static int __init omap4_l3_probe(struct platform_device *pdev)
 
 	l3 = kzalloc(sizeof(*l3), GFP_KERNEL);
 	if (!l3)
-		ret = -ENOMEM;
+		return -ENOMEM;
 
 	platform_set_drvdata(pdev, l3);
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "couldn't find resource 0\n");
 		ret = -ENODEV;
-		goto err1;
+		goto err0;
 	}
 
 	l3->l3_base[0] = ioremap(res->start, resource_size(res));
 	if (!(l3->l3_base[0])) {
 		dev_err(&pdev->dev, "ioremap failed\n");
 		ret = -ENOMEM;
-		goto err2;
+		goto err0;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	if (!res) {
 		dev_err(&pdev->dev, "couldn't find resource 1\n");
 		ret = -ENODEV;
-		goto err3;
+		goto err1;
 	}
 
 	l3->l3_base[1] = ioremap(res->start, resource_size(res));
 	if (!(l3->l3_base[1])) {
 		dev_err(&pdev->dev, "ioremap failed\n");
 		ret = -ENOMEM;
-		goto err4;
+		goto err1;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
 	if (!res) {
 		dev_err(&pdev->dev, "couldn't find resource 2\n");
 		ret = -ENODEV;
-		goto err5;
+		goto err2;
 	}
 
 	l3->l3_base[2] = ioremap(res->start, resource_size(res));
 	if (!(l3->l3_base[2])) {
 		dev_err(&pdev->dev, "ioremap failed\n");
 		ret = -ENOMEM;
-		goto err6;
+		goto err2;
 	}
 
 	/*
@@ -187,7 +187,7 @@ static int __init omap4_l3_probe(struct platform_device *pdev)
 	if (ret) {
 		pr_crit("L3: request_irq failed to register for 0x%x\n",
 					 OMAP44XX_IRQ_L3_DBG);
-		goto err7;
+		goto err3;
 	}
 	l3->debug_irq = irq;
 
@@ -198,24 +198,22 @@ static int __init omap4_l3_probe(struct platform_device *pdev)
 	if (ret) {
 		pr_crit("L3: request_irq failed to register for 0x%x\n",
 					 OMAP44XX_IRQ_L3_APP);
-		goto err8;
+		goto err4;
 	}
 	l3->app_irq = irq;
 
-	goto err0;
-err8:
-err7:
-	iounmap(l3->l3_base[2]);
-err6:
-err5:
-	iounmap(l3->l3_base[1]);
+	return 0;
+
 err4:
+	free_irq(l3->debug_irq, l3);
 err3:
-	iounmap(l3->l3_base[0]);
+	iounmap(l3->l3_base[2]);
 err2:
+	iounmap(l3->l3_base[1]);
 err1:
-	kfree(l3);
+	iounmap(l3->l3_base[0]);
 err0:
+	kfree(l3);
 	return ret;
 }
 
-- 
1.7.1
