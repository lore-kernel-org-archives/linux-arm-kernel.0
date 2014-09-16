From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 16 Sep 2014 13:54:40 +0200
Subject: [PATCH v2 13/18] iommu: exynos: add support for runtime_pm
In-Reply-To: <1410868485-4143-1-git-send-email-m.szyprowski@samsung.com>
References: <1410868485-4143-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1410868485-4143-14-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes support for runtime power management for SYSMMU
controllers, so they are enabled when master device is attached.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index cf36cdecf335..5a6d3d0af61e 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -696,6 +696,7 @@ static int exynos_iommu_attach_device(struct iommu_domain *domain,
 		return -ENODEV;
 
 	list_for_each_entry(data, &owner->clients, owner_node) {
+		pm_runtime_get_sync(data->sysmmu);
 		ret = __sysmmu_enable(data, pagetable, domain);
 		if (ret >= 0) {
 			data->master = dev;
@@ -737,6 +738,7 @@ static void exynos_iommu_detach_device(struct iommu_domain *domain,
 				data->master = NULL;
 				list_del_init(&data->domain_node);
 			}
+			pm_runtime_put(data->sysmmu);
 			found = true;
 		}
 	}
-- 
1.9.2
