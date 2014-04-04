From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 04 Apr 2014 23:32:08 +0100
Subject: [PATCH] ARM: Better virt_to_page() handling
In-Reply-To: <20140328152831.GK7528@n2100.arm.linux.org.uk>
References: <20140328152831.GK7528@n2100.arm.linux.org.uk>
Message-ID: <E1WWCee-0003FW-7j@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

virt_to_page() is incredibly inefficient when virt-to-phys patching is
enabled.  This is because we end up with this calculation:

  page = &mem_map[asm virt_to_phys(addr) >> 12 - __pv_phys_offset >> 12]

in assembly.  The asm virt_to_phys() is equivalent this this operation:

  addr - PAGE_OFFSET + __pv_phys_offset

and we can see that because this is assembly, the compiler has no chance
to optimise some of that away.  This should reduce down to:

  page = &mem_map[(addr - PAGE_OFFSET) >> 12]

for the common cases.  Permit the compiler to make this optimisation by
giving it more of the information it needs - do this by providing a
virt_to_pfn() macro.

Another issue which makes this more complex is that __pv_phys_offset is
a 64-bit type on all platforms.  This is needlessly wasteful - if we
store the physical offset as a PFN, we can save a lot of work having
to deal with 64-bit values, which sometimes ends up producing incredibly
horrid code:

     a4c:       e3009000        movw    r9, #0
                        a4c: R_ARM_MOVW_ABS_NC  __pv_phys_offset
     a50:       e3409000        movt    r9, #0          ; r9 = &__pv_phys_offset
                        a50: R_ARM_MOVT_ABS     __pv_phys_offset
     a54:       e3002000        movw    r2, #0
                        a54: R_ARM_MOVW_ABS_NC  __pv_phys_offset
     a58:       e3402000        movt    r2, #0          ; r2 = &__pv_phys_offset
                        a58: R_ARM_MOVT_ABS     __pv_phys_offset
     a5c:       e5999004        ldr     r9, [r9, #4]    ; r9 = high word of __pv_phys_offset
     a60:       e3001000        movw    r1, #0
                        a60: R_ARM_MOVW_ABS_NC  mem_map
     a64:       e592c000        ldr     ip, [r2]        ; ip = low word of __pv_phys_offset

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/memory.h | 41 ++++++++++++++++++++++++-----------------
 arch/arm/kernel/armksyms.c    |  2 +-
 arch/arm/kernel/head.S        | 17 +++++++++--------
 3 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 4afb376d9c7c..02fa2558f662 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -166,9 +166,17 @@
  * Physical vs virtual RAM address space conversion.  These are
  * private definitions which should NOT be used outside memory.h
  * files.  Use virt_to_phys/phys_to_virt/__pa/__va instead.
+ *
+ * PFNs are used to describe any physical page; this means
+ * PFN 0 == physical address 0.
  */
-#ifndef __virt_to_phys
-#ifdef CONFIG_ARM_PATCH_PHYS_VIRT
+#if defined(__virt_to_phys)
+#define PHYS_OFFSET	PLAT_PHYS_OFFSET
+#define PHYS_PFN_OFFSET	((unsigned long)(PHYS_OFFSET >> PAGE_SHIFT))
+
+#define virt_to_pfn(kaddr) (__pa(kaddr) >> PAGE_SHIFT)
+
+#elif defined(CONFIG_ARM_PATCH_PHYS_VIRT)
 
 /*
  * Constants used to force the right instruction encodings and shifts
@@ -177,12 +185,17 @@
 #define __PV_BITS_31_24	0x81000000
 #define __PV_BITS_7_0	0x81
 
-extern u64 __pv_phys_offset;
+extern unsigned long __pv_phys_pfn_offset;
 extern u64 __pv_offset;
 extern void fixup_pv_table(const void *, unsigned long);
 extern const void *__pv_table_begin, *__pv_table_end;
 
-#define PHYS_OFFSET __pv_phys_offset
+#define PHYS_OFFSET	((phys_addr_t)__pv_phys_pfn_offset << PAGE_SHIFT)
+#define PHYS_PFN_OFFSET	(__pv_phys_pfn_offset)
+
+#define virt_to_pfn(kaddr) \
+	((((unsigned long)(kaddr) - PAGE_OFFSET) >> PAGE_SHIFT) + \
+	 PHYS_PFN_OFFSET)
 
 #define __pv_stub(from,to,instr,type)			\
 	__asm__("@ __pv_stub\n"				\
@@ -243,6 +256,7 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
 #else
 
 #define PHYS_OFFSET	PLAT_PHYS_OFFSET
+#define PHYS_PFN_OFFSET	((unsigned long)(PHYS_OFFSET >> PAGE_SHIFT))
 
 static inline phys_addr_t __virt_to_phys(unsigned long x)
 {
@@ -254,18 +268,11 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
 	return x - PHYS_OFFSET + PAGE_OFFSET;
 }
 
-#endif
-#endif
+#define virt_to_pfn(kaddr) \
+	((((unsigned long)(kaddr) - PAGE_OFFSET) >> PAGE_SHIFT) + \
+	 PHYS_PFN_OFFSET)
 
-/*
- * PFNs are used to describe any physical page; this means
- * PFN 0 == physical address 0.
- *
- * This is the PFN of the first RAM page in the kernel
- * direct-mapped view.  We assume this is the first page
- * of RAM in the mem_map as well.
- */
-#define PHYS_PFN_OFFSET	((unsigned long)(PHYS_OFFSET >> PAGE_SHIFT))
+#endif
 
 /*
  * These are *only* valid on the kernel direct mapped RAM memory.
@@ -343,9 +350,9 @@ static inline __deprecated void *bus_to_virt(unsigned long x)
  */
 #define ARCH_PFN_OFFSET		PHYS_PFN_OFFSET
 
-#define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
+#define virt_to_page(kaddr)	pfn_to_page(virt_to_pfn(kaddr))
 #define virt_addr_valid(kaddr)	(((unsigned long)(kaddr) >= PAGE_OFFSET && (unsigned long)(kaddr) < (unsigned long)high_memory) \
-					&& pfn_valid(__pa(kaddr) >> PAGE_SHIFT) )
+					&& pfn_valid(virt_to_pfn(kaddr)))
 
 #endif
 
diff --git a/arch/arm/kernel/armksyms.c b/arch/arm/kernel/armksyms.c
index 85e664b6a5f1..f7b450f97e68 100644
--- a/arch/arm/kernel/armksyms.c
+++ b/arch/arm/kernel/armksyms.c
@@ -158,6 +158,6 @@ EXPORT_SYMBOL(__gnu_mcount_nc);
 #endif
 
 #ifdef CONFIG_ARM_PATCH_PHYS_VIRT
-EXPORT_SYMBOL(__pv_phys_offset);
+EXPORT_SYMBOL(__pv_phys_pfn_offset);
 EXPORT_SYMBOL(__pv_offset);
 #endif
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index f5f381d91556..f8c08839edf3 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -584,9 +584,10 @@ __fixup_pv_table:
 	subs	r3, r0, r3	@ PHYS_OFFSET - PAGE_OFFSET
 	add	r4, r4, r3	@ adjust table start address
 	add	r5, r5, r3	@ adjust table end address
-	add	r6, r6, r3	@ adjust __pv_phys_offset address
+	add	r6, r6, r3	@ adjust __pv_phys_pfn_offset address
 	add	r7, r7, r3	@ adjust __pv_offset address
-	str	r8, [r6, #LOW_OFFSET]	@ save computed PHYS_OFFSET to __pv_phys_offset
+	mov	r0, r8, lsr #12	@ convert to PFN
+	str	r0, [r6, #LOW_OFFSET]	@ save computed PHYS_OFFSET to __pv_phys_pfn_offset
 	strcc	ip, [r7, #HIGH_OFFSET]	@ save to __pv_offset high bits
 	mov	r6, r3, lsr #24	@ constant for add/sub instructions
 	teq	r3, r6, lsl #24 @ must be 16MiB aligned
@@ -600,7 +601,7 @@ ENDPROC(__fixup_pv_table)
 1:	.long	.
 	.long	__pv_table_begin
 	.long	__pv_table_end
-2:	.long	__pv_phys_offset
+2:	.long	__pv_phys_pfn_offset
 	.long	__pv_offset
 
 	.text
@@ -688,11 +689,11 @@ ENTRY(fixup_pv_table)
 ENDPROC(fixup_pv_table)
 
 	.data
-	.globl	__pv_phys_offset
-	.type	__pv_phys_offset, %object
-__pv_phys_offset:
-	.quad	0
-	.size	__pv_phys_offset, . -__pv_phys_offset
+	.globl	__pv_phys_pfn_offset
+	.type	__pv_phys_pfn_offset, %object
+__pv_phys_pfn_offset:
+	.word	0
+	.size	__pv_phys_pfn_offset, . -__pv_phys_pfn_offset
 
 	.globl	__pv_offset
 	.type	__pv_offset, %object
-- 
1.8.3.1
