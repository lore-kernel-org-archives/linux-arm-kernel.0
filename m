From: firogm@gmail.com (Firo Yang)
Date: Mon,  8 Jun 2015 17:45:01 +0800
Subject: [PATCH v3] ARM: pxa: ssp: remove unnessary free for devm_xxx
Message-ID: <1433756701-32194-1-git-send-email-firogm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A Coccinelle warning.
It's not necessary to free memory allocated with devm_xxx
and using these free functions maybe lead to a double free that
will corrupt the resource subsys. So, I just remove them.

Signed-off-by: Firo Yang <firogm@gmail.com>
---
In "[PATCH] ARM: pxa: ssp: remove unnessary free for devm_xxx", 
I forgot to remove an unused variable struct resource *res.

 arch/arm/plat-pxa/ssp.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index ad9529c..2b92a3b 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -232,25 +232,16 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 
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
