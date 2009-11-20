From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 20 Nov 2009 18:03:00 +0000
Subject: [PATCH 3/7] ARM: dma-mapping: provide dma_to_page()
In-Reply-To: <20091120182539.GG16920@n2100.arm.linux.org.uk>
References: <20091120182539.GG16920@n2100.arm.linux.org.uk>
Message-ID: <E1NBYE5-0005ky-8T@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/dma-mapping.h          |   10 ++++++++++
 arch/arm/mach-iop13xx/include/mach/memory.h |    2 ++
 arch/arm/mach-ks8695/include/mach/memory.h  |    7 +++++++
 arch/arm/plat-omap/include/mach/memory.h    |    7 +++++++
 4 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 5d78eb1..f06d80c 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -20,6 +20,11 @@ static inline dma_addr_t page_to_dma(struct device *dev, struct page *page)
 	return (dma_addr_t)__pfn_to_bus(page_to_pfn(page));
 }
 
+static inline struct page *dma_to_page(struct device *dev, dma_addr_t addr)
+{
+	return pfn_to_page(__bus_to_pfn(addr));
+}
+
 static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
 {
 	return (void *)__bus_to_virt(addr);
@@ -35,6 +40,11 @@ static inline dma_addr_t page_to_dma(struct device *dev, struct page *page)
 	return __arch_page_to_dma(dev, page);
 }
 
+static inline struct page *dma_to_page(struct device *dev, dma_addr_t addr)
+{
+	return __arch_dma_to_page(dev, addr);
+}
+
 static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
 {
 	return __arch_dma_to_virt(dev, addr);
diff --git a/arch/arm/mach-iop13xx/include/mach/memory.h b/arch/arm/mach-iop13xx/include/mach/memory.h
index 42ae29b..25b1da9 100644
--- a/arch/arm/mach-iop13xx/include/mach/memory.h
+++ b/arch/arm/mach-iop13xx/include/mach/memory.h
@@ -64,6 +64,8 @@ static inline unsigned long __lbus_to_virt(dma_addr_t x)
 		(dma_addr_t)page_to_phys(page);				\
 	})
 
+#define __arch_dma_to_page(dev, addr)	phys_to_page(addr)
+
 #endif /* CONFIG_ARCH_IOP13XX */
 #endif /* !ASSEMBLY */
 
diff --git a/arch/arm/mach-ks8695/include/mach/memory.h b/arch/arm/mach-ks8695/include/mach/memory.h
index 76e5308..ffa19aa 100644
--- a/arch/arm/mach-ks8695/include/mach/memory.h
+++ b/arch/arm/mach-ks8695/include/mach/memory.h
@@ -41,6 +41,13 @@ extern struct bus_type platform_bus_type;
 		__dma = __dma - PHYS_OFFSET + KS8695_PCIMEM_PA; \
 	   __dma; })
 
+#define __arch_dma_to_page(dev, x)	\
+	({ dma_addr_t __dma = x;				\
+	   if (!is_lbus_device(dev))				\
+		__dma += PHYS_OFFSET - KS8695_PCIMEM_PA;	\
+	   phys_to_page(__dma);					\
+	})
+
 #endif
 
 #endif
diff --git a/arch/arm/plat-omap/include/mach/memory.h b/arch/arm/plat-omap/include/mach/memory.h
index 9ad41dc..3325f7b 100644
--- a/arch/arm/plat-omap/include/mach/memory.h
+++ b/arch/arm/plat-omap/include/mach/memory.h
@@ -68,6 +68,13 @@
 		__dma = __dma - PHYS_OFFSET + OMAP1510_LB_OFFSET; \
 	   __dma; })
 
+#define __arch_dma_to_page(dev, addr)	\
+	({ dma_addr_t __dma = addr;				\
+	   if (is_lbus_device(dev))				\
+		__dma += PHYS_OFFSET - OMAP1510_LB_OFFSET;	\
+	   phys_to_page(__dma);					\
+	})
+
 #define __arch_dma_to_virt(dev, addr)	({ (void *) (is_lbus_device(dev) ? \
 						lbus_to_virt(addr) : \
 						__phys_to_virt(addr)); })
-- 
1.6.2.5
