From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Jul 2011 09:13:15 +0100
Subject: [PATCH 01/10] ARM: change ARM_DMA_ZONE_SIZE into a variable
In-Reply-To: <20110708203045.GT4812@n2100.arm.linux.org.uk>
References: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
	<20110706230455.GZ8286@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107062043180.14596@xanadu.home>
	<20110708121441.GD4812@n2100.arm.linux.org.uk>
	<20110708203045.GT4812@n2100.arm.linux.org.uk>
Message-ID: <20110709081315.GB30368@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 09:30:45PM +0100, Russell King - ARM Linux wrote:
> On Fri, Jul 08, 2011 at 01:14:41PM +0100, Russell King - ARM Linux wrote:
> > It looks like ISA_DMA_THRESHOLD has become unused by most of the kernel,
> > so yes, renaming it to "dma_zone_limit" would be more descriptive.  We
> > should probably make dma_supported() be out-of-line anyway (which then
> > means that dma_zone_limit doesn't have to be exported to drivers) - and
> > I think the DMA bounce stuff needs cleaning up in dma_set_mask().
> 
> ... and I now have a patch which does this, pending testing.  Once
> I've tested it I'll send it out.

8<--------
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
ARM: dma: replace ISA_DMA_THRESHOLD with a variable

ISA_DMA_THRESHOLD has been unused by non-arch code, so lets now get
rid of it from ARM by replacing it with arm_dma_zone_mask.  Move
dma_supported() and dma_set_mask() out of line, and have
dma_supported() check this new variable instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/dma-mapping.h |   29 ++---------------------------
 arch/arm/include/asm/memory.h      |   12 ------------
 arch/arm/mm/dma-mapping.c          |   35 ++++++++++++++++++++++++++++++++---
 arch/arm/mm/init.c                 |   10 ++++++++++
 arch/arm/mm/mm.h                   |    6 ++++++
 5 files changed, 50 insertions(+), 42 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 94662f4..7a21d0b 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -115,33 +115,8 @@ static inline void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
 		___dma_page_dev_to_cpu(page, off, size, dir);
 }
 
-/*
- * Return whether the given device DMA address mask can be supported
- * properly.  For example, if your device can only drive the low 24-bits
- * during bus mastering, then you would pass 0x00ffffff as the mask
- * to this function.
- *
- * FIXME: This should really be a platform specific issue - we should
- * return false if GFP_DMA allocations may not satisfy the supplied 'mask'.
- */
-static inline int dma_supported(struct device *dev, u64 mask)
-{
-	if (mask < ISA_DMA_THRESHOLD)
-		return 0;
-	return 1;
-}
-
-static inline int dma_set_mask(struct device *dev, u64 dma_mask)
-{
-	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
-		return -EIO;
-
-#ifndef CONFIG_DMABOUNCE
-	*dev->dma_mask = dma_mask;
-#endif
-
-	return 0;
-}
+extern int dma_supported(struct device *, u64);
+extern int dma_set_mask(struct device *, u64);
 
 /*
  * DMA errors are defined by all-bits-set in the DMA address.
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index af44a8f..b8de516 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -204,18 +204,6 @@ static inline unsigned long __phys_to_virt(unsigned long x)
 #endif
 
 /*
- * The DMA mask corresponding to the maximum bus address allocatable
- * using GFP_DMA.  The default here places no restriction on DMA
- * allocations.  This must be the smallest DMA mask in the system,
- * so a successful GFP_DMA allocation will always satisfy this.
- */
-#ifndef ARM_DMA_ZONE_SIZE
-#define ISA_DMA_THRESHOLD	(0xffffffffULL)
-#else
-#define ISA_DMA_THRESHOLD	(PHYS_OFFSET + ARM_DMA_ZONE_SIZE - 1)
-#endif
-
-/*
  * PFNs are used to describe any physical page; this means
  * PFN 0 == physical address 0.
  *
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 82a093c..0a0a1e7 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -25,9 +25,11 @@
 #include <asm/tlbflush.h>
 #include <asm/sizes.h>
 
+#include "mm.h"
+
 static u64 get_coherent_dma_mask(struct device *dev)
 {
-	u64 mask = ISA_DMA_THRESHOLD;
+	u64 mask = (u64)arm_dma_limit;
 
 	if (dev) {
 		mask = dev->coherent_dma_mask;
@@ -41,10 +43,10 @@ static u64 get_coherent_dma_mask(struct device *dev)
 			return 0;
 		}
 
-		if ((~mask) & ISA_DMA_THRESHOLD) {
+		if ((~mask) & (u64)arm_dma_limit) {
 			dev_warn(dev, "coherent DMA mask %#llx is smaller "
 				 "than system GFP_DMA mask %#llx\n",
-				 mask, (unsigned long long)ISA_DMA_THRESHOLD);
+				 mask, (u64)arm_dma_limit);
 			return 0;
 		}
 	}
@@ -657,6 +659,33 @@ void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 }
 EXPORT_SYMBOL(dma_sync_sg_for_device);
 
+/*
+ * Return whether the given device DMA address mask can be supported
+ * properly.  For example, if your device can only drive the low 24-bits
+ * during bus mastering, then you would pass 0x00ffffff as the mask
+ * to this function.
+ */
+int dma_supported(struct device *dev, u64 mask)
+{
+	if (mask < (u64)arm_dma_limit)
+		return 0;
+	return 1;
+}
+EXPORT_SYMBOL(dma_supported);
+
+int dma_set_mask(struct device *dev, u64 dma_mask)
+{
+	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
+		return -EIO;
+
+#ifndef CONFIG_DMABOUNCE
+	*dev->dma_mask = dma_mask;
+#endif
+
+	return 0;
+}
+EXPORT_SYMBOL(dma_set_mask);
+
 #define PREALLOC_DMA_DEBUG_ENTRIES	4096
 
 static int __init dma_debug_do_init(void)
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index c19571c..b9efa18 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -212,6 +212,14 @@ static void __init arm_bootmem_init(unsigned long start_pfn,
 }
 
 #ifdef CONFIG_ZONE_DMA
+/*
+ * The DMA mask corresponding to the maximum bus address allocatable
+ * using GFP_DMA.  The default here places no restriction on DMA
+ * allocations.  This must be the smallest DMA mask in the system,
+ * so a successful GFP_DMA allocation will always satisfy this.
+ */
+u32 arm_dma_zone_size;
+
 static void __init arm_adjust_dma_zone(unsigned long *size, unsigned long *hole,
 	unsigned long dma_size)
 {
@@ -278,6 +286,8 @@ static void __init arm_bootmem_free(unsigned long min, unsigned long max_low,
 	 */
 	arm_adjust_dma_zone(zone_size, zhole_size,
 		ARM_DMA_ZONE_SIZE >> PAGE_SHIFT);
+
+	arm_dma_limit = PHYS_OFFSET + ARM_DMA_ZONE_SIZE - 1;
 #endif
 
 	free_area_init_node(0, zone_size, min, zhole_size);
diff --git a/arch/arm/mm/mm.h b/arch/arm/mm/mm.h
index 5b3d7d5..0105667 100644
--- a/arch/arm/mm/mm.h
+++ b/arch/arm/mm/mm.h
@@ -23,5 +23,11 @@ extern void __flush_dcache_page(struct address_space *mapping, struct page *page
 
 #endif
 
+#ifdef CONFIG_ZONE_DMA
+extern u32 arm_dma_limit;
+#else
+#define arm_dma_limit ((u32)~0)
+#endif
+
 void __init bootmem_init(void);
 void arm_mm_memblock_reserve(void);
-- 
1.7.4.4
