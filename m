From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:23:50 +0900
Subject: [PATCH 14/80] sh-pfc: Use devm_ioremap_nocache()
In-Reply-To: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359080696-31489-15-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace probe-time ioremap_nocache() call with devm_ioremap_nocache()
and get rid of the corresponding iounmap() call.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/sh/pfc/core.c |   25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/sh/pfc/core.c b/drivers/sh/pfc/core.c
index 5491902..8ec57bd 100644
--- a/drivers/sh/pfc/core.c
+++ b/drivers/sh/pfc/core.c
@@ -26,15 +26,6 @@
 
 #include "core.h"
 
-static void pfc_iounmap(struct sh_pfc *pfc)
-{
-	int k;
-
-	for (k = 0; k < pfc->pdata->num_resources; k++)
-		if (pfc->window[k].virt)
-			iounmap(pfc->window[k].virt);
-}
-
 static int pfc_ioremap(struct sh_pfc *pfc)
 {
 	struct resource *res;
@@ -53,12 +44,10 @@ static int pfc_ioremap(struct sh_pfc *pfc)
 		WARN_ON(resource_type(res) != IORESOURCE_MEM);
 		pfc->window[k].phys = res->start;
 		pfc->window[k].size = resource_size(res);
-		pfc->window[k].virt = ioremap_nocache(res->start,
-							 resource_size(res));
-		if (!pfc->window[k].virt) {
-			pfc_iounmap(pfc);
+		pfc->window[k].virt = devm_ioremap_nocache(pfc->dev, res->start,
+							   resource_size(res));
+		if (!pfc->window[k].virt)
 			return -ENOMEM;
-		}
 	}
 
 	return 0;
@@ -524,7 +513,7 @@ static int sh_pfc_probe(struct platform_device *pdev)
 	 */
 	ret = sh_pfc_register_pinctrl(pfc);
 	if (unlikely(ret != 0))
-		goto err;
+		return ret;
 
 #ifdef CONFIG_GPIO_SH_PFC
 	/*
@@ -546,10 +535,6 @@ static int sh_pfc_probe(struct platform_device *pdev)
 	pr_info("%s support registered\n", pdata->name);
 
 	return 0;
-
-err:
-	pfc_iounmap(pfc);
-	return ret;
 }
 
 static int sh_pfc_remove(struct platform_device *pdev)
@@ -561,8 +546,6 @@ static int sh_pfc_remove(struct platform_device *pdev)
 #endif
 	sh_pfc_unregister_pinctrl(pfc);
 
-	pfc_iounmap(pfc);
-
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
-- 
1.7.10.4
