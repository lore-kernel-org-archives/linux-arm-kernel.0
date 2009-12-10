From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 10 Dec 2009 16:21:29 -0500 (EST)
Subject: dma_cache_maint_contiguous should be patched as dma_cache_maint do
In-Reply-To: <20091210163920.GA13210@n2100.arm.linux.org.uk>
References: <SNT109-W4788A2C238168B3B9086CBA78D0@phx.gbl>
	<1260459307.23073.41.camel@pc1117.cambridge.arm.com>
	<20091210163920.GA13210@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.0912101529320.31174@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Dec 2009, Russell King - ARM Linux wrote:

> If it is just ARMv6 which is affected by this (note that we can not rely
> upon ID_MMFR3 telling us since this register has a different purpose
> there) then we can solve this by just modifying the ARMv6 DMA cache
> methods - which becomes easier if I get the rearrangement of the DMA
> stuff finally sorted.  The *only* thing that remains in the way of that
> is the stupid flush_ioremap_region() crap for just one MTD driver.

My suggestion: kill flush_ioremap_region() and substitute it by an ARMv5 
cache range invalidate loop implementation local to that driver.

While at it, here's the patch:

-----

Subject: ARM: kill flush_ioremap_region()

There is not enough users to warrant its existance, and it is actually
an obstacle to progress with the new DMA API which cannot cover this
case properly.

To keep backward compatibility, let's do the necessary cache maintenance
locally in the only driver affected.

Signed-off-by: Nicolas Pitre <nico@marvell.com>

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 3d0cdd2..244fb97 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -456,13 +456,6 @@ static inline void flush_kernel_dcache_page(struct page *page)
  */
 #define flush_icache_page(vma,page)	do { } while (0)
 
-static inline void flush_ioremap_region(unsigned long phys, void __iomem *virt,
-	unsigned offset, size_t size)
-{
-	const void *start = (void __force *)virt + offset;
-	dmac_inv_range(start, start + size);
-}
-
 /*
  * flush_cache_vmap() is used when creating mappings (eg, via vmap,
  * vmalloc, ioremap etc) in kernel space for pages.  On non-VIPT
diff --git a/arch/arm/mm/proc-syms.c b/arch/arm/mm/proc-syms.c
index ac5c800..f604aa8 100644
--- a/arch/arm/mm/proc-syms.c
+++ b/arch/arm/mm/proc-syms.c
@@ -28,7 +28,6 @@ EXPORT_SYMBOL(__cpuc_flush_user_all);
 EXPORT_SYMBOL(__cpuc_flush_user_range);
 EXPORT_SYMBOL(__cpuc_coherent_kern_range);
 EXPORT_SYMBOL(__cpuc_flush_dcache_page);
-EXPORT_SYMBOL(dmac_inv_range);  /* because of flush_ioremap_region() */
 #else
 EXPORT_SYMBOL(cpu_cache);
 #endif
diff --git a/drivers/mtd/maps/pxa2xx-flash.c b/drivers/mtd/maps/pxa2xx-flash.c
index 74fa075..b13f641 100644
--- a/drivers/mtd/maps/pxa2xx-flash.c
+++ b/drivers/mtd/maps/pxa2xx-flash.c
@@ -20,14 +20,23 @@
 
 #include <asm/io.h>
 #include <mach/hardware.h>
-#include <asm/cacheflush.h>
 
 #include <asm/mach/flash.h>
 
+#define CACHELINESIZE	32
+
 static void pxa2xx_map_inval_cache(struct map_info *map, unsigned long from,
 				      ssize_t len)
 {
-	flush_ioremap_region(map->phys, map->cached, from, len);
+	unsigned long start = (unsigned long)map->cached + from;
+	unsigned long end = start + len;
+
+	start &= ~(CACHELINESIZE - 1);
+	while (start < end) {
+		/* invalidate D cache line */
+		asm volatile ("mcr p15, 0, %0, c7, c6, 1" : : "r" (start));
+		start += CACHELINESIZE;
+	}
 }
 
 struct pxa2xx_flash_info {
