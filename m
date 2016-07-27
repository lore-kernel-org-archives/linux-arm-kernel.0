From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 27 Jul 2016 16:10:34 -0400 (EDT)
Subject: [PATCH] asm/memory.h: remove dead definitions
Message-ID: <alpine.LFD.2.20.1607271604500.17623@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The last ad-hoc __phys_to_virt definition was removed in commit fd0053c9
("ARM: realview: remove sparsemem hack"). Therefore we can remove the
unneeded definitions and unduplicate the virt_to_pfn macro from
asm/memory.h.

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 31c07a2cc1..76cbd9c674 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -159,13 +159,8 @@
  * PFNs are used to describe any physical page; this means
  * PFN 0 == physical address 0.
  */
-#if defined(__virt_to_phys)
-#define PHYS_OFFSET	PLAT_PHYS_OFFSET
-#define PHYS_PFN_OFFSET	((unsigned long)(PHYS_OFFSET >> PAGE_SHIFT))
-
-#define virt_to_pfn(kaddr) (__pa(kaddr) >> PAGE_SHIFT)
 
-#elif defined(CONFIG_ARM_PATCH_PHYS_VIRT)
+#if defined(CONFIG_ARM_PATCH_PHYS_VIRT)
 
 /*
  * Constants used to force the right instruction encodings and shifts
@@ -182,10 +177,6 @@ extern const void *__pv_table_begin, *__pv_table_end;
 #define PHYS_OFFSET	((phys_addr_t)__pv_phys_pfn_offset << PAGE_SHIFT)
 #define PHYS_PFN_OFFSET	(__pv_phys_pfn_offset)
 
-#define virt_to_pfn(kaddr) \
-	((((unsigned long)(kaddr) - PAGE_OFFSET) >> PAGE_SHIFT) + \
-	 PHYS_PFN_OFFSET)
-
 #define __pv_stub(from,to,instr,type)			\
 	__asm__("@ __pv_stub\n"				\
 	"1:	" instr "	%0, %1, %2\n"		\
@@ -257,12 +248,12 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
 	return x - PHYS_OFFSET + PAGE_OFFSET;
 }
 
+#endif
+
 #define virt_to_pfn(kaddr) \
 	((((unsigned long)(kaddr) - PAGE_OFFSET) >> PAGE_SHIFT) + \
 	 PHYS_PFN_OFFSET)
 
-#endif
-
 /*
  * These are *only* valid on the kernel direct mapped RAM memory.
  * Note: Drivers should NOT use these.  They are the wrong
