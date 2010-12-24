From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Dec 2010 11:11:25 +0000
Subject: [PATCH] Replace page_to_dma()/dma_to_page() with
	pfn_to_dma()/dma_to_pfn()
Message-ID: <20101224111125.GD20587@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the page_to_dma() and dma_to_page() macros with their PFN
equivalents.  This allows us to map parts of memory which do not have
a struct page allocated to them to bus addresses.  This will be used
internally by dma_alloc_coherent()/dma_alloc_writecombine().

Build tested on Versatile, OMAP1, IOP13xx and KS8695.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/dma-mapping.h          |   34 +++++++++++++++------------
 arch/arm/mach-iop13xx/include/mach/memory.h |    6 ++--
 arch/arm/mach-ks8695/include/mach/memory.h  |    8 +++---
 arch/arm/mm/dma-mapping.c                   |    4 +-
 arch/arm/plat-omap/include/plat/memory.h    |    8 +++---
 5 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index c568da7..8f69b98 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -9,20 +9,24 @@
 #include <asm-generic/dma-coherent.h>
 #include <asm/memory.h>
 
+#ifdef __arch_page_to_dma
+#error Please update to __arch_pfn_to_dma
+#endif
+
 /*
- * page_to_dma/dma_to_virt/virt_to_dma are architecture private functions
- * used internally by the DMA-mapping API to provide DMA addresses. They
- * must not be used by drivers.
+ * dma_to_pfn/pfn_to_dma/dma_to_virt/virt_to_dma are architecture private
+ * functions used internally by the DMA-mapping API to provide DMA
+ * addresses. They must not be used by drivers.
  */
-#ifndef __arch_page_to_dma
-static inline dma_addr_t page_to_dma(struct device *dev, struct page *page)
+#ifndef __arch_pfn_to_dma
+static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
 {
-	return (dma_addr_t)__pfn_to_bus(page_to_pfn(page));
+	return (dma_addr_t)__pfn_to_bus(pfn);
 }
 
-static inline struct page *dma_to_page(struct device *dev, dma_addr_t addr)
+static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
 {
-	return pfn_to_page(__bus_to_pfn(addr));
+	return __bus_to_pfn(addr);
 }
 
 static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
@@ -35,14 +39,14 @@ static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
 	return (dma_addr_t)__virt_to_bus((unsigned long)(addr));
 }
 #else
-static inline dma_addr_t page_to_dma(struct device *dev, struct page *page)
+static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
 {
-	return __arch_page_to_dma(dev, page);
+	return __arch_pfn_to_dma(dev, pfn);
 }
 
-static inline struct page *dma_to_page(struct device *dev, dma_addr_t addr)
+static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
 {
-	return __arch_dma_to_page(dev, addr);
+	return __arch_dma_to_pfn(dev, addr);
 }
 
 static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
@@ -368,7 +372,7 @@ static inline dma_addr_t dma_map_page(struct device *dev, struct page *page,
 
 	__dma_page_cpu_to_dev(page, offset, size, dir);
 
-	return page_to_dma(dev, page) + offset;
+	return pfn_to_dma(dev, page_to_pfn(page)) + offset;
 }
 
 /**
@@ -408,8 +412,8 @@ static inline void dma_unmap_single(struct device *dev, dma_addr_t handle,
 static inline void dma_unmap_page(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir)
 {
-	__dma_page_dev_to_cpu(dma_to_page(dev, handle), handle & ~PAGE_MASK,
-		size, dir);
+	__dma_page_dev_to_cpu(pfn_to_page(dma_to_pfn(dev, handle)),
+		handle & ~PAGE_MASK, size, dir);
 }
 #endif /* CONFIG_DMABOUNCE */
 
diff --git a/arch/arm/mach-iop13xx/include/mach/memory.h b/arch/arm/mach-iop13xx/include/mach/memory.h
index 7415e43..3ad4553 100644
--- a/arch/arm/mach-iop13xx/include/mach/memory.h
+++ b/arch/arm/mach-iop13xx/include/mach/memory.h
@@ -58,13 +58,13 @@ static inline unsigned long __lbus_to_virt(dma_addr_t x)
 		__dma;							\
 	})
 
-#define __arch_page_to_dma(dev, page)					\
+#define __arch_pfn_to_dma(dev, pfn)					\
 	({								\
 		/* __is_lbus_virt() can never be true for RAM pages */	\
-		(dma_addr_t)page_to_phys(page);				\
+		(dma_addr_t)__pfn_to_phys(pfn);				\
 	})
 
-#define __arch_dma_to_page(dev, addr)	phys_to_page(addr)
+#define __arch_dma_to_pfn(dev, addr)	__phys_to_pfn(addr)
 
 #endif /* CONFIG_ARCH_IOP13XX */
 #endif /* !ASSEMBLY */
diff --git a/arch/arm/mach-ks8695/include/mach/memory.h b/arch/arm/mach-ks8695/include/mach/memory.h
index ffa19aa..bace9a6 100644
--- a/arch/arm/mach-ks8695/include/mach/memory.h
+++ b/arch/arm/mach-ks8695/include/mach/memory.h
@@ -35,17 +35,17 @@ extern struct bus_type platform_bus_type;
 					__phys_to_virt(x) : __bus_to_virt(x)); })
 #define __arch_virt_to_dma(dev, x)	({ is_lbus_device(dev) ? \
 					(dma_addr_t)__virt_to_phys(x) : (dma_addr_t)__virt_to_bus(x); })
-#define __arch_page_to_dma(dev, x)	\
-	({ dma_addr_t __dma = page_to_phys(page); \
+#define __arch_pfn_to_dma(dev, pfn)	\
+	({ dma_addr_t __dma = __pfn_to_phys(pfn); \
 	   if (!is_lbus_device(dev)) \
 		__dma = __dma - PHYS_OFFSET + KS8695_PCIMEM_PA; \
 	   __dma; })
 
-#define __arch_dma_to_page(dev, x)	\
+#define __arch_dma_to_pfn(dev, x)	\
 	({ dma_addr_t __dma = x;				\
 	   if (!is_lbus_device(dev))				\
 		__dma += PHYS_OFFSET - KS8695_PCIMEM_PA;	\
-	   phys_to_page(__dma);					\
+	   __phys_to_pfn(__dma);				\
 	})
 
 #endif
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 1ccc303..1c5c570 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -321,7 +321,7 @@ __dma_alloc(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp,
 		addr = page_address(page);
 
 	if (addr)
-		*handle = page_to_dma(dev, page);
+		*handle = pfn_to_dma(dev, page_to_pfn(page));
 
 	return addr;
 }
@@ -416,7 +416,7 @@ void dma_free_coherent(struct device *dev, size_t size, void *cpu_addr, dma_addr
 	if (!arch_is_coherent())
 		__dma_free_remap(cpu_addr, size);
 
-	__dma_free_buffer(dma_to_page(dev, handle), size);
+	__dma_free_buffer(pfn_to_page(dma_to_pfn(dev, handle)), size);
 }
 EXPORT_SYMBOL(dma_free_coherent);
 
diff --git a/arch/arm/plat-omap/include/plat/memory.h b/arch/arm/plat-omap/include/plat/memory.h
index d5306be..f8d922f 100644
--- a/arch/arm/plat-omap/include/plat/memory.h
+++ b/arch/arm/plat-omap/include/plat/memory.h
@@ -61,17 +61,17 @@
 #define lbus_to_virt(x)		((x) - OMAP1510_LB_OFFSET + PAGE_OFFSET)
 #define is_lbus_device(dev)	(cpu_is_omap15xx() && dev && (strncmp(dev_name(dev), "ohci", 4) == 0))
 
-#define __arch_page_to_dma(dev, page)	\
-	({ dma_addr_t __dma = page_to_phys(page); \
+#define __arch_pfn_to_dma(dev, pfn)	\
+	({ dma_addr_t __dma = __pfn_to_phys(pfn); \
 	   if (is_lbus_device(dev)) \
 		__dma = __dma - PHYS_OFFSET + OMAP1510_LB_OFFSET; \
 	   __dma; })
 
-#define __arch_dma_to_page(dev, addr)	\
+#define __arch_dma_to_pfn(dev, addr)	\
 	({ dma_addr_t __dma = addr;				\
 	   if (is_lbus_device(dev))				\
 		__dma += PHYS_OFFSET - OMAP1510_LB_OFFSET;	\
-	   phys_to_page(__dma);					\
+	   __phys_to_pfn(__dma);				\
 	})
 
 #define __arch_dma_to_virt(dev, addr)	({ (void *) (is_lbus_device(dev) ? \
