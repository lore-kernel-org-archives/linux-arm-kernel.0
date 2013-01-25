From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:23:56 +0900
Subject: [PATCH 20/80] sh-pfc: Support passing resources through platform
 device
In-Reply-To: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359080696-31489-21-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Resources should be passed through the platform device, not through
platform data. Default to platform device resources and fall back to
platform data resources if not available.

Support for platform data resources will be removed when arch code will
be converted.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Paul Mundt <lethal@linux-sh.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/sh/pfc/core.c |   26 +++++++++++++++++++-------
 drivers/sh/pfc/core.h |    2 ++
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/sh/pfc/core.c b/drivers/sh/pfc/core.c
index cd8f09d..b2e121d 100644
--- a/drivers/sh/pfc/core.c
+++ b/drivers/sh/pfc/core.c
@@ -26,21 +26,33 @@
 
 #include "core.h"
 
-static int sh_pfc_ioremap(struct sh_pfc *pfc)
+static int sh_pfc_ioremap(struct sh_pfc *pfc, struct platform_device *pdev)
 {
+	unsigned int num_resources;
 	struct resource *res;
 	int k;
 
-	if (!pfc->pdata->num_resources)
+	if (pdev->num_resources) {
+		num_resources = pdev->num_resources;
+		res = pdev->resource;
+	} else {
+		num_resources = pfc->pdata->num_resources;
+		res = pfc->pdata->resource;
+	}
+
+	if (num_resources == 0) {
+		pfc->num_windows = 0;
 		return 0;
+	}
 
-	pfc->window = devm_kzalloc(pfc->dev, pfc->pdata->num_resources *
+	pfc->window = devm_kzalloc(pfc->dev, num_resources *
 				   sizeof(*pfc->window), GFP_NOWAIT);
 	if (!pfc->window)
 		return -ENOMEM;
 
-	for (k = 0; k < pfc->pdata->num_resources; k++) {
-		res = pfc->pdata->resource + k;
+	pfc->num_windows = num_resources;
+
+	for (k = 0; k < num_resources; k++, res++) {
 		WARN_ON(resource_type(res) != IORESOURCE_MEM);
 		pfc->window[k].phys = res->start;
 		pfc->window[k].size = resource_size(res);
@@ -60,7 +72,7 @@ static void __iomem *sh_pfc_phys_to_virt(struct sh_pfc *pfc,
 	int k;
 
 	/* scan through physical windows and convert address */
-	for (k = 0; k < pfc->pdata->num_resources; k++) {
+	for (k = 0; k < pfc->num_windows; k++) {
 		window = pfc->window + k;
 
 		if (address < window->phys)
@@ -498,7 +510,7 @@ static int sh_pfc_probe(struct platform_device *pdev)
 	pfc->pdata = pdata;
 	pfc->dev = &pdev->dev;
 
-	ret = sh_pfc_ioremap(pfc);
+	ret = sh_pfc_ioremap(pfc, pdev);
 	if (unlikely(ret < 0))
 		return ret;
 
diff --git a/drivers/sh/pfc/core.h b/drivers/sh/pfc/core.h
index d6a40bc..87ae5fd 100644
--- a/drivers/sh/pfc/core.h
+++ b/drivers/sh/pfc/core.h
@@ -28,7 +28,9 @@ struct sh_pfc {
 	struct sh_pfc_platform_data *pdata;
 	spinlock_t lock;
 
+	unsigned int num_windows;
 	struct sh_pfc_window *window;
+
 	struct sh_pfc_chip *gpio;
 	struct sh_pfc_pinctrl *pinctrl;
 };
-- 
1.7.10.4
