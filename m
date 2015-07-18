From: vitalya@ti.com (Vitaly Andrianov)
Date: Fri, 17 Jul 2015 20:29:35 -0400
Subject: [PATCH] ARM: mm: do not use virt_to_idmap() for NOMMU systems
Message-ID: <1437179375-23855-1-git-send-email-vitalya@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "ARM: mm: Introduce virt_to_idmap() with an arch hook" defines
arch_virt_to_idmap hook in arch/arm/mm/idmap.c. That breaks systems w/o
MMU because that file is not built for them.

This patch fixes this bug.

Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
---
 arch/arm/include/asm/memory.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 6f225ac..114abe3 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -279,6 +279,7 @@ static inline void *phys_to_virt(phys_addr_t x)
 
 extern phys_addr_t (*arch_virt_to_idmap)(unsigned long x);
 
+#ifdef CONFIG_MMU
 /*
  * These are for systems that have a hardware interconnect supported alias of
  * physical memory for idmap purposes.  Most cases should leave these
@@ -293,6 +294,9 @@ static inline phys_addr_t __virt_to_idmap(unsigned long x)
 }
 
 #define virt_to_idmap(x)	__virt_to_idmap((unsigned long)(x))
+#else
+#define virt_to_idmap(x)	__virt_to_phys((unsigned long)(x))
+#endif
 
 /*
  * Virtual <-> DMA view memory address translations
-- 
1.9.1
