From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 05 Dec 2014 14:47:37 +0100
Subject: [PATCH] iommu: Fix build of allmod/allyes config on ARMv8 architecture
Message-ID: <1417787257-10056-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Disable the Exynos IOMMU on ARMv8-A architecture so the build won't fail.
The Exynos7 is not supported yet by Exynos IOMMU driver.

This fixes following build errors on ARMv8 (allmodconfig, allyesconfig):

drivers/iommu/exynos-iommu.c: In function ?pgtable_flush?:
drivers/iommu/exynos-iommu.c:694:2: error: implicit declaration of function ?dmac_flush_range? [-Werror=implicit-function-declaration]
  dmac_flush_range(vastart, vaend);
  ^
drivers/iommu/exynos-iommu.c:695:2: error: implicit declaration of function ?outer_flush_range? [-Werror=implicit-function-declaration]
  outer_flush_range(virt_to_phys(vastart),
  ^
In file included from include/uapi/linux/stddef.h:1:0,
                 from include/linux/stddef.h:4,
                 from ./include/uapi/linux/posix_types.h:4,
                 from include/uapi/linux/types.h:13,
                 from include/linux/types.h:5,
                 from include/linux/io.h:21,
                 from drivers/iommu/exynos-iommu.c:15:
drivers/iommu/exynos-iommu.c: In function ?alloc_lv2entry?:
drivers/iommu/exynos-iommu.c:853:10: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
   BUG_ON((unsigned int)pent & (LV2TABLE_SIZE - 1));
          ^
include/linux/compiler.h:160:42: note: in definition of macro ?unlikely?
 # define unlikely(x) __builtin_expect(!!(x), 0)
                                          ^
drivers/iommu/exynos-iommu.c:853:3: note: in expansion of macro ?BUG_ON?
   BUG_ON((unsigned int)pent & (LV2TABLE_SIZE - 1));
   ^
cc1: some warnings being treated as errors
make[2]: *** [drivers/iommu/exynos-iommu.o] Error 1
make[1]: *** [drivers/iommu] Error 2
make[1]: *** Waiting for unfinished jobs....

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 30f0e61341c5..dbdcb5be8583 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -187,7 +187,7 @@ config TEGRA_IOMMU_SMMU
 
 config EXYNOS_IOMMU
 	bool "Exynos IOMMU Support"
-	depends on ARCH_EXYNOS
+	depends on ARCH_EXYNOS && !ARCH_EXYNOS7
 	select IOMMU_API
 	select ARM_DMA_USE_IOMMU
 	help
-- 
1.9.1
