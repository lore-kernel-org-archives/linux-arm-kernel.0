From: robin.murphy@arm.com (Robin Murphy)
Date: Mon,  8 Jan 2018 19:27:51 +0000
Subject: [PATCH] iommu/exynos: Don't unconditionally steal bus ops
Message-ID: <1432caf4ecfb077bb54f0115cb5e12b6620e8bfa.1515439558.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removing the early device registration hook overlooked the fact that
it only ran conditionally on a compatible device being present in the
DT. With exynos_iommu_init() now running as an unconditional initcall,
problems arise on non-Exynos systems when other IOMMU drivers find
themselves unable to install their ops on the platform bus, or at worst
the Exynos ops get called with someone else's domain and all hell breaks
loose.

Fix this by delaying the setting of bus ops until an Exynos IOMMU is
actually found, to replicate the previous order of events.

Fixes: 928055a01b3f ("iommu/exynos: Remove custom platform device registration code")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/exynos-iommu.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 6a96a4c42153..e9e756156429 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -574,6 +574,12 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 	struct sysmmu_drvdata *data;
 	struct resource *res;
 
+	if (platform_bus_type->iommu_ops != &exynos_iommu_ops) {
+		ret = bus_set_iommu(&platform_bus_type, &exynos_iommu_ops);
+		if (ret)
+			return ret;
+	}
+
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -1367,16 +1373,8 @@ static int __init exynos_iommu_init(void)
 		goto err_zero_lv2;
 	}
 
-	ret = bus_set_iommu(&platform_bus_type, &exynos_iommu_ops);
-	if (ret) {
-		pr_err("%s: Failed to register exynos-iommu driver.\n",
-								__func__);
-		goto err_set_iommu;
-	}
-
 	return 0;
-err_set_iommu:
-	kmem_cache_free(lv2table_kmem_cache, zero_lv2_table);
+
 err_zero_lv2:
 	platform_driver_unregister(&exynos_sysmmu_driver);
 err_reg_driver:
-- 
2.13.4.dirty
