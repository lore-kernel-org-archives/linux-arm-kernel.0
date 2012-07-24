From: cyril@ti.com (Cyril Chemparathy)
Date: Tue, 24 Jul 2012 01:10:23 -0000
Subject: [RFC 03/23] ARM: LPAE: use phys_addr_t on virt <--> phys conversion
In-Reply-To: <1343092165-9470-1-git-send-email-cyril@ti.com>
References: <1343092165-9470-1-git-send-email-cyril@ti.com>
Message-ID: <1343092165-9470-4-git-send-email-cyril@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes up the types used when converting back and forth between
physical and virtual addresses.

Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
Signed-off-by: Cyril Chemparathy <cyril@ti.com>
---
 arch/arm/include/asm/memory.h |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index fcb5757..7629dfe 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -169,22 +169,27 @@ extern unsigned long __pv_phys_offset;
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
 #else
-#define __virt_to_phys(x)	((x) - PAGE_OFFSET + PHYS_OFFSET)
-#define __phys_to_virt(x)	((x) - PHYS_OFFSET + PAGE_OFFSET)
+
+#define __virt_to_phys(x)		\
+	((phys_addr_t)(x) - PAGE_OFFSET + PHYS_OFFSET)
+
+#define __phys_to_virt(x)		\
+	((unsigned long)((phys_addr_t)(x) - PHYS_OFFSET + PAGE_OFFSET))
+
 #endif
 #endif
 
@@ -219,14 +224,14 @@ static inline phys_addr_t virt_to_phys(const volatile void *x)
 
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
