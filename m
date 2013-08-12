From: zonque@gmail.com (Daniel Mack)
Date: Mon, 12 Aug 2013 10:37:15 +0200
Subject: [PATCH 2/5] ARM: pxa: ssp: add shortcut for &pdev->dev
In-Reply-To: <1376296638-19804-1-git-send-email-zonque@gmail.com>
References: <1376296638-19804-1-git-send-email-zonque@gmail.com>
Message-ID: <1376296638-19804-3-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No functional change, just a cosmetic cleanup.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/plat-pxa/ssp.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index f746b6a..65ba28a 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -77,6 +77,7 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 	const struct platform_device_id *id = platform_get_device_id(pdev);
 	struct resource *res;
 	struct ssp_device *ssp;
+	struct device *dev = &pdev->dev;
 	int ret = 0;
 
 	ssp = kzalloc(sizeof(struct ssp_device), GFP_KERNEL);
@@ -85,7 +86,7 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 
 	ssp->pdev = pdev;
 
-	ssp->clk = clk_get(&pdev->dev, NULL);
+	ssp->clk = clk_get(dev, NULL);
 	if (IS_ERR(ssp->clk)) {
 		ret = PTR_ERR(ssp->clk);
 		goto err_free;
@@ -93,7 +94,7 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 	if (res == NULL) {
-		dev_err(&pdev->dev, "no SSP RX DRCMR defined\n");
+		dev_err(dev, "no SSP RX DRCMR defined\n");
 		ret = -ENODEV;
 		goto err_free_clk;
 	}
@@ -101,7 +102,7 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
 	if (res == NULL) {
-		dev_err(&pdev->dev, "no SSP TX DRCMR defined\n");
+		dev_err(dev, "no SSP TX DRCMR defined\n");
 		ret = -ENODEV;
 		goto err_free_clk;
 	}
@@ -109,7 +110,7 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res == NULL) {
-		dev_err(&pdev->dev, "no memory resource defined\n");
+		dev_err(dev, "no memory resource defined\n");
 		ret = -ENODEV;
 		goto err_free_clk;
 	}
@@ -117,7 +118,7 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 	res = request_mem_region(res->start, resource_size(res),
 			pdev->name);
 	if (res == NULL) {
-		dev_err(&pdev->dev, "failed to request memory resource\n");
+		dev_err(dev, "failed to request memory resource\n");
 		ret = -EBUSY;
 		goto err_free_clk;
 	}
@@ -126,14 +127,14 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 
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
