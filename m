From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 20 May 2016 15:48:21 +0200
Subject: [PATCH] iommu/exynos: Suppress unbinding to prevent system failure
Message-ID: <1463752114-23653-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removal of IOMMU driver cannot be done reliably, so Exynos IOMMU driver
doesn't support this operation. It is essential for system operation, so
it makes sense to prevent unbinding by disabling bind/unbind sysfs
feature for SYSMMU controller driver to avoid kernel ops or trashing
memory caused by such operation.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
CC: stable at vger.kernel.org  # v4.2+
---
 drivers/iommu/exynos-iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 558a40d3a6a0..d365c40a7b84 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -681,6 +681,7 @@ static struct platform_driver exynos_sysmmu_driver __refdata = {
 		.name		= "exynos-sysmmu",
 		.of_match_table	= sysmmu_of_match,
 		.pm		= &sysmmu_pm_ops,
+		.suppress_bind_attrs = true,
 	}
 };
 
-- 
1.9.2
