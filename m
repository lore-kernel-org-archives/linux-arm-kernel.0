From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 23 Jan 2015 16:51:22 +0100
Subject: [PATCH v5 12/18] iommu: exynos: add support for binding more than one
 sysmmu to master device
In-Reply-To: <1422028288-891-1-git-send-email-m.szyprowski@samsung.com>
References: <1422028288-891-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1422028288-891-13-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for assigning more than one SYSMMU controller to
the master device. This has been achieved simply by chaning the struct
device pointer in struct exynos_iommu_owner into the list of struct
sysmmu_drvdata of all controllers assigned to the given master device.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index e40e699..c6cca44 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -186,7 +186,7 @@ static char *sysmmu_fault_name[SYSMMU_FAULTS_NUM] = {
 
 /* attached to dev.archdata.iommu of the master device */
 struct exynos_iommu_owner {
-	struct device *sysmmu;
+	struct list_head clients;
 };
 
 struct exynos_iommu_domain {
@@ -207,6 +207,7 @@ struct sysmmu_drvdata {
 	spinlock_t lock;
 	struct iommu_domain *domain;
 	struct list_head domain_node;
+	struct list_head owner_node;
 	phys_addr_t pgtable;
 	int version;
 };
@@ -693,8 +694,7 @@ static int exynos_iommu_attach_device(struct iommu_domain *domain,
 	if (!has_sysmmu(dev))
 		return -ENODEV;
 
-	data = dev_get_drvdata(owner->sysmmu);
-	if (data) {
+	list_for_each_entry(data, &owner->clients, owner_node) {
 		ret = __sysmmu_enable(data, pagetable, domain);
 		if (ret >= 0) {
 			data->master = dev;
@@ -722,7 +722,7 @@ static void exynos_iommu_detach_device(struct iommu_domain *domain,
 {
 	struct exynos_iommu_domain *priv = domain->priv;
 	phys_addr_t pagetable = virt_to_phys(priv->pgtable);
-	struct sysmmu_drvdata *data;
+	struct sysmmu_drvdata *data, *next;
 	unsigned long flags;
 	int found = 0;
 
@@ -730,14 +730,13 @@ static void exynos_iommu_detach_device(struct iommu_domain *domain,
 		return;
 
 	spin_lock_irqsave(&priv->lock, flags);
-	list_for_each_entry(data, &priv->clients, domain_node) {
+	list_for_each_entry_safe(data, next, &priv->clients, domain_node) {
 		if (data->master == dev) {
 			if (__sysmmu_disable(data)) {
 				data->master = NULL;
 				list_del_init(&data->domain_node);
 			}
 			found = true;
-			break;
 		}
 	}
 	spin_unlock_irqrestore(&priv->lock, flags);
-- 
1.9.2
