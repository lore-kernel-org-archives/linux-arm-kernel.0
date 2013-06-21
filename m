From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 21 Jun 2013 19:48:15 -0400
Subject: [PATCH 1/8] ARM: mm: LPAE: use phys_addr_t appropriately in p2v and
 v2p conversions
In-Reply-To: <1371858502-10083-1-git-send-email-santosh.shilimkar@ti.com>
References: <1371858502-10083-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1371858502-10083-2-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix remainder types used when converting back and forth between
physical and virtual addresses.

Cc: Nicolas Pitre <nico@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/include/asm/memory.h |   22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 584786f..93376e4 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -185,22 +185,32 @@ extern unsigned long __pv_phys_offset;
 	: "=r" (to)					\
 	: "r" (from), "I" (type))
 
-static inline unsigned long __virt_to_phys(unsigned long x)
+static inline phys_addr_t __virt_to_phys(unsigned long x)
 {
 	unsigned long t;
 	__pv_stub(x, t, "add", __PV_BITS_31_24);
 	return t;
 }
 
-static inline unsigned long __phys_to_virt(unsigned long x)
+static inline unsigned long __phys_to_virt(phys_addr_t x)
 {
 	unsigned long t;
 	__pv_stub(x, t, "sub", __PV_BITS_31_24);
 	return t;
 }
+
 #else
-#define __virt_to_phys(x)	((x) - PAGE_OFFSET + PHYS_OFFSET)
-#define __phys_to_virt(x)	((x) - PHYS_OFFSET + PAGE_OFFSET)
+
+static inline phys_addr_t __virt_to_phys(unsigned long x)
+{
+	return (phys_addr_t)x - PAGE_OFFSET + PHYS_OFFSET;
+}
+
+static inline unsigned long __phys_to_virt(phys_addr_t x)
+{
+	return x - PHYS_OFFSET + PAGE_OFFSET;
+}
+
 #endif
 #endif
 #endif /* __ASSEMBLY__ */
@@ -238,14 +248,14 @@ static inline phys_addr_t virt_to_phys(const volatile void *x)
 
 static inline void *phys_to_virt(phys_addr_t x)
 {
-	return (void *)(__phys_to_virt((unsigned long)(x)));
+	return (void *)__phys_to_virt(x);
 }
 
 /*
  * Drivers should NOT use these either.
  */
 #define __pa(x)			__virt_to_phys((unsigned long)(x))
-#define __va(x)			((void *)__phys_to_virt((unsigned long)(x)))
+#define __va(x)			((void *)__phys_to_virt((phys_addr_t)(x)))
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
 
 /*
-- 
1.7.9.5
