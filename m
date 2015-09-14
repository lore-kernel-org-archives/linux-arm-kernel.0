From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon, 14 Sep 2015 14:26:20 +0100
Subject: [RFC PATCH v2 6/7] arm64: Implement IPI_CPU_BACKTRACE using
 pseudo-NMIs
In-Reply-To: <1442237181-17064-1-git-send-email-daniel.thompson@linaro.org>
References: <1442237181-17064-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1442237181-17064-7-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recently arm64 gained the capability to (optionally) mask interrupts
using the GIC PMR rather than the CPU PSR. That allows us to introduce
an NMI-like means to handle backtrace requests.

This provides a useful debug aid by allowing the kernel to robustly show
a backtrace for every processor in the system when, for example, we hang
trying to acquire a spin lock.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm64/include/asm/assembler.h | 23 +++++++++++
 arch/arm64/include/asm/smp.h       |  2 +
 arch/arm64/kernel/entry.S          | 78 ++++++++++++++++++++++++++++++--------
 arch/arm64/kernel/smp.c            | 20 +++++++++-
 drivers/irqchip/irq-gic-v3.c       | 69 +++++++++++++++++++++++++++++++++
 5 files changed, 176 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index ab7c3ffd6104..da6b8d9913de 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -42,6 +42,29 @@
 	.endm
 
 /*
+ * Enable and disable pseudo NMI.
+ */
+	.macro disable_nmi
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+alternative_if_not ARM64_HAS_SYSREG_GIC_CPUIF
+	nop
+alternative_else
+	msr	daifset, #2
+alternative_endif
+#endif
+	.endm
+
+	.macro enable_nmi
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+alternative_if_not ARM64_HAS_SYSREG_GIC_CPUIF
+	nop
+alternative_else
+	msr	daifclr, #2
+alternative_endif
+#endif
+	.endm
+
+/*
  * Enable and disable interrupts.
  */
 	.macro	disable_irq, tmp
diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index d9c3d6a6100a..fc310b6486b1 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -20,6 +20,8 @@
 #include <linux/cpumask.h>
 #include <linux/thread_info.h>
 
+#define SMP_IPI_NMI_MASK (1 << 5)
+
 #define raw_smp_processor_id() (current_thread_info()->cpu)
 
 struct seq_file;
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index ccbe867c7734..2f4d69f62138 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -205,6 +205,40 @@ alternative_endif
 	and	\rd, \rd, #~(THREAD_SIZE - 1)	// top of stack
 	.endm
 
+	.macro	trace_hardirqs_off, pstate
+#ifdef CONFIG_TRACE_IRQFLAGS
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+alternative_if_not ARM64_HAS_SYSREG_GIC_CPUIF
+	bl	trace_hardirqs_off
+	nop
+alternative_else
+	tbnz	\pstate, #PSR_G_SHIFT, 1f		// PSR_G_BIT
+	bl	trace_hardirqs_off
+1:
+alternative_endif
+#else
+	bl	trace_hardirqs_off
+#endif
+#endif
+	.endm
+
+	.macro	trace_hardirqs_on, pstate
+#ifdef CONFIG_TRACE_IRQFLAGS
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+alternative_if_not ARM64_HAS_SYSREG_GIC_CPUIF
+	bl	trace_hardirqs_on
+	nop
+alternative_else
+	tbnz	\pstate, #PSR_G_SHIFT, 1f		// PSR_G_BIT
+	bl	trace_hardirqs_on
+1:
+alternative_endif
+#else
+	bl	trace_hardirqs_on
+#endif
+#endif
+	.endm
+
 /*
  * These are the registers used in the syscall handler, and allow us to
  * have in theory up to 7 arguments to a function - x0 to x6.
@@ -341,20 +375,19 @@ el1_da:
 	 * Data abort handling
 	 */
 	mrs	x0, far_el1
+	enable_nmi
 	enable_dbg
 	// re-enable interrupts if they were enabled in the aborted context
 #ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
 alternative_if_not ARM64_HAS_SYSREG_GIC_CPUIF
 	tbnz	x23, #7, 1f			// PSR_I_BIT
 	nop
-	nop
 	msr     daifclr, #2
 1:
 alternative_else
 	tbnz	x23, #PSR_G_SHIFT, 1f		// PSR_G_BIT
 	mov     x2, #ICC_PMR_EL1_UNMASKED
 	msr_s   ICC_PMR_EL1, x2
-	msr     daifclr, #2
 1:
 alternative_endif
 #else
@@ -367,6 +400,7 @@ alternative_endif
 
 	// disable interrupts before pulling preserved data off the stack
 	disable_irq x21
+	disable_nmi
 	kernel_exit 1
 el1_sp_pc:
 	/*
@@ -407,10 +441,14 @@ ENDPROC(el1_sync)
 el1_irq:
 	kernel_entry 1
 	enable_dbg
-#ifdef CONFIG_TRACE_IRQFLAGS
-	bl	trace_hardirqs_off
-#endif
+	trace_hardirqs_off x23
 
+	/*
+	 * On systems with CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS then
+	 * we do not yet know if this IRQ is a pseudo-NMI or a normal
+	 * interrupt. For that reason we must rely on the irq_handler to
+	 * enable the NMI once the interrupt type is determined.
+	 */
 	irq_handler
 
 #ifdef CONFIG_PREEMPT
@@ -422,9 +460,9 @@ el1_irq:
 	bl	el1_preempt
 1:
 #endif
-#ifdef CONFIG_TRACE_IRQFLAGS
-	bl	trace_hardirqs_on
-#endif
+
+	disable_nmi
+	trace_hardirqs_on x23
 	kernel_exit 1
 ENDPROC(el1_irq)
 
@@ -519,6 +557,7 @@ el0_da:
 	 */
 	mrs	x26, far_el1
 	// enable interrupts before calling the main handler
+	enable_nmi
 	enable_dbg_and_irq x0
 	ct_user_exit
 	bic	x0, x26, #(0xff << 56)
@@ -532,6 +571,7 @@ el0_ia:
 	 */
 	mrs	x26, far_el1
 	// enable interrupts before calling the main handler
+	enable_nmi
 	enable_dbg_and_irq x0
 	ct_user_exit
 	mov	x0, x26
@@ -565,6 +605,7 @@ el0_sp_pc:
 	 */
 	mrs	x26, far_el1
 	// enable interrupts before calling the main handler
+	enable_nmi
 	enable_dbg_and_irq x0
 	ct_user_exit
 	mov	x0, x26
@@ -577,6 +618,7 @@ el0_undef:
 	 * Undefined instruction
 	 */
 	// enable interrupts before calling the main handler
+	enable_nmi
 	enable_dbg_and_irq x0
 	ct_user_exit
 	mov	x0, sp
@@ -609,16 +651,18 @@ el0_irq:
 	kernel_entry 0
 el0_irq_naked:
 	enable_dbg
-#ifdef CONFIG_TRACE_IRQFLAGS
-	bl	trace_hardirqs_off
-#endif
-
+	trace_hardirqs_off x23
 	ct_user_exit
+
+	/*
+	 * On systems with CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS then
+	 * we do not yet know if this IRQ is a pseudo-NMI or a normal
+	 * interrupt. For that reason we must rely on the irq_handler to
+	 * enable the NMI once the interrupt type is determined.
+	 */
 	irq_handler
 
-#ifdef CONFIG_TRACE_IRQFLAGS
-	bl	trace_hardirqs_on
-#endif
+	trace_hardirqs_on x23
 	b	ret_to_user
 ENDPROC(el0_irq)
 
@@ -666,6 +710,7 @@ ret_fast_syscall:
 	and	x2, x1, #_TIF_WORK_MASK
 	cbnz	x2, work_pending
 	enable_step_tsk x1, x2
+	disable_nmi
 	kernel_exit 0
 ret_fast_syscall_trace:
 	enable_irq x0				// enable interrupts
@@ -681,6 +726,7 @@ work_pending:
 	mov	x0, sp				// 'regs'
 	tst	x2, #PSR_MODE_MASK		// user mode regs?
 	b.ne	no_work_pending			// returning to kernel
+	enable_nmi
 	enable_irq x21				// enable interrupts for do_notify_resume()
 	bl	do_notify_resume
 	b	ret_to_user
@@ -697,6 +743,7 @@ ret_to_user:
 	cbnz	x2, work_pending
 	enable_step_tsk x1, x2
 no_work_pending:
+	disable_nmi
 	kernel_exit 0
 ENDPROC(ret_to_user)
 
@@ -722,6 +769,7 @@ el0_svc:
 	mov	sc_nr, #__NR_syscalls
 el0_svc_naked:					// compat entry point
 	stp	x0, scno, [sp, #S_ORIG_X0]	// save the original x0 and syscall number
+	enable_nmi
 	enable_dbg_and_irq x16
 	ct_user_exit 1
 
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 0f37a33499e2..d5539291ac55 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -804,13 +804,31 @@ int setup_profiling_timer(unsigned int multiplier)
 	return -EINVAL;
 }
 
+/*
+ * IPI_CPU_BACKTRACE is either implemented either as a normal IRQ  or,
+ * if the hardware can supports it, using a pseudo-NMI.
+ *
+ * The mechanism used to implement pseudo-NMI means that in both cases
+ * testing if the backtrace IPI is disabled requires us to check the
+ * PSR I bit. However in the later case we cannot use irqs_disabled()
+ * to check the I bit because, when the pseudo-NMI is active that
+ * function examines the GIC PMR instead.
+ */
+static unsigned long nmi_disabled(void)
+{
+	unsigned long flags;
+
+	asm volatile("mrs %0, daif" : "=r"(flags) :: "memory");
+	return flags & PSR_I_BIT;
+}
+
 static void raise_nmi(cpumask_t *mask)
 {
 	/*
 	 * Generate the backtrace directly if we are running in a
 	 * calling context that is not preemptible by the backtrace IPI.
 	 */
-	if (cpumask_test_cpu(smp_processor_id(), mask) && irqs_disabled())
+	if (cpumask_test_cpu(smp_processor_id(), mask) && nmi_disabled())
 		nmi_cpu_backtrace(NULL);
 
 	smp_cross_call(mask, IPI_CPU_BACKTRACE);
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 48cc3dfe1a0a..a389a387c5a6 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -19,6 +19,7 @@
 #include <linux/cpu_pm.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/nmi.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -409,10 +410,60 @@ static u64 gic_mpidr_to_affinity(u64 mpidr)
 	return aff;
 }
 
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+static bool gic_handle_nmi(struct pt_regs *regs)
+{
+	u64 irqnr;
+	struct pt_regs *old_regs;
+
+	asm volatile("mrs_s %0, " __stringify(ICC_IAR1_EL1) : "=r"(irqnr));
+
+	/*
+	 * If no IRQ is acknowledged at this point then we have entered the
+	 * handler due to an normal interrupt (rather than a pseudo-NMI).
+	 * If so then unmask the I-bit and return to normal handling.
+	 */
+	if (irqnr == ICC_IAR1_EL1_SPURIOUS) {
+		asm volatile("msr daifclr, #2" : : : "memory");
+		return false;
+	}
+
+	old_regs = set_irq_regs(regs);
+	nmi_enter();
+
+	do {
+		if (SMP_IPI_NMI_MASK & (1 << irqnr)) {
+			gic_write_eoir(irqnr);
+			if (static_key_true(&supports_deactivate))
+				gic_write_dir(irqnr);
+			nmi_cpu_backtrace(regs);
+		} else if (unlikely(irqnr != ICC_IAR1_EL1_SPURIOUS)) {
+			gic_write_eoir(irqnr);
+			if (static_key_true(&supports_deactivate))
+				gic_write_dir(irqnr);
+			WARN_ONCE(true, "Unexpected NMI received!\n");
+		}
+
+		asm volatile("mrs_s %0, " __stringify(ICC_IAR1_EL1)
+			     : "=r"(irqnr));
+	} while (irqnr != ICC_IAR1_EL1_SPURIOUS);
+
+	nmi_exit();
+	set_irq_regs(old_regs);
+
+	return true;
+}
+#else
+static bool gic_handle_nmi(struct pt_regs *regs) { return false; }
+#endif
+
 static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 {
 	u64 irqnr;
 
+	if (gic_handle_nmi(regs))
+		return;
+
 	do {
 		irqnr = gic_read_iar();
 
@@ -567,6 +618,7 @@ static int gic_dist_supports_lpis(void)
 static void gic_cpu_init(void)
 {
 	void __iomem *rbase;
+	unsigned long nmimask, hwirq;
 
 	/* Register ourselves with the rest of the world */
 	if (gic_populate_rdist())
@@ -584,6 +636,23 @@ static void gic_cpu_init(void)
 
 	/* initialise system registers */
 	gic_cpu_sys_reg_init();
+
+	/* Boost the priority of any IPI in the mask */
+	nmimask = SMP_IPI_NMI_MASK;
+	for_each_set_bit(hwirq, &nmimask, 16) {
+		unsigned int pri_reg = (hwirq / 4) * 4;
+		u32 pri_mask = BIT(6 + ((hwirq % 4) * 8));
+		u32 pri_val = readl_relaxed(rbase + GIC_DIST_PRI + pri_reg);
+		u32 actual;
+
+		pri_mask |= BIT(7 + ((hwirq % 4) * 8));
+		pri_val &= ~pri_mask;	/* priority boost */
+		writel_relaxed(pri_val, rbase + GIC_DIST_PRI + pri_reg);
+
+		actual = readl_relaxed(rbase + GIC_DIST_PRI + pri_reg);
+	}
+	gic_dist_wait_for_rwp();
+	gic_redist_wait_for_rwp();
 }
 
 #ifdef CONFIG_SMP
-- 
2.4.3
