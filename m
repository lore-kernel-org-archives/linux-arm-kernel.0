From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 23 May 2016 11:30:09 +0200
Subject: [PATCH 3/3] iommu/exynos: Prepare clocks when needed,
 not in driver probe
In-Reply-To: <1463995809-26862-1-git-send-email-m.szyprowski@samsung.com>
References: <1463995809-26862-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1463995809-26862-4-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make clock preparation together with clk_enable(). This way inactive
SYSMMU controllers will not keep clocks prepared all the time.
This change allows more fine graded power management in the future.
All the code assumes that clock management doesn't fail, so guard
clock_prepare_enable() it with BUG_ON().

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 54 +++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 018bcd5d5edc..e0b834375f17 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -322,14 +322,27 @@ static void __sysmmu_set_ptbase(struct sysmmu_drvdata *data, phys_addr_t pgd)
 	__sysmmu_tlb_invalidate(data);
 }
 
+static void __sysmmu_enable_clocks(struct sysmmu_drvdata *data)
+{
+	BUG_ON(clk_prepare_enable(data->clk_master));
+	BUG_ON(clk_prepare_enable(data->clk));
+	BUG_ON(clk_prepare_enable(data->pclk));
+	BUG_ON(clk_prepare_enable(data->aclk));
+}
+
+static void __sysmmu_disable_clocks(struct sysmmu_drvdata *data)
+{
+	clk_disable_unprepare(data->aclk);
+	clk_disable_unprepare(data->pclk);
+	clk_disable_unprepare(data->clk);
+	clk_disable_unprepare(data->clk_master);
+}
+
 static void __sysmmu_get_version(struct sysmmu_drvdata *data)
 {
 	u32 ver;
 
-	clk_enable(data->clk_master);
-	clk_enable(data->clk);
-	clk_enable(data->pclk);
-	clk_enable(data->aclk);
+	__sysmmu_enable_clocks(data);
 
 	ver = readl(data->sfrbase + REG_MMU_VERSION);
 
@@ -342,10 +355,7 @@ static void __sysmmu_get_version(struct sysmmu_drvdata *data)
 	dev_dbg(data->sysmmu, "hardware version: %d.%d\n",
 		MMU_MAJ_VER(data->version), MMU_MIN_VER(data->version));
 
-	clk_disable(data->aclk);
-	clk_disable(data->pclk);
-	clk_disable(data->clk);
-	clk_disable(data->clk_master);
+	__sysmmu_disable_clocks(data);
 }
 
 static void show_fault_information(struct sysmmu_drvdata *data,
@@ -427,10 +437,7 @@ static void __sysmmu_disable_nocount(struct sysmmu_drvdata *data)
 	writel(CTRL_DISABLE, data->sfrbase + REG_MMU_CTRL);
 	writel(0, data->sfrbase + REG_MMU_CFG);
 
-	clk_disable(data->aclk);
-	clk_disable(data->pclk);
-	clk_disable(data->clk);
-	clk_disable(data->clk_master);
+	__sysmmu_disable_clocks(data);
 }
 
 static bool __sysmmu_disable(struct sysmmu_drvdata *data)
@@ -475,10 +482,7 @@ static void __sysmmu_init_config(struct sysmmu_drvdata *data)
 
 static void __sysmmu_enable_nocount(struct sysmmu_drvdata *data)
 {
-	clk_enable(data->clk_master);
-	clk_enable(data->clk);
-	clk_enable(data->pclk);
-	clk_enable(data->aclk);
+	__sysmmu_enable_clocks(data);
 
 	writel(CTRL_BLOCK, data->sfrbase + REG_MMU_CTRL);
 
@@ -488,6 +492,12 @@ static void __sysmmu_enable_nocount(struct sysmmu_drvdata *data)
 
 	writel(CTRL_ENABLE, data->sfrbase + REG_MMU_CTRL);
 
+	/*
+	 * SYSMMU driver keeps master's clock enabled only for the short
+	 * time, while accessing the registers. For performing address
+	 * translation during DMA transaction it relies on the client
+	 * driver to enable it.
+	 */
 	clk_disable(data->clk_master);
 }
 
@@ -605,27 +615,18 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 		data->clk = NULL;
 	else if (IS_ERR(data->clk))
 		return PTR_ERR(data->clk);
-	ret = clk_prepare(data->clk);
-	if (ret)
-		return ret;
 
 	data->aclk = devm_clk_get(dev, "aclk");
 	if (PTR_ERR(data->aclk) == -ENOENT)
 		data->aclk = NULL;
 	else if (IS_ERR(data->aclk))
 		return PTR_ERR(data->aclk);
-	ret = clk_prepare(data->aclk);
-	if (ret)
-		return ret;
 
 	data->pclk = devm_clk_get(dev, "pclk");
 	if (PTR_ERR(data->pclk) == -ENOENT)
 		data->pclk = NULL;
 	else if (IS_ERR(data->pclk))
 		return PTR_ERR(data->pclk);
-	ret = clk_prepare(data->pclk);
-	if (ret)
-		return ret;
 
 	if (!data->clk && (!data->aclk || !data->pclk)) {
 		dev_err(dev, "Failed to get device clock(s)!\n");
@@ -637,9 +638,6 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 		data->clk_master = NULL;
 	else if (IS_ERR(data->clk_master))
 		return PTR_ERR(data->clk_master);
-	ret = clk_prepare(data->clk_master);
-	if (ret)
-		return ret;
 
 	data->sysmmu = dev;
 	spin_lock_init(&data->lock);
-- 
1.9.2
