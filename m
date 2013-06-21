From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 21 Jun 2013 19:48:20 -0400
Subject: [PATCH 6/8] ARM: mm: LPAE: Correct virt_to_phys patching for 64 bit
 physical addresses
In-Reply-To: <1371858502-10083-1-git-send-email-santosh.shilimkar@ti.com>
References: <1371858502-10083-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1371858502-10083-7-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sricharan R <r.sricharan@ti.com>

The current phys_to_virt patching mechanism does not work
for 64 bit physical addressesp. Note that constant used in add/sub
instructions is encoded in to the last 8 bits of the opcode. So shift
the _pv_offset constant by 24 to get it in to the correct place.

The v2p patching mechanism patches the higher 32bits of physical
address with a constant. While this is correct, in those platforms
where the lowmem addressable physical memory spawns across 4GB boundary,
a carry bit can be produced as a result of addition of lower 32bits.
This has to be taken in to account and added in to the upper. The patched
__pv_offset and va are added in lower 32bits, where __pv_offset can be
in two's complement form when PA_START < VA_START and that can result
in a false carry bit.

e.g PA = 0x80000000 VA = 0xC0000000
__pv_offset = PA - VA = 0xC0000000 (2's complement)

So adding __pv_offset + VA should never result in a true overflow. So in
order to differentiate between a true carry, a extra flag __pv_sign_flag
is introduced.

There is no corresponding change on the phys_to_virt() side, because
computations on the upper 32-bits would be discarded anyway.

We think, the patch can be further optimised and made bit better with expert
review from RMK, Nico and others.

Cc: Nicolas Pitre <nico@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>

Signed-off-by: Sricharan R <r.sricharan@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/include/asm/memory.h |   22 ++++++++++++++++++++--
 arch/arm/kernel/armksyms.c    |    2 ++
 arch/arm/kernel/head.S        |   34 ++++++++++++++++++++++++++++++++--
 arch/arm/kernel/module.c      |    7 +++++++
 4 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index d8a3ea6..e16468d 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -174,9 +174,17 @@
 #define __PV_BITS_31_24	0x81000000
 #define __PV_BITS_7_0	0x81
 
+/*
+ * PV patch constants.
+ * Lower 32bits are 16MB aligned.
+ */
+#define PV_LOW_SHIFT	24
+#define PV_HIGH_SHIFT	32
+
 extern phys_addr_t (*arch_virt_to_idmap) (unsigned long x);
-extern unsigned long __pv_phys_offset;
+extern phys_addr_t __pv_phys_offset;
 extern unsigned long __pv_offset;
+extern unsigned long __pv_sign_flag;
 
 #define PHYS_OFFSET __pv_phys_offset
 
@@ -187,7 +195,8 @@ extern unsigned long __pv_offset;
 	"	.long	1b\n"				\
 	"	.popsection\n"				\
 	: "=r" (to)					\
-	: "r" (from), "I" (type))
+	: "r" (from), "I" (type)			\
+	: "cc")
 
 #define __pv_stub_mov(to, instr, type)			\
 	__asm__ volatile("@ __pv_stub_mov\n"		\
@@ -200,8 +209,17 @@ extern unsigned long __pv_offset;
 
 static inline phys_addr_t __virt_to_phys(unsigned long x)
 {
+#ifdef CONFIG_ARM_LPAE
+	register phys_addr_t t asm("r4") = 0;
+
+	__pv_stub_mov(t, "mov", __PV_BITS_7_0);
+	__pv_stub(x, t, "adds", __PV_BITS_31_24);
+	__asm__ volatile("adc %R0, %R0, %1" : "+r" (t) : "I" (0x0));
+	__asm__ volatile("sub %R0, %R0, %1" : "+r" (t) : "r" (__pv_sign_flag));
+#else
 	unsigned long t;
 	__pv_stub(x, t, "add", __PV_BITS_31_24);
+#endif
 	return t;
 }
 
diff --git a/arch/arm/kernel/armksyms.c b/arch/arm/kernel/armksyms.c
index 60d3b73..f0c51ed 100644
--- a/arch/arm/kernel/armksyms.c
+++ b/arch/arm/kernel/armksyms.c
@@ -155,4 +155,6 @@ EXPORT_SYMBOL(__gnu_mcount_nc);
 
 #ifdef CONFIG_ARM_PATCH_PHYS_VIRT
 EXPORT_SYMBOL(__pv_phys_offset);
+EXPORT_SYMBOL(__pv_offset);
+EXPORT_SYMBOL(__pv_sign_flag);
 #endif
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index b1bdeb5..25c9d5f 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -546,24 +546,42 @@ ENDPROC(fixup_smp)
 	__HEAD
 __fixup_pv_table:
 	adr	r0, 1f
-	ldmia	r0, {r3-r5, r7}
+	ldmia	r0, {r3-r7}
+	cmp	r0, r3
+	mov	ip, #1
 	sub	r3, r0, r3	@ PHYS_OFFSET - PAGE_OFFSET
 	add	r4, r4, r3	@ adjust table start address
 	add	r5, r5, r3	@ adjust table end address
 	add	r7, r7, r3	@ adjust __pv_phys_offset address
+	add	r6, r6, r3	@ adjust __pv_sign_flag
+	strcc	ip, [r6]	@ save __pv_sign_flag
 	str	r8, [r7]	@ save computed PHYS_OFFSET to __pv_phys_offset
 	mov	r6, r3, lsr #24	@ constant for add/sub instructions
 	teq	r3, r6, lsl #24 @ must be 16MiB aligned
 THUMB(	it	ne		@ cross section branch )
 	bne	__error
+#ifndef CONFIG_ARM_LPAE
 	str	r6, [r7, #4]	@ save to __pv_offset
 	b	__fixup_a_pv_table
+#else
+	str	r6, [r7, #8]	@ save to __pv_offset
+	mov	r0, r14		@ save lr
+	bl	__fixup_a_pv_table
+	adr	r6, 3f
+	ldmia	r6, {r4-r5}
+	add	r4, r4, r3	@ adjust __pv_high_table start address
+	add 	r5, r5, r3	@ adjust __pv_high_table end address
+	mov	r6, #0		@ higher 32 bits of PHYS_OFFSET to start with
+	bl	__fixup_a_pv_table
+	mov	pc, r0
+#endif
 ENDPROC(__fixup_pv_table)
 
 	.align
 1:	.long	.
 	.long	__pv_table_begin
 	.long	__pv_table_end
+	.long  __pv_sign_flag
 2:	.long	__pv_phys_offset
 3:	.long	__pv_high_table_begin
 	.long	__pv_high_table_end
@@ -621,10 +639,22 @@ ENDPROC(fixup_pv_table)
 	.globl	__pv_phys_offset
 	.type	__pv_phys_offset, %object
 __pv_phys_offset:
+#ifdef CONFIG_ARM_LPAE
+	.quad	0
+#else
 	.long	0
-	.size	__pv_phys_offset, . - __pv_phys_offset
+#endif
+	.data
+	.globl __pv_offset
+	.type __pv_offset, %object
 __pv_offset:
 	.long	0
+
+	.data
+	.globl __pv_sign_flag
+	.type __pv_sign_flag, %object
+__pv_sign_flag:
+	.long 0
 #endif
 
 #include "head-common.S"
diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 1ac071b..024c06d 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -320,6 +320,13 @@ int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
 	s = find_mod_section(hdr, sechdrs, ".pv_table");
 	if (s)
 		fixup_pv_table((void *)s->sh_addr, s->sh_size, __pv_offset);
+
+#ifdef CONFIG_ARM_LPAE
+	s = find_mod_section(hdr, sechdrs, ".pv_high_table");
+	if (s)
+		fixup_pv_table((void *)s->sh_addr, s->sh_size,
+					__pv_phys_offset >> PV_HIGH_SHIFT);
+#endif
 #endif
 	s = find_mod_section(hdr, sechdrs, ".alt.smp.init");
 	if (s && !is_smp())
-- 
1.7.9.5
