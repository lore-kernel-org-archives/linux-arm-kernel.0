From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Mar 2016 22:37:17 +0100
Subject: [PATCH] iommu: provide of_xlate pointer unconditionally
Message-ID: <1458077877-474066-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

iommu drivers that support the standard DT bindings use a of_xlate
callback pointer, but that is only part of struct iommu_ops when
CONFIG_OF_IOMMU is enabled, leading to build errors in randconfig
builds when that is not provided:

drivers/iommu/mtk_iommu.c:497:2: error: unknown field 'of_xlate' specified in initializer
  .of_xlate = mtk_iommu_of_xlate,
  ^
drivers/iommu/mtk_iommu.c:497:14: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
  .of_xlate = mtk_iommu_of_xlate,
              ^~~~~~~~~~~~~~~~~~
drivers/iommu/mtk_iommu.c:497:14: note: (near initialization for 'mtk_iommu_ops.domain_get_attr')

We can work around it by adding more #ifdefs in each driver, but
it seems nicer to just allow setting the pointer even if it is
unused. This makes the driver code look nicer, and it gives better
compile-time coverage when test building on other architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 0df4fabe208d ("iommu/mediatek: Add mt8173 IOMMU driver")
---
 include/linux/iommu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a5c539fa5d2b..ef7a6ecd8584 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -195,9 +195,7 @@ struct iommu_ops {
 	/* Get the number of windows per domain */
 	u32 (*domain_get_windows)(struct iommu_domain *domain);
 
-#ifdef CONFIG_OF_IOMMU
 	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
-#endif
 
 	unsigned long pgsize_bitmap;
 	void *priv;
-- 
2.7.0
