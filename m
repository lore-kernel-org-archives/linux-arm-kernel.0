From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 17 Jun 2014 18:12:54 +0300
Subject: [PATCH v3] ARM: mm: Remove unused dma_to_virt()
Message-ID: <1403017974-25946-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove dma_to_virt() as there are no in-tree users of it.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Olof Johansson <olof@lixom.net>
Cc: Tony Lindgren <tony@atomide.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Greg Ungerer <gerg@uclinux.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
Changes in v3:
 rebased on top of v3.16-rc1
Link on v2:
 http://marc.info/?l=linux-arm-kernel&m=139353613111986&w=2

 arch/arm/include/asm/dma-mapping.h          |   18 +-----------------
 arch/arm/mach-iop13xx/include/mach/memory.h |   11 -----------
 arch/arm/mach-ks8695/include/mach/memory.h  |    2 --
 arch/arm/mach-omap1/include/mach/memory.h   |    4 ----
 4 files changed, 1 insertion(+), 34 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index c45b61a..7dd8347 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -51,7 +51,7 @@ static inline int dma_set_mask(struct device *dev, u64 mask)
 #endif
 
 /*
- * dma_to_pfn/pfn_to_dma/dma_to_virt/virt_to_dma are architecture private
+ * dma_to_pfn/pfn_to_dma/virt_to_dma are architecture private
  * functions used internally by the DMA-mapping API to provide DMA
  * addresses. They must not be used by drivers.
  */
@@ -73,17 +73,6 @@ static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
 	return pfn;
 }
 
-static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
-{
-	if (dev) {
-		unsigned long pfn = dma_to_pfn(dev, addr);
-
-		return phys_to_virt(__pfn_to_phys(pfn));
-	}
-
-	return (void *)__bus_to_virt((unsigned long)addr);
-}
-
 static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
 {
 	if (dev)
@@ -103,11 +92,6 @@ static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
 	return __arch_dma_to_pfn(dev, addr);
 }
 
-static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
-{
-	return __arch_dma_to_virt(dev, addr);
-}
-
 static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
 {
 	return __arch_virt_to_dma(dev, addr);
diff --git a/arch/arm/mach-iop13xx/include/mach/memory.h b/arch/arm/mach-iop13xx/include/mach/memory.h
index 7c032d0..1223c85 100644
--- a/arch/arm/mach-iop13xx/include/mach/memory.h
+++ b/arch/arm/mach-iop13xx/include/mach/memory.h
@@ -36,17 +36,6 @@ static inline void __iomem *__lbus_to_virt(dma_addr_t x)
 #define is_lbus_device(dev) 				\
 	(dev && strncmp(dev->bus->name, "platform", 8) == 0)
 
-#define __arch_dma_to_virt(dev, addr)					\
-	({								\
-		void * __virt;						\
-		dma_addr_t __dma = addr;				\
-		if (is_lbus_device(dev) && __is_lbus_dma(__dma))	\
-			__virt = __lbus_to_virt(__dma);			\
-		else							\
-			__virt = (void *)__phys_to_virt(__dma);		\
-		__virt;							\
-	})
-
 #define __arch_virt_to_dma(dev, addr)					\
 	({								\
 		void * __virt = addr;					\
diff --git a/arch/arm/mach-ks8695/include/mach/memory.h b/arch/arm/mach-ks8695/include/mach/memory.h
index 95e731a..f42477c 100644
--- a/arch/arm/mach-ks8695/include/mach/memory.h
+++ b/arch/arm/mach-ks8695/include/mach/memory.h
@@ -31,8 +31,6 @@
 /* Platform-bus mapping */
 extern struct bus_type platform_bus_type;
 #define is_lbus_device(dev)		(dev && dev->bus == &platform_bus_type)
-#define __arch_dma_to_virt(dev, x)	({ (void *) (is_lbus_device(dev) ? \
-					__phys_to_virt(x) : __bus_to_virt(x)); })
 #define __arch_virt_to_dma(dev, x)	({ is_lbus_device(dev) ? \
 					(dma_addr_t)__virt_to_phys((unsigned long)x) \
 					: (dma_addr_t)__virt_to_bus(x); })
diff --git a/arch/arm/mach-omap1/include/mach/memory.h b/arch/arm/mach-omap1/include/mach/memory.h
index 3c25305..73f86db 100644
--- a/arch/arm/mach-omap1/include/mach/memory.h
+++ b/arch/arm/mach-omap1/include/mach/memory.h
@@ -43,10 +43,6 @@
 	   __phys_to_pfn(__dma);				\
 	})
 
-#define __arch_dma_to_virt(dev, addr)	({ (void *) (is_lbus_device(dev) ? \
-						lbus_to_virt(addr) : \
-						__phys_to_virt(addr)); })
-
 #define __arch_virt_to_dma(dev, addr)	({ unsigned long __addr = (unsigned long)(addr); \
 					   (dma_addr_t) (is_lbus_device(dev) ? \
 						virt_to_lbus(__addr) : \
-- 
1.7.9.5
