From: pullip.cho@samsung.com (Cho KyongHo)
Date: Fri, 14 Mar 2014 14:09:44 +0900
Subject: [PATCH v11 14/27] iommu/exynos: gating clocks of master H/W
Message-ID: <20140314140944.ebab0ec5997424ab7034d566@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch gates clocks of master H/W as well as clocks of System MMU
if master clocks are specified.

Some Exynos SoCs (i.e. GScalers in Exynos5250) have dependencies in
the gating clocks of master H/W and its System MMU. If a H/W is the
case, accessing control registers of System MMU is prohibited unless
both of the gating clocks of System MMU and its master H/W.

CC: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
---
 drivers/iommu/exynos-iommu.c |   35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 34feb04..71e77f1 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -173,6 +173,7 @@ struct sysmmu_drvdata {
 	struct device *dev;	/* Owner of system MMU */
 	void __iomem *sfrbase;
 	struct clk *clk;
+	struct clk *clk_master;
 	int activations;
 	rwlock_t lock;
 	struct iommu_domain *domain;
@@ -301,6 +302,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 
 	WARN_ON(!is_sysmmu_active(data));
 
+	clk_enable(data->clk_master);
 	itype = (enum exynos_sysmmu_inttype)
 		__ffs(__raw_readl(data->sfrbase + REG_INT_STATUS));
 	if (WARN_ON(!((itype >= 0) && (itype < SYSMMU_FAULT_UNKNOWN))))
@@ -327,6 +329,8 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 	if (itype != SYSMMU_FAULT_UNKNOWN)
 		sysmmu_unblock(data->sfrbase);
 
+	clk_disable(data->clk_master);
+
 	read_unlock(&data->lock);
 
 	return IRQ_HANDLED;
@@ -342,10 +346,12 @@ static bool __exynos_sysmmu_disable(struct sysmmu_drvdata *data)
 	if (!set_sysmmu_inactive(data))
 		goto finish;
 
+	clk_enable(data->clk_master);
+
 	__raw_writel(CTRL_DISABLE, data->sfrbase + REG_MMU_CTRL);
 
-	if (data->clk)
-		clk_disable(data->clk);
+	clk_disable(data->clk);
+	clk_disable(data->clk_master);
 
 	disabled = true;
 	data->pgtable = 0;
@@ -388,15 +394,17 @@ static int __exynos_sysmmu_enable(struct sysmmu_drvdata *data,
 		goto finish;
 	}
 
-	if (data->clk)
-		clk_enable(data->clk);
-
 	data->pgtable = pgtable;
 
+	clk_enable(data->clk_master);
+	clk_enable(data->clk);
+
 	__sysmmu_set_ptbase(data->sfrbase, pgtable);
 
 	__raw_writel(CTRL_ENABLE, data->sfrbase + REG_MMU_CTRL);
 
+	clk_disable(data->clk_master);
+
 	data->domain = domain;
 
 	dev_dbg(data->sysmmu, "Enabled\n");
@@ -453,6 +461,9 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova,
 	if (is_sysmmu_active(data)) {
 		unsigned int maj;
 		unsigned int num_inv = 1;
+
+		clk_enable(data->clk_master);
+
 		maj = __raw_readl(data->sfrbase + REG_MMU_VERSION);
 		/*
 		 * L2TLB invalidation required
@@ -472,6 +483,7 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova,
 							num_inv);
 			sysmmu_unblock(data->sfrbase);
 		}
+		clk_disable(data->clk_master);
 	} else {
 		dev_dbg(data->sysmmu, "Disabled. Skipping invalidating TLB.\n");
 	}
@@ -487,10 +499,12 @@ void exynos_sysmmu_tlb_invalidate(struct device *dev)
 	read_lock_irqsave(&data->lock, flags);
 
 	if (is_sysmmu_active(data)) {
+		clk_enable(data->clk_master);
 		if (sysmmu_block(data->sfrbase)) {
 			__sysmmu_tlb_invalidate(data->sfrbase);
 			sysmmu_unblock(data->sfrbase);
 		}
+		clk_disable(data->clk_master);
 	} else {
 		dev_dbg(data->sysmmu, "Disabled. Skipping invalidating TLB.\n");
 	}
@@ -544,6 +558,17 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	data->clk_master = devm_clk_get(dev, "master");
+	if (IS_ERR(data->clk_master))
+		data->clk_master = NULL;
+
+	ret = clk_prepare(data->clk_master);
+	if (ret) {
+		clk_unprepare(data->clk);
+		dev_err(dev, "Failed to prepare master's clk\n");
+		return ret;
+	}
+
 	data->sysmmu = dev;
 	rwlock_init(&data->lock);
 	INIT_LIST_HEAD(&data->node);
-- 
1.7.9.5
