From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Wed, 2 Feb 2011 17:16:21 +0000 (GMT)
Subject: hibernation yet again ...
Message-ID: <alpine.DEB.2.00.1102021637030.13135@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


Sorry to bring an almost-beaten-to-death topic up again here ... the ARM 
hibernation support patch, and the question how to avoid descending into 
#ifdef hell in order to support different architectures / platforms.

Long post - discard if not interested, please.


We've had to get it to run on both ARM11 (Samsung S5P6450) and Cortex-A8 
(OMAP3) systems and hence re-worked the patch originally posted by 
TI/Nokia - kudos and thanks, to everyone who contributed to this so far.

I've used Hiroshi Doku's patch, the mach-dove hibernation support code 
from Ubuntu and the old 2.6.12 swsusp "sample" code from elinux.org to 
base this on.


What came out of this is code that, at least for those two platforms, is 
generic, and uses a single arch-dependent header file, <mach/hibernate.h>, 
to implement __save_processor_state() / __restore_processor_state() in 
whatever way necessary.

There's no #ifdef on cpu types required at the moment. Code structure 
looks like this:

  arch/arm/Kconfig                               |    9 +
  arch/arm/plat-omap/Kconfig                     |    1 +
  arch/arm/include/asm/memory.h                  |    1 +
  arch/arm/include/asm/suspend.h                 |    6 +
  arch/arm/kernel/Makefile                       |    2 +
  arch/arm/kernel/cpu.c                          |  187 +++++++++++++++++++++
  arch/arm/kernel/swsusp.S                       |  206 ++++++++++++++++++++++++
  arch/arm/kernel/vmlinux.lds.S                  |    8 +-
  include/asm-generic/vmlinux.lds.h              |    2 +-
  arch/arm/mach-s5p6450/include/mach/hibernate.h |  130 +++++++++++++++
  arch/arm/plat-omap/include/mach/hibernate.h    |  178 ++++++++++++++++++++

If you'd want to add another one, that should be no harder than creating a 
suitable <mach/hibernate.h> for yourself and switching 
ARCH_HIBERNATION_POSSIBLE on wherever your platform Kconfig's itself.



Some comments on changes made:

I've also moved the entire "context" structure into a single place, so 
that CPU regs, CP regs, and whatever else the arch-dependent code decides 
to save is in found in a single place - all within the same MMU page as 
swsusp_arch_resume() itself. That's not strictly necessary but helps a 
little bit with debugging. A side-effect is that swsusp_arch_resume() 
becomes (mostly) relocatable, who know what that might one day be useful 
for ...

The __attribute__ ((packed)) used on struct saved_context is/was 
unnecessary (and resulted in very 'interesting' machine code - byte 
loads/stores). I've removed it.

I've put swsusp_arch_suspend() into C using inline assembler, mostly for 
illustration purposes but then the calling context for it is safe enough 
to do it in C.

Finally, I've used the code from copy_page.S to speed up the pagelist 
restore done at the beginning of swsusp_arch_resume(). The reg-by-reg 
approach from the existing patch is unnecessarily slow.



Please don't think this patch as "final". I'm not proposing to integrate 
this at the moment, I agree with other previous posters on the subject 
that there's still some work to do. I'm hoping this patch might help with 
creating easily-extendible ARM hibernation support code without having to 
descend into #ifdef hell.



Regarding things unaddressed by my specific patch:

For one, the __save_processor_state() / __restore_processor_state() aren't 
quite following ARM's app note guidelines on how to save / restore CP regs 
yet (AN143, for ARM11 at least - does anyone have the equiv for Cortex ?). 
Much of the CP15 state being saved isn't used by "normal" workloads, 
testcases more than welcome ;-)

Also, as you can see from the comments in cpu.c, I've had some 
crosscompiler issues where incorrect assembly was generated for the 
ldr/mcr sequences in restore_processor_state. This probably doesn't belong 
into a final patch either.

And, right now, it's explicitly made incompatible with SMP; I'm not 100% 
sure of this but lacking Cortex-A9 test hardware, someone else will have 
to experiment there.

The mach-dove Ubuntu patches as well as the Nokia/TI hibernation patch 
mention that FP / Neon state should be saved as well; That seems 
unnecessary to me because the freezer makes sure this state already _is_ 
saved elsewhere. In my (largely manual) tests, I've not noticed any 
problems resuming into running applications that use floating point.

Last, this is tested against 2.6.32 ...


Finally, for those who want to play with this on Android kernels: Android 
has a modification in kernel/power/process.c, try_to_freeze_processes() 
where it _prevents_ multiple tries through the freezer loop if a wakelock 
is pending. That stops a manual hibernation request, so remove the "break" 
from that condition.



Thanks,
FrankH.
-------------- next part --------------
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7034880..2131818 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -197,6 +197,14 @@ config VECTORS_BASE
 	help
 	  The base address of exception vectors.
 
+config ARCH_HIBERNATION_POSSIBLE
+	bool
+	depends on !SMP
+	help
+	  If the machine architecture supports suspend-to-disk
+	  it should select this automatically for you.
+	  Otherwise, say 'Y' at your own peril.
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
@@ -650,6 +658,7 @@ config ARCH_S5P6450
         select GENERIC_GPIO
         select ARCH_HAS_CPUFREQ
         select HAVE_CLK
+	select ARCH_HIBERNATION_POSSIBLE
         help
           Samsung S5P6450 CPU based systems
 
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 019a55d..12158c2 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -23,6 +23,7 @@ config ARCH_OMAP3
 	select CPU_V7
 	select COMMON_CLKDEV
 	select ARM_L1_CACHE_SHIFT_6
+	select ARCH_HIBERNATION_POSSIBLE
 
 config ARCH_OMAP4
 	bool "TI OMAP4"
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index cefedf0..22f17f8 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -183,6 +183,7 @@ static inline void *phys_to_virt(unsigned long x)
  */
 #define __pa(x)			__virt_to_phys((unsigned long)(x))
 #define __va(x)			((void *)__phys_to_virt((unsigned long)(x)))
+#define __pa_symbol(x)		__pa(RELOC_HIDE((unsigned long)(x),0))
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
 
 /*
diff --git a/arch/arm/include/asm/suspend.h b/arch/arm/include/asm/suspend.h
new file mode 100644
index 0000000..8857c79
--- /dev/null
+++ b/arch/arm/include/asm/suspend.h
@@ -0,0 +1,6 @@
+#ifndef __ASM_ARM_SUSPEND_H
+#define __ASM_ARM_SUSPEND_H
+
+static inline int arch_prepare_suspend(void) { return 0; }
+
+#endif	/* __ASM_ARM_SUSPEND_H */
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 79087dd..71bde73 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -4,6 +4,7 @@
 
 CPPFLAGS_vmlinux.lds := -DTEXT_OFFSET=$(TEXT_OFFSET)
 AFLAGS_head.o        := -DTEXT_OFFSET=$(TEXT_OFFSET)
+AFLAGS_swsusp.o      := -DTEXT_OFFSET=$(TEXT_OFFSET)
 
 ifdef CONFIG_DYNAMIC_FTRACE
 CFLAGS_REMOVE_ftrace.o = -pg
@@ -36,6 +37,7 @@ obj-$(CONFIG_ARM_THUMBEE)	+= thumbee.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_ARM_UNWIND)	+= unwind.o
 obj-$(CONFIG_HAVE_TCM)		+= tcm.o
+obj-$(CONFIG_HIBERNATION)       += cpu.o swsusp.o
 
 obj-$(CONFIG_CRUNCH)		+= crunch.o crunch-bits.o
 AFLAGS_crunch-bits.o		:= -Wa,-mcpu=ep9312
diff --git a/arch/arm/kernel/cpu.c b/arch/arm/kernel/cpu.c
new file mode 100644
index 0000000..eafb800
--- /dev/null
+++ b/arch/arm/kernel/cpu.c
@@ -0,0 +1,187 @@
+/*
+ * Hibernation support specific for ARM
+ *
+ * Copyright (C) 2010 Nokia Corporation
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Copyright (C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
+ *
+ * Contact: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <asm/ptrace.h>
+#include <linux/stringify.h>
+
+
+/*
+ * Helper macros for machine-specific code to create ARM coprocessor
+ * state save/load operations.
+ *
+ * Used in <mach/hibernate.h> to save/restore processor specific state.
+ */
+
+#define SAVE_CPREG(p, op1, cr1, cr2, op2, tgt)			\
+	"mrc " __stringify(p, op1, %0, cr1, cr2, op2) : "=r"(tgt) : : "memory", "cc"
+
+/*
+ * Note: I have a version of gcc 4.3.3 which sometimes emits incorrect code
+ * for this inline assembly if the obvious ": : r(src) :" constraint is used
+ * to load the operand register.
+ *
+ * It eliminates the automatically-generated "ldr %0, [src]" instruction.
+ * The problem happens even on explictly-requested "ldr" like:
+ *	"ldr r3, %0\n"		\
+ *	"mcr " __stringify(p, op1, r3, cr1, cr2, op2) : : "m" (src) : "r3", "memory"
+ *
+ * To prevent that from happening, tell the compiler to treat input as
+ * output, which means this will give us code like:
+ *	ldr %0, [src]
+ *	mcr ...
+ *	str %0, [src]
+ * That might not be perfect but what works works ... on my compiler.
+ *
+ * Enable CONFIG_NO_GCC_INLINE_ASM_WORKAROUND if you wish to test what
+ * your compiler version creates.
+ */
+#ifdef	CONFIG_NO_GCC_INLINE_ASM_WORKAROUND
+#define	LOADCONSTRAINT(src)	: "r"((src))  : "memory", "cc"
+#else
+#define	LOADCONSTRAINT(src)	"+r"((src)) : : "memory", "cc"
+#endif
+
+#define	LOAD_CPREG(p, op1, cr1, cr2, op2, src)			\
+	"mcr " __stringify(p, op1, %0, cr1, cr2, op2) : LOADCONSTRAINT(src)
+
+
+#include <mach/hibernate.h>
+
+
+struct arm_cpu_context {
+	u32 regs_usr[15];		/* user r0 - r14 */
+	u32 regs_fiq[7];		/* FIQ r8 - r14 */
+	u32 regs_irq[2];		/* IRQ r13, r14 */
+	u32 regs_svc[2];		/* SVC r13, r14 */
+	u32 regs_abt[2];		/* ABT r13, r14 */
+	u32 regs_und[2];		/* UND r13, r14 */
+	u32 cpsr;
+	u32 spsr_fiq;
+	u32 spsr_irq;
+	u32 spsr_svc;
+	u32 spsr_abt;
+	u32 spsr_und;
+	struct saved_context mach_context;	/* from mach/hibernate.h */
+};
+
+/*
+ * This is kept together with the swsusp_arch_resume() within swsusp.S
+ * and only referenced here.
+ */
+extern struct arm_cpu_context ctx;
+
+/* References to section boundaries */
+extern const void __nosave_begin, __nosave_end;
+
+
+/*
+ * All of the functions in this section operate in a "restricted"
+ * context. This means in particular that they should neither use
+ * stack, nor any variables not "NoSave".
+ *
+ * These functions are called while the suspend code is rewriting
+ * one kernel image with another. What is stack in the "boot" image
+ * might well be a data page in the "resume" image, and overwriting
+ * your own stack is a bad idea.
+ *
+ * All have to be attributed "notrace" to prevent ftrace hooks
+ * being automatically embedded into the generated code.
+ */
+
+/*
+ * pfn_is_nosave - check if given pfn is in the 'nosave' section
+ */
+notrace int pfn_is_nosave(unsigned long pfn)
+{
+	unsigned long nosave_begin_pfn = __pa_symbol(&__nosave_begin) >> PAGE_SHIFT;
+	unsigned long nosave_end_pfn = PAGE_ALIGN(__pa_symbol(&__nosave_end)) >> PAGE_SHIFT;
+
+	return (pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
+}
+
+notrace void save_processor_state(void)
+{
+	register struct arm_cpu_context* saved_context = &ctx;
+	preempt_disable();
+	__save_processor_state(&saved_context->mach_context);
+}
+
+notrace void restore_processor_state(void)
+{
+	register struct arm_cpu_context* saved_context = &ctx;
+	__restore_processor_state(&saved_context->mach_context);
+	preempt_enable();
+}
+
+/*
+ * Save the CPU registers before suspend. This is called after having
+ * snapshot the processor state via the above, and will trigger the
+ * actual system down by calling swsusp_save().
+ *
+ * Context is even more restricted because swsusp_save() doesn't restore
+ * a valid return address. It has to be reloaded from the saved context.
+ * Prevent compiler from adding prologue/epilogue code via __naked.
+ */
+extern void swsusp_save(void);
+
+notrace __naked void swsusp_arch_suspend(void)
+{
+	register struct arm_cpu_context* saved_context = &ctx;
+	register u32 cpsr;
+
+	asm volatile ("mrs %0, cpsr" : "=r" (cpsr));
+
+	saved_context->cpsr = cpsr;
+	cpsr &= ~MODE_MASK;
+
+	asm volatile ("msr cpsr, %0" : : "r" (cpsr | SYSTEM_MODE));
+	asm volatile ("stmia %0, {r0-r14}" : : "r" (&saved_context->regs_usr));
+
+	asm volatile ("msr cpsr, %0" : : "r" (cpsr | FIQ_MODE));
+	asm volatile ("stmia %0, {r8-r14}" : : "r" (&saved_context->regs_fiq));
+	asm volatile ("mrs %0, spsr" : "=r" (saved_context->spsr_fiq));
+
+	asm volatile ("msr cpsr, %0" : : "r" (cpsr | IRQ_MODE));
+	asm volatile ("stmia %0, {r13-r14}" : : "r" (&saved_context->regs_irq));
+	asm volatile ("mrs %0, spsr" : "=r" (saved_context->spsr_irq));
+
+	asm volatile ("msr cpsr, %0" : : "r" (cpsr | SVC_MODE));
+	asm volatile ("stmia %0, {r13-r14}" : : "r" (&saved_context->regs_svc));
+	asm volatile ("mrs %0, spsr" : "=r" (saved_context->spsr_svc));
+
+	asm volatile ("msr cpsr, %0" : : "r" (cpsr | ABT_MODE));
+	asm volatile ("stmia %0, {r13-r14}" : : "r" (&saved_context->regs_abt));
+	asm volatile ("mrs %0, spsr" : "=r" (saved_context->spsr_abt));
+
+	asm volatile ("msr cpsr, %0" : : "r" (cpsr | UND_MODE));
+	asm volatile ("stmia %0, {r13-r14}" : : "r" (&saved_context->regs_und));
+	asm volatile ("mrs %0, spsr" : "=r" (saved_context->spsr_und));
+
+	/*
+	 * restore original mode before suspending.
+	 */
+	asm volatile ("msr cpsr, %0" : : "r" (saved_context->cpsr));
+	swsusp_save();
+
+	/*
+	 * On return from swsusp_save(), re-load our return address from
+	 * saved state.
+	 * This would have to be done even if we weren't __naked, because
+	 * hibernation context has changed when returning from suspend.
+	 */
+	asm volatile (	"ldr lr, [%0]\n"
+			"mov r0, #0\n"
+			"mov pc, lr" : : "r" (&saved_context->regs_svc[1]) : "r0", "lr");
+}
+
diff --git a/arch/arm/kernel/swsusp.S b/arch/arm/kernel/swsusp.S
new file mode 100644
index 0000000..1f75738
--- /dev/null
+++ b/arch/arm/kernel/swsusp.S
@@ -0,0 +1,206 @@
+/*
+ * Hibernation support specific for ARM
+ *
+ * Copyright (C) 2010 Nokia Corporation
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Copyright (C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
+ *
+ * Contact: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/asm-offsets.h>
+#include <asm/cache.h>
+#include <asm/memory.h>
+#include <asm/segment.h>
+#include <asm/page.h>
+#include <asm/ptrace.h>
+
+/*
+ * swsusp_arch_suspend() has been written in C with inline assembly.
+ *
+ENTRY(swsusp_arch_suspend)
+ENDPROC(swsusp_arch_suspend)
+*/
+
+#define	KERNEL_RAM_PADDR	(PHYS_OFFSET + TEXT_OFFSET)
+#define	SWAPPER_PG_DIR		(KERNEL_RAM_PADDR - 0x4000)
+
+
+/*
+ * Save the CPU context (register set for all modes and mach-specific cp regs)
+ * here. Setting aside a CPU page, should be aplenty.
+ */
+.align	PAGE_SHIFT
+ctx:
+.globl	ctx
+.space	PAGE_SIZE / 2
+.size	ctx,.-ctx
+
+/*
+ * offsets within "struct arm_cpu_context {}" for:
+ *	Register set	usr[15], fiq[7], irq..und[2]
+ *	cpsr/spsr	system, fiq..und
+ *
+ * Always make sure these match the structure definition in cpu.c
+ */
+#define	CTXREL		(ctx - .)		/* when adding to pc */
+#define	CTX		(ctx - . - 8)		/* used with ldr ... [pc, #...] */
+#define	REGS_USR	(0)
+#define	REGS_FIQ	(REGS_USR + 15 * 4)
+#define	REGS_IRQ	(REGS_FIQ + 7 * 4)
+#define	REGS_SVC	(REGS_IRQ + 2 * 4)
+#define	REGS_ABT	(REGS_SVC + 2 * 4)
+#define	REGS_UND	(REGS_ABT + 2 * 4)
+
+#define	REG_CPSR	(REGS_UND + 2 * 4)
+#define	REG_SPSR_FIQ	(REG_CPSR + 4)
+#define	REG_SPSR_IRQ	(REG_SPSR_FIQ + 4)
+#define	REG_SPSR_SVC	(REG_SPSR_IRQ + 4)
+#define	REG_SPSR_ABT	(REG_SPSR_SVC + 4)
+#define	REG_SPSR_UND	(REG_SPSR_ABT + 4)
+
+/*
+ * Temporary storage for CPSR, required during swsusp_arch_resume()
+ */
+#define	CPSRTMP	(.Lcpsrtmp - . - 8)	/* for ldr ..., [pc, #CPSRTMP] */
+
+#define	COPY_COUNT	(PAGE_SIZE / (2 * L1_CACHE_BYTES) PLD( -1 ))
+
+ENTRY(swsusp_arch_resume)
+	/* set page table if needed */
+	ldr	r0, =SWAPPER_PG_DIR
+	mcr	p15, 0, r0, c2, c0, 0		@ load page table pointer
+	mcr	p15, 0, r0, c8, c7, 0		@ invalidate I,D TLBs
+	mcr	p15, 0, r0, c7, c5, 4		@ ISB
+
+	/*
+	 * Restore_pblist is the starting point for loaded pages
+	 */
+	ldr     r0, =restore_pblist
+	ldr     r1, [r0]
+
+.Lcopy_loop:
+	ldr     r0, [r1]		/* src IOW present address */
+	ldr     r2, [r1, #4]		/* dst IOW original address */
+
+.align L1_CACHE_SHIFT
+	/*
+	 * Reasonably fast copy loop - shamelessly cut&pasted from copy_page.S
+	 */
+PLD(	pld	[r0, #0]			)
+PLD(	pld	[r0, #L1_CACHE_BYTES]		)
+	mov	r3, #COPY_COUNT
+	ldmia	r0!, {r4-r7}
+1:
+PLD(	pld	[r0, #(2 * L1_CACHE_BYTES)]	)
+PLD(	pld	[r0, #(3 * L1_CACHE_BYTES)]	)
+2:
+.rept	(2 * L1_CACHE_BYTES / 16 - 1)
+	stmia	r2!, {r4-r7}
+	ldmia	r0!, {r4-r7}
+.endr
+	subs	r3, r3, #1
+	stmia	r2!, {r4-r7}
+	ldmgtia	r0!, {r4-r7}
+	bgt	1b
+PLD(	ldmeqia	r0!, {r4-r7}			)
+PLD(	beq	2b				)
+
+	/* The last field of struct pbe is a pointer to the next pbe structure */
+	ldr     r1, [r1, #8]
+	cmp     r1, #0
+	bne     .Lcopy_loop
+
+	/*
+	 * CPU register restore, for all modes.
+	 */
+	mrs	r0, cpsr
+	str	r0, [pc, #CPSRTMP]		/* cpsr_save */
+
+	/*
+	 * User (System) mode registers
+	 */
+	orr	r0, r0, #SYSTEM_MODE
+	msr	cpsr_c, r0
+.align 4					/* prevent fixup error */
+	add	r1, pc, #CTXREL
+	ldm	r1, {r0-r14}
+	ldr	r0, [pc, #(CTX + REG_CPSR)]
+	msr	cpsr_cxsf, r0
+	ldr	r0, [pc, #CPSRTMP]		/* cpsr_save */
+
+	/*
+	 * FIQ mode registers
+	 */
+	bic	r0, r0, #MODE_MASK
+	orr	r0, r0, #FIQ_MODE
+	msr	cpsr_c, r0
+	add	r1, pc, #CTXREL			/* ldm clobbered r1 - restore */
+	add	r2, r1, #REGS_FIQ
+	ldm	r2, {r8-r14}
+	ldr	r2, [pc, #(CTX + REG_SPSR_FIQ)]
+	msr	spsr_cxsf, r2
+
+	/*
+	 * IRQ mode registers
+	 */
+	bic	r0, r0, #MODE_MASK
+	orr	r0, r0, #IRQ_MODE
+	msr	cpsr_c, r0
+	ldr	sp, [pc, #(CTX + REGS_IRQ)]
+	ldr	lr, [pc, #(CTX + REGS_IRQ + 4)]
+	ldr	r2, [pc, #(CTX + REG_SPSR_IRQ)]
+	msr	spsr_cxsf, r2
+
+	/*
+	 * SVC mode registers
+	 */
+	bic	r0, r0, #MODE_MASK
+	orr	r0, r0, #SVC_MODE
+	msr	cpsr_c, r0
+	ldr	sp, [pc, #(CTX + REGS_SVC)]
+	ldr	lr, [pc, #(CTX + REGS_SVC + 4)]
+	ldr	r2, [pc, #(CTX + REG_SPSR_SVC)]
+	msr	spsr_cxsf, r2
+
+	/*
+	 * ABT mode registers
+	 */
+	bic	r0, r0, #MODE_MASK
+	orr	r0, r0, #ABT_MODE
+	msr	cpsr_c, r0
+	ldr	sp, [pc, #(CTX + REGS_ABT)]
+	ldr	lr, [pc, #(CTX + REGS_ABT + 4)]
+	ldr	r2, [pc, #(CTX + REG_SPSR_ABT)]
+	msr	spsr_cxsf, r2
+
+	/*
+	 * UND mode registers
+	 */
+	bic	r0, r0, #MODE_MASK
+	orr	r0, r0, #UND_MODE
+	msr	cpsr_c, r0
+	ldr	sp, [pc, #(CTX + REGS_UND)]
+	ldr	lr, [pc, #(CTX + REGS_UND + 4)]
+	ldr	r2, [pc, #(CTX + REG_SPSR_UND)]
+	msr	spsr_cxsf, r2
+
+	ldr	r0, [pc, #CPSRTMP]	/* cpsr_save */
+	msr	cpsr_c, r0
+
+	/*
+	 * Flush TLB before returning.
+	 */
+	mov	r0, #0
+	mcr p15, 0, r0, c8, c7, 0
+
+	ldr	lr, [pc, #(CTX + REGS_SVC + 4)]
+	mov	pc, lr
+
+ENDPROC(swsusp_arch_resume)
+
+.Lcpsrtmp:	.long	0
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index aecf87d..05883b7 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -167,12 +167,6 @@ SECTIONS
 		__init_end = .;
 #endif
 
-		. = ALIGN(PAGE_SIZE);
-		__nosave_begin = .;
-		*(.data.nosave)
-		. = ALIGN(PAGE_SIZE);
-		__nosave_end = .;
-
 		/*
 		 * then the cacheline aligned data
 		 */
@@ -199,6 +193,8 @@ SECTIONS
 	}
 	_edata_loc = __data_loc + SIZEOF(.data);
 
+	NOSAVE_DATA
+
 #ifdef CONFIG_HAVE_TCM
         /*
 	 * We align everything to a page boundary so we can
diff --git a/arch/arm/mach-s5p6450/include/mach/hibernate.h b/arch/arm/mach-s5p6450/include/mach/hibernate.h
new file mode 100644
index 0000000..23906ee
--- /dev/null
+++ b/arch/arm/mach-s5p6450/include/mach/hibernate.h
@@ -0,0 +1,130 @@
+/*
+ * Hibernation support specific for ARM
+ *
+ * Copyright (C) 2010 Nokia Corporation
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Copyright (C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
+ *
+ * Contact: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#ifndef __ASM_ARCH_HIBERNATE_H
+#define __ASM_ARCH_HIBERNATE_H
+
+#include <linux/stringify.h>
+
+/*
+ * Image of the saved processor state
+ *
+ * coprocessor 15 registers(RW) - SMDK6450 (ARM1176)
+ */
+struct saved_context {
+	u32 cr;
+	u32 cacr;
+	u32 ttb0;
+	u32 ttb1;
+	u32 ttbcr;
+	u32 dacr;
+	u32 dfsr;
+	u32 ifsr;
+	u32 dfar;
+	u32 wfar;
+	u32 ifar;
+	u32 par;
+	u32 dclr;
+	u32 iclr;
+	u32 dtcmr;
+	u32 itcmr;
+	u32 tcmsel;
+	u32 cbor;
+	u32 tlblr;
+	u32 prrr;
+	u32 nrrr;
+	u32 snsvbar;
+	u32 mvbar;
+	u32 fcse;
+	u32 cid;
+	u32 urwtpid;
+	u32 urotpid;
+	u32 potpid;
+	u32 pmrr;
+	u32 pmcr;
+	u32 pmcc;
+	u32 pmc0;
+	u32 pmc1;
+};
+
+__inline__ static void __save_processor_state(struct saved_context *ctxt)
+{
+	asm volatile (SAVE_CPREG(p15, 0, c1, c0, 0, ctxt->cr));
+	asm volatile (SAVE_CPREG(p15, 0, c1, c0, 2, ctxt->cacr));
+	asm volatile (SAVE_CPREG(p15, 0, c2, c0, 0, ctxt->ttb0));
+	asm volatile (SAVE_CPREG(p15, 0, c2, c0, 1, ctxt->ttb1));
+	asm volatile (SAVE_CPREG(p15, 0, c2, c0, 2, ctxt->ttbcr));
+	asm volatile (SAVE_CPREG(p15, 0, c3, c0, 0, ctxt->dacr));
+	asm volatile (SAVE_CPREG(p15, 0, c5, c0, 0, ctxt->dfsr));
+	asm volatile (SAVE_CPREG(p15, 0, c5, c0, 1, ctxt->ifsr));
+	asm volatile (SAVE_CPREG(p15, 0, c6, c0, 0, ctxt->dfar));
+	asm volatile (SAVE_CPREG(p15, 0, c6, c0, 1, ctxt->wfar));
+	asm volatile (SAVE_CPREG(p15, 0, c6, c0, 2, ctxt->ifar));
+	asm volatile (SAVE_CPREG(p15, 0, c9, c0, 0, ctxt->dclr));
+	asm volatile (SAVE_CPREG(p15, 0, c9, c0, 1, ctxt->iclr));
+	asm volatile (SAVE_CPREG(p15, 0, c9, c1, 0, ctxt->dtcmr));
+	asm volatile (SAVE_CPREG(p15, 0, c9, c1, 1, ctxt->itcmr));
+	asm volatile (SAVE_CPREG(p15, 0, c9, c2, 0, ctxt->tcmsel));
+	asm volatile (SAVE_CPREG(p15, 0, c9, c8, 0, ctxt->cbor));
+	asm volatile (SAVE_CPREG(p15, 0, c10, c0, 0, ctxt->tlblr));
+	asm volatile (SAVE_CPREG(p15, 0, c10, c2, 0, ctxt->prrr));
+	asm volatile (SAVE_CPREG(p15, 0, c10, c2, 1, ctxt->nrrr));
+	asm volatile (SAVE_CPREG(p15, 0, c12, c0, 0, ctxt->snsvbar));
+	asm volatile (SAVE_CPREG(p15, 0, c12, c0, 1, ctxt->mvbar));
+	asm volatile (SAVE_CPREG(p15, 0, c13, c0, 0, ctxt->fcse));
+	asm volatile (SAVE_CPREG(p15, 0, c13, c0, 1, ctxt->cid));
+	asm volatile (SAVE_CPREG(p15, 0, c13, c0, 2, ctxt->urwtpid));
+	asm volatile (SAVE_CPREG(p15, 0, c13, c0, 3, ctxt->urotpid));
+	asm volatile (SAVE_CPREG(p15, 0, c13, c0, 4, ctxt->potpid));
+	asm volatile (SAVE_CPREG(p15, 0, c15, c2, 4, ctxt->pmrr));
+	asm volatile (SAVE_CPREG(p15, 0, c15, c12, 0, ctxt->pmcr));
+	asm volatile (SAVE_CPREG(p15, 0, c15, c12, 1, ctxt->pmcc));
+	asm volatile (SAVE_CPREG(p15, 0, c15, c12, 2, ctxt->pmc0));
+	asm volatile (SAVE_CPREG(p15, 0, c15, c12, 3, ctxt->pmc1));
+}
+
+__inline__ static void __restore_processor_state(struct saved_context *ctxt)
+{
+	asm volatile (LOAD_CPREG(p15, 0, c1, c0, 0, ctxt->cr));
+	asm volatile (LOAD_CPREG(p15, 0, c1, c0, 2, ctxt->cacr));
+	asm volatile (LOAD_CPREG(p15, 0, c2, c0, 0, ctxt->ttb0));
+	asm volatile (LOAD_CPREG(p15, 0, c2, c0, 1, ctxt->ttb1));
+	asm volatile (LOAD_CPREG(p15, 0, c2, c0, 2, ctxt->ttbcr));
+	asm volatile (LOAD_CPREG(p15, 0, c3, c0, 0, ctxt->dacr));
+	asm volatile (LOAD_CPREG(p15, 0, c5, c0, 0, ctxt->dfsr));
+	asm volatile (LOAD_CPREG(p15, 0, c5, c0, 1, ctxt->ifsr));
+	asm volatile (LOAD_CPREG(p15, 0, c6, c0, 0, ctxt->dfar));
+	asm volatile (LOAD_CPREG(p15, 0, c6, c0, 1, ctxt->wfar));
+	asm volatile (LOAD_CPREG(p15, 0, c6, c0, 2, ctxt->ifar));
+	asm volatile (LOAD_CPREG(p15, 0, c9, c0, 0, ctxt->dclr));
+	asm volatile (LOAD_CPREG(p15, 0, c9, c0, 1, ctxt->iclr));
+	asm volatile (LOAD_CPREG(p15, 0, c9, c1, 0, ctxt->dtcmr));
+	asm volatile (LOAD_CPREG(p15, 0, c9, c1, 1, ctxt->itcmr));
+	asm volatile (LOAD_CPREG(p15, 0, c9, c2, 0, ctxt->tcmsel));
+	asm volatile (LOAD_CPREG(p15, 0, c9, c8, 0, ctxt->cbor));
+	asm volatile (LOAD_CPREG(p15, 0, c10, c0, 0, ctxt->tlblr));
+	asm volatile (LOAD_CPREG(p15, 0, c10, c2, 0, ctxt->prrr));
+	asm volatile (LOAD_CPREG(p15, 0, c10, c2, 1, ctxt->nrrr));
+	asm volatile (LOAD_CPREG(p15, 0, c12, c0, 0, ctxt->snsvbar));
+	asm volatile (LOAD_CPREG(p15, 0, c12, c0, 1, ctxt->mvbar));
+	asm volatile (LOAD_CPREG(p15, 0, c13, c0, 0, ctxt->fcse));
+	asm volatile (LOAD_CPREG(p15, 0, c13, c0, 1, ctxt->cid));
+	asm volatile (LOAD_CPREG(p15, 0, c13, c0, 2, ctxt->urwtpid));
+	asm volatile (LOAD_CPREG(p15, 0, c13, c0, 3, ctxt->urotpid));
+	asm volatile (LOAD_CPREG(p15, 0, c13, c0, 4, ctxt->potpid));
+	asm volatile (LOAD_CPREG(p15, 0, c15, c2, 4, ctxt->pmrr));
+	asm volatile (LOAD_CPREG(p15, 0, c15, c12, 0, ctxt->pmcr));
+	asm volatile (LOAD_CPREG(p15, 0, c15, c12, 1, ctxt->pmcc));
+	asm volatile (LOAD_CPREG(p15, 0, c15, c12, 2, ctxt->pmc0));
+	asm volatile (LOAD_CPREG(p15, 0, c15, c12, 3, ctxt->pmc1));
+}
+#endif
diff --git a/arch/arm/plat-omap/include/mach/hibernate.h b/arch/arm/plat-omap/include/mach/hibernate.h
new file mode 100644
index 0000000..c634768
--- /dev/null
+++ b/arch/arm/plat-omap/include/mach/hibernate.h
@@ -0,0 +1,178 @@
+/*
+ * Hibernation support specific for ARM
+ *
+ * Copyright (C) 2010 Nokia Corporation
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Copyright (C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
+ *
+ * Contact: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#ifndef __ASM_ARCH_HIBERNATE_H
+#define __ASM_ARCH_HIBERNATE_H
+
+
+#include <linux/stringify.h>
+
+/*
+ * Image of the saved processor state
+ *
+ * coprocessor 15 registers(RW) - OMAP3 (Cortex A8)
+ */
+
+struct saved_context {
+	/* CR0 */
+	u32 cssr;	/* Cache Size Selection */
+	/* CR1 */
+	u32 cr;		/* Control */
+	u32 cacr;	/* Coprocessor Access Control */
+	/* CR2 */
+	u32 ttb_0r;	/* Translation Table Base 0 */
+	u32 ttb_1r;	/* Translation Table Base 1 */
+	u32 ttbcr;	/* Translation Talbe Base Control */
+	/* CR3 */
+	u32 dacr;	/* Domain Access Control */
+	/* CR5 */
+	u32 d_fsr;	/* Data Fault Status */
+	u32 i_fsr;	/* Instruction Fault Status */
+	u32 d_afsr;	/* Data Auxilirary Fault Status */       ;
+	u32 i_afsr;	/* Instruction Auxilirary Fault Status */;
+	/* CR6 */
+	u32 d_far;	/* Data Fault Address */
+	u32 i_far;	/* Instruction Fault Address */
+	/* CR7 */
+	u32 par;	/* Physical Address */
+	/* CR9 */	/* FIXME: Are they necessary? */
+	u32 pmcontrolr;	/* Performance Monitor Control */
+	u32 cesr;	/* Count Enable Set */
+	u32 cecr;	/* Count Enable Clear */
+	u32 ofsr;	/* Overflow Flag Status */
+	u32 sir;	/* Software Increment */
+	u32 pcsr;	/* Performance Counter Selection */
+	u32 ccr;	/* Cycle Count */
+	u32 esr;	/* Event Selection */
+	u32 pmcountr;	/* Performance Monitor Count */
+	u32 uer;	/* User Enable */
+	u32 iesr;	/* Interrupt Enable Set */
+	u32 iecr;	/* Interrupt Enable Clear */
+	u32 l2clr;	/* L2 Cache Lockdown */
+	/* CR10 */
+	u32 d_tlblr;	/* Data TLB Lockdown Register */
+	u32 i_tlblr;	/* Instruction TLB Lockdown Register */
+	u32 prrr;	/* Primary Region Remap Register */
+	u32 nrrr;	/* Normal Memory Remap Register */
+	/* CR11 */
+	u32 pleuar;	/* PLE User Accessibility */
+	u32 plecnr;	/* PLE Channel Number */
+	u32 plecr;	/* PLE Control */
+	u32 pleisar;	/* PLE Internal Start Address */
+	u32 pleiear;	/* PLE Internal End Address */
+	u32 plecidr;	/* PLE Context ID */
+	/* CR12 */
+	u32 snsvbar;	/* Secure or Nonsecure Vector Base Address */
+	/* CR13 */
+	u32 fcse;	/* FCSE PID */
+	u32 cid;	/* Context ID */
+	u32 urwtpid;	/* User read/write Thread and Process ID */
+	u32 urotpid;	/* User read-only Thread and Process ID */
+	u32 potpid;	/* Privileged only Thread and Process ID */
+};
+
+__inline__ static void __save_processor_state(struct saved_context *ctxt)
+{
+	asm volatile(SAVE_CPREG(p15, 2, c0, c0, 0, ctxt->cssr));
+	asm volatile(SAVE_CPREG(p15, 0, c1, c0, 0, ctxt->cr));
+	asm volatile(SAVE_CPREG(p15, 0, c1, c0, 2, ctxt->cacr));
+	asm volatile(SAVE_CPREG(p15, 0, c2, c0, 0, ctxt->ttb_0r));
+	asm volatile(SAVE_CPREG(p15, 0, c2, c0, 1, ctxt->ttb_1r));
+	asm volatile(SAVE_CPREG(p15, 0, c2, c0, 2, ctxt->ttbcr));
+	asm volatile(SAVE_CPREG(p15, 0, c3, c0, 0, ctxt->dacr));
+	asm volatile(SAVE_CPREG(p15, 0, c5, c0, 0, ctxt->d_fsr));
+	asm volatile(SAVE_CPREG(p15, 0, c5, c0, 1, ctxt->i_fsr));
+	asm volatile(SAVE_CPREG(p15, 0, c5, c1, 0, ctxt->d_afsr));
+	asm volatile(SAVE_CPREG(p15, 0, c5, c1, 1, ctxt->i_afsr));
+	asm volatile(SAVE_CPREG(p15, 0, c6, c0, 0, ctxt->d_far));
+	asm volatile(SAVE_CPREG(p15, 0, c6, c0, 2, ctxt->i_far));
+	asm volatile(SAVE_CPREG(p15, 0, c7, c4, 0, ctxt->par));
+	asm volatile(SAVE_CPREG(p15, 0, c9, c12, 0, ctxt->pmcontrolr));
+	asm volatile(SAVE_CPREG(p15, 0, c9, c12, 1, ctxt->cesr));
+	asm volatile(SAVE_CPREG(p15, 0, c9, c12, 2, ctxt->cecr));
+	asm volatile(SAVE_CPREG(p15, 0, c9, c12, 3, ctxt->ofsr));
+	asm volatile(SAVE_CPREG(p15, 0, c9, c12, 4, ctxt->sir));
+	asm volatile(SAVE_CPREG(p15, 0, c9, c12, 5, ctxt->pcsr));
+	asm volatile(SAVE_CPREG(p15, 0, c9, c13, 0, ctxt->ccr));
+	asm volatile(SAVE_CPREG(p15, 0, c9, c13, 1, ctxt->esr));
+	asm volatile(SAVE_CPREG(p15, 0, c9, c13, 2, ctxt->pmcountr));
+	asm volatile(SAVE_CPREG(p15, 0, c9, c14, 0, ctxt->uer));
+	asm volatile(SAVE_CPREG(p15, 0, c9, c14, 1, ctxt->iesr));
+	asm volatile(SAVE_CPREG(p15, 0, c9, c14, 2, ctxt->iecr));
+	asm volatile(SAVE_CPREG(p15, 1, c9, c0, 0, ctxt->l2clr));
+	asm volatile(SAVE_CPREG(p15, 0, c10, c0, 0, ctxt->d_tlblr));
+	asm volatile(SAVE_CPREG(p15, 0, c10, c0, 1, ctxt->i_tlblr));
+	asm volatile(SAVE_CPREG(p15, 0, c10, c2, 0, ctxt->prrr));
+	asm volatile(SAVE_CPREG(p15, 0, c10, c2, 1, ctxt->nrrr));
+	asm volatile(SAVE_CPREG(p15, 0, c11, c1, 0, ctxt->pleuar));
+	asm volatile(SAVE_CPREG(p15, 0, c11, c2, 0, ctxt->plecnr));
+	asm volatile(SAVE_CPREG(p15, 0, c11, c4, 0, ctxt->plecr));
+	asm volatile(SAVE_CPREG(p15, 0, c11, c5, 0, ctxt->pleisar));
+	asm volatile(SAVE_CPREG(p15, 0, c11, c7, 0, ctxt->pleiear));
+	asm volatile(SAVE_CPREG(p15, 0, c11, c15, 0, ctxt->plecidr));
+	asm volatile(SAVE_CPREG(p15, 0, c12, c0, 0, ctxt->snsvbar));
+	asm volatile(SAVE_CPREG(p15, 0, c13, c0, 0, ctxt->fcse));
+	asm volatile(SAVE_CPREG(p15, 0, c13, c0, 1, ctxt->cid));
+	asm volatile(SAVE_CPREG(p15, 0, c13, c0, 2, ctxt->urwtpid));
+	asm volatile(SAVE_CPREG(p15, 0, c13, c0, 3, ctxt->urotpid));
+	asm volatile(SAVE_CPREG(p15, 0, c13, c0, 4, ctxt->potpid));
+}
+
+__inline__ static void __restore_processor_state(struct saved_context *ctxt)
+{
+	asm volatile(LOAD_CPREG(p15, 2, c0, c0, 0, ctxt->cssr));
+	asm volatile(LOAD_CPREG(p15, 0, c1, c0, 0, ctxt->cr));
+	asm volatile(LOAD_CPREG(p15, 0, c1, c0, 2, ctxt->cacr));
+	asm volatile(LOAD_CPREG(p15, 0, c2, c0, 0, ctxt->ttb_0r));
+	asm volatile(LOAD_CPREG(p15, 0, c2, c0, 1, ctxt->ttb_1r));
+	asm volatile(LOAD_CPREG(p15, 0, c2, c0, 2, ctxt->ttbcr));
+	asm volatile(LOAD_CPREG(p15, 0, c3, c0, 0, ctxt->dacr));
+	asm volatile(LOAD_CPREG(p15, 0, c5, c0, 0, ctxt->d_fsr));
+	asm volatile(LOAD_CPREG(p15, 0, c5, c0, 1, ctxt->i_fsr));
+	asm volatile(LOAD_CPREG(p15, 0, c5, c1, 0, ctxt->d_afsr));
+	asm volatile(LOAD_CPREG(p15, 0, c5, c1, 1, ctxt->i_afsr));
+	asm volatile(LOAD_CPREG(p15, 0, c6, c0, 0, ctxt->d_far));
+	asm volatile(LOAD_CPREG(p15, 0, c6, c0, 2, ctxt->i_far));
+	asm volatile(LOAD_CPREG(p15, 0, c7, c4, 0, ctxt->par));
+	asm volatile(LOAD_CPREG(p15, 0, c9, c12, 0, ctxt->pmcontrolr));
+	asm volatile(LOAD_CPREG(p15, 0, c9, c12, 1, ctxt->cesr));
+	asm volatile(LOAD_CPREG(p15, 0, c9, c12, 2, ctxt->cecr));
+	asm volatile(LOAD_CPREG(p15, 0, c9, c12, 3, ctxt->ofsr));
+	asm volatile(LOAD_CPREG(p15, 0, c9, c12, 4, ctxt->sir));
+	asm volatile(LOAD_CPREG(p15, 0, c9, c12, 5, ctxt->pcsr));
+	asm volatile(LOAD_CPREG(p15, 0, c9, c13, 0, ctxt->ccr));
+	asm volatile(LOAD_CPREG(p15, 0, c9, c13, 1, ctxt->esr));
+	asm volatile(LOAD_CPREG(p15, 0, c9, c13, 2, ctxt->pmcountr));
+	asm volatile(LOAD_CPREG(p15, 0, c9, c14, 0, ctxt->uer));
+	asm volatile(LOAD_CPREG(p15, 0, c9, c14, 1, ctxt->iesr));
+	asm volatile(LOAD_CPREG(p15, 0, c9, c14, 2, ctxt->iecr));
+	asm volatile(LOAD_CPREG(p15, 1, c9, c0, 0, ctxt->l2clr));
+	asm volatile(LOAD_CPREG(p15, 0, c10, c0, 0, ctxt->d_tlblr));
+	asm volatile(LOAD_CPREG(p15, 0, c10, c0, 1, ctxt->i_tlblr));
+	asm volatile(LOAD_CPREG(p15, 0, c10, c2, 0, ctxt->prrr));
+	asm volatile(LOAD_CPREG(p15, 0, c10, c2, 1, ctxt->nrrr));
+	asm volatile(LOAD_CPREG(p15, 0, c11, c1, 0, ctxt->pleuar));
+	asm volatile(LOAD_CPREG(p15, 0, c11, c2, 0, ctxt->plecnr));
+	asm volatile(LOAD_CPREG(p15, 0, c11, c4, 0, ctxt->plecr));
+	asm volatile(LOAD_CPREG(p15, 0, c11, c5, 0, ctxt->pleisar));
+	asm volatile(LOAD_CPREG(p15, 0, c11, c7, 0, ctxt->pleiear));
+	asm volatile(LOAD_CPREG(p15, 0, c11, c15, 0, ctxt->plecidr));
+	asm volatile(LOAD_CPREG(p15, 0, c12, c0, 0, ctxt->snsvbar));
+	asm volatile(LOAD_CPREG(p15, 0, c13, c0, 0, ctxt->fcse));
+	asm volatile(LOAD_CPREG(p15, 0, c13, c0, 1, ctxt->cid));
+	asm volatile(LOAD_CPREG(p15, 0, c13, c0, 2, ctxt->urwtpid));
+	asm volatile(LOAD_CPREG(p15, 0, c13, c0, 3, ctxt->urotpid));
+	asm volatile(LOAD_CPREG(p15, 0, c13, c0, 4, ctxt->potpid));
+}
+
+#endif
+
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b6e818f..0d39ae0 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -171,7 +171,7 @@
 #define NOSAVE_DATA							\
 	. = ALIGN(PAGE_SIZE);						\
 	VMLINUX_SYMBOL(__nosave_begin) = .;				\
-	*(.data.nosave)							\
+	.data.nosave : { *(.data.nosave) }				\
 	. = ALIGN(PAGE_SIZE);						\
 	VMLINUX_SYMBOL(__nosave_end) = .;
 
