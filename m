From: amitoj1606@gmail.com (Amitoj Kaur Chawla)
Date: Mon, 13 Jun 2016 20:23:07 +0530
Subject: [PATCH 1/2] ARM: pxa: ssp: Drop unnecessary freeing functions
In-Reply-To: <cover.1465827542.git.amitoj1606@gmail.com>
References: <cover.1465827542.git.amitoj1606@gmail.com>
Message-ID: <da474c948aefa6ff7ef13f8e1250055d572ffbac.1465827542.git.amitoj1606@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop clk_put, kfree, release_mem_region and iounmap for
devm_ allocated data in the remove function of the driver.

Some of these changes were made with the help of the following
Coccinelle semantic patch:
@r@
expression x;
@@

(
 x = devm_kzalloc(...)
|
 x = devm_request_irq(...)
|
 x = devm_ioremap(...)
|
 x = devm_ioremap_nocache(...)
)

@@
expression r.x;
@@

(
* kfree(x)
|
* free_irq(x)
|
* iounmap(x)
)

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 arch/arm/plat-pxa/ssp.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index ba13f79..97bd43c 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -230,25 +230,16 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 
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
1.9.1
