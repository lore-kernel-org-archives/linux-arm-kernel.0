From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 04 May 2015 10:16:09 +0200
Subject: [PATCH v6 14/25] iommu: exynos: use struct exynos_iommu_domain in
 internal structures
In-Reply-To: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1430727380-10912-15-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace all remaining usage of struct iommu_domain with struct
exynos_iommu_domain in all internal structures and functions.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index a58f4a4c91d0..67e0633b8080 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -206,7 +206,7 @@ struct sysmmu_drvdata {
 	struct clk *clk_master;
 	int activations;
 	spinlock_t lock;
-	struct iommu_domain *domain;
+	struct exynos_iommu_domain *domain;
 	struct list_head domain_node;
 	struct list_head owner_node;
 	phys_addr_t pgtable;
@@ -338,7 +338,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 		show_fault_information(dev_name(data->sysmmu),
 					itype, base, addr);
 		if (data->domain)
-			ret = report_iommu_fault(data->domain,
+			ret = report_iommu_fault(&data->domain->domain,
 					data->master, addr, itype);
 	}
 
@@ -437,7 +437,7 @@ static void __sysmmu_enable_nocount(struct sysmmu_drvdata *data)
 }
 
 static int __sysmmu_enable(struct sysmmu_drvdata *data, phys_addr_t pgtable,
-			   struct iommu_domain *iommu_domain)
+			   struct exynos_iommu_domain *domain)
 {
 	int ret = 0;
 	unsigned long flags;
@@ -445,7 +445,7 @@ static int __sysmmu_enable(struct sysmmu_drvdata *data, phys_addr_t pgtable,
 	spin_lock_irqsave(&data->lock, flags);
 	if (set_sysmmu_active(data)) {
 		data->pgtable = pgtable;
-		data->domain = iommu_domain;
+		data->domain = domain;
 
 		__sysmmu_enable_nocount(data);
 
@@ -703,7 +703,7 @@ static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
 
 	list_for_each_entry(data, &owner->clients, owner_node) {
 		pm_runtime_get_sync(data->sysmmu);
-		ret = __sysmmu_enable(data, pagetable, iommu_domain);
+		ret = __sysmmu_enable(data, pagetable, domain);
 		if (ret >= 0) {
 			data->master = dev;
 
-- 
1.9.2
