From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 19 May 2015 15:20:29 +0200
Subject: [PATCH v7 09/25] iommu/exynos: Use struct exynos_iommu_domain in
 internal structures
In-Reply-To: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1432041645-11172-10-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace all remaining usage of struct iommu_domain with struct
exynos_iommu_domain in all internal structures and functions.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 1cb3c27e9125..33118aa9fdc1 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -206,7 +206,7 @@ struct sysmmu_drvdata {
 	struct clk *clk_master;
 	int activations;
 	spinlock_t lock;
-	struct iommu_domain *domain;
+	struct exynos_iommu_domain *domain;
 	struct list_head domain_node;
 	phys_addr_t pgtable;
 	unsigned int version;
@@ -337,7 +337,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 		show_fault_information(dev_name(data->sysmmu),
 					itype, base, addr);
 		if (data->domain)
-			ret = report_iommu_fault(data->domain,
+			ret = report_iommu_fault(&data->domain->domain,
 					data->master, addr, itype);
 	}
 
@@ -436,7 +436,7 @@ static void __sysmmu_enable_nocount(struct sysmmu_drvdata *data)
 }
 
 static int __sysmmu_enable(struct sysmmu_drvdata *data, phys_addr_t pgtable,
-			   struct iommu_domain *iommu_domain)
+			   struct exynos_iommu_domain *domain)
 {
 	int ret = 0;
 	unsigned long flags;
@@ -444,7 +444,7 @@ static int __sysmmu_enable(struct sysmmu_drvdata *data, phys_addr_t pgtable,
 	spin_lock_irqsave(&data->lock, flags);
 	if (set_sysmmu_active(data)) {
 		data->pgtable = pgtable;
-		data->domain = iommu_domain;
+		data->domain = domain;
 
 		__sysmmu_enable_nocount(data);
 
@@ -702,7 +702,7 @@ static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
 
 	data = dev_get_drvdata(owner->sysmmu);
 	if (data) {
-		ret = __sysmmu_enable(data, pagetable, iommu_domain);
+		ret = __sysmmu_enable(data, pagetable, domain);
 		if (ret >= 0) {
 			data->master = dev;
 
-- 
1.9.2
