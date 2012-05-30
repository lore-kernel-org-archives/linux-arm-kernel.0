From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 30 May 2012 10:59:51 +0200
Subject: [PATCH] ARM: dma-mapping: remove unconditional dependency on CMA
In-Reply-To: <20120529122932.GA24623@n2100.arm.linux.org.uk>
References: <20120529122932.GA24623@n2100.arm.linux.org.uk>
Message-ID: <1338368391-25057-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CMA has been enabled unconditionally on all ARMv6+ systems to solve the
long standing issue of double kernel mappings for all dma coherent
buffers. This however created a dependency on CONFIG_EXPERIMENTAL for
the whole ARM architecture what should be really avoided. This patch
removes this dependency and lets one use old, well-tested dma-mapping
implementation also on ARMv6+ systems without the need to use
EXPERIMENTAL stuff.

Reported-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/Kconfig          |    1 -
 arch/arm/mm/dma-mapping.c |   10 ++++------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5e76013..ca7354f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -7,7 +7,6 @@ config ARM
 	select HAVE_IDE if PCI || ISA || PCMCIA
 	select HAVE_DMA_ATTRS
 	select HAVE_DMA_CONTIGUOUS if (CPU_V6 || CPU_V6K || CPU_V7)
-	select CMA if (CPU_V6 || CPU_V6K || CPU_V7)
 	select HAVE_MEMBLOCK
 	select RTC_LIB
 	select SYS_SUPPORTS_APM_EMULATION
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index ea6b431..106c4c0 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -268,10 +268,8 @@ static int __init consistent_init(void)
 	unsigned long base = consistent_base;
 	unsigned long num_ptes = (CONSISTENT_END - base) >> PMD_SHIFT;
 
-#ifndef CONFIG_ARM_DMA_USE_IOMMU
-	if (cpu_architecture() >= CPU_ARCH_ARMv6)
+	if (IS_ENABLED(CONFIG_CMA) && !IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU))
 		return 0;
-#endif
 
 	consistent_pte = kmalloc(num_ptes * sizeof(pte_t), GFP_KERNEL);
 	if (!consistent_pte) {
@@ -342,7 +340,7 @@ static int __init coherent_init(void)
 	struct page *page;
 	void *ptr;
 
-	if (cpu_architecture() < CPU_ARCH_ARMv6)
+	if (!IS_ENABLED(CONFIG_CMA))
 		return 0;
 
 	ptr = __alloc_from_contiguous(NULL, size, prot, &page);
@@ -704,7 +702,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 
 	if (arch_is_coherent() || nommu())
 		addr = __alloc_simple_buffer(dev, size, gfp, &page);
-	else if (cpu_architecture() < CPU_ARCH_ARMv6)
+	else if (!IS_ENABLED(CONFIG_CMA))
 		addr = __alloc_remap_buffer(dev, size, gfp, prot, &page, caller);
 	else if (gfp & GFP_ATOMIC)
 		addr = __alloc_from_pool(dev, size, &page, caller);
@@ -773,7 +771,7 @@ void arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
 
 	if (arch_is_coherent() || nommu()) {
 		__dma_free_buffer(page, size);
-	} else if (cpu_architecture() < CPU_ARCH_ARMv6) {
+	} else if (!IS_ENABLED(CONFIG_CMA)) {
 		__dma_free_remap(cpu_addr, size);
 		__dma_free_buffer(page, size);
 	} else {
-- 
1.7.1.569.g6f426
