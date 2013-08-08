From: pullip.cho@samsung.com (Cho KyongHo)
Date: Thu, 08 Aug 2013 18:40:12 +0900
Subject: [PATCH v9 11/16] iommu/exynos: remove calls to Runtime PM API
 functions
Message-ID: <002f01ce941b$47796910$d66c3b30$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Runtime power management by exynos-iommu driver independently from
master H/W's runtime pm is not useful for power saving since attaching
master H/W in probing time turns on its local power endlessly.
Thus this removes runtime pm API calls.
Runtime PM support is added in the following commits to exynos-iommu
driver.

Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
---
 drivers/iommu/exynos-iommu.c |   20 --------------------
 1 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index e8f3e82..686e3c8 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -491,15 +491,8 @@ int exynos_sysmmu_enable(struct device *dev, unsigned long pgtable)
 
 	BUG_ON(!memblock_is_memory(pgtable));
 
-	ret = pm_runtime_get_sync(data->sysmmu);
-	if (ret < 0) {
-		dev_dbg(data->sysmmu, "Failed to enable\n");
-		return ret;
-	}
-
 	ret = __exynos_sysmmu_enable(data, pgtable, NULL);
 	if (WARN_ON(ret < 0)) {
-		pm_runtime_put(data->sysmmu);
 		dev_err(data->sysmmu,
 			"Already enabled with page table %#lx\n",
 			data->pgtable);
@@ -516,7 +509,6 @@ static bool exynos_sysmmu_disable(struct device *dev)
 	bool disabled;
 
 	disabled = __exynos_sysmmu_disable(data);
-	pm_runtime_put(data->sysmmu);
 
 	return disabled;
 }
@@ -626,8 +618,6 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 		}
 	}
 
-	pm_runtime_enable(dev);
-
 	data->sysmmu = dev;
 	data->clk = devm_clk_get(dev, "sysmmu");
 	if (IS_ERR(data->clk)) {
@@ -759,12 +749,6 @@ static int exynos_iommu_attach_device(struct iommu_domain *domain,
 	unsigned long flags;
 	int ret;
 
-	ret = pm_runtime_get_sync(data->sysmmu);
-	if (ret < 0)
-		return ret;
-
-	ret = 0;
-
 	spin_lock_irqsave(&priv->lock, flags);
 
 	ret = __exynos_sysmmu_enable(data, __pa(priv->pgtable), domain);
@@ -781,7 +765,6 @@ static int exynos_iommu_attach_device(struct iommu_domain *domain,
 	if (ret < 0) {
 		dev_err(dev, "%s: Failed to attach IOMMU with pgtable %#lx\n",
 				__func__, __pa(priv->pgtable));
-		pm_runtime_put(data->sysmmu);
 	} else if (ret > 0) {
 		dev_dbg(dev, "%s: IOMMU with pgtable 0x%lx already attached\n",
 					__func__, __pa(priv->pgtable));
@@ -826,9 +809,6 @@ static void exynos_iommu_detach_device(struct iommu_domain *domain,
 
 finish:
 	spin_unlock_irqrestore(&priv->lock, flags);
-
-	if (found)
-		pm_runtime_put(data->sysmmu);
 }
 
 static unsigned long *alloc_lv2entry(unsigned long *sent, unsigned long iova,
-- 
1.7.2.5
