From: zonque@gmail.com (Daniel Mack)
Date: Wed,  7 Aug 2013 17:33:52 +0200
Subject: [PATCH 03/20] ARM: pxa: ssp: add shortcut for &pdev->dev
In-Reply-To: <1375889649-14638-1-git-send-email-zonque@gmail.com>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
Message-ID: <1375889649-14638-4-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No functional change, just a cosmetic cleanup.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/plat-pxa/ssp.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index 8e11e96..a503ea0 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -77,16 +77,17 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 	const struct platform_device_id *id = platform_get_device_id(pdev);
 	struct resource *res;
 	struct ssp_device *ssp;
+	struct device *dev = &pdev->dev;
 	int ret = 0;
 
 	ssp = kzalloc(sizeof(struct ssp_device), GFP_KERNEL);
 	if (ssp == NULL) {
-		dev_err(&pdev->dev, "failed to allocate memory");
+		dev_err(dev, "failed to allocate memory");
 		return -ENOMEM;
 	}
 	ssp->pdev = pdev;
 
-	ssp->clk = clk_get(&pdev->dev, NULL);
+	ssp->clk = clk_get(dev, NULL);
 	if (IS_ERR(ssp->clk)) {
 		ret = PTR_ERR(ssp->clk);
 		goto err_free;
@@ -94,7 +95,7 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 	if (res == NULL) {
-		dev_err(&pdev->dev, "no SSP RX DRCMR defined\n");
+		dev_err(dev, "no SSP RX DRCMR defined\n");
 		ret = -ENODEV;
 		goto err_free_clk;
 	}
@@ -102,7 +103,7 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
 	if (res == NULL) {
-		dev_err(&pdev->dev, "no SSP TX DRCMR defined\n");
+		dev_err(dev, "no SSP TX DRCMR defined\n");
 		ret = -ENODEV;
 		goto err_free_clk;
 	}
@@ -110,7 +111,7 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res == NULL) {
-		dev_err(&pdev->dev, "no memory resource defined\n");
+		dev_err(dev, "no memory resource defined\n");
 		ret = -ENODEV;
 		goto err_free_clk;
 	}
@@ -118,7 +119,7 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 	res = request_mem_region(res->start, resource_size(res),
 			pdev->name);
 	if (res == NULL) {
-		dev_err(&pdev->dev, "failed to request memory resource\n");
+		dev_err(dev, "failed to request memory resource\n");
 		ret = -EBUSY;
 		goto err_free_clk;
 	}
@@ -127,14 +128,14 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 
 	ssp->mmio_base = ioremap(res->start, resource_size(res));
 	if (ssp->mmio_base == NULL) {
-		dev_err(&pdev->dev, "failed to ioremap() registers\n");
+		dev_err(dev, "failed to ioremap() registers\n");
 		ret = -ENODEV;
 		goto err_free_mem;
 	}
 
 	ssp->irq = platform_get_irq(pdev, 0);
 	if (ssp->irq < 0) {
-		dev_err(&pdev->dev, "no IRQ resource defined\n");
+		dev_err(dev, "no IRQ resource defined\n");
 		ret = -ENODEV;
 		goto err_free_io;
 	}
-- 
1.8.3.1
