From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 25 Apr 2018 12:10:51 +0200
Subject: [PATCH v2 5/5] ARM: Unconditionally enable ARM_DMA_USE_IOMMU
In-Reply-To: <20180425101051.15349-1-thierry.reding@gmail.com>
References: <20180425101051.15349-1-thierry.reding@gmail.com>
Message-ID: <20180425101051.15349-5-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

The ARM_DMA_USE_IOMMU Kconfig option has side-effects that drivers can
not opt into but have to explicitly opt out of. This can lead to subtle
bugs that are difficult to track down and not immediately obvious to be
related to this Kconfig option.

To avoid this confusion, always enable the option to expose any lurking
bugs once and allow any regressions introduced by the DMA/IOMMU code to
be caught more quickly in the future.

Note that some drivers still use the Kconfig symbol to provide different
code paths depending on what architecture the code runs on (e.g. 32-bit
ARM vs. 64-bit ARM which have different and incompatible implementations
of the DMA/IOMMU integration code), so leave the symbol in place to keep
those drivers working.

For the long term, it is preferable to transition everyone to the
generic DMA/IOMMU integration code in drivers/iommu/dma-iommu.c.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- new patch

 arch/arm/Kconfig               |  2 +-
 arch/arm/include/asm/device.h  |  6 ------
 arch/arm/mm/dma-mapping.c      | 18 ------------------
 drivers/iommu/Kconfig          |  7 -------
 drivers/media/platform/Kconfig |  1 -
 5 files changed, 1 insertion(+), 33 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fa0b190f8a38..3c91de78535a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -124,7 +124,7 @@ config NEED_SG_DMA_LENGTH
 	bool
 
 config ARM_DMA_USE_IOMMU
-	bool
+	def_bool y
 	select ARM_HAS_SG_CHAIN
 	select NEED_SG_DMA_LENGTH
 
diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
index 3234fe9bba6e..c3cf38e16866 100644
--- a/arch/arm/include/asm/device.h
+++ b/arch/arm/include/asm/device.h
@@ -13,9 +13,7 @@ struct dev_archdata {
 #ifdef CONFIG_IOMMU_API
 	void *iommu; /* private IOMMU data */
 #endif
-#ifdef CONFIG_ARM_DMA_USE_IOMMU
 	struct dma_iommu_mapping	*mapping;
-#endif
 #ifdef CONFIG_XEN
 	const struct dma_map_ops *dev_dma_ops;
 #endif
@@ -31,10 +29,6 @@ struct pdev_archdata {
 #endif
 };
 
-#ifdef CONFIG_ARM_DMA_USE_IOMMU
 #define to_dma_iommu_mapping(dev) ((dev)->archdata.mapping)
-#else
-#define to_dma_iommu_mapping(dev) NULL
-#endif
 
 #endif
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index cc63a25bd088..f6c28ed5651a 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1174,8 +1174,6 @@ static int __init dma_debug_do_init(void)
 }
 core_initcall(dma_debug_do_init);
 
-#ifdef CONFIG_ARM_DMA_USE_IOMMU
-
 static int __dma_info_to_prot(enum dma_data_direction dir, unsigned long attrs)
 {
 	int prot = 0;
@@ -2366,20 +2364,6 @@ static void arm_teardown_iommu_dma_ops(struct device *dev)
 	arm_iommu_release_mapping(mapping);
 }
 
-#else
-
-static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
-				    const struct iommu_ops *iommu)
-{
-	return false;
-}
-
-static void arm_teardown_iommu_dma_ops(struct device *dev) { }
-
-#define arm_get_iommu_dma_map_ops arm_get_dma_map_ops
-
-#endif	/* CONFIG_ARM_DMA_USE_IOMMU */
-
 static const struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
 {
 	return coherent ? &arm_coherent_dma_ops : &arm_dma_ops;
@@ -2426,7 +2410,6 @@ void arch_teardown_dma_ops(struct device *dev)
 
 void arch_iommu_detach_device(struct device *dev)
 {
-#ifdef CONFIG_ARM_DMA_USE_IOMMU
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	const struct dma_map_ops *dma_ops;
 
@@ -2438,5 +2421,4 @@ void arch_iommu_detach_device(struct device *dev)
 
 	dma_ops = arm_get_dma_map_ops(dev->archdata.dma_coherent);
 	set_dma_ops(dev, dma_ops);
-#endif
 }
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index df171cb85822..7f0b3ca76a17 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -226,7 +226,6 @@ config ROCKCHIP_IOMMU
 	depends on ARM || ARM64
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	select IOMMU_API
-	select ARM_DMA_USE_IOMMU
 	help
 	  Support for IOMMUs found on Rockchip rk32xx SOCs.
 	  These IOMMUs allow virtualization of the address space used by most
@@ -259,7 +258,6 @@ config EXYNOS_IOMMU
 	depends on ARCH_EXYNOS && MMU
 	depends on !CPU_BIG_ENDIAN # revisit driver if we can enable big-endian ptes
 	select IOMMU_API
-	select ARM_DMA_USE_IOMMU
 	help
 	  Support for the IOMMU (System MMU) of Samsung Exynos application
 	  processor family. This enables H/W multimedia accelerators to see
@@ -283,7 +281,6 @@ config IPMMU_VMSA
 	depends on ARCH_RENESAS || (COMPILE_TEST && !GENERIC_ATOMIC64)
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
-	select ARM_DMA_USE_IOMMU
 	help
 	  Support for the Renesas VMSA-compatible IPMMU Renesas found in the
 	  R-Mobile APE6 and R-Car H2/M2 SoCs.
@@ -304,7 +301,6 @@ config ARM_SMMU
 	depends on (ARM64 || ARM) && MMU
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
-	select ARM_DMA_USE_IOMMU if ARM
 	help
 	  Support for implementations of the ARM System MMU architecture
 	  versions 1 and 2.
@@ -344,7 +340,6 @@ config MTK_IOMMU
 	bool "MTK IOMMU Support"
 	depends on ARM || ARM64
 	depends on ARCH_MEDIATEK || COMPILE_TEST
-	select ARM_DMA_USE_IOMMU
 	select IOMMU_API
 	select IOMMU_DMA
 	select IOMMU_IO_PGTABLE_ARMV7S
@@ -361,7 +356,6 @@ config MTK_IOMMU_V1
 	bool "MTK IOMMU Version 1 (M4U gen1) Support"
 	depends on ARM
 	depends on ARCH_MEDIATEK || COMPILE_TEST
-	select ARM_DMA_USE_IOMMU
 	select IOMMU_API
 	select MEMORY
 	select MTK_SMI
@@ -379,7 +373,6 @@ config QCOM_IOMMU
 	depends on HAS_DMA
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
-	select ARM_DMA_USE_IOMMU
 	help
 	  Support for IOMMU on certain Qualcomm SoCs.
 
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index e3229f7baed1..5f7135b052ed 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -66,7 +66,6 @@ config VIDEO_OMAP3
 	depends on (ARCH_OMAP3 && OMAP_IOMMU) || COMPILE_TEST
 	depends on COMMON_CLK
 	depends on HAS_DMA && OF
-	select ARM_DMA_USE_IOMMU if OMAP_IOMMU
 	select VIDEOBUF2_DMA_CONTIG
 	select MFD_SYSCON
 	select V4L2_FWNODE
-- 
2.17.0
