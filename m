From: pullip.cho@samsung.com (Cho KyongHo)
Date: Fri, 14 Mar 2014 14:09:51 +0900
Subject: [PATCH v11 15/27] iommu/exynos: use convenient macro to handle gate
 clocks
Message-ID: <20140314140951.3d443a3096e80297c9fecef0@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

exynos-iommu driver must care about master H/W's gate clock as well as
System MMU's gate clock. To enhance readability of the source code,
macros to gate/ungate those clocks are defined.

Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
---
 drivers/iommu/exynos-iommu.c |   34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 71e77f1..cef62d0 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -101,6 +101,16 @@
 #define REG_PB1_SADDR		0x054
 #define REG_PB1_EADDR		0x058
 
+#define __clk_gate_ctrl(data, clk, en)	do {		\
+		if (data->clk)				\
+			clk_##en##able(data->clk);	\
+	} while (0)
+
+#define __sysmmu_clk_enable(data)	__clk_gate_ctrl(data, clk, en)
+#define __sysmmu_clk_disable(data)	__clk_gate_ctrl(data, clk, dis)
+#define __master_clk_enable(data)	__clk_gate_ctrl(data, clk_master, en)
+#define __master_clk_disable(data)	__clk_gate_ctrl(data, clk_master, dis)
+
 static struct kmem_cache *lv2table_kmem_cache;
 
 static unsigned long *section_entry(unsigned long *pgtable, unsigned long iova)
@@ -302,7 +312,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 
 	WARN_ON(!is_sysmmu_active(data));
 
-	clk_enable(data->clk_master);
+	__master_clk_enable(data);
 	itype = (enum exynos_sysmmu_inttype)
 		__ffs(__raw_readl(data->sfrbase + REG_INT_STATUS));
 	if (WARN_ON(!((itype >= 0) && (itype < SYSMMU_FAULT_UNKNOWN))))
@@ -329,7 +339,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 	if (itype != SYSMMU_FAULT_UNKNOWN)
 		sysmmu_unblock(data->sfrbase);
 
-	clk_disable(data->clk_master);
+	__master_clk_disable(data);
 
 	read_unlock(&data->lock);
 
@@ -346,12 +356,12 @@ static bool __exynos_sysmmu_disable(struct sysmmu_drvdata *data)
 	if (!set_sysmmu_inactive(data))
 		goto finish;
 
-	clk_enable(data->clk_master);
+	__master_clk_enable(data);
 
 	__raw_writel(CTRL_DISABLE, data->sfrbase + REG_MMU_CTRL);
 
-	clk_disable(data->clk);
-	clk_disable(data->clk_master);
+	__sysmmu_clk_disable(data);
+	__master_clk_disable(data);
 
 	disabled = true;
 	data->pgtable = 0;
@@ -396,14 +406,14 @@ static int __exynos_sysmmu_enable(struct sysmmu_drvdata *data,
 
 	data->pgtable = pgtable;
 
-	clk_enable(data->clk_master);
-	clk_enable(data->clk);
+	__master_clk_enable(data);
+	__sysmmu_clk_enable(data);
 
 	__sysmmu_set_ptbase(data->sfrbase, pgtable);
 
 	__raw_writel(CTRL_ENABLE, data->sfrbase + REG_MMU_CTRL);
 
-	clk_disable(data->clk_master);
+	__master_clk_disable(data);
 
 	data->domain = domain;
 
@@ -462,7 +472,7 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova,
 		unsigned int maj;
 		unsigned int num_inv = 1;
 
-		clk_enable(data->clk_master);
+		__master_clk_enable(data);
 
 		maj = __raw_readl(data->sfrbase + REG_MMU_VERSION);
 		/*
@@ -483,7 +493,7 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova,
 							num_inv);
 			sysmmu_unblock(data->sfrbase);
 		}
-		clk_disable(data->clk_master);
+		__master_clk_disable(data);
 	} else {
 		dev_dbg(data->sysmmu, "Disabled. Skipping invalidating TLB.\n");
 	}
@@ -499,12 +509,12 @@ void exynos_sysmmu_tlb_invalidate(struct device *dev)
 	read_lock_irqsave(&data->lock, flags);
 
 	if (is_sysmmu_active(data)) {
-		clk_enable(data->clk_master);
+		__master_clk_enable(data);
 		if (sysmmu_block(data->sfrbase)) {
 			__sysmmu_tlb_invalidate(data->sfrbase);
 			sysmmu_unblock(data->sfrbase);
 		}
-		clk_disable(data->clk_master);
+		__master_clk_disable(data);
 	} else {
 		dev_dbg(data->sysmmu, "Disabled. Skipping invalidating TLB.\n");
 	}
-- 
1.7.9.5
