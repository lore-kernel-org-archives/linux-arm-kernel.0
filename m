From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 18 Mar 2015 14:20:26 +0000
Subject: [RFC PATCH 5/7] arm64: irqflags: Use ICC sysregs to implement IRQ
 masking
In-Reply-To: <1426688428-3150-1-git-send-email-daniel.thompson@linaro.org>
References: <1426688428-3150-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1426688428-3150-6-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently irqflags is implemented using the PSR's I bit. It is possible
to implement irqflags by using the co-processor interface to the GIC.
Using the co-processor interface makes it feasible to simulate NMIs
using GIC interrupt prioritization.

This patch changes the irqflags macros to modify, save and restore
ICC_PMR_EL1. This has a substantial knock on effect for the rest of
the kernel. There are three reasons for this:

1. The state of the ICC_PMR_EL1_G_BIT becomes part of the CPU context
   and must be saved and restored during traps. To simplify the
   additional context management the ICC_PMR_EL1_G_BIT is converted
   into a fake (reserved) bit within the PSR (PSR_G_BIT). Naturally
   this approach will need to be changed if future ARM architecture
   extensions make use of this bit.

2. The hardware automatically masks the I bit (at boot, during traps, etc).
   When the I bit is set by hardware we must add code to switch from I
   bit masking and PMR masking.

3. Some instructions, noteably wfi, require that the PMR not be used
   for interrupt masking. Before calling these instructions we must
   switch from PMR masking to I bit masking.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm64/Kconfig                   | 15 ++++++
 arch/arm64/include/asm/assembler.h   | 72 ++++++++++++++++++++++++++---
 arch/arm64/include/asm/irqflags.h    | 89 ++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/ptrace.h      | 10 ++++
 arch/arm64/include/uapi/asm/ptrace.h |  8 ++++
 arch/arm64/kernel/entry.S            | 70 ++++++++++++++++++++++++----
 arch/arm64/kernel/head.S             | 27 +++++++++++
 arch/arm64/mm/cache.S                |  4 +-
 arch/arm64/mm/proc.S                 | 19 ++++++++
 drivers/irqchip/irq-gic-v3.c         | 29 +++++++++++-
 include/linux/irqchip/arm-gic-v3.h   |  4 +-
 include/linux/irqchip/arm-gic.h      |  2 +-
 12 files changed, 329 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0725a6051872..91c0babb6132 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -611,6 +611,21 @@ config SETEND_EMULATION
 	  If unsure, say Y
 endif
 
+config USE_ICC_SYSREGS_FOR_IRQFLAGS
+	bool "Use ICC system registers for IRQ masking"
+	select CONFIG_ARM_GIC_V3
+	help
+	  Using the ICC system registers for IRQ masking makes it possible
+	  to simulate NMI on ARM64 systems. This allows several interesting
+	  features (especially debug features) to be used on these systems.
+
+	  Say Y here to implement IRQ masking using ICC system
+	  registers. This will result in an unbootable kernel if these
+	  registers are not implemented or made inaccessible by the
+	  EL3 firmare or EL2 hypervisor (if present).
+
+	  If unsure, say N
+
 endmenu
 
 menu "Boot options"
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 750bac4e637e..0a0a97f3c3c1 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -23,6 +23,7 @@
 #ifndef __ASM_ASSEMBLER_H
 #define __ASM_ASSEMBLER_H
 
+#include <linux/irqchip/arm-gic-v3.h>
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
 
@@ -39,26 +40,79 @@
 	.endm
 
 /*
+ * Enable and disable pseudo NMI.
+ */
+	.macro disable_nmi
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	msr	daifset, #2
+#endif
+	.endm
+
+	.macro enable_nmi
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	msr	daifclr, #2
+#endif
+	.endm
+
+/*
+ * Save/disable and restore pseudo NMI.
+ */
+	.macro	save_and_disable_nmis, olddaif
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	mrs	\olddaif, daif			/* Get flags		      */
+	disable_nmi
+#endif
+	.endm
+
+	.macro	restore_nmis, olddaif
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	msr	daif, \olddaif
+#endif
+	.endm
+
+/*
  * Enable and disable interrupts.
  */
-	.macro	disable_irq
+	.macro	disable_irq, tmp
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	mov	\tmp, #ICC_PMR_EL1_MASKED
+	msr_s	ICC_PMR_EL1, \tmp
+	isb
+#else
 	msr	daifset, #2
+#endif
 	.endm
 
-	.macro	enable_irq
+	.macro	enable_irq, tmp
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	enable_nmi
+	mov     \tmp, #ICC_PMR_EL1_UNMASKED
+	msr_s   ICC_PMR_EL1, \tmp
+	isb
+#else
 	msr	daifclr, #2
+#endif
 	.endm
 
 /*
  * Save/disable and restore interrupts.
  */
-	.macro	save_and_disable_irqs, olddaif
-	mrs	\olddaif, daif
-	disable_irq
+	.macro	save_and_disable_irqs, olddaif, tmp
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	mrs_s	\olddaif, ICC_PMR_EL1		/* Get PMR		      */
+#else
+	mrs	\olddaif, daif			/* Get flags		      */
+#endif
+	disable_irq \tmp
 	.endm
 
 	.macro	restore_irqs, olddaif
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	msr_s	ICC_PMR_EL1, \olddaif		  /* Write to PMR	      */
+	isb
+#else
 	msr	daif, \olddaif
+#endif
 	.endm
 
 /*
@@ -90,13 +144,19 @@
 9990:
 	.endm
 
+
 /*
  * Enable both debug exceptions and interrupts. This is likely to be
  * faster than two daifclr operations, since writes to this register
  * are self-synchronising.
  */
-	.macro	enable_dbg_and_irq
+	.macro	enable_dbg_and_irq, tmp
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	enable_dbg
+	enable_irq \tmp
+#else
 	msr	daifclr, #(8 | 2)
+#endif
 	.endm
 
 /*
diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index df7477af6389..7b6866022f82 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -20,6 +20,8 @@
 
 #include <asm/ptrace.h>
 
+#ifndef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+
 /*
  * CPU interrupt mask handling.
  */
@@ -84,6 +86,93 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
 	return flags & PSR_I_BIT;
 }
 
+#else /* CONFIG_IRQFLAGS_GIC_MASKING */
+
+#include <linux/irqchip/arm-gic-v3.h>
+
+/*
+ * CPU interrupt mask handling.
+ */
+static inline unsigned long arch_local_irq_save(void)
+{
+	unsigned long flags, masked = ICC_PMR_EL1_MASKED;
+
+	asm volatile(
+		"// arch_local_irq_save\n"
+		"mrs_s  %0, " __stringify(ICC_PMR_EL1) "\n"
+		"msr_s	" __stringify(ICC_PMR_EL1) ",%1\n"
+		"isb\n"
+		: "=&r" (flags)
+		: "r" (masked)
+		: "memory");
+
+	return flags;
+}
+
+static inline void arch_local_irq_enable(void)
+{
+	unsigned long unmasked = ICC_PMR_EL1_UNMASKED;
+
+	asm volatile(
+		"// arch_local_irq_enable\n"
+		"msr_s  " __stringify(ICC_PMR_EL1) ",%0\n"
+		"isb\n"
+		:
+		: "r" (unmasked)
+		: "memory");
+}
+
+static inline void arch_local_irq_disable(void)
+{
+	unsigned long masked = ICC_PMR_EL1_MASKED;
+
+	asm volatile(
+		"// arch_local_irq_disable\n"
+		"msr_s  " __stringify(ICC_PMR_EL1) ",%0\n"
+		"isb\n"
+		:
+		: "r" (masked)
+		: "memory");
+}
+
+/*
+ * Save the current interrupt enable state.
+ */
+static inline unsigned long arch_local_save_flags(void)
+{
+	unsigned long flags;
+
+	asm volatile(
+		"// arch_local_save_flags\n"
+		"mrs_s  %0, " __stringify(ICC_PMR_EL1) "\n"
+		: "=r" (flags)
+		:
+		: "memory");
+
+	return flags;
+}
+
+/*
+ * restore saved IRQ state
+ */
+static inline void arch_local_irq_restore(unsigned long flags)
+{
+	asm volatile(
+		"// arch_local_irq_restore\n"
+		"msr_s  " __stringify(ICC_PMR_EL1) ",%0\n"
+		"isb\n"
+	:
+	: "r" (flags)
+	: "memory");
+}
+
+static inline int arch_irqs_disabled_flags(unsigned long flags)
+{
+	return !(flags & ICC_PMR_EL1_G_BIT);
+}
+
+#endif /* CONFIG_IRQFLAGS_GIC_MASKING */
+
 #define local_fiq_enable()	asm("msr	daifclr, #1" : : : "memory")
 #define local_fiq_disable()	asm("msr	daifset, #1" : : : "memory")
 
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index a379596e0888..da4c593b596d 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -25,6 +25,16 @@
 #define CurrentEL_EL1		(1 << 2)
 #define CurrentEL_EL2		(2 << 2)
 
+/* PMR values used to mask/unmask interrupts */
+#define ICC_PMR_EL1_G_SHIFT     6
+#define ICC_PMR_EL1_G_BIT       (1 << ICC_PMR_EL1_G_SHIFT)
+#define ICC_PMR_EL1_UNMASKED    0xf0
+#define ICC_PMR_EL1_MASKED      (ICC_PMR_EL1_UNMASKED ^ ICC_PMR_EL1_G_BIT)
+
+#define PSR_G_SHIFT             22
+#define PSR_G_PMR_G_SHIFT	(PSR_G_SHIFT - ICC_PMR_EL1_G_SHIFT)
+#define PSR_I_PMR_G_SHIFT	(7 - ICC_PMR_EL1_G_SHIFT)
+
 /* AArch32-specific ptrace requests */
 #define COMPAT_PTRACE_GETREGS		12
 #define COMPAT_PTRACE_SETREGS		13
diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index 6913643bbe54..6c640d6430d8 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -51,6 +51,14 @@
 #define PSR_N_BIT	0x80000000
 
 /*
+ * This is the GIC interrupt mask bit. It is not actually part of the
+ * PSR, we are simply using some reserved bits in the PSR to store some state
+ * from the interrupt controller. The context save/restore functions will
+ * extract the ICC_PMR_EL1_G_BIT and save it as the PSR_G_BIT.
+ */
+#define PSR_G_BIT       0x00400000
+
+/*
  * Groups of PSR bits
  */
 #define PSR_f		0xff000000	/* Flags		*/
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 0aa5747639f8..964573308e68 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -20,6 +20,7 @@
 
 #include <linux/init.h>
 #include <linux/linkage.h>
+#include <linux/irqchip/arm-gic-v3.h>
 
 #include <asm/assembler.h>
 #include <asm/asm-offsets.h>
@@ -94,6 +95,26 @@
 	.endif
 	mrs	x22, elr_el1
 	mrs	x23, spsr_el1
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	/*
+	 * Save the context held in the PMR register and copy the current
+	 * I bit state to the PMR. Re-enable of the I bit happens in later
+	 * code that knows what type of trap we are handling.
+	 */
+	mrs_s	x20, ICC_PMR_EL1		// Get PMR
+	and	x20, x20, #ICC_PMR_EL1_G_BIT	// Extract mask bit
+	lsl	x20, x20, #PSR_G_PMR_G_SHIFT	// Shift to a PSTATE RES0 bit
+	eor	x20, x20, #PSR_G_BIT		// Invert bit
+	orr	x23, x20, x23			// Store PMR within PSTATE
+	orr	x20, x23, #PSR_I_BIT		// Extract I bit
+	.if	PSR_I_PMR_G_SHIFT != 0
+	lsr	x20, x20, #PSR_I_PMR_G_SHIFT	// Shift down to meet mask bit
+	.endif
+	eor	x20, x20, #ICC_PMR_EL1_UNMASKED	// If I set: 0xb0 else: 0xf0
+	msr_s	ICC_PMR_EL1, x20		// Write to PMR
+	isb
+#endif
+
 	stp	lr, x21, [sp, #S_LR]
 	stp	x22, x23, [sp, #S_PC]
 
@@ -121,6 +142,18 @@
 	ldr	x23, [sp, #S_SP]		// load return stack pointer
 	msr	sp_el0, x23
 	.endif
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	/*
+	 * Restore the context to the PMR (and ensure the reserved bit is
+	 * restored to zero before being copied back to the PSR).
+	 */
+	and	x20, x22, #PSR_G_BIT		// Get stolen PSTATE bit
+	and	x22, x22, #~PSR_G_BIT		// Clear stolen bit
+	lsr	x20, x20, #PSR_G_PMR_G_SHIFT	// Shift back to PMR mask
+	eor	x20, x20, #ICC_PMR_EL1_UNMASKED	// x20 gets 0xf0 or 0xb0
+	msr_s	ICC_PMR_EL1, x20		// Write to PMR
+	isb
+#endif
 	msr	elr_el1, x21			// set up the return data
 	msr	spsr_el1, x22
 	.if	\ret
@@ -288,16 +321,22 @@ el1_da:
 	 * Data abort handling
 	 */
 	mrs	x0, far_el1
+	enable_nmi
 	enable_dbg
 	// re-enable interrupts if they were enabled in the aborted context
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	tbnz	x23, #PSR_G_SHIFT, 1f		// PSR_G_BIT
+#else
 	tbnz	x23, #7, 1f			// PSR_I_BIT
-	enable_irq
+#endif
+	enable_irq x2
 1:
 	mov	x2, sp				// struct pt_regs
 	bl	do_mem_abort
 
 	// disable interrupts before pulling preserved data off the stack
-	disable_irq
+	disable_irq x21
+	disable_nmi
 	kernel_exit 1
 el1_sp_pc:
 	/*
@@ -337,6 +376,7 @@ ENDPROC(el1_sync)
 	.align	6
 el1_irq:
 	kernel_entry 1
+	enable_nmi
 	enable_dbg
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bl	trace_hardirqs_off
@@ -356,6 +396,7 @@ el1_irq:
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bl	trace_hardirqs_on
 #endif
+	disable_nmi
 	kernel_exit 1
 ENDPROC(el1_irq)
 
@@ -450,7 +491,8 @@ el0_da:
 	 */
 	mrs	x26, far_el1
 	// enable interrupts before calling the main handler
-	enable_dbg_and_irq
+	enable_nmi
+	enable_dbg_and_irq x0
 	ct_user_exit
 	bic	x0, x26, #(0xff << 56)
 	mov	x1, x25
@@ -463,7 +505,8 @@ el0_ia:
 	 */
 	mrs	x26, far_el1
 	// enable interrupts before calling the main handler
-	enable_dbg_and_irq
+	enable_nmi
+	enable_dbg_and_irq x0
 	ct_user_exit
 	mov	x0, x26
 	orr	x1, x25, #1 << 24		// use reserved ISS bit for instruction aborts
@@ -496,7 +539,8 @@ el0_sp_pc:
 	 */
 	mrs	x26, far_el1
 	// enable interrupts before calling the main handler
-	enable_dbg_and_irq
+	enable_nmi
+	enable_dbg_and_irq x0
 	mov	x0, x26
 	mov	x1, x25
 	mov	x2, sp
@@ -507,7 +551,8 @@ el0_undef:
 	 * Undefined instruction
 	 */
 	// enable interrupts before calling the main handler
-	enable_dbg_and_irq
+	enable_nmi
+	enable_dbg_and_irq x0
 	ct_user_exit
 	mov	x0, sp
 	bl	do_undefinstr
@@ -538,6 +583,7 @@ ENDPROC(el0_sync)
 el0_irq:
 	kernel_entry 0
 el0_irq_naked:
+	enable_nmi
 	enable_dbg
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bl	trace_hardirqs_off
@@ -587,11 +633,12 @@ ENDPROC(cpu_switch_to)
  * and this includes saving x0 back into the kernel stack.
  */
 ret_fast_syscall:
-	disable_irq				// disable interrupts
+	disable_irq x21				// disable interrupts
 	ldr	x1, [tsk, #TI_FLAGS]
 	and	x2, x1, #_TIF_WORK_MASK
 	cbnz	x2, fast_work_pending
 	enable_step_tsk x1, x2
+	disable_nmi
 	kernel_exit 0, ret = 1
 
 /*
@@ -606,7 +653,8 @@ work_pending:
 	mov	x0, sp				// 'regs'
 	tst	x2, #PSR_MODE_MASK		// user mode regs?
 	b.ne	no_work_pending			// returning to kernel
-	enable_irq				// enable interrupts for do_notify_resume()
+	enable_nmi
+	enable_irq x21				// enable interrupts for do_notify_resume()
 	bl	do_notify_resume
 	b	ret_to_user
 work_resched:
@@ -616,12 +664,13 @@ work_resched:
  * "slow" syscall return path.
  */
 ret_to_user:
-	disable_irq				// disable interrupts
+	disable_irq x21				// disable interrupts
 	ldr	x1, [tsk, #TI_FLAGS]
 	and	x2, x1, #_TIF_WORK_MASK
 	cbnz	x2, work_pending
 	enable_step_tsk x1, x2
 no_work_pending:
+	disable_nmi
 	kernel_exit 0, ret = 0
 ENDPROC(ret_to_user)
 
@@ -652,7 +701,8 @@ el0_svc:
 	adrp	stbl, sys_call_table		// load syscall table pointer
 el0_svc_naked:					// compat entry point
 	stp	x0, scno, [sp, #S_ORIG_X0]	// save the original x0 and syscall number
-	enable_dbg_and_irq
+	enable_nmi
+	enable_dbg_and_irq x16
 	ct_user_exit 1
 
 	ldr	x16, [tsk, #TI_FLAGS]		// check for syscall hooks
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 9a4ef52abf7c..6226d24f8107 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -445,6 +445,30 @@ __switch_data:
 	.quad	init_thread_union + THREAD_START_SP // sp
 
 /*
+ * Conditional macro to enable interrupt controller system register access.
+ *
+ * Before we jump into generic code we must enable interrupt controller system
+ * register access because this is required by the irqflags macros.  We must
+ * also mask interrupts at the PMR and unmask them within the PSR. That leaves
+ * us set up and ready for the kernel to make its first call to
+ * arch_local_irq_enable().
+ *
+ * Corrupts:	tmp
+ */
+	.macro	enable_icc_sysregs, tmp
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	mrs_s	\tmp, ICC_SRE_EL1
+	orr	\tmp, \tmp, #ICC_SRE_EL1_SRE
+	msr_s	ICC_SRE_EL1, \tmp		// Set ICC_SRE_EL1.SRE==1
+	isb					// Make sure SRE is now set
+	mov	\tmp, ICC_PMR_EL1_MASKED
+	msr_s	ICC_PMR_EL1, \tmp		// Prepare for unmask of I bit
+	isb
+	msr	daifclr, #2			// Clear the I bit
+#endif
+	.endm
+
+/*
  * The following fragment of code is executed with the MMU on in MMU mode, and
  * uses absolute addresses; this is not position independent.
  */
@@ -464,6 +488,8 @@ __mmap_switched:
 	str	x22, [x4]			// Save processor ID
 	str	x21, [x5]			// Save FDT pointer
 	str	x24, [x6]			// Save PHYS_OFFSET
+
+	enable_icc_sysregs x29			// May be nop
 	mov	x29, #0
 	b	start_kernel
 ENDPROC(__mmap_switched)
@@ -652,6 +678,7 @@ ENDPROC(secondary_startup)
 ENTRY(__secondary_switched)
 	ldr	x0, [x21]			// get secondary_data.stack
 	mov	sp, x0
+	enable_icc_sysregs x29			// may be nop
 	mov	x29, #0
 	b	secondary_start_kernel
 ENDPROC(__secondary_switched)
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 2560e1e1562e..f34aab45f948 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -46,10 +46,12 @@ loop1:
 	and	x1, x1, #7			// mask of the bits for current cache only
 	cmp	x1, #2				// see what cache we have@this level
 	b.lt	skip				// skip if no cache, or just i-cache
-	save_and_disable_irqs x9		// make CSSELR and CCSIDR access atomic
+	save_and_disable_irqs x9, x4		// make CSSELR and CCSIDR access atomic
+	save_and_disable_nmis x4
 	msr	csselr_el1, x10			// select current cache level in csselr
 	isb					// isb to sych the new cssr&csidr
 	mrs	x1, ccsidr_el1			// read the new ccsidr
+	restore_nmis x4
 	restore_irqs x9
 	and	x2, x1, #7			// extract the length of the cache lines
 	add	x2, x2, #4			// add 4 (line length offset)
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 28eebfb6af76..f91e66ecef80 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -20,6 +20,7 @@
 
 #include <linux/init.h>
 #include <linux/linkage.h>
+#include <linux/irqchip/arm-gic-v3.h>
 #include <asm/assembler.h>
 #include <asm/asm-offsets.h>
 #include <asm/hwcap.h>
@@ -95,10 +96,28 @@ ENDPROC(cpu_soft_restart)
  *	cpu_do_idle()
  *
  *	Idle the processor (wait for interrupt).
+ *
+ *	If CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS is set we must do additional
+ *	work to ensure that interrupts are not masked at the PMR (because the
+ *	core will not wake up if we block the wake up signal in the interrupt
+ *	controller).
  */
 ENTRY(cpu_do_idle)
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	mrs	x0, daif			// save I bit
+	msr	daifset, #2			// set I bit
+	mrs_s	x1, ICC_PMR_EL1			// save PMR
+	mov	x2, #ICC_PMR_EL1_UNMASKED
+	msr_s	ICC_PMR_EL1, x2			// unmask at PMR
+	isb
+#endif
 	dsb	sy				// WFI may enter a low-power mode
 	wfi
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	msr_s	ICC_PMR_EL1, x1			// restore PMR
+	isb
+	msr	daif, x0			// restore I bit
+#endif
 	ret
 ENDPROC(cpu_do_idle)
 
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 32533650494c..3923b2a2150c 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -110,8 +110,33 @@ static void gic_redist_wait_for_rwp(void)
 static u64 __maybe_unused gic_read_iar(void)
 {
 	u64 irqstat;
+	u64 __maybe_unused daif;
+	u64 __maybe_unused pmr;
+	u64 __maybe_unused default_pmr_value = DEFAULT_PMR_VALUE;
 
+#ifndef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
 	asm volatile("mrs_s %0, " __stringify(ICC_IAR1_EL1) : "=r" (irqstat));
+#else
+	/*
+	 * The PMR may be configured to mask interrupts when this code is
+	 * called, thus in order to acknowledge interrupts we must set the
+	 * PMR to its default value before reading from the IAR.
+	 *
+	 * To do this without taking an interrupt we also ensure the I bit
+	 * is set whilst we are interfering with the value of the PMR.
+	 */
+	asm volatile(
+		"mrs	%1, daif\n"			     /* save I bit  */
+		"msr	daifset, #2\n"			     /* set I bit   */
+		"mrs_s  %2, " __stringify(ICC_PMR_EL1) "\n"  /* save PMR    */
+		"msr_s	" __stringify(ICC_PMR_EL1) ",%3\n"   /* set PMR     */
+		"mrs_s	%0, " __stringify(ICC_IAR1_EL1) "\n" /* ack int     */
+		"msr_s  " __stringify(ICC_PMR_EL1) ",%2\n"   /* restore PMR */
+		"isb\n"
+		"msr	daif, %1"			     /* restore I   */
+		: "=r" (irqstat), "=&r" (daif), "=&r" (pmr)
+		: "r" (default_pmr_value));
+#endif
 	return irqstat;
 }
 
@@ -142,7 +167,7 @@ static void __maybe_unused gic_write_sgi1r(u64 val)
 	asm volatile("msr_s " __stringify(ICC_SGI1R_EL1) ", %0" : : "r" (val));
 }
 
-static void gic_enable_sre(void)
+static void __maybe_unused gic_enable_sre(void)
 {
 	u64 val;
 
@@ -382,11 +407,13 @@ static int gic_populate_rdist(void)
 
 static void gic_cpu_sys_reg_init(void)
 {
+#ifndef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
 	/* Enable system registers */
 	gic_enable_sre();
 
 	/* Set priority mask register */
 	gic_write_pmr(DEFAULT_PMR_VALUE);
+#endif
 
 	/*
 	 * On FVP, CPU 0 arrives in the kernel with its BPR changed from the
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 79d6645897e6..67b90813b619 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -242,7 +242,7 @@
  */
 #define ICC_CTLR_EL1_EOImode_drop_dir	(0U << 1)
 #define ICC_CTLR_EL1_EOImode_drop	(1U << 1)
-#define ICC_SRE_EL1_SRE			(1U << 0)
+#define ICC_SRE_EL1_SRE			(1 << 0)
 
 /*
  * Hypervisor interface registers (SRE only)
@@ -346,6 +346,8 @@
 
 #include <linux/stringify.h>
 
+struct device_node;
+
 /*
  * We need a value to serve as a irq-type for LPIs. Choose one that will
  * hopefully pique the interest of the reviewer.
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 71d706d5f169..65340ce7b5af 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -49,7 +49,7 @@
 #define GICD_INT_EN_CLR_X32		0xffffffff
 #define GICD_INT_EN_SET_SGI		0x0000ffff
 #define GICD_INT_EN_CLR_PPI		0xffff0000
-#define GICD_INT_DEF_PRI		0xa0
+#define GICD_INT_DEF_PRI		0xc0
 #define GICD_INT_DEF_PRI_X4		((GICD_INT_DEF_PRI << 24) |\
 					(GICD_INT_DEF_PRI << 16) |\
 					(GICD_INT_DEF_PRI << 8) |\
-- 
2.1.0
