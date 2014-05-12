From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Mon, 12 May 2014 11:44:54 +0530
Subject: [PATCH v13 09/19] iommu/exynos: use managed device helper functions
In-Reply-To: <1399875304-19948-1-git-send-email-shaik.ameer@samsung.com>
References: <1399875304-19948-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <1399875304-19948-10-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cho KyongHo <pullip.cho@samsung.com>

This patch uses managed device helper functions in the probe().

Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
---
 drivers/iommu/exynos-iommu.c |   68 ++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 43 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index be7a7b9..c86e374 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -343,8 +343,7 @@ static bool __exynos_sysmmu_disable(struct sysmmu_drvdata *data)
 
 	__raw_writel(CTRL_DISABLE, data->sfrbase + REG_MMU_CTRL);
 
-	if (!IS_ERR(data->clk))
-		clk_disable(data->clk);
+	clk_disable(data->clk);
 
 	disabled = true;
 	data->pgtable = 0;
@@ -387,8 +386,7 @@ static int __exynos_sysmmu_enable(struct sysmmu_drvdata *data,
 		goto finish;
 	}
 
-	if (!IS_ERR(data->clk))
-		clk_enable(data->clk);
+	clk_enable(data->clk);
 
 	data->pgtable = pgtable;
 
@@ -499,49 +497,43 @@ void exynos_sysmmu_tlb_invalidate(struct device *dev)
 
 static int exynos_sysmmu_probe(struct platform_device *pdev)
 {
-	int ret;
+	int irq, ret;
 	struct device *dev = &pdev->dev;
 	struct sysmmu_drvdata *data;
 	struct resource *res;
 
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		dev_dbg(dev, "Not enough memory\n");
-		ret = -ENOMEM;
-		goto err_alloc;
-	}
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_dbg(dev, "Unable to find IOMEM region\n");
-		ret = -ENOENT;
-		goto err_init;
-	}
+	data->sfrbase = devm_ioremap_resource(dev, res);
+	if (IS_ERR(data->sfrbase))
+		return PTR_ERR(data->sfrbase);
 
-	data->sfrbase = ioremap(res->start, resource_size(res));
-	if (!data->sfrbase) {
-		dev_dbg(dev, "Unable to map IOMEM @ PA:%#x\n", res->start);
-		ret = -ENOENT;
-		goto err_res;
-	}
-
-	ret = platform_get_irq(pdev, 0);
-	if (ret <= 0) {
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0) {
 		dev_dbg(dev, "Unable to find IRQ resource\n");
-		goto err_irq;
+		return irq;
 	}
 
-	ret = request_irq(ret, exynos_sysmmu_irq, 0,
+	ret = devm_request_irq(dev, irq, exynos_sysmmu_irq, 0,
 				dev_name(dev), data);
 	if (ret) {
-		dev_dbg(dev, "Unabled to register interrupt handler\n");
-		goto err_irq;
+		dev_err(dev, "Unabled to register handler of irq %d\n", irq);
+		return ret;
 	}
 
-	if (dev_get_platdata(dev)) {
-		data->clk = clk_get(dev, "sysmmu");
-		if (IS_ERR(data->clk))
-			dev_dbg(dev, "No clock descriptor registered\n");
+	data->clk = devm_clk_get(dev, "sysmmu");
+	if (IS_ERR(data->clk)) {
+		dev_err(dev, "Failed to get clock!\n");
+		return PTR_ERR(data->clk);
+	} else  {
+		ret = clk_prepare(data->clk);
+		if (ret) {
+			dev_err(dev, "Failed to prepare clk\n");
+			return ret;
+		}
 	}
 
 	data->sysmmu = dev;
@@ -554,17 +546,7 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
-	dev_dbg(dev, "Initialized\n");
 	return 0;
-err_irq:
-	free_irq(platform_get_irq(pdev, 0), data);
-err_res:
-	iounmap(data->sfrbase);
-err_init:
-	kfree(data);
-err_alloc:
-	dev_err(dev, "Failed to initialize\n");
-	return ret;
 }
 
 static struct platform_driver exynos_sysmmu_driver = {
-- 
1.7.9.5
