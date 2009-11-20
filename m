From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 20 Nov 2009 18:02:00 +0000
Subject: [PATCH 2/7] ARM: dma-mapping: simplify page_to_dma() and
	__pfn_to_bus()
In-Reply-To: <20091120182539.GG16920@n2100.arm.linux.org.uk>
References: <20091120182539.GG16920@n2100.arm.linux.org.uk>
Message-ID: <E1NBYE2-0005kv-7H@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The non-highmem() and the __pfn_to_bus() based page_to_dma() both
compile to the same code, so its pointless having these two different
approaches.  Use the __pfn_to_bus() based version.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/dma-mapping.h |   10 ----------
 arch/arm/include/asm/memory.h      |    3 ++-
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index ff46dfa..5d78eb1 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -15,20 +15,10 @@
  * must not be used by drivers.
  */
 #ifndef __arch_page_to_dma
-
-#if !defined(CONFIG_HIGHMEM)
-static inline dma_addr_t page_to_dma(struct device *dev, struct page *page)
-{
-	return (dma_addr_t)__virt_to_bus((unsigned long)page_address(page));
-}
-#elif defined(__pfn_to_bus)
 static inline dma_addr_t page_to_dma(struct device *dev, struct page *page)
 {
 	return (dma_addr_t)__pfn_to_bus(page_to_pfn(page));
 }
-#else
-#error "this machine class needs to define __arch_page_to_dma to use HIGHMEM"
-#endif
 
 static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
 {
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index e0f8f4a..9099ada 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -200,7 +200,8 @@ static inline void *phys_to_virt(unsigned long x)
 #ifndef __virt_to_bus
 #define __virt_to_bus	__virt_to_phys
 #define __bus_to_virt	__phys_to_virt
-#define __pfn_to_bus(x)	((x) << PAGE_SHIFT)
+#define __pfn_to_bus(x)	__pfn_to_phys(x)
+#define __bus_to_pfn(x)	__phys_to_pfn(x)
 #endif
 
 static inline __deprecated unsigned long virt_to_bus(void *x)
-- 
1.6.2.5
