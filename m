From: pullip.cho@samsung.com (Cho KyongHo)
Date: Fri, 14 Mar 2014 14:12:38 +0900
Subject: [PATCH v11 23/27] iommu/exynos: fix address handling
Message-ID: <20140314141238.a1c596c349eccf10b869f8d1@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use of __pa and __va macro is changed to virt_to_phys and phys_to_virt
which are recommended in driver code. printk formatting of physical
address is also fixed to %pa.

Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
---
 drivers/iommu/exynos-iommu.c |   45 +++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 2beb197..e375501 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -142,7 +142,8 @@ static unsigned long *section_entry(unsigned long *pgtable, unsigned long iova)
 
 static unsigned long *page_entry(unsigned long *sent, unsigned long iova)
 {
-	return (unsigned long *)__va(lv2table_base(sent)) + lv2ent_offset(iova);
+	return (unsigned long *)phys_to_virt(
+				lv2table_base(sent)) + lv2ent_offset(iova);
 }
 
 enum exynos_sysmmu_inttype {
@@ -215,7 +216,7 @@ struct sysmmu_drvdata {
 	struct iommu_domain *domain;
 	bool runtime_active;
 	bool suspended;
-	unsigned long pgtable;
+	phys_addr_t pgtable;
 };
 
 static bool set_sysmmu_active(struct sysmmu_drvdata *data)
@@ -307,17 +308,17 @@ static void __sysmmu_set_ptbase(void __iomem *sfrbase,
 
 static void show_fault_information(const char *name,
 		enum exynos_sysmmu_inttype itype,
-		unsigned long pgtable_base, unsigned long fault_addr)
+		phys_addr_t pgtable_base, unsigned long fault_addr)
 {
 	unsigned long *ent;
 
 	if ((itype >= SYSMMU_FAULTS_NUM) || (itype < SYSMMU_PAGEFAULT))
 		itype = SYSMMU_FAULT_UNKNOWN;
 
-	pr_err("%s occurred at 0x%lx by %s(Page table base: 0x%lx)\n",
-		sysmmu_fault_name[itype], fault_addr, name, pgtable_base);
+	pr_err("%s occurred@%#lx by %s(Page table base: %pa)\n",
+		sysmmu_fault_name[itype], fault_addr, name, &pgtable_base);
 
-	ent = section_entry(__va(pgtable_base), fault_addr);
+	ent = section_entry(phys_to_virt(pgtable_base), fault_addr);
 	pr_err("\tLv1 entry: 0x%lx\n", *ent);
 
 	if (lv1ent_page(ent)) {
@@ -917,7 +918,7 @@ static void exynos_iommu_domain_destroy(struct iommu_domain *domain)
 	for (i = 0; i < NUM_LV1ENTRIES; i++)
 		if (lv1ent_page(priv->pgtable + i))
 			kmem_cache_free(lv2table_kmem_cache,
-					__va(lv2table_base(priv->pgtable + i)));
+				phys_to_virt(lv2table_base(priv->pgtable + i)));
 
 	free_pages((unsigned long)priv->pgtable, 2);
 	free_pages((unsigned long)priv->lv2entcnt, 1);
@@ -931,11 +932,12 @@ static int exynos_iommu_attach_device(struct iommu_domain *domain,
 	struct exynos_iommu_owner *owner = dev->archdata.iommu;
 	struct exynos_iommu_domain *priv = domain->priv;
 	unsigned long flags;
+	phys_addr_t pgtable = virt_to_phys(priv->pgtable);
 	int ret;
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	ret = __exynos_sysmmu_enable(dev, __pa(priv->pgtable), domain);
+	ret = __exynos_sysmmu_enable(dev, pgtable, domain);
 	if (ret == 0) {
 		list_add_tail(&owner->client, &priv->clients);
 		owner->domain = domain;
@@ -943,13 +945,14 @@ static int exynos_iommu_attach_device(struct iommu_domain *domain,
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	if (ret < 0)
-		dev_err(dev, "%s: Failed to attach IOMMU with pgtable %#x\n",
-				__func__, __pa(priv->pgtable));
-	else
-		dev_dbg(dev, "%s: Attached IOMMU with pgtable 0x%x%s\n",
-					__func__, __pa(priv->pgtable),
-					(ret == 0) ? "" : ", again");
+	if (ret < 0) {
+		dev_err(dev, "%s: Failed to attach IOMMU with pgtable %pa\n",
+				__func__, &pgtable);
+		return ret;
+	}
+
+	dev_dbg(dev, "%s: Attached IOMMU with pgtable %pa %s\n",
+		__func__, &pgtable, (ret == 0) ? "" : ", again");
 
 	return ret;
 }
@@ -975,11 +978,13 @@ static void exynos_iommu_detach_device(struct iommu_domain *domain,
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	if (owner == dev->archdata.iommu)
-		dev_dbg(dev, "%s: Detached IOMMU with pgtable %#x\n",
-					__func__, __pa(priv->pgtable));
-	else
+	if (owner == dev->archdata.iommu) {
+		phys_addr_t pgtable = virt_to_phys(priv->pgtable);
+		dev_dbg(dev, "%s: Detached IOMMU with pgtable %pa\n",
+					__func__, &pgtable);
+	} else {
 		dev_dbg(dev, "%s: No IOMMU is attached\n", __func__);
+	}
 }
 
 static unsigned long *alloc_lv2entry(unsigned long *sent, unsigned long iova,
@@ -998,7 +1003,7 @@ static unsigned long *alloc_lv2entry(unsigned long *sent, unsigned long iova,
 		if (!pent)
 			return ERR_PTR(-ENOMEM);
 
-		*sent = mk_lv1ent_page(__pa(pent));
+		*sent = mk_lv1ent_page(virt_to_phys(pent));
 		*pgcounter = NUM_LV2ENTRIES;
 		pgtable_flush(pent, pent + NUM_LV2ENTRIES);
 		pgtable_flush(sent, sent + 1);
-- 
1.7.9.5
