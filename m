From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 19 May 2015 15:20:34 +0200
Subject: [PATCH v7 14/25] iommu/exynos: Add support for runtime_pm
In-Reply-To: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1432041645-11172-15-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes support for runtime power management for SYSMMU
controllers, so they are enabled when master device is attached.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 946f95ae46bc..fcd23e9c409a 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -715,6 +715,7 @@ static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
 		return -ENODEV;
 
 	list_for_each_entry(data, &owner->controllers, owner_node) {
+		pm_runtime_get_sync(data->sysmmu);
 		ret = __sysmmu_enable(data, pagetable, domain);
 		if (ret >= 0) {
 			data->master = dev;
@@ -756,6 +757,7 @@ static void exynos_iommu_detach_device(struct iommu_domain *iommu_domain,
 				data->master = NULL;
 				list_del_init(&data->domain_node);
 			}
+			pm_runtime_put(data->sysmmu);
 			found = true;
 		}
 	}
-- 
1.9.2
