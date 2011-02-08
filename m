From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Tue, 8 Feb 2011 18:17:14 +0000 (GMT)
Subject: [PATCH] ARM hibernation support code, again
Message-ID: <alpine.DEB.2.00.1102081734270.7871@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


The topic has been up a few times - how to make the ARM architecture 
support hibernation, not just in a way that "works for me" but such a way 
that it's minimal, easy to maintain, easy to extend to new machine types.

The attached code is another stab at it; it does away with the #ifdef orgy 
by simply allowing each ARM board type that wants to support suspend to 
disk to provide its own __save_processor_state() / __restore_processor_state() 
functions via <mach/hibernate.h>.

As illustration, this patch supports both S5P6450 and OMAP3 architectures.

Russell King is currently working on a patch set on linux-arm-kernel 
that'd provide do_suspend() / do_resume() as ARM processor support 
functions; if and when that mainlines, it'll hopefully be possible to do 
away with the <mach/hibernate.h> things as well.

;-) Death to __save/__restore_processor_state() ...


Everything else about this patch is, as far as I can tell, far more 
machine-independent than what's been posted before. Restore is also 
faster, by using optimized page copy code.


Some Q/A on this patch:

Q: What's the baseline for the patch ?
A: attached source is against 2.6.37-rc4.

Q: You've posted another one on linux-arm-kernel last week ?
A: Older version, this one is cleaned up now, and against mainline.

Q: Why are you not just using "the" linux-omap hibernation patch ?
A: There's more to the ARM world than OMAP.

Q: How to use / enable it ?
A: "select ARCH_HIBERNATION_POSSIBLE" in your machine's Kconfig
    and add CONFIG_PM, CONFIG_SWAP and CONFIG_HIBERNATION to your
    defconfig file.
    Then create your <mach/hibernate.h> and simply compile away.

Q: Why are you not saving/restoring FIQ/IRQ/UND/ABT mode regs ?
A: That's not necessary, the kernel setup code deals with this for us.

Q: Why are you not saving/restoring VFP, Neon, ... FPU state ?
A: Also not necessary, freezing user processes takes care of that.

Q: What about SMP ?
A: No way for me to test; not sure how state saving works there.

Q: Who came up with this ?
A: It's based on previous work by people from TI, Nokia and Ubuntu,
    see comments in the code. Newton, "... shoulders of giants".
    I only improved the page copy loop, cleaned swsusp.S and
    took some of the comments on that were made about where/how
    to save state.

Q: What's this been tested on ?
A: smdk6450 proto boards, and a custom omap3430 board, with
    2.6.32-derived kernels, mostly. I don't have a testsuite for it.

Q: Has this been tested with TuxOnIce yet ?
A: No. Planning to do so next.

Q: Is this "final" ?
A: Well, see above. One would want to do away with the horrid
    CP15 orgies in favour of calling processor support code
    provided (and maintained) elsewhere. If and when that happens ...


Best regards,
Frank Hofmann
-------------- next part --------------
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5cff165..3751a5a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -191,6 +191,14 @@ config VECTORS_BASE
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
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index d0ee74b..a69e095 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -203,6 +203,7 @@ static inline void *phys_to_virt(unsigned long x)
  */
 #define __pa(x)			__virt_to_phys((unsigned long)(x))
 #define __va(x)			((void *)__phys_to_virt((unsigned long)(x)))
+#define __pa_symbol(x)		__pa(RELOC_HIDE((unsigned long)(x),0))
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
 
 /*
diff --git a/arch/arm/include/asm/suspend.h b/arch/arm/include/asm/suspend.h
new file mode 100644
index 0000000..f54b029
--- /dev/null
+++ b/arch/arm/include/asm/suspend.h
@@ -0,0 +1,18 @@
+#ifndef __ASM_ARM_SUSPEND_H
+#define __ASM_ARM_SUSPEND_H
+
+static inline int arch_prepare_suspend(void) { return 0; }
+
+/*
+ * On ARM, we'd ultimately prefer to have these "static" so that they
+ * completely disappear from the code. All necessary state save / restore
+ * is done from within swsusp_arch_suspend / swsusp_arch_resume.
+ * These functions have no other purpose than to get the preempt count right.
+ *
+ * swsusp generics force existance of the symbols though, so at least mandate
+ * inlining for good.
+ */
+__inline__ void notrace save_processor_state(void) { preempt_disable(); }
+__inline__ void notrace restore_processor_state(void) { preempt_enable(); }
+
+#endif	/* __ASM_ARM_SUSPEND_H */
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 185ee82..bc6026c 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -4,6 +4,7 @@
 
 CPPFLAGS_vmlinux.lds := -DTEXT_OFFSET=$(TEXT_OFFSET)
 AFLAGS_head.o        := -DTEXT_OFFSET=$(TEXT_OFFSET)
+AFLAGS_swsusp.o      := -DTEXT_OFFSET=$(TEXT_OFFSET)
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_ftrace.o = -pg
@@ -43,6 +44,7 @@ obj-$(CONFIG_ARM_THUMBEE)	+= thumbee.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_ARM_UNWIND)	+= unwind.o
 obj-$(CONFIG_HAVE_TCM)		+= tcm.o
+obj-$(CONFIG_HIBERNATION)	+= cpu.o swsusp.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_SWP_EMULATE)	+= swp_emulate.o
 CFLAGS_swp_emulate.o		:= -Wa,-march=armv7-a
diff --git a/arch/arm/kernel/cpu.c b/arch/arm/kernel/cpu.c
new file mode 100644
index 0000000..3f3e35c
--- /dev/null
+++ b/arch/arm/kernel/cpu.c
@@ -0,0 +1,90 @@
+/*
+ * Hibernation support specific for ARM
+ *
+ * Based on work by:
+ *
+ * Ubuntu project, hibernation support for mach-dove,
+ *	https://lkml.org/lkml/2010/6/18/4
+ *
+ * Copyright (C) 2010 Nokia Corporation
+ *	Contact: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
+ *	https://lists.linux-foundation.org/pipermail/linux-pm/2010-June/027422.html
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ *	via linux-omap mailing list, Teerth Reddy et al.
+ *	https://patchwork.kernel.org/patch/96442/
+ *
+ * Copyright (C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <asm/ptrace.h>
+#include <asm/tlbflush.h>
+#include <linux/stringify.h>
+
+
+/*
+ * Helper macros for machine-specific code to create ARM coprocessor
+ * state save/load operations.
+ *
+ * Used in <mach/hibernate.h> to save/restore processor specific state.
+ *
+ * Note: Some versions of gcc's inline assembler create incorrect code
+ * (ldr / str instructions to transfer src/tgt into the register given
+ * to mrc/mcr are missing); it's a good idea to disassemble cpu.o to
+ * validate that the mrc/mcr is always paired with a str/ldr instruction.
+ * If that's not the case, a "+r"() constraint might help, at the cost
+ * of an unnecessary load/store.
+ */
+
+#define SAVE_CPREG(p, op1, cr1, cr2, op2, tgt)			\
+	"mrc " __stringify(p, op1, %0, cr1, cr2, op2) : "=r"(tgt) : : "memory", "cc"
+
+#define	LOAD_CPREG(p, op1, cr1, cr2, op2, src)			\
+	"mcr " __stringify(p, op1, %0, cr1, cr2, op2) : : "r"(src) : "memory", "cc"
+
+
+/*
+ * declares "struct saved_context" for mach-specific registers. 
+ */
+#include <mach/hibernate.h>
+
+/* References to section boundaries */
+extern const void __nosave_begin, __nosave_end;
+
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
+/*
+ * The ARM suspend code calls these to save/restore machine-specific
+ * registers. These might be highly architecture- and even SoC-specific.
+ *
+ * All architectures supporting swsusp need to implement their own
+ * versions of __save/__restore_processor_state().
+ *
+ * FIXME: Once there is a generic interface to save/restore processor
+ * state, it should simply be hooked here.
+ */
+
+notrace void swsusp_cpu_save(struct saved_context *ctx)
+{
+	__save_processor_state(ctx);
+}
+
+notrace void swsusp_cpu_restore(struct saved_context *ctx)
+{
+	__restore_processor_state(ctx);
+	local_flush_tlb_all();	/* only on this CPU ? */
+}
diff --git a/arch/arm/kernel/swsusp.S b/arch/arm/kernel/swsusp.S
new file mode 100644
index 0000000..08d1e61
--- /dev/null
+++ b/arch/arm/kernel/swsusp.S
@@ -0,0 +1,147 @@
+/*
+ * Hibernation support specific for ARM
+ *
+ * Based on work by:
+ *
+ * Ubuntu project, hibernation support for mach-dove,
+ *	https://lkml.org/lkml/2010/6/18/4
+ *
+ * Copyright (C) 2010 Nokia Corporation
+ *	Contact: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
+ *	https://lists.linux-foundation.org/pipermail/linux-pm/2010-June/027422.html
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ *	via linux-omap mailing list, Teerth Reddy et al.
+ *	https://patchwork.kernel.org/patch/96442/
+ *
+ * Copyright (C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/cache.h>
+#include <asm/memory.h>
+#include <asm/page.h>
+#include <asm/ptrace.h>
+
+
+#define	KERNEL_RAM_PADDR	(PHYS_OFFSET + TEXT_OFFSET)
+#define	SWAPPER_PG_DIR		(KERNEL_RAM_PADDR - 0x4000)
+
+
+/*
+ * Force ARM mode because:
+ *	- we use PC-relative addressing with >8bit offsets
+ *	- we use msr with immediates
+ */
+.arm
+
+.align	PAGE_SHIFT
+.Lswsusp_page_start:
+
+/*
+ * Save the current CPU state before suspend / poweroff.
+ */
+ENTRY(swsusp_arch_suspend)
+	adr	r0, ctx
+	mrs	r1, cpsr
+	stm	r0!, {r1}		/* current CPSR */
+	msr	cpsr_c, #SYSTEM_MODE
+	stm	r0!, {r0-r14}		/* user regs */
+	msr	cpsr_c, #SVC_MODE
+	mrs	r2, spsr
+	stm	r0!, {r2, sp, lr}	/* SVC SPSR, SVC regs */
+	msr	cpsr, r1		/* restore original mode */
+
+	stmfd	sp!, {lr}
+	bl	swsusp_cpu_save
+	ldmfd	sp!, {lr}
+	b	swsusp_save
+ENDPROC(swsusp_arch_suspend)
+
+
+/*
+ * Restore the memory image from the pagelists, and load the CPU registers
+ * from saved state.
+ * This runs in a very restrictive context - namely, no stack can be used
+ * before the CPU register state saved by swsusp_arch_suspend() has been
+ * restored.
+ */
+ENTRY(swsusp_arch_resume)
+	ldr	r0, =SWAPPER_PG_DIR
+	mcr	p15, 0, r0, c2, c0, 0		/* load page table pointer */
+	mcr	p15, 0, r0, c8, c7, 0		/* invalidate I,D TLBs */
+	mcr	p15, 0, r0, c7, c5, 4		/* ISB */
+
+	/*
+	 * The following code is an assembly version of:
+	 *
+	 *	struct pbe *pbe;
+	 *	for (pbe = restore_pblist; pbe != NULL; pbe = pbe->next)
+	 *		copy_page(pbe->orig_address, pbe->address);
+	 *
+	 * Because this is the very place where data pages, including our stack,
+	 * are overwritten, function calls are obviously impossible. Hence asm.
+	 *
+	 * The core of the loop is taken almost verbatim from copy_page.S.
+	 */
+	ldr     r1, =(restore_pblist - 8)	/* "fake" pbe->next */
+	b	3f
+.align L1_CACHE_SHIFT
+0:
+PLD(	pld	[r0, #0]			)
+PLD(	pld	[r0, #L1_CACHE_BYTES]		)
+	mov	r3, #(PAGE_SIZE / (2 * L1_CACHE_BYTES) PLD( -1 ))
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
+3:
+	ldr     r1, [r1, #8]		/* load next in list (pbe->next) */
+	cmp     r1, #0
+	ldrne	r0, [r1]		/* src page start address (pbe->address) */
+	ldrne	r2, [r1, #4]		/* dst page start address (pbe->orig_address) */
+	bne     0b
+
+	/*
+	 * Done - now restore the CPU state and return.
+	 */
+	msr	cpsr_c, #SYSTEM_MODE
+	adr	r0, ctx
+	ldm	r0!, {r1, sp, lr}	/* first word is CPSR, following are r0/r1 (irrelevant) */
+	msr	cpsr_cxsf, r1
+	ldm	r0!, {r2-r14}
+	msr	cpsr_c, #SVC_MODE
+	ldm	r0!, {r2, sp, lr}
+	msr	spsr_cxsf, r2
+	msr	cpsr_c, r1		/* use CPSR from above */
+
+	mov	r1, #0
+	stmfd	sp!, {r1,lr}
+	bl	swsusp_cpu_restore	/* restore CP state, flush TLB */
+	ldmfd	sp!, {r0,pc}
+ENDPROC(swsusp_arch_resume)
+
+.ltorg
+
+/*
+ * Save the CPU context (register set for all modes and mach-specific cp regs)
+ * here. Setting aside what remains of this CPU page, should be aplenty.
+ */
+.align L1_CACHE_SHIFT
+ENTRY(ctx)
+.space	(PAGE_SIZE - (. - .Lswsusp_page_start))
+END(ctx)
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 86b66f3..85a6f37 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -166,7 +166,6 @@ SECTIONS
 		__init_end = .;
 #endif
 
-		NOSAVE_DATA
 		CACHELINE_ALIGNED_DATA(32)
 		READ_MOSTLY_DATA(32)
 
@@ -190,6 +189,8 @@ SECTIONS
 	}
 	_edata_loc = __data_loc + SIZEOF(.data);
 
+	NOSAVE_DATA
+
 #ifdef CONFIG_HAVE_TCM
         /*
 	 * We align everything to a page boundary so we can
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 1a2cf62..814aa05 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -35,6 +35,7 @@ config ARCH_OMAP3
 	select CPU_V7
 	select USB_ARCH_HAS_EHCI
 	select ARM_L1_CACHE_SHIFT_6 if !ARCH_OMAP4
+	select ARCH_HIBERNATION_POSSIBLE
 	select ARCH_HAS_OPP
 	select PM_OPP if PM
 
diff --git a/arch/arm/mach-omap2/include/mach/hibernate.h b/arch/arm/mach-omap2/include/mach/hibernate.h
new file mode 100644
index 0000000..794e1fe
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/hibernate.h
@@ -0,0 +1,169 @@
+/*
+ * Hibernation support specific for ARM
+ * Image of the saved processor state
+ *
+ * coprocessor 15 registers(RW) - OMAP3 (Cortex A8)
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
diff --git a/arch/arm/mach-s5p64x0/Kconfig b/arch/arm/mach-s5p64x0/Kconfig
index 164d278..6910af9 100644
--- a/arch/arm/mach-s5p64x0/Kconfig
+++ b/arch/arm/mach-s5p64x0/Kconfig
@@ -49,6 +49,7 @@ config MACH_SMDK6450
 	select SAMSUNG_DEV_ADC
 	select SAMSUNG_DEV_TS
 	select S5P64X0_SETUP_I2C1
+	select ARCH_HIBERNATION_POSSIBLE
 	help
 	  Machine support for the Samsung SMDK6450
 
diff --git a/arch/arm/mach-s5p64x0/include/mach/hibernate.h b/arch/arm/mach-s5p64x0/include/mach/hibernate.h
new file mode 100644
index 0000000..1057e33
--- /dev/null
+++ b/arch/arm/mach-s5p64x0/include/mach/hibernate.h
@@ -0,0 +1,122 @@
+/*
+ * Hibernation support specific for ARM
+ * Image of the saved processor state
+ *
+ * coprocessor 15 registers(RW) - SMDK6450 (ARM1176)
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#ifndef __ASM_ARCH_HIBERNATE_H
+#define __ASM_ARCH_HIBERNATE_H
+
+#include <linux/stringify.h>
+
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
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index fe77e33..4091ef3 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -184,7 +184,7 @@
 #define NOSAVE_DATA							\
 	. = ALIGN(PAGE_SIZE);						\
 	VMLINUX_SYMBOL(__nosave_begin) = .;				\
-	*(.data..nosave)						\
+	.data.nosave : { *(.data.nosave) }				\
 	. = ALIGN(PAGE_SIZE);						\
 	VMLINUX_SYMBOL(__nosave_end) = .;
 
