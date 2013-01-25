From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:24:19 +0900
Subject: [PATCH 43/80] sh-pfc: Remove unused resource and num_resources
 platform data fields
In-Reply-To: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359080696-31489-44-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The fields are now unused, remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Paul Mundt <lethal@linux-sh.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/sh/pfc/core.c  |   17 ++++-------------
 include/linux/sh_pfc.h |    3 ---
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/sh/pfc/core.c b/drivers/sh/pfc/core.c
index 9456c70..8e7818b 100644
--- a/drivers/sh/pfc/core.c
+++ b/drivers/sh/pfc/core.c
@@ -28,31 +28,22 @@
 
 static int sh_pfc_ioremap(struct sh_pfc *pfc, struct platform_device *pdev)
 {
-	unsigned int num_resources;
 	struct resource *res;
 	int k;
 
-	if (pdev->num_resources) {
-		num_resources = pdev->num_resources;
-		res = pdev->resource;
-	} else {
-		num_resources = pfc->pdata->num_resources;
-		res = pfc->pdata->resource;
-	}
-
-	if (num_resources == 0) {
+	if (pdev->num_resources == 0) {
 		pfc->num_windows = 0;
 		return 0;
 	}
 
-	pfc->window = devm_kzalloc(pfc->dev, num_resources *
+	pfc->window = devm_kzalloc(pfc->dev, pdev->num_resources *
 				   sizeof(*pfc->window), GFP_NOWAIT);
 	if (!pfc->window)
 		return -ENOMEM;
 
-	pfc->num_windows = num_resources;
+	pfc->num_windows = pdev->num_resources;
 
-	for (k = 0; k < num_resources; k++, res++) {
+	for (k = 0, res = pdev->resource; k < pdev->num_resources; k++, res++) {
 		WARN_ON(resource_type(res) != IORESOURCE_MEM);
 		pfc->window[k].phys = res->start;
 		pfc->window[k].size = resource_size(res);
diff --git a/include/linux/sh_pfc.h b/include/linux/sh_pfc.h
index fa1fec0..4f94233 100644
--- a/include/linux/sh_pfc.h
+++ b/include/linux/sh_pfc.h
@@ -111,9 +111,6 @@ struct sh_pfc_platform_data {
 	struct pinmux_irq *gpio_irq;
 	unsigned int gpio_irq_size;
 
-	struct resource *resource;
-	unsigned int num_resources;
-
 	unsigned long unlock_reg;
 };
 
-- 
1.7.10.4
