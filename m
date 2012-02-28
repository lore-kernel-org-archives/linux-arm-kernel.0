From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 28 Feb 2012 18:59:45 +0000
Subject: [RFC PATCH 1/2] ARM: assembler: Add uniform assembler framework
In-Reply-To: <1330455586-10353-1-git-send-email-dave.martin@linaro.org>
References: <1330455586-10353-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1330455586-10353-2-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch creates a framework for adding common assembler macros
and declarations usable identically by .S files and inline asm.

A preprocessing rule converts special uniform assembler headers
arch/arm/include/*.h.asm into generated headers
include/generates/asm-*.h.  These headers can be included directly
by .c or .S files to get the common macros.

A simple script arch/arm/tools/asm-header.pl converts marked blocks
of assembler declarations appropriately for inclusion in both types
of file.  These blocks can be intermingled with ordinary C
preprocessing directives (and even C content, if that content is
protected with #ifndef __ASSEMBLY__ as is usual for any header in
<asm/>.  This makes it straightforward to write config-dependent
code in the normal way.

<asm/assembler.h> is converted to the new framework by this patch,
so it is now safe to include that header in .c files.  There are no
common declarations yet, but over time many features from this
header could be replaced with common implementations if this looks
worthwhile.  The content is now in
arch/arm/include/asm/assembler.h.asm (which is where maintenance
should be done).

Signed-off-by: Dave Martin <dave.martin@arm.com>
---
 arch/arm/Makefile                    |    8 +-
 arch/arm/include/asm/assembler.h     |  322 +---------------------------------
 arch/arm/include/asm/assembler.h.asm |  323 ++++++++++++++++++++++++++++++++++
 arch/arm/tools/Makefile              |    4 +
 arch/arm/tools/asm-header.pl         |   76 ++++++++
 5 files changed, 411 insertions(+), 322 deletions(-)
 create mode 100644 arch/arm/include/asm/assembler.h.asm
 create mode 100644 arch/arm/tools/asm-header.pl

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 1683bfb..9cfef30 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -269,8 +269,14 @@ all:	$(KBUILD_IMAGE)
 
 boot := arch/arm/boot
 
+asm_headers := $(wildcard arch/arm/include/asm/*.h.asm)
+generated_asm_headers := \
+	$(patsubst arch/arm/include/asm/%.h.asm,include/generated/asm-%.h,$(asm_headers))
+
 archprepare:
-	$(Q)$(MAKE) $(build)=arch/arm/tools include/generated/mach-types.h
+	$(Q)$(MAKE) $(build)=arch/arm/tools \
+		include/generated/mach-types.h \
+		$(generated_asm_headers)
 
 # Convert bzImage to zImage
 bzImage: zImage
diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 23371b1..7d4458f 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -1,321 +1 @@
-/*
- *  arch/arm/include/asm/assembler.h
- *
- *  Copyright (C) 1996-2000 Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- *  This file contains arm architecture specific defines
- *  for the different processors.
- *
- *  Do not include any C declarations in this file - it is included by
- *  assembler source.
- */
-#ifndef __ASM_ASSEMBLER_H__
-#define __ASM_ASSEMBLER_H__
-
-#ifndef __ASSEMBLY__
-#error "Only include this from assembly code"
-#endif
-
-#include <asm/ptrace.h>
-#include <asm/domain.h>
-
-/*
- * Endian independent macros for shifting bytes within registers.
- */
-#ifndef __ARMEB__
-#define pull            lsr
-#define push            lsl
-#define get_byte_0      lsl #0
-#define get_byte_1	lsr #8
-#define get_byte_2	lsr #16
-#define get_byte_3	lsr #24
-#define put_byte_0      lsl #0
-#define put_byte_1	lsl #8
-#define put_byte_2	lsl #16
-#define put_byte_3	lsl #24
-#else
-#define pull            lsl
-#define push            lsr
-#define get_byte_0	lsr #24
-#define get_byte_1	lsr #16
-#define get_byte_2	lsr #8
-#define get_byte_3      lsl #0
-#define put_byte_0	lsl #24
-#define put_byte_1	lsl #16
-#define put_byte_2	lsl #8
-#define put_byte_3      lsl #0
-#endif
-
-/*
- * Data preload for architectures that support it
- */
-#if __LINUX_ARM_ARCH__ >= 5
-#define PLD(code...)	code
-#else
-#define PLD(code...)
-#endif
-
-/*
- * This can be used to enable code to cacheline align the destination
- * pointer when bulk writing to memory.  Experiments on StrongARM and
- * XScale didn't show this a worthwhile thing to do when the cache is not
- * set to write-allocate (this would need further testing on XScale when WA
- * is used).
- *
- * On Feroceon there is much to gain however, regardless of cache mode.
- */
-#ifdef CONFIG_CPU_FEROCEON
-#define CALGN(code...) code
-#else
-#define CALGN(code...)
-#endif
-
-/*
- * Enable and disable interrupts
- */
-#if __LINUX_ARM_ARCH__ >= 6
-	.macro	disable_irq_notrace
-	cpsid	i
-	.endm
-
-	.macro	enable_irq_notrace
-	cpsie	i
-	.endm
-#else
-	.macro	disable_irq_notrace
-	msr	cpsr_c, #PSR_I_BIT | SVC_MODE
-	.endm
-
-	.macro	enable_irq_notrace
-	msr	cpsr_c, #SVC_MODE
-	.endm
-#endif
-
-	.macro asm_trace_hardirqs_off
-#if defined(CONFIG_TRACE_IRQFLAGS)
-	stmdb   sp!, {r0-r3, ip, lr}
-	bl	trace_hardirqs_off
-	ldmia	sp!, {r0-r3, ip, lr}
-#endif
-	.endm
-
-	.macro asm_trace_hardirqs_on_cond, cond
-#if defined(CONFIG_TRACE_IRQFLAGS)
-	/*
-	 * actually the registers should be pushed and pop'd conditionally, but
-	 * after bl the flags are certainly clobbered
-	 */
-	stmdb   sp!, {r0-r3, ip, lr}
-	bl\cond	trace_hardirqs_on
-	ldmia	sp!, {r0-r3, ip, lr}
-#endif
-	.endm
-
-	.macro asm_trace_hardirqs_on
-	asm_trace_hardirqs_on_cond al
-	.endm
-
-	.macro disable_irq
-	disable_irq_notrace
-	asm_trace_hardirqs_off
-	.endm
-
-	.macro enable_irq
-	asm_trace_hardirqs_on
-	enable_irq_notrace
-	.endm
-/*
- * Save the current IRQ state and disable IRQs.  Note that this macro
- * assumes FIQs are enabled, and that the processor is in SVC mode.
- */
-	.macro	save_and_disable_irqs, oldcpsr
-	mrs	\oldcpsr, cpsr
-	disable_irq
-	.endm
-
-	.macro	save_and_disable_irqs_notrace, oldcpsr
-	mrs	\oldcpsr, cpsr
-	disable_irq_notrace
-	.endm
-
-/*
- * Restore interrupt state previously stored in a register.  We don't
- * guarantee that this will preserve the flags.
- */
-	.macro	restore_irqs_notrace, oldcpsr
-	msr	cpsr_c, \oldcpsr
-	.endm
-
-	.macro restore_irqs, oldcpsr
-	tst	\oldcpsr, #PSR_I_BIT
-	asm_trace_hardirqs_on_cond eq
-	restore_irqs_notrace \oldcpsr
-	.endm
-
-#define USER(x...)				\
-9999:	x;					\
-	.pushsection __ex_table,"a";		\
-	.align	3;				\
-	.long	9999b,9001f;			\
-	.popsection
-
-#ifdef CONFIG_SMP
-#define ALT_SMP(instr...)					\
-9998:	instr
-/*
- * Note: if you get assembler errors from ALT_UP() when building with
- * CONFIG_THUMB2_KERNEL, you almost certainly need to use
- * ALT_SMP( W(instr) ... )
- */
-#define ALT_UP(instr...)					\
-	.pushsection ".alt.smp.init", "a"			;\
-	.long	9998b						;\
-9997:	instr							;\
-	.if . - 9997b != 4					;\
-		.error "ALT_UP() content must assemble to exactly 4 bytes";\
-	.endif							;\
-	.popsection
-#define ALT_UP_B(label)					\
-	.equ	up_b_offset, label - 9998b			;\
-	.pushsection ".alt.smp.init", "a"			;\
-	.long	9998b						;\
-	W(b)	. + up_b_offset					;\
-	.popsection
-#else
-#define ALT_SMP(instr...)
-#define ALT_UP(instr...) instr
-#define ALT_UP_B(label) b label
-#endif
-
-/*
- * Instruction barrier
- */
-	.macro	instr_sync
-#if __LINUX_ARM_ARCH__ >= 7
-	isb
-#elif __LINUX_ARM_ARCH__ == 6
-	mcr	p15, 0, r0, c7, c5, 4
-#endif
-	.endm
-
-/*
- * SMP data memory barrier
- */
-	.macro	smp_dmb mode
-#ifdef CONFIG_SMP
-#if __LINUX_ARM_ARCH__ >= 7
-	.ifeqs "\mode","arm"
-	ALT_SMP(dmb)
-	.else
-	ALT_SMP(W(dmb))
-	.endif
-#elif __LINUX_ARM_ARCH__ == 6
-	ALT_SMP(mcr	p15, 0, r0, c7, c10, 5)	@ dmb
-#else
-#error Incompatible SMP platform
-#endif
-	.ifeqs "\mode","arm"
-	ALT_UP(nop)
-	.else
-	ALT_UP(W(nop))
-	.endif
-#endif
-	.endm
-
-#ifdef CONFIG_THUMB2_KERNEL
-	.macro	setmode, mode, reg
-	mov	\reg, #\mode
-	msr	cpsr_c, \reg
-	.endm
-#else
-	.macro	setmode, mode, reg
-	msr	cpsr_c, #\mode
-	.endm
-#endif
-
-/*
- * STRT/LDRT access macros with ARM and Thumb-2 variants
- */
-#ifdef CONFIG_THUMB2_KERNEL
-
-	.macro	usraccoff, instr, reg, ptr, inc, off, cond, abort, t=TUSER()
-9999:
-	.if	\inc == 1
-	\instr\cond\()b\()\t\().w \reg, [\ptr, #\off]
-	.elseif	\inc == 4
-	\instr\cond\()\t\().w \reg, [\ptr, #\off]
-	.else
-	.error	"Unsupported inc macro argument"
-	.endif
-
-	.pushsection __ex_table,"a"
-	.align	3
-	.long	9999b, \abort
-	.popsection
-	.endm
-
-	.macro	usracc, instr, reg, ptr, inc, cond, rept, abort
-	@ explicit IT instruction needed because of the label
-	@ introduced by the USER macro
-	.ifnc	\cond,al
-	.if	\rept == 1
-	itt	\cond
-	.elseif	\rept == 2
-	ittt	\cond
-	.else
-	.error	"Unsupported rept macro argument"
-	.endif
-	.endif
-
-	@ Slightly optimised to avoid incrementing the pointer twice
-	usraccoff \instr, \reg, \ptr, \inc, 0, \cond, \abort
-	.if	\rept == 2
-	usraccoff \instr, \reg, \ptr, \inc, \inc, \cond, \abort
-	.endif
-
-	add\cond \ptr, #\rept * \inc
-	.endm
-
-#else	/* !CONFIG_THUMB2_KERNEL */
-
-	.macro	usracc, instr, reg, ptr, inc, cond, rept, abort, t=TUSER()
-	.rept	\rept
-9999:
-	.if	\inc == 1
-	\instr\cond\()b\()\t \reg, [\ptr], #\inc
-	.elseif	\inc == 4
-	\instr\cond\()\t \reg, [\ptr], #\inc
-	.else
-	.error	"Unsupported inc macro argument"
-	.endif
-
-	.pushsection __ex_table,"a"
-	.align	3
-	.long	9999b, \abort
-	.popsection
-	.endr
-	.endm
-
-#endif	/* CONFIG_THUMB2_KERNEL */
-
-	.macro	strusr, reg, ptr, inc, cond=al, rept=1, abort=9001f
-	usracc	str, \reg, \ptr, \inc, \cond, \rept, \abort
-	.endm
-
-	.macro	ldrusr, reg, ptr, inc, cond=al, rept=1, abort=9001f
-	usracc	ldr, \reg, \ptr, \inc, \cond, \rept, \abort
-	.endm
-
-/* Utility macro for declaring string literals */
-	.macro	string name:req, string
-	.type \name , #object
-\name:
-	.asciz "\string"
-	.size \name , . - \name
-	.endm
-
-#endif /* __ASM_ASSEMBLER_H__ */
+#include <generated/asm-assembler.h>
diff --git a/arch/arm/include/asm/assembler.h.asm b/arch/arm/include/asm/assembler.h.asm
new file mode 100644
index 0000000..c1c3bc9
--- /dev/null
+++ b/arch/arm/include/asm/assembler.h.asm
@@ -0,0 +1,323 @@
+/*
+ *  arch/arm/include/asm/assembler.h
+ *
+ *  Copyright (C) 1996-2000 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ *  This file contains arm architecture specific defines
+ *  for the different processors.
+ *
+ *  Do not include any C declarations in this file - it is included by
+ *  assembler source.
+ */
+#ifndef __ASM_ASSEMBLER_H__
+#define __ASM_ASSEMBLER_H__
+
+#include <asm/ptrace.h>
+#include <asm/domain.h>
+
+#ifdef __ASSEMBLY__
+/*
+ * Endian independent macros for shifting bytes within registers.
+ */
+#ifndef __ARMEB__
+#define pull            lsr
+#define push            lsl
+#define get_byte_0      lsl #0
+#define get_byte_1	lsr #8
+#define get_byte_2	lsr #16
+#define get_byte_3	lsr #24
+#define put_byte_0      lsl #0
+#define put_byte_1	lsl #8
+#define put_byte_2	lsl #16
+#define put_byte_3	lsl #24
+#else
+#define pull            lsl
+#define push            lsr
+#define get_byte_0	lsr #24
+#define get_byte_1	lsr #16
+#define get_byte_2	lsr #8
+#define get_byte_3      lsl #0
+#define put_byte_0	lsl #24
+#define put_byte_1	lsl #16
+#define put_byte_2	lsl #8
+#define put_byte_3      lsl #0
+#endif
+
+/*
+ * Data preload for architectures that support it
+ */
+#if __LINUX_ARM_ARCH__ >= 5
+#define PLD(code...)	code
+#else
+#define PLD(code...)
+#endif
+
+/*
+ * This can be used to enable code to cacheline align the destination
+ * pointer when bulk writing to memory.  Experiments on StrongARM and
+ * XScale didn't show this a worthwhile thing to do when the cache is not
+ * set to write-allocate (this would need further testing on XScale when WA
+ * is used).
+ *
+ * On Feroceon there is much to gain however, regardless of cache mode.
+ */
+#ifdef CONFIG_CPU_FEROCEON
+#define CALGN(code...) code
+#else
+#define CALGN(code...)
+#endif
+
+/*
+ * Enable and disable interrupts
+ */
+#if __LINUX_ARM_ARCH__ >= 6
+	.macro	disable_irq_notrace
+	cpsid	i
+	.endm
+
+	.macro	enable_irq_notrace
+	cpsie	i
+	.endm
+#else
+	.macro	disable_irq_notrace
+	msr	cpsr_c, #PSR_I_BIT | SVC_MODE
+	.endm
+
+	.macro	enable_irq_notrace
+	msr	cpsr_c, #SVC_MODE
+	.endm
+#endif
+
+	.macro asm_trace_hardirqs_off
+#if defined(CONFIG_TRACE_IRQFLAGS)
+	stmdb   sp!, {r0-r3, ip, lr}
+	bl	trace_hardirqs_off
+	ldmia	sp!, {r0-r3, ip, lr}
+#endif
+	.endm
+
+	.macro asm_trace_hardirqs_on_cond, cond
+#if defined(CONFIG_TRACE_IRQFLAGS)
+	/*
+	 * actually the registers should be pushed and pop'd conditionally, but
+	 * after bl the flags are certainly clobbered
+	 */
+	stmdb   sp!, {r0-r3, ip, lr}
+	bl\cond	trace_hardirqs_on
+	ldmia	sp!, {r0-r3, ip, lr}
+#endif
+	.endm
+
+	.macro asm_trace_hardirqs_on
+	asm_trace_hardirqs_on_cond al
+	.endm
+
+	.macro disable_irq
+	disable_irq_notrace
+	asm_trace_hardirqs_off
+	.endm
+
+	.macro enable_irq
+	asm_trace_hardirqs_on
+	enable_irq_notrace
+	.endm
+/*
+ * Save the current IRQ state and disable IRQs.  Note that this macro
+ * assumes FIQs are enabled, and that the processor is in SVC mode.
+ */
+	.macro	save_and_disable_irqs, oldcpsr
+	mrs	\oldcpsr, cpsr
+	disable_irq
+	.endm
+
+	.macro	save_and_disable_irqs_notrace, oldcpsr
+	mrs	\oldcpsr, cpsr
+	disable_irq_notrace
+	.endm
+
+/*
+ * Restore interrupt state previously stored in a register.  We don't
+ * guarantee that this will preserve the flags.
+ */
+	.macro	restore_irqs_notrace, oldcpsr
+	msr	cpsr_c, \oldcpsr
+	.endm
+
+	.macro restore_irqs, oldcpsr
+	tst	\oldcpsr, #PSR_I_BIT
+	asm_trace_hardirqs_on_cond eq
+	restore_irqs_notrace \oldcpsr
+	.endm
+
+#define USER(x...)				\
+9999:	x;					\
+	.pushsection __ex_table,"a";		\
+	.align	3;				\
+	.long	9999b,9001f;			\
+	.popsection
+
+#ifdef CONFIG_SMP
+#define ALT_SMP(instr...)					\
+9998:	instr
+/*
+ * Note: if you get assembler errors from ALT_UP() when building with
+ * CONFIG_THUMB2_KERNEL, you almost certainly need to use
+ * ALT_SMP( W(instr) ... )
+ */
+#define ALT_UP(instr...)					\
+	.pushsection ".alt.smp.init", "a"			;\
+	.long	9998b						;\
+9997:	instr							;\
+	.if . - 9997b != 4					;\
+		.error "ALT_UP() content must assemble to exactly 4 bytes";\
+	.endif							;\
+	.popsection
+#define ALT_UP_B(label)					\
+	.equ	up_b_offset, label - 9998b			;\
+	.pushsection ".alt.smp.init", "a"			;\
+	.long	9998b						;\
+	W(b)	. + up_b_offset					;\
+	.popsection
+#else
+#define ALT_SMP(instr...)
+#define ALT_UP(instr...) instr
+#define ALT_UP_B(label) b label
+#endif
+
+/*
+ * Instruction barrier
+ */
+	.macro	instr_sync
+#if __LINUX_ARM_ARCH__ >= 7
+	isb
+#elif __LINUX_ARM_ARCH__ == 6
+	mcr	p15, 0, r0, c7, c5, 4
+#endif
+	.endm
+
+/*
+ * SMP data memory barrier
+ */
+	.macro	smp_dmb mode
+#ifdef CONFIG_SMP
+#if __LINUX_ARM_ARCH__ >= 7
+	.ifeqs "\mode","arm"
+	ALT_SMP(dmb)
+	.else
+	ALT_SMP(W(dmb))
+	.endif
+#elif __LINUX_ARM_ARCH__ == 6
+	ALT_SMP(mcr	p15, 0, r0, c7, c10, 5)	@ dmb
+#else
+#error Incompatible SMP platform
+#endif
+	.ifeqs "\mode","arm"
+	ALT_UP(nop)
+	.else
+	ALT_UP(W(nop))
+	.endif
+#endif
+	.endm
+
+#ifdef CONFIG_THUMB2_KERNEL
+	.macro	setmode, mode, reg
+	mov	\reg, #\mode
+	msr	cpsr_c, \reg
+	.endm
+#else
+	.macro	setmode, mode, reg
+	msr	cpsr_c, #\mode
+	.endm
+#endif
+
+/*
+ * STRT/LDRT access macros with ARM and Thumb-2 variants
+ */
+#ifdef CONFIG_THUMB2_KERNEL
+
+	.macro	usraccoff, instr, reg, ptr, inc, off, cond, abort, t=TUSER()
+9999:
+	.if	\inc == 1
+	\instr\cond\()b\()\t\().w \reg, [\ptr, #\off]
+	.elseif	\inc == 4
+	\instr\cond\()\t\().w \reg, [\ptr, #\off]
+	.else
+	.error	"Unsupported inc macro argument"
+	.endif
+
+	.pushsection __ex_table,"a"
+	.align	3
+	.long	9999b, \abort
+	.popsection
+	.endm
+
+	.macro	usracc, instr, reg, ptr, inc, cond, rept, abort
+	@ explicit IT instruction needed because of the label
+	@ introduced by the USER macro
+	.ifnc	\cond,al
+	.if	\rept == 1
+	itt	\cond
+	.elseif	\rept == 2
+	ittt	\cond
+	.else
+	.error	"Unsupported rept macro argument"
+	.endif
+	.endif
+
+	@ Slightly optimised to avoid incrementing the pointer twice
+	usraccoff \instr, \reg, \ptr, \inc, 0, \cond, \abort
+	.if	\rept == 2
+	usraccoff \instr, \reg, \ptr, \inc, \inc, \cond, \abort
+	.endif
+
+	add\cond \ptr, #\rept * \inc
+	.endm
+
+#else	/* !CONFIG_THUMB2_KERNEL */
+
+	.macro	usracc, instr, reg, ptr, inc, cond, rept, abort, t=TUSER()
+	.rept	\rept
+9999:
+	.if	\inc == 1
+	\instr\cond\()b\()\t \reg, [\ptr], #\inc
+	.elseif	\inc == 4
+	\instr\cond\()\t \reg, [\ptr], #\inc
+	.else
+	.error	"Unsupported inc macro argument"
+	.endif
+
+	.pushsection __ex_table,"a"
+	.align	3
+	.long	9999b, \abort
+	.popsection
+	.endr
+	.endm
+
+#endif	/* CONFIG_THUMB2_KERNEL */
+
+	.macro	strusr, reg, ptr, inc, cond=al, rept=1, abort=9001f
+	usracc	str, \reg, \ptr, \inc, \cond, \rept, \abort
+	.endm
+
+	.macro	ldrusr, reg, ptr, inc, cond=al, rept=1, abort=9001f
+	usracc	ldr, \reg, \ptr, \inc, \cond, \rept, \abort
+	.endm
+
+/* Utility macro for declaring string literals */
+	.macro	string name:req, string
+	.type \name , #object
+\name:
+	.asciz "\string"
+	.size \name , . - \name
+	.endm
+#endif /* __ASSEMBLY__ */
+
+ASM(
+/* Add common macros for .S files and C inline assembler here */
+)
+
+#endif /* __ASM_ASSEMBLER_H__ */
diff --git a/arch/arm/tools/Makefile b/arch/arm/tools/Makefile
index 635cb18..f0140b6 100644
--- a/arch/arm/tools/Makefile
+++ b/arch/arm/tools/Makefile
@@ -8,3 +8,7 @@ include/generated/mach-types.h: $(src)/gen-mach-types $(src)/mach-types
 	@echo '  Generating $@'
 	@mkdir -p $(dir $@)
 	$(Q)$(AWK) -f $^ > $@ || { rm -f $@; /bin/false; }
+
+include/generated/asm-%.h: arch/arm/include/asm/%.h.asm
+	@echo '  GEN     $@'
+	$(Q)$(PERL) $(src)/asm-header.pl $< >$@ || { $(RM) $@; /bin/false; }
diff --git a/arch/arm/tools/asm-header.pl b/arch/arm/tools/asm-header.pl
new file mode 100644
index 0000000..dfdc5c5
--- /dev/null
+++ b/arch/arm/tools/asm-header.pl
@@ -0,0 +1,76 @@
+#!/usr/bin/perl
+
+# asm-header.pl -- converts assembler declarations in header files for
+# inclusion via the compiler.
+#
+# Headers intended for processing by this script should be named
+# arch/arm/include/asm/*.h.asm
+#
+# In these headers, blocks between
+#
+# ASM(
+#
+# ...and...
+#
+# )
+#
+# are passed through to the assembler unmodified.  Use ASM() blocks for
+# common assembler declarations and macros to be shared by .S files and
+# inline asm.
+#
+# You can use C preprocessor directives and C macros in such headers,
+# but the content of ASM() blocks will not be preprocessed in any way
+# except for the collapsing of continuation lines.  The assembler will
+# see the content of these blocks unchanged.
+#
+# For every header file arch/arm/include/asm/NAME.h.asm, you should
+# create a proxy header in arch/arm/include/asm/NAME.h which just
+# contains the line:
+#
+# #include <generated/asm-NAME.h>
+#
+# The correct way to make use of the generated header in a source file
+# (.S or .c) is:
+#
+# #include <asm/NAME.h>
+
+use strict;
+
+print <<EOF;
+/*
+ * Do not edit this file.
+ * Header automatically generated from $ARGV[0] by asm-header.pl
+ */
+
+EOF
+
+my $start_match = qr/^ASM\(/;
+my $end_match = qr/^\)/;
+
+while (<>) {
+	if (/$start_match/) {
+		my @asm = ();
+
+		while (<>) {
+			last if /$end_match/;
+			push @asm, $_;
+		}
+
+		for (my $i = 0; $i <= $#asm - 1; $i++) {
+			while ($asm[$i] =~ s/\\\n$//) {
+				$asm[$i] .= ' ' . $asm[$i + 1];
+				splice @asm, $i + 1, 1;
+			}
+		}
+
+		print "#ifdef __ASSEMBLY__\n";
+		print @asm;
+		print "#else /* ! __ASSEMBLY__ */\n";
+		do { s/[\\\"]/\\$&/g; s/.*/asm("$&");/; print } foreach @asm;
+		print "#endif /* ! __ASSEMBLY__ */\n";
+
+		next;
+	}
+
+	print
+}
-- 
1.7.4.1
