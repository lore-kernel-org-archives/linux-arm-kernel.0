From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 31 Jul 2013 12:44:44 -0400
Subject: [PATCH v2 4/6] ARM: mm: LPAE: Correct virt_to_phys patching for 64
 bit physical addresses
In-Reply-To: <1375289086-5315-1-git-send-email-santosh.shilimkar@ti.com>
References: <1375289086-5315-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1375289086-5315-5-git-send-email-santosh.shilimkar@ti.com>
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
order to differentiate between a true carry, a __pv_offset is extended
to 64bit and the upper 32bits will have 0xffffffff if __pv_offset is
2's complement. We are using the same to insert 'mvn #0' instead of
'mov' while patching.

The above idea was suggested by Nicolas Pitre <nico@linaro.org> as
part of the review of first version of the subject patch.

There is no corresponding change on the phys_to_virt() side, because
computations on the upper 32-bits would be discarded anyway.

Cc: Nicolas Pitre <nico@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>

Signed-off-by: Sricharan R <r.sricharan@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/include/asm/memory.h |   35 +++++++++++++++++++--
 arch/arm/kernel/armksyms.c    |    1 +
 arch/arm/kernel/head.S        |   68 +++++++++++++++++++++++++++++++----------
 3 files changed, 85 insertions(+), 19 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index d9b96c65..abe879d 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -174,7 +174,9 @@
 #define __PV_BITS_31_24	0x81000000
 
 extern phys_addr_t (*arch_virt_to_idmap) (unsigned long x);
-extern unsigned long __pv_phys_offset;
+extern phys_addr_t __pv_phys_offset;
+extern phys_addr_t __pv_offset;
+
 #define PHYS_OFFSET __pv_phys_offset
 
 #define __pv_stub(from,to,instr,type)			\
@@ -186,10 +188,37 @@ extern unsigned long __pv_phys_offset;
 	: "=r" (to)					\
 	: "r" (from), "I" (type))
 
+#define __pv_stub_mov_hi(t)				\
+	__asm__ volatile("@ __pv_stub_mov\n"		\
+	"1:	mov	%R0, %1\n"			\
+	"	.pushsection .pv_table,\"a\"\n"		\
+	"	.long	1b\n"				\
+	"	.popsection\n"				\
+	: "=r" (t)					\
+	: "I" (__PV_BITS_31_24))
+
+#define __pv_add_carry_stub(x, y)			\
+	__asm__ volatile("@ __pv_add_carry_stub\n"	\
+	"1:	adds	%Q0, %1, %2\n"			\
+	"2:	adc	%R0, %R0, #0\n"			\
+	"	.pushsection .pv_table,\"a\"\n"		\
+	"	.long	1b\n"				\
+	"	.long	2b\n"				\
+	"	.popsection\n"				\
+	: "+r" (y)					\
+	: "r" (x), "I" (__PV_BITS_31_24)		\
+	: "cc")
+
 static inline phys_addr_t __virt_to_phys(unsigned long x)
 {
-	unsigned long t;
-	__pv_stub(x, t, "add", __PV_BITS_31_24);
+	phys_addr_t t = 0;
+
+	if (sizeof(phys_addr_t) == 4) {
+		__pv_stub(x, t, "add", __PV_BITS_31_24);
+	} else {
+		__pv_stub_mov_hi(t);
+		__pv_add_carry_stub(x, t);
+	}
 	return t;
 }
 
diff --git a/arch/arm/kernel/armksyms.c b/arch/arm/kernel/armksyms.c
index 60d3b73..1f031dd 100644
--- a/arch/arm/kernel/armksyms.c
+++ b/arch/arm/kernel/armksyms.c
@@ -155,4 +155,5 @@ EXPORT_SYMBOL(__gnu_mcount_nc);
 
 #ifdef CONFIG_ARM_PATCH_PHYS_VIRT
 EXPORT_SYMBOL(__pv_phys_offset);
+EXPORT_SYMBOL(__pv_offset);
 #endif
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 9cf6063..aa3b0f7 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -545,17 +545,22 @@ ENDPROC(fixup_smp)
 	__HEAD
 __fixup_pv_table:
 	adr	r0, 1f
-	ldmia	r0, {r3-r5, r7}
+	ldmia	r0, {r3-r7}
+	cmp	r0, r3
+	mvn	ip, #0
 	sub	r3, r0, r3	@ PHYS_OFFSET - PAGE_OFFSET
 	add	r4, r4, r3	@ adjust table start address
 	add	r5, r5, r3	@ adjust table end address
-	add	r7, r7, r3	@ adjust __pv_phys_offset address
-	str	r8, [r7]	@ save computed PHYS_OFFSET to __pv_phys_offset
+	add	r6, r6, r3	@ adjust __pv_phys_offset address
+	add	r7, r7, r3	@ adjust __pv_offset address
+	str	r8, [r6]	@ save computed PHYS_OFFSET to __pv_phys_offset
+	strcc	ip, [r7, #4]	@ save to __pv_offset high bits
 	mov	r6, r3, lsr #24	@ constant for add/sub instructions
 	teq	r3, r6, lsl #24 @ must be 16MiB aligned
 THUMB(	it	ne		@ cross section branch )
 	bne	__error
-	str	r6, [r7, #4]	@ save to __pv_offset
+	lsl	r6, r6, #24
+	str	r6, [r7]	@ save to __pv_offset low bits
 	b	__fixup_a_pv_table
 ENDPROC(__fixup_pv_table)
 
@@ -564,6 +569,7 @@ ENDPROC(__fixup_pv_table)
 	.long	__pv_table_begin
 	.long	__pv_table_end
 2:	.long	__pv_phys_offset
+	.long	__pv_offset
 
 	.text
 __fixup_a_pv_table:
@@ -589,27 +595,53 @@ __fixup_a_pv_table:
 	bcc	1b
 	bx	lr
 #else
-	b	2f
+	adr	r0, 5f
+	b	4f
 1:	ldr	ip, [r7, r3]
-	bic	ip, ip, #0x000000ff
-	orr	ip, ip, r6	@ mask in offset bits 31-24
-	str	ip, [r7, r3]
-2:	cmp	r4, r5
+	lsr	r6, ip, #20		@ extract opcode
+	and	r6, r6, #0x3e
+	cmp	r6, #0x28		@ check for 'add' instruction
+	beq	2f
+	cmp	r6, #0x24		@ check for 'sub' instruction
+	beq	2f
+	cmp	r6, #0x2a		@ check for 'adc' instruction
+	beq	4f
+	ldr	r6, [r0]
+	add	r6, r6, r3
+	ldr	r6, [r6, #4]
+	mvn	r11, #0
+	cmp	r11, r6
+	and	ip, ip, #0xf000		@ Register encoded in inst
+	orrne	ip, ip, r6
+	ldreq	r6, [r0, #0x4]		@ mvn if _pv_offset high bits is 0xffffffff
+	ldrne	r6, [r0, #0x8]		@ mov otherwise
+	bic	r6, r6, #0xff
+	bic	r6, r6, #0xf00
+	orr	ip, ip, r6
+	b	3f
+2:	ldr	r6, [r0]
+	ldr	r6, [r6, r3]
+	bic	ip, ip, #0xff
+	orr	ip, ip, r6, lsr #24	@ mask in offset bits 31-24
+3:	str	ip, [r7, r3]
+4:	cmp	r4, r5
 	ldrcc	r7, [r4], #4	@ use branch for delay slot
 	bcc	1b
 	mov	pc, lr
 #endif
 ENDPROC(__fixup_a_pv_table)
 
+5:	.long __pv_offset
+	mvn	r0, #0
+	mov	r0, #0x81000000 @ For getting the correct 4 byte encoding
+
 ENTRY(fixup_pv_table)
-	stmfd	sp!, {r4 - r7, lr}
-	ldr	r2, 2f			@ get address of __pv_phys_offset
+	stmfd	sp!, {r0, r3 - r7, r11 - r12, lr}
 	mov	r3, #0			@ no offset
 	mov	r4, r0			@ r0 = table start
 	add	r5, r0, r1		@ r1 = table size
-	ldr	r6, [r2, #4]		@ get __pv_offset
 	bl	__fixup_a_pv_table
-	ldmfd	sp!, {r4 - r7, pc}
+	ldmfd	sp!, {r0, r3 - r7, r11 - r12, pc}
 ENDPROC(fixup_pv_table)
 
 	.align
@@ -619,10 +651,14 @@ ENDPROC(fixup_pv_table)
 	.globl	__pv_phys_offset
 	.type	__pv_phys_offset, %object
 __pv_phys_offset:
-	.long	0
-	.size	__pv_phys_offset, . - __pv_phys_offset
+	.quad	0
+
+	.data
+	.globl __pv_offset
+	.type __pv_offset, %object
 __pv_offset:
-	.long	0
+	.quad   0
+
 #endif
 
 #include "head-common.S"
-- 
1.7.9.5
