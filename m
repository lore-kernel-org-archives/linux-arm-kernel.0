From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Mon, 12 May 2014 11:44:56 +0530
Subject: [PATCH v13 11/19] iommu/exynos: remove custom fault handler
In-Reply-To: <1399875304-19948-1-git-send-email-shaik.ameer@samsung.com>
References: <1399875304-19948-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <1399875304-19948-12-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cho KyongHo <pullip.cho@samsung.com>

This commit removes custom fault handler. The device drivers that
need to register fault handler can register
with iommu_set_fault_handler().

CC: Grant Grundler <grundler@chromium.org>
Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
---
 drivers/iommu/exynos-iommu.c |   80 +++++++++++++-----------------------------
 1 file changed, 24 insertions(+), 56 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 5af5c5c..c1be65f 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -125,16 +125,6 @@ enum exynos_sysmmu_inttype {
 	SYSMMU_FAULTS_NUM
 };
 
-/*
- * @itype: type of fault.
- * @pgtable_base: the physical address of page table base. This is 0 if @itype
- *                is SYSMMU_BUSERROR.
- * @fault_addr: the device (virtual) address that the System MMU tried to
- *             translated. This is 0 if @itype is SYSMMU_BUSERROR.
- */
-typedef int (*sysmmu_fault_handler_t)(enum exynos_sysmmu_inttype itype,
-			phys_addr_t pgtable_base, unsigned long fault_addr);
-
 static unsigned short fault_reg_offset[SYSMMU_FAULTS_NUM] = {
 	REG_PAGE_FAULT_ADDR,
 	REG_AR_FAULT_ADDR,
@@ -176,7 +166,6 @@ struct sysmmu_drvdata {
 	int activations;
 	rwlock_t lock;
 	struct iommu_domain *domain;
-	sysmmu_fault_handler_t fault_handler;
 	phys_addr_t pgtable;
 };
 
@@ -245,34 +234,17 @@ static void __sysmmu_set_ptbase(void __iomem *sfrbase,
 	__sysmmu_tlb_invalidate(sfrbase);
 }
 
-static void __set_fault_handler(struct sysmmu_drvdata *data,
-					sysmmu_fault_handler_t handler)
-{
-	unsigned long flags;
-
-	write_lock_irqsave(&data->lock, flags);
-	data->fault_handler = handler;
-	write_unlock_irqrestore(&data->lock, flags);
-}
-
-void exynos_sysmmu_set_fault_handler(struct device *dev,
-					sysmmu_fault_handler_t handler)
-{
-	struct sysmmu_drvdata *data = dev_get_drvdata(dev->archdata.iommu);
-
-	__set_fault_handler(data, handler);
-}
-
-static int default_fault_handler(enum exynos_sysmmu_inttype itype,
-			phys_addr_t pgtable_base, unsigned long fault_addr)
+static void show_fault_information(const char *name,
+		enum exynos_sysmmu_inttype itype,
+		phys_addr_t pgtable_base, unsigned long fault_addr)
 {
 	unsigned long *ent;
 
 	if ((itype >= SYSMMU_FAULTS_NUM) || (itype < SYSMMU_PAGEFAULT))
 		itype = SYSMMU_FAULT_UNKNOWN;
 
-	pr_err("%s occurred at 0x%lx(Page table base: %pa)\n",
-			sysmmu_fault_name[itype], fault_addr, &pgtable_base);
+	pr_err("%s occurred@%#lx by %s(Page table base: %pa)\n",
+		sysmmu_fault_name[itype], fault_addr, name, &pgtable_base);
 
 	ent = section_entry(phys_to_virt(pgtable_base), fault_addr);
 	pr_err("\tLv1 entry: 0x%lx\n", *ent);
@@ -281,12 +253,6 @@ static int default_fault_handler(enum exynos_sysmmu_inttype itype,
 		ent = page_entry(ent, fault_addr);
 		pr_err("\t Lv2 entry: 0x%lx\n", *ent);
 	}
-
-	pr_err("Generating Kernel OOPS... because it is unrecoverable.\n");
-
-	BUG();
-
-	return 0;
 }
 
 static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
@@ -310,24 +276,28 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 	else
 		addr = __raw_readl(data->sfrbase + fault_reg_offset[itype]);
 
-	if (data->domain)
-		ret = report_iommu_fault(data->domain, data->dev, addr, itype);
-
-	if ((ret == -ENOSYS) && data->fault_handler) {
-		unsigned long base = data->pgtable;
-		if (itype != SYSMMU_FAULT_UNKNOWN)
-			base = __raw_readl(data->sfrbase + REG_PT_BASE_ADDR);
-		ret = data->fault_handler(itype, base, addr);
+	if (itype == SYSMMU_FAULT_UNKNOWN) {
+		pr_err("%s: Fault is not occurred by System MMU '%s'!\n",
+			__func__, dev_name(data->sysmmu));
+		pr_err("%s: Please check if IRQ is correctly configured.\n",
+			__func__);
+		BUG();
+	} else {
+		unsigned long base =
+				__raw_readl(data->sfrbase + REG_PT_BASE_ADDR);
+		show_fault_information(dev_name(data->sysmmu),
+					itype, base, addr);
+		if (data->domain)
+			ret = report_iommu_fault(data->domain,
+					data->dev, addr, itype);
 	}
 
-	if (!ret && (itype != SYSMMU_FAULT_UNKNOWN))
-		__raw_writel(1 << itype, data->sfrbase + REG_INT_CLEAR);
-	else
-		dev_dbg(data->sysmmu, "%s is not handled.\n",
-				sysmmu_fault_name[itype]);
+	/* fault is not recovered by fault handler */
+	BUG_ON(ret != 0);
 
-	if (itype != SYSMMU_FAULT_UNKNOWN)
-		sysmmu_unblock(data->sfrbase);
+	__raw_writel(1 << itype, data->sfrbase + REG_INT_CLEAR);
+
+	sysmmu_unblock(data->sfrbase);
 
 	if (!IS_ERR(data->clk_master))
 		clk_disable(data->clk_master);
@@ -576,8 +546,6 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 	rwlock_init(&data->lock);
 	INIT_LIST_HEAD(&data->node);
 
-	__set_fault_handler(data, &default_fault_handler);
-
 	platform_set_drvdata(pdev, data);
 
 	pm_runtime_enable(dev);
-- 
1.7.9.5
