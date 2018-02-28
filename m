From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 28 Feb 2018 18:47:20 +0000
Subject: [PATCH v2] arm64: Revert L1_CACHE_SHIFT back to 6 (64-byte cache line
 size)
Message-ID: <20180228184720.25467-1-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 97303480753e ("arm64: Increase the max granular size") increased
the cache line size to 128 to match Cavium ThunderX, apparently for some
performance benefit which could not be confirmed. This change, however,
has an impact on the network packets allocation in certain
circumstances, requiring slightly over a 4K page with a significant
performance degradation.

This patch reverts L1_CACHE_SHIFT back to 6 (64-byte cache line) while
keeping ARCH_DMA_MINALIGN at 128. The cache_line_size() function was
changed to default to ARCH_DMA_MINALIGN in the absence of a meaningful
CTR_EL0.CWG bit field.

In addition, if a system with ARCH_DMA_MINALIGN < CTR_EL0.CWG is
detected, the kernel will force swiotlb bounce buffering for all
non-coherent devices since DMA cache maintenance on sub-CWG ranges is
not safe, leading to data corruption.

Cc: Tirumalesh Chalamarla <tchalamarla@cavium.com>
Cc: Timur Tabi <timur@codeaurora.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

Changes since v1:
 
- Moved CWG check and swiotlb = 1 assignment to arm64_dma_init() following
  Robin's comment (swiotlb is __ro_after_init)

- The swiotlb_noncoherent_bounce label is now enabled in arm64_dma_init().
  There is a possibility of a platform with large CWG not having any 
  non-coherent device and dma_capable() being slightly slower. But this
  exercise is mostly theoretical anyway

- Removed Will's ack since I've made some small changes.

 arch/arm64/Kconfig                  |  1 +
 arch/arm64/include/asm/cache.h      |  6 +++---
 arch/arm64/include/asm/dma-direct.h | 43 +++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/cpufeature.c      |  9 ++------
 arch/arm64/mm/dma-mapping.c         | 17 +++++++++++++++
 arch/arm64/mm/init.c                |  3 ++-
 6 files changed, 68 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/include/asm/dma-direct.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7381eeb7ef8e..655c0e99d9fa 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -17,6 +17,7 @@ config ARM64
 	select ARCH_HAS_GIGANTIC_PAGE if (MEMORY_ISOLATION && COMPACTION) || CMA
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
+	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_STRICT_KERNEL_RWX
diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index ea9bb4e0e9bb..b2e6ece23713 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -29,7 +29,7 @@
 #define ICACHE_POLICY_VIPT	2
 #define ICACHE_POLICY_PIPT	3
 
-#define L1_CACHE_SHIFT		7
+#define L1_CACHE_SHIFT		(6)
 #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
 
 /*
@@ -39,7 +39,7 @@
  * cache before the transfer is done, causing old data to be seen by
  * the CPU.
  */
-#define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
+#define ARCH_DMA_MINALIGN	(128)
 
 #ifndef __ASSEMBLY__
 
@@ -73,7 +73,7 @@ static inline u32 cache_type_cwg(void)
 static inline int cache_line_size(void)
 {
 	u32 cwg = cache_type_cwg();
-	return cwg ? 4 << cwg : L1_CACHE_BYTES;
+	return cwg ? 4 << cwg : ARCH_DMA_MINALIGN;
 }
 
 #endif	/* __ASSEMBLY__ */
diff --git a/arch/arm64/include/asm/dma-direct.h b/arch/arm64/include/asm/dma-direct.h
new file mode 100644
index 000000000000..abb1b40ec751
--- /dev/null
+++ b/arch/arm64/include/asm/dma-direct.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_DMA_DIRECT_H
+#define __ASM_DMA_DIRECT_H
+
+#include <linux/jump_label.h>
+#include <linux/swiotlb.h>
+
+#include <asm/cache.h>
+
+DECLARE_STATIC_KEY_FALSE(swiotlb_noncoherent_bounce);
+
+static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+	dma_addr_t dev_addr = (dma_addr_t)paddr;
+
+	return dev_addr - ((dma_addr_t)dev->dma_pfn_offset << PAGE_SHIFT);
+}
+
+static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr)
+{
+	phys_addr_t paddr = (phys_addr_t)dev_addr;
+
+	return paddr + ((phys_addr_t)dev->dma_pfn_offset << PAGE_SHIFT);
+}
+
+static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
+{
+	if (!dev->dma_mask)
+		return false;
+
+	/*
+	 * Force swiotlb buffer bouncing when ARCH_DMA_MINALIGN < CWG. The
+	 * swiotlb bounce buffers are aligned to (1 << IO_TLB_SHIFT).
+	 */
+	if (static_branch_unlikely(&swiotlb_noncoherent_bounce) &&
+	    !is_device_dma_coherent(dev) &&
+	    !is_swiotlb_buffer(dma_to_phys(dev, addr)))
+		return false;
+
+	return addr + size - 1 <= *dev->dma_mask;
+}
+
+#endif /* __ASM_DMA_DIRECT_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 2985a067fc13..702901eadf75 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1385,7 +1385,6 @@ bool this_cpu_has_cap(unsigned int cap)
 void __init setup_cpu_features(void)
 {
 	u32 cwg;
-	int cls;
 
 	/* Set the CPU feature capabilies */
 	setup_feature_capabilities();
@@ -1405,13 +1404,9 @@ void __init setup_cpu_features(void)
 	 * Check for sane CTR_EL0.CWG value.
 	 */
 	cwg = cache_type_cwg();
-	cls = cache_line_size();
 	if (!cwg)
-		pr_warn("No Cache Writeback Granule information, assuming cache line size %d\n",
-			cls);
-	if (L1_CACHE_BYTES < cls)
-		pr_warn("L1_CACHE_BYTES smaller than the Cache Writeback Granule (%d < %d)\n",
-			L1_CACHE_BYTES, cls);
+		pr_warn("No Cache Writeback Granule information, assuming %d\n",
+			ARCH_DMA_MINALIGN);
 }
 
 static bool __maybe_unused
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index a96ec0181818..1e9dac8684ca 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -33,6 +33,7 @@
 #include <asm/cacheflush.h>
 
 static int swiotlb __ro_after_init;
+DEFINE_STATIC_KEY_FALSE(swiotlb_noncoherent_bounce);
 
 static pgprot_t __get_dma_pgprot(unsigned long attrs, pgprot_t prot,
 				 bool coherent)
@@ -504,6 +505,14 @@ static int __init arm64_dma_init(void)
 	    max_pfn > (arm64_dma_phys_limit >> PAGE_SHIFT))
 		swiotlb = 1;
 
+	if (WARN_TAINT(ARCH_DMA_MINALIGN < cache_line_size(),
+		       TAINT_CPU_OUT_OF_SPEC,
+		       "ARCH_DMA_MINALIGN smaller than CTR_EL0.CWG (%d < %d)",
+		       ARCH_DMA_MINALIGN, cache_line_size())) {
+		swiotlb = 1;
+		static_branch_enable(&swiotlb_noncoherent_bounce);
+	}
+
 	return atomic_pool_init();
 }
 arch_initcall(arm64_dma_init);
@@ -882,6 +891,14 @@ static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			const struct iommu_ops *iommu, bool coherent)
 {
+	/*
+	 * Enable swiotlb for buffer bouncing if ARCH_DMA_MINALIGN < CWG.
+	 * dma_capable() forces the actual bounce if the device is
+	 * non-coherent.
+	 */
+	if (static_branch_unlikely(&swiotlb_noncoherent_bounce) && !coherent)
+		iommu = NULL;
+
 	if (!dev->dma_ops)
 		dev->dma_ops = &arm64_swiotlb_dma_ops;
 
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 9f3c47acf8ff..664acf177799 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -586,7 +586,8 @@ static void __init free_unused_memmap(void)
 void __init mem_init(void)
 {
 	if (swiotlb_force == SWIOTLB_FORCE ||
-	    max_pfn > (arm64_dma_phys_limit >> PAGE_SHIFT))
+	    max_pfn > (arm64_dma_phys_limit >> PAGE_SHIFT) ||
+	    ARCH_DMA_MINALIGN < cache_line_size())
 		swiotlb_init(1);
 	else
 		swiotlb_force = SWIOTLB_NO_FORCE;
