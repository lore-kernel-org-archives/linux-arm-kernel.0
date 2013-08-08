From: pullip.cho@samsung.com (Cho KyongHo)
Date: Thu, 08 Aug 2013 18:41:39 +0900
Subject: [PATCH v9 15/16] iommu/exynos: change rwlock to spinlock
Message-ID: <003301ce941b$7b4fd3a0$71ef7ae0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since acquiring read_lock is not more frequent than write_lock, it is
not beneficial to use rwlock, this commit changes rwlock to spinlock.

Reviewed-by: Grant Grundler <grundler@chromium.org>
Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
---
 drivers/iommu/exynos-iommu.c |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 56aead9..2d16fc0 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -185,7 +185,7 @@ struct sysmmu_drvdata {
 	struct clk *clk;
 	struct clk *clk_master;
 	int activations;
-	rwlock_t lock;
+	spinlock_t lock;
 	struct iommu_domain *domain;
 	bool runtime_active;
 	unsigned long pgtable;
@@ -285,7 +285,7 @@ void exynos_sysmmu_set_prefbuf(struct device *dev,
 	BUG_ON((base0 + size0) <= base0);
 	BUG_ON((size1 > 0) && ((base1 + size1) <= base1));
 
-	read_lock_irqsave(&data->lock, flags);
+	spin_lock_irqsave(&data->lock, flags);
 	if (!is_sysmmu_active(data))
 		goto finish;
 
@@ -319,7 +319,7 @@ void exynos_sysmmu_set_prefbuf(struct device *dev,
 
 	clk_disable(data->clk_master);
 finish:
-	read_unlock_irqrestore(&data->lock, flags);
+	spin_unlock_irqrestore(&data->lock, flags);
 }
 
 static void show_fault_information(const char *name,
@@ -372,7 +372,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 	clk_enable(data->clk_master);
 	if (client)
 		spin_lock(&client->lock);
-	read_lock(&data->lock);
+	spin_lock(&data->lock);
 
 	if (i == data->nsfrs) {
 		itype = SYSMMU_FAULT_UNKNOWN;
@@ -405,7 +405,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 
 	clk_disable(data->clk_master);
 
-	read_unlock(&data->lock);
+	spin_unlock(&data->lock);
 	if (client)
 		spin_unlock(&client->lock);
 
@@ -432,7 +432,7 @@ static bool __sysmmu_disable(struct sysmmu_drvdata *data)
 	bool disabled;
 	unsigned long flags;
 
-	write_lock_irqsave(&data->lock, flags);
+	spin_lock_irqsave(&data->lock, flags);
 
 	disabled = set_sysmmu_inactive(data);
 
@@ -449,7 +449,7 @@ static bool __sysmmu_disable(struct sysmmu_drvdata *data)
 					data->activations);
 	}
 
-	write_unlock_irqrestore(&data->lock, flags);
+	spin_unlock_irqrestore(&data->lock, flags);
 
 	return disabled;
 }
@@ -503,7 +503,7 @@ static int __sysmmu_enable(struct sysmmu_drvdata *data,
 	int ret = 0;
 	unsigned long flags;
 
-	write_lock_irqsave(&data->lock, flags);
+	spin_lock_irqsave(&data->lock, flags);
 	if (set_sysmmu_active(data)) {
 		data->pgtable = pgtable;
 		data->domain = domain;
@@ -521,7 +521,7 @@ static int __sysmmu_enable(struct sysmmu_drvdata *data,
 	if (WARN_ON(ret < 0))
 		set_sysmmu_inactive(data); /* decrement count */
 
-	write_unlock_irqrestore(&data->lock, flags);
+	spin_unlock_irqrestore(&data->lock, flags);
 
 	return ret;
 }
@@ -612,7 +612,7 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova)
 
 		data = dev_get_drvdata(client->sysmmu[i]);
 
-		read_lock_irqsave(&data->lock, flags);
+		spin_lock_irqsave(&data->lock, flags);
 		if (is_sysmmu_active(data) && data->runtime_active) {
 			int i;
 			clk_enable(data->clk_master);
@@ -625,7 +625,7 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova)
 				"disabled. Skipping TLB invalidation @ %#lx\n",
 				iova);
 		}
-		read_unlock_irqrestore(&data->lock, flags);
+		spin_unlock_irqrestore(&data->lock, flags);
 	}
 }
 
@@ -640,7 +640,7 @@ void exynos_sysmmu_tlb_invalidate(struct device *dev)
 
 		data = dev_get_drvdata(client->sysmmu[i]);
 
-		read_lock_irqsave(&data->lock, flags);
+		spin_lock_irqsave(&data->lock, flags);
 		if (is_sysmmu_active(data) &&
 				data->runtime_active) {
 			int i;
@@ -656,7 +656,7 @@ void exynos_sysmmu_tlb_invalidate(struct device *dev)
 		} else {
 			dev_dbg(dev, "disabled. Skipping TLB invalidation\n");
 		}
-		read_unlock_irqrestore(&data->lock, flags);
+		spin_unlock_irqrestore(&data->lock, flags);
 	}
 }
 
@@ -745,7 +745,7 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 
 	data->runtime_active = !pm_runtime_enabled(dev);
 
-	rwlock_init(&data->lock);
+	spin_lock_init(&data->lock);
 
 	platform_set_drvdata(pdev, data);
 	dev_dbg(dev, "Probed and initialized\n");
@@ -758,11 +758,11 @@ static int sysmmu_suspend(struct device *dev)
 {
 	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
 	unsigned long flags;
-	read_lock_irqsave(&data->lock, flags);
+	spin_lock_irqsave(&data->lock, flags);
 	if (is_sysmmu_active(data) &&
 		(!pm_runtime_enabled(dev) || data->runtime_active))
 		__sysmmu_disable_nocount(data);
-	read_unlock_irqrestore(&data->lock, flags);
+	spin_unlock_irqrestore(&data->lock, flags);
 	return 0;
 }
 
@@ -770,11 +770,11 @@ static int sysmmu_resume(struct device *dev)
 {
 	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
 	unsigned long flags;
-	read_lock_irqsave(&data->lock, flags);
+	spin_lock_irqsave(&data->lock, flags);
 	if (is_sysmmu_active(data) &&
 		(!pm_runtime_enabled(dev) || data->runtime_active))
 		__sysmmu_enable_nocount(data);
-	read_unlock_irqrestore(&data->lock, flags);
+	spin_unlock_irqrestore(&data->lock, flags);
 	return 0;
 }
 #endif
-- 
1.7.2.5
