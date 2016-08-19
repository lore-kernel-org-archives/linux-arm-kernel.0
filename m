From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 19 Aug 2016 17:13:14 +0100
Subject: [RFC PATCH v3 6/7] arm64: irqflags: Use ICC sysregs to implement IRQ
 masking
In-Reply-To: <1471623195-7829-1-git-send-email-daniel.thompson@linaro.org>
References: <1471623195-7829-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1471623195-7829-7-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently irqflags is implemented using the PSR's I bit. It is possible
to implement irqflags by using the co-processor interface to the GIC.
Using the co-processor interface makes it feasible to simulate NMIs
using GIC interrupt prioritization.

This patch changes the irqflags macros to modify, save and restore
ICC_PMR_EL1. This has a substantial knock on effect for the rest of
the kernel. There are four reasons for this:

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

4. We use the alternatives system to all a single kernel to boot and
   switch between the different masking approaches.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm64/Kconfig                  |  15 +++++
 arch/arm64/include/asm/arch_gicv3.h |  51 +++++++++++++++++
 arch/arm64/include/asm/assembler.h  |  32 ++++++++++-
 arch/arm64/include/asm/irqflags.h   | 106 ++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/ptrace.h     |  23 ++++++++
 arch/arm64/kernel/entry.S           |  77 ++++++++++++++++++++++----
 arch/arm64/kernel/head.S            |  35 ++++++++++++
 arch/arm64/kernel/smp.c             |   6 ++
 arch/arm64/mm/proc.S                |  23 ++++++++
 drivers/irqchip/irq-gic-v3.c        |   2 +
 include/linux/irqchip/arm-gic.h     |   2 +-
 11 files changed, 356 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index bc3f00f586f1..56846724d2af 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -718,6 +718,21 @@ config FORCE_MAX_ZONEORDER
 	  However for 4K, we choose a higher default value, 11 as opposed to 10, giving us
 	  4M allocations matching the default size used by generic code.
 
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
 menuconfig ARMV8_DEPRECATED
 	bool "Emulate deprecated/obsolete ARMv8 instructions"
 	depends on COMPAT
diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index fc2a0cb47b2c..a4ad69e2831b 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -80,6 +80,9 @@
 #include <linux/stringify.h>
 #include <asm/barrier.h>
 
+/* Our default, arbitrary priority value. Linux only uses one anyway. */
+#define DEFAULT_PMR_VALUE	0xf0
+
 /*
  * Low-level accessors
  *
@@ -102,9 +105,35 @@ static inline void gic_write_dir(u32 irq)
 static inline u64 gic_read_iar_common(void)
 {
 	u64 irqstat;
+	u64 __maybe_unused daif;
+	u64 __maybe_unused pmr;
+	u64 __maybe_unused default_pmr_value = DEFAULT_PMR_VALUE;
 
+#ifndef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
 	asm volatile("mrs_s %0, " __stringify(ICC_IAR1_EL1) : "=r" (irqstat));
 	dsb(sy);
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
+		"mrs	%1, daif\n\t"			     /* save I bit  */
+		"msr	daifset, #2\n\t"		     /* set I bit   */
+		"mrs_s  %2, " __stringify(ICC_PMR_EL1) "\n\t"/* save PMR    */
+		"msr_s	" __stringify(ICC_PMR_EL1) ",%3\n\t" /* set PMR     */
+		"mrs_s	%0, " __stringify(ICC_IAR1_EL1) "\n\t" /* ack int   */
+		"msr_s  " __stringify(ICC_PMR_EL1) ",%2\n\t" /* restore PMR */
+		"isb\n\t"
+		"msr	daif, %1"			     /* restore I   */
+		: "=r" (irqstat), "=&r" (daif), "=&r" (pmr)
+		: "r" (default_pmr_value));
+#endif
+
 	return irqstat;
 }
 
@@ -118,7 +147,11 @@ static inline u64 gic_read_iar_common(void)
 static inline u64 gic_read_iar_cavium_thunderx(void)
 {
 	u64 irqstat;
+	u64 __maybe_unused daif;
+	u64 __maybe_unused pmr;
+	u64 __maybe_unused default_pmr_value = DEFAULT_PMR_VALUE;
 
+#ifndef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
 	asm volatile(
 		"nop;nop;nop;nop\n\t"
 		"nop;nop;nop;nop\n\t"
@@ -126,6 +159,24 @@ static inline u64 gic_read_iar_cavium_thunderx(void)
 		"nop;nop;nop;nop"
 		: "=r" (irqstat));
 	mb();
+#else
+	/* Refer to comment in gic_read_iar_common() for more details */
+	asm volatile(
+		"mrs	%1, daif\n\t"			     /* save I bit  */
+		"msr	daifset, #2\n\t"		     /* set I bit   */
+		"mrs_s  %2, " __stringify(ICC_PMR_EL1) "\n\t"/* save PMR    */
+		"msr_s	" __stringify(ICC_PMR_EL1) ",%3\n\t" /* set PMR     */
+		"nop;nop;nop;nop\n\t"
+		"nop;nop;nop;nop\n\t"
+		"mrs_s	%0, " __stringify(ICC_IAR1_EL1) "\n\t" /* ack int   */
+		"nop;nop;nop;nop\n\t"
+		"msr_s  " __stringify(ICC_PMR_EL1) ",%2\n\t" /* restore PMR */
+		"isb\n\t"
+		"msr	daif, %1"			     /* restore I   */
+		: "=r" (irqstat), "=&r" (daif), "=&r" (pmr)
+		: "r" (default_pmr_value));
+
+#endif
 
 	return irqstat;
 }
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index d5025c69ca81..0adea5807ef0 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -23,6 +23,8 @@
 #ifndef __ASM_ASSEMBLER_H
 #define __ASM_ASSEMBLER_H
 
+#include <asm/alternative.h>
+#include <asm/arch_gicv3.h>
 #include <asm/asm-offsets.h>
 #include <asm/cpufeature.h>
 #include <asm/page.h>
@@ -33,12 +35,30 @@
 /*
  * Enable and disable interrupts.
  */
-	.macro	disable_irq
+	.macro	disable_irq, tmp
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	mov	\tmp, #ICC_PMR_EL1_MASKED
+alternative_if_not ARM64_HAS_SYSREG_GIC_CPUIF
 	msr	daifset, #2
+alternative_else
+	msr_s	ICC_PMR_EL1, \tmp
+alternative_endif
+#else
+	msr	daifset, #2
+#endif
 	.endm
 
-	.macro	enable_irq
+	.macro	enable_irq, tmp
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	mov     \tmp, #ICC_PMR_EL1_UNMASKED
+alternative_if_not ARM64_HAS_SYSREG_GIC_CPUIF
 	msr	daifclr, #2
+alternative_else
+	msr_s	ICC_PMR_EL1, \tmp
+alternative_endif
+#else
+	msr	daifclr, #2
+#endif
 	.endm
 
 /*
@@ -70,13 +90,19 @@
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
index f367cbd92ff0..b14ee24bc3a7 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -18,8 +18,13 @@
 
 #ifdef __KERNEL__
 
+#include <asm/alternative.h>
+#include <asm/arch_gicv3.h>
+#include <asm/cpufeature.h>
 #include <asm/ptrace.h>
 
+#ifndef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+
 /*
  * CPU interrupt mask handling.
  */
@@ -84,6 +89,107 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
 	return flags & PSR_I_BIT;
 }
 
+static inline void maybe_switch_to_sysreg_gic_cpuif(void) {}
+
+#else /* CONFIG_IRQFLAGS_GIC_MASKING */
+
+/*
+ * CPU interrupt mask handling.
+ */
+static inline unsigned long arch_local_irq_save(void)
+{
+	unsigned long flags, masked = ICC_PMR_EL1_MASKED;
+
+	asm volatile(ALTERNATIVE(
+		"mrs	%0, daif		// arch_local_irq_save\n"
+		"msr	daifset, #2",
+		/* --- */
+		"mrs_s  %0, " __stringify(ICC_PMR_EL1) "\n"
+		"msr_s	" __stringify(ICC_PMR_EL1) ",%1",
+		ARM64_HAS_SYSREG_GIC_CPUIF)
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
+	asm volatile(ALTERNATIVE(
+		"msr	daifclr, #2		// arch_local_irq_enable",
+		"msr_s  " __stringify(ICC_PMR_EL1) ",%0",
+		ARM64_HAS_SYSREG_GIC_CPUIF)
+		:
+		: "r" (unmasked)
+		: "memory");
+}
+
+static inline void arch_local_irq_disable(void)
+{
+	unsigned long masked = ICC_PMR_EL1_MASKED;
+
+	asm volatile(ALTERNATIVE(
+		"msr	daifset, #2		// arch_local_irq_disable",
+		"msr_s  " __stringify(ICC_PMR_EL1) ",%0",
+		ARM64_HAS_SYSREG_GIC_CPUIF)
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
+	asm volatile(ALTERNATIVE(
+		"mrs	%0, daif		// arch_local_save_flags",
+		"mrs_s  %0, " __stringify(ICC_PMR_EL1),
+		ARM64_HAS_SYSREG_GIC_CPUIF)
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
+	asm volatile(ALTERNATIVE(
+		"msr	daif, %0		// arch_local_irq_restore",
+		"msr_s  " __stringify(ICC_PMR_EL1) ",%0",
+		ARM64_HAS_SYSREG_GIC_CPUIF)
+	:
+	: "r" (flags)
+	: "memory");
+}
+
+static inline int arch_irqs_disabled_flags(unsigned long flags)
+{
+	asm volatile(ALTERNATIVE(
+		"and	%0, %0, #" __stringify(PSR_I_BIT) "\n"
+		"nop",
+		/* --- */
+		"and	%0, %0, # " __stringify(ICC_PMR_EL1_G_BIT) "\n"
+		"eor	%0, %0, # " __stringify(ICC_PMR_EL1_G_BIT),
+		ARM64_HAS_SYSREG_GIC_CPUIF)
+		: "+r" (flags));
+
+	return flags;
+}
+
+void maybe_switch_to_sysreg_gic_cpuif(void);
+
+#endif /* CONFIG_IRQFLAGS_GIC_MASKING */
+
 #define local_fiq_enable()	asm("msr	daifclr, #1" : : : "memory")
 #define local_fiq_disable()	asm("msr	daifset, #1" : : : "memory")
 
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index ada08b5b036d..24154d6228d7 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -25,6 +25,24 @@
 #define CurrentEL_EL1		(1 << 2)
 #define CurrentEL_EL2		(2 << 2)
 
+/* PMR values used to mask/unmask interrupts */
+#define ICC_PMR_EL1_G_SHIFT     6
+#define ICC_PMR_EL1_G_BIT       (1 << ICC_PMR_EL1_G_SHIFT)
+#define ICC_PMR_EL1_UNMASKED    0xf0
+#define ICC_PMR_EL1_MASKED      (ICC_PMR_EL1_UNMASKED ^ ICC_PMR_EL1_G_BIT)
+
+/*
+ * This is the GIC interrupt mask bit. It is not actually part of the
+ * PSR and so does not appear in the user API, we are simply using some
+ * reserved bits in the PSR to store some state from the interrupt
+ * controller. The context save/restore functions will extract the
+ * ICC_PMR_EL1_G_BIT and save it as the PSR_G_BIT.
+ */
+#define PSR_G_BIT		0x00400000
+#define PSR_G_SHIFT             22
+#define PSR_G_PMR_G_SHIFT	(PSR_G_SHIFT - ICC_PMR_EL1_G_SHIFT)
+#define PSR_I_PMR_G_SHIFT	(7 - ICC_PMR_EL1_G_SHIFT)
+
 /* AArch32-specific ptrace requests */
 #define COMPAT_PTRACE_GETREGS		12
 #define COMPAT_PTRACE_SETREGS		13
@@ -142,8 +160,13 @@ struct pt_regs {
 #define processor_mode(regs) \
 	((regs)->pstate & PSR_MODE_MASK)
 
+#ifndef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
 #define interrupts_enabled(regs) \
 	(!((regs)->pstate & PSR_I_BIT))
+#else
+#define interrupts_enabled(regs) \
+	((!((regs)->pstate & PSR_I_BIT)) && (!((regs)->pstate & PSR_G_BIT)))
+#endif
 
 #define fast_interrupts_enabled(regs) \
 	(!((regs)->pstate & PSR_F_BIT))
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 441420ca7d08..1712b344cbf3 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -20,6 +20,7 @@
 
 #include <linux/init.h>
 #include <linux/linkage.h>
+#include <linux/irqchip/arm-gic-v3.h>
 
 #include <asm/alternative.h>
 #include <asm/assembler.h>
@@ -108,6 +109,26 @@
 	.endif /* \el == 0 */
 	mrs	x22, elr_el1
 	mrs	x23, spsr_el1
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	/*
+	 * Save the context held in the PMR register and copy the current
+	 * I bit state to the PMR. Re-enable of the I bit happens in later
+	 * code that knows what type of trap we are handling.
+	 */
+alternative_if_not ARM64_HAS_SYSREG_GIC_CPUIF
+	b	1f
+alternative_else
+	mrs_s	x20, ICC_PMR_EL1		// Get PMR
+alternative_endif
+	and	x20, x20, #ICC_PMR_EL1_G_BIT	// Extract mask bit
+	lsl	x20, x20, #PSR_G_PMR_G_SHIFT	// Shift to a PSTATE RES0 bit
+	eor	x20, x20, #PSR_G_BIT		// Invert bit
+	orr	x23, x20, x23			// Store PMR within PSTATE
+	mov	x20, #ICC_PMR_EL1_MASKED
+	msr_s	ICC_PMR_EL1, x20		// Mask normal interrupts at PMR
+1:
+#endif
+
 	stp	lr, x21, [sp, #S_LR]
 	stp	x22, x23, [sp, #S_PC]
 
@@ -168,6 +189,22 @@ alternative_else
 alternative_endif
 #endif
 	.endif
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	/*
+	 * Restore the context to the PMR (and ensure the reserved bit is
+	 * restored to zero before being copied back to the PSR).
+	 */
+alternative_if_not ARM64_HAS_SYSREG_GIC_CPUIF
+	b	1f
+alternative_else
+	and	x20, x22, #PSR_G_BIT		// Get stolen PSTATE bit
+alternative_endif
+	and	x22, x22, #~PSR_G_BIT		// Clear stolen bit
+	lsr	x20, x20, #PSR_G_PMR_G_SHIFT	// Shift back to PMR mask
+	eor	x20, x20, #ICC_PMR_EL1_UNMASKED	// x20 gets 0xf0 or 0xb0
+	msr_s	ICC_PMR_EL1, x20		// Write to PMR
+1:
+#endif
 	msr	elr_el1, x21			// set up the return data
 	msr	spsr_el1, x22
 	ldp	x0, x1, [sp, #16 * 0]
@@ -378,14 +415,30 @@ el1_da:
 	mrs	x0, far_el1
 	enable_dbg
 	// re-enable interrupts if they were enabled in the aborted context
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+alternative_if_not ARM64_HAS_SYSREG_GIC_CPUIF
 	tbnz	x23, #7, 1f			// PSR_I_BIT
-	enable_irq
+	nop
+	nop
+	msr     daifclr, #2
+1:
+alternative_else
+	tbnz	x23, #PSR_G_SHIFT, 1f		// PSR_G_BIT
+	mov     x2, #ICC_PMR_EL1_UNMASKED
+	msr_s   ICC_PMR_EL1, x2
+	msr     daifclr, #2
 1:
+alternative_endif
+#else
+	tbnz	x23, #7, 1f			// PSR_I_BIT
+	enable_irq x2
+1:
+#endif
 	mov	x2, sp				// struct pt_regs
 	bl	do_mem_abort
 
 	// disable interrupts before pulling preserved data off the stack
-	disable_irq
+	disable_irq x21
 	kernel_exit 1
 el1_sp_pc:
 	/*
@@ -539,7 +592,7 @@ el0_da:
 	 */
 	mrs	x26, far_el1
 	// enable interrupts before calling the main handler
-	enable_dbg_and_irq
+	enable_dbg_and_irq x0
 	ct_user_exit
 	bic	x0, x26, #(0xff << 56)
 	mov	x1, x25
@@ -552,7 +605,7 @@ el0_ia:
 	 */
 	mrs	x26, far_el1
 	// enable interrupts before calling the main handler
-	enable_dbg_and_irq
+	enable_dbg_and_irq x0
 	ct_user_exit
 	mov	x0, x26
 	mov	x1, x25
@@ -585,7 +638,7 @@ el0_sp_pc:
 	 */
 	mrs	x26, far_el1
 	// enable interrupts before calling the main handler
-	enable_dbg_and_irq
+	enable_dbg_and_irq x0
 	ct_user_exit
 	mov	x0, x26
 	mov	x1, x25
@@ -597,7 +650,7 @@ el0_undef:
 	 * Undefined instruction
 	 */
 	// enable interrupts before calling the main handler
-	enable_dbg_and_irq
+	enable_dbg_and_irq x0
 	ct_user_exit
 	mov	x0, sp
 	bl	do_undefinstr
@@ -606,7 +659,7 @@ el0_sys:
 	/*
 	 * System instructions, for trapped cache maintenance instructions
 	 */
-	enable_dbg_and_irq
+	enable_dbg_and_irq x0
 	ct_user_exit
 	mov	x0, x25
 	mov	x1, sp
@@ -690,7 +743,7 @@ ENDPROC(cpu_switch_to)
  * and this includes saving x0 back into the kernel stack.
  */
 ret_fast_syscall:
-	disable_irq				// disable interrupts
+	disable_irq x21				// disable interrupts
 	str	x0, [sp, #S_X0]			// returned x0
 	ldr	x1, [tsk, #TI_FLAGS]		// re-check for syscall tracing
 	and	x2, x1, #_TIF_SYSCALL_WORK
@@ -700,7 +753,7 @@ ret_fast_syscall:
 	enable_step_tsk x1, x2
 	kernel_exit 0
 ret_fast_syscall_trace:
-	enable_irq				// enable interrupts
+	enable_irq x0				// enable interrupts
 	b	__sys_trace_return_skipped	// we already saved x0
 
 /*
@@ -710,7 +763,7 @@ work_pending:
 	tbnz	x1, #TIF_NEED_RESCHED, work_resched
 	/* TIF_SIGPENDING, TIF_NOTIFY_RESUME or TIF_FOREIGN_FPSTATE case */
 	mov	x0, sp				// 'regs'
-	enable_irq				// enable interrupts for do_notify_resume()
+	enable_irq x21				// enable interrupts for do_notify_resume()
 	bl	do_notify_resume
 	b	ret_to_user
 work_resched:
@@ -723,7 +776,7 @@ work_resched:
  * "slow" syscall return path.
  */
 ret_to_user:
-	disable_irq				// disable interrupts
+	disable_irq x21				// disable interrupts
 	ldr	x1, [tsk, #TI_FLAGS]
 	and	x2, x1, #_TIF_WORK_MASK
 	cbnz	x2, work_pending
@@ -753,7 +806,7 @@ el0_svc:
 	mov	sc_nr, #__NR_syscalls
 el0_svc_naked:					// compat entry point
 	stp	x0, scno, [sp, #S_ORIG_X0]	// save the original x0 and syscall number
-	enable_dbg_and_irq
+	enable_dbg_and_irq x16
 	ct_user_exit 1
 
 	ldr	x16, [tsk, #TI_FLAGS]		// check for syscall hooks
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index b77f58355da1..27f04f03a179 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -620,6 +620,38 @@ set_cpu_boot_mode_flag:
 	ret
 ENDPROC(set_cpu_boot_mode_flag)
 
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+/*
+ * void maybe_switch_to_sysreg_gic_cpuif(void)
+ *
+ * Enable interrupt controller system register access if this feature
+ * has been detected by the alternatives system.
+ *
+ * Before we jump into generic code we must enable interrupt controller system
+ * register access because this is required by the irqflags macros.  We must
+ * also mask interrupts@the PMR and unmask them within the PSR. That leaves
+ * us set up and ready for the kernel to make its first call to
+ * arch_local_irq_enable().
+
+ *
+ */
+ENTRY(maybe_switch_to_sysreg_gic_cpuif)
+alternative_if_not ARM64_HAS_SYSREG_GIC_CPUIF
+	b	1f
+alternative_else
+	mrs_s	x0, ICC_SRE_EL1
+alternative_endif
+	orr	x0, x0, #1
+	msr_s	ICC_SRE_EL1, x0			// Set ICC_SRE_EL1.SRE==1
+	isb					// Make sure SRE is now set
+	mov	x0, ICC_PMR_EL1_MASKED
+	msr_s	ICC_PMR_EL1, x0			// Prepare for unmask of I bit
+	msr	daifclr, #2			// Clear the I bit
+1:
+	ret
+ENDPROC(maybe_switch_to_sysreg_gic_cpuif)
+#endif
+
 /*
  * We need to find out the CPU boot mode long after boot, so we need to
  * store it in a writable variable.
@@ -684,6 +716,9 @@ __secondary_switched:
 	mov	sp, x0
 	and	x0, x0, #~(THREAD_SIZE - 1)
 	msr	sp_el0, x0			// save thread_info
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	bl	maybe_switch_to_sysreg_gic_cpuif
+#endif
 	mov	x29, #0
 	b	secondary_start_kernel
 ENDPROC(__secondary_switched)
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index c49e8874fba8..2c118b2db7b4 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -448,6 +448,12 @@ void __init smp_prepare_boot_cpu(void)
 	 * and/or scheduling is enabled.
 	 */
 	apply_alternatives_early();
+
+	/*
+	 * Conditionally switch to GIC PMR for interrupt masking (this
+	 * will be a nop if we are using normal interrupt masking)
+	 */
+	maybe_switch_to_sysreg_gic_cpuif();
 }
 
 static u64 __init of_get_cpu_mpidr(struct device_node *dn)
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 5bb61de23201..dba725eece86 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -20,6 +20,7 @@
 
 #include <linux/init.h>
 #include <linux/linkage.h>
+#include <linux/irqchip/arm-gic-v3.h>
 #include <asm/assembler.h>
 #include <asm/asm-offsets.h>
 #include <asm/hwcap.h>
@@ -47,11 +48,33 @@
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
+alternative_if_not ARM64_HAS_SYSREG_GIC_CPUIF
+#endif
+	dsb	sy				// WFI may enter a low-power mode
+	wfi
+	ret
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+alternative_else
+	mrs	x0, daif			// save I bit
+	msr	daifset, #2			// set I bit
+	mrs_s	x1, ICC_PMR_EL1			// save PMR
+alternative_endif
+	mov	x2, #ICC_PMR_EL1_UNMASKED
+	msr_s	ICC_PMR_EL1, x2			// unmask at PMR
 	dsb	sy				// WFI may enter a low-power mode
 	wfi
+	msr_s	ICC_PMR_EL1, x1			// restore PMR
+	msr	daif, x0			// restore I bit
 	ret
+#endif
 ENDPROC(cpu_do_idle)
 
 #ifdef CONFIG_CPU_PM
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index fedcdd09b9b2..14b2fb5e81ef 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -492,8 +492,10 @@ static void gic_cpu_sys_reg_init(void)
 	if (!gic_enable_sre())
 		pr_err("GIC: unable to set SRE (disabled at EL2), panic ahead\n");
 
+#ifndef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
 	/* Set priority mask register */
 	gic_write_pmr(DEFAULT_PMR_VALUE);
+#endif
 
 	/*
 	 * Some firmwares hand over to the kernel with the BPR changed from
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index eafc965b3eb8..ba9ed0a2ac09 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -54,7 +54,7 @@
 #define GICD_INT_EN_CLR_X32		0xffffffff
 #define GICD_INT_EN_SET_SGI		0x0000ffff
 #define GICD_INT_EN_CLR_PPI		0xffff0000
-#define GICD_INT_DEF_PRI		0xa0
+#define GICD_INT_DEF_PRI		0xc0
 #define GICD_INT_DEF_PRI_X4		((GICD_INT_DEF_PRI << 24) |\
 					(GICD_INT_DEF_PRI << 16) |\
 					(GICD_INT_DEF_PRI << 8) |\
-- 
2.7.4
