From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 05 Sep 2014 10:41:43 +0100
Subject: [PATCH FYI 4/4] ARM: cobble together FIQ backtracing
In-Reply-To: <20140905094056.GD30401@n2100.arm.linux.org.uk>
References: <20140905094056.GD30401@n2100.arm.linux.org.uk>
Message-ID: <E1XPq1X-0000RT-IV@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cobble the FIQ backtracing together, some of this patch based on work
which David Thompson has done.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/entry-armv.S | 96 ++++++++++++++++++++++++++++++++++++++------
 arch/arm/kernel/fiq.c        | 11 ++++-
 arch/arm/kernel/setup.c      |  8 +++-
 arch/arm/kernel/smp.c        |  5 +++
 drivers/irqchip/irq-gic.c    | 45 ++++++++++++++++++---
 5 files changed, 144 insertions(+), 21 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 36276cdccfbc..bd1ad0076937 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -146,7 +146,7 @@ ENDPROC(__und_invalid)
 #define SPFIX(code...)
 #endif
 
-	.macro	svc_entry, stack_hole=0
+	.macro	svc_entry, stack_hole=0, trace=1
  UNWIND(.fnstart		)
  UNWIND(.save {r0 - pc}		)
 	sub	sp, sp, #(S_FRAME_SIZE + \stack_hole - 4)
@@ -182,9 +182,11 @@ ENDPROC(__und_invalid)
 	@
 	stmia	r7, {r2 - r6}
 
+	.if	\trace
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bl	trace_hardirqs_off
 #endif
+	.endif
 	.endm
 
 	.align	5
@@ -314,7 +316,7 @@ ENDPROC(__pabt_svc)
 #error "sizeof(struct pt_regs) must be a multiple of 8"
 #endif
 
-	.macro	usr_entry
+	.macro	usr_entry, trace=1
  UNWIND(.fnstart	)
  UNWIND(.cantunwind	)	@ don't unwind the user space
 	sub	sp, sp, #S_FRAME_SIZE
@@ -351,10 +353,12 @@ ENDPROC(__pabt_svc)
 	@
 	zero_fp
 
+	.if	\trace
 #ifdef CONFIG_IRQSOFF_TRACER
 	bl	trace_hardirqs_off
 #endif
 	ct_user_exit save = 0
+	.endif
 	.endm
 
 	.macro	kuser_cmpxchg_check
@@ -683,6 +687,61 @@ ENTRY(ret_from_exception)
 ENDPROC(__pabt_usr)
 ENDPROC(ret_from_exception)
 
+	.macro  svc_exit_via_fiq, rpsr
+	mov     r0, sp
+	ldmib   r0, {r1 - r14}  @ abort is deadly from here onward (it will
+				@ clobber state restored below)
+	msr     cpsr_c, #FIQ_MODE | PSR_I_BIT | PSR_F_BIT
+	add     r8, r0, #S_PC
+	ldr     r9, [r0, #S_PSR]
+	msr     spsr_cxsf, r9
+	ldr     r0, [r0, #S_R0]
+	ldmia   r8, {pc}^
+	.endm
+
+	.macro	fiq_handler
+	bl	__fiq_handle
+	.endm
+
+	.align 5
+__fiq_usr:
+	usr_entry trace=0
+	kuser_cmpxchg_check
+	mov	r0, sp
+	fiq_handler
+	get_thread_info tsk
+	restore_user_regs fast = 0, offset = 0
+ UNWIND(.fnend)
+ UNWIND(.cantunwind)
+ENDPROC(__fiq_usr)
+
+__fiq_abt:
+	svc_entry trace=0
+	msr     cpsr_c, #ABT_MODE | PSR_I_BIT | PSR_F_BIT
+	mov     r2, lr          @ Save lr_abt
+	mrs     r3, spsr        @ Save spsr_abt, abort is now safe
+	msr     cpsr_c, #SVC_MODE | PSR_I_BIT | PSR_F_BIT
+	mov	r0, sp
+	push    {r2 - r3}
+	fiq_handler
+	pop     {r0 - r1}
+	msr     cpsr_c, #ABT_MODE | PSR_I_BIT | PSR_F_BIT
+	mov     lr, r0          @ Restore lr_abt, abort is unsafe
+	msr     spsr_cxsf, r1   @ Restore spsr_abt
+	msr     cpsr_c, #SVC_MODE | PSR_I_BIT | PSR_F_BIT
+	svc_exit_via_fiq r5
+ UNWIND(.fnend)
+ENDPROC(__fiq_abt)
+
+__fiq_svc:
+	svc_entry trace=0
+	mov	r0, sp
+	fiq_handler
+	svc_exit_via_fiq r5
+ UNWIND(.fnend)
+ENDPROC(__fiq_svc)
+
+
 /*
  * Register switch for ARMv3 and ARMv4 processors
  * r0 = previous task_struct, r1 = previous thread_info, r2 = next thread_info
@@ -1117,18 +1176,29 @@ vector_rst:
 vector_addrexcptn:
 	b	vector_addrexcptn
 
-/*=============================================================================
- * Undefined FIQs
- *-----------------------------------------------------------------------------
- * Enter in FIQ mode, spsr = ANY CPSR, lr = ANY PC
- * MUST PRESERVE SVC SPSR, but need to switch to SVC mode to show our msg.
- * Basically to switch modes, we *HAVE* to clobber one register...  brain
- * damage alert!  I don't think that we can execute any code in here in any
- * other mode than FIQ...  Ok you can switch to another mode, but you can't
- * get out of that mode without clobbering one register.
+/*
+ * FIQs.  We provide a default stub here, which is used by the kernel
+ * when something fails (eg, spinlock lockup or deadlock, rcu stall,
+ * etc.)
  */
-vector_fiq:
-	subs	pc, lr, #4
+	vector_stub	fiq, FIQ_MODE, 4
+
+	.long	__fiq_usr
+	.long	__fiq_svc
+	.long	__fiq_svc
+	.long	__fiq_svc
+	.long	__fiq_svc
+	.long	__fiq_svc
+	.long	__fiq_svc
+	.long	__fiq_abt
+	.long	__fiq_svc
+	.long	__fiq_svc
+	.long	__fiq_svc
+	.long	__fiq_svc
+	.long	__fiq_svc
+	.long	__fiq_svc
+	.long	__fiq_svc
+	.long	__fiq_svc
 
 	.globl	vector_fiq_offset
 	.equ	vector_fiq_offset, vector_fiq
diff --git a/arch/arm/kernel/fiq.c b/arch/arm/kernel/fiq.c
index 918875d96d5d..1743049c433b 100644
--- a/arch/arm/kernel/fiq.c
+++ b/arch/arm/kernel/fiq.c
@@ -53,6 +53,7 @@
 	})
 
 static unsigned long no_fiq_insn;
+static struct pt_regs def_fiq_regs;
 
 /* Default reacquire function
  * - we always relinquish FIQ control
@@ -60,8 +61,15 @@ static unsigned long no_fiq_insn;
  */
 static int fiq_def_op(void *ref, int relinquish)
 {
-	if (!relinquish)
+	if (!relinquish) {
+		/* Restore default handler and registers */
+		local_fiq_disable();
+		set_fiq_regs(&dfl_fiq_regs);
 		set_fiq_handler(&no_fiq_insn, sizeof(no_fiq_insn));
+		local_fiq_enable();
+
+		/* FIXME: notify irq controller to standard enable FIQs */
+	}
 
 	return 0;
 }
@@ -151,5 +159,6 @@ void __init init_FIQ(int start)
 {
 	unsigned offset = FIQ_OFFSET;
 	no_fiq_insn = *(unsigned long *)(0xffff0000 + offset);
+	get_fiq_regs(&dfl_fiq_regs);
 	fiq_start = start;
 }
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 84db893dedc2..22e56f6ff446 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -423,6 +423,8 @@ static void __init elf_hwcap_fixup(void)
 		elf_hwcap &= ~HWCAP_SWP;
 }
 
+static unsigned int fiq_stack[4][1024];
+
 /*
  * cpu_init - initialise one CPU.
  *
@@ -470,7 +472,9 @@ void notrace cpu_init(void)
 	"msr	cpsr_c, %5\n\t"
 	"add	r14, %0, %6\n\t"
 	"mov	sp, r14\n\t"
-	"msr	cpsr_c, %7"
+	"msr	cpsr_c, %7\n\t"
+	"mov	sp, %8\n\t"
+	"msr	cpsr_c, %9"
 	    :
 	    : "r" (stk),
 	      PLC (PSR_F_BIT | PSR_I_BIT | IRQ_MODE),
@@ -479,6 +483,8 @@ void notrace cpu_init(void)
 	      "I" (offsetof(struct stack, abt[0])),
 	      PLC (PSR_F_BIT | PSR_I_BIT | UND_MODE),
 	      "I" (offsetof(struct stack, und[0])),
+	      PLC (PSR_F_BIT | PSR_I_BIT | FIQ_MODE),
+	      "r" (&fiq_stack[cpu][1024]),
 	      PLC (PSR_F_BIT | PSR_I_BIT | SVC_MODE)
 	    : "r14");
 #endif
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 94959f977b82..ce30ed9f8e1a 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -774,3 +774,8 @@ void arch_trigger_all_cpu_backtrace(bool include_self)
 	smp_mb__after_atomic();
 	put_cpu();
 }
+
+void __fiq_handle(struct pt_regs *regs)
+{
+	ipi_cpu_backtrace(regs);
+}
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 4b959e606fe8..ec7be8eaab3a 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -371,9 +371,19 @@ static void __init gic_dist_init(struct gic_chip_data *gic)
 	for (i = 32; i < gic_irqs; i += 4)
 		writel_relaxed(cpumask, base + GIC_DIST_TARGET + i * 4 / 4);
 
+	/*
+	 * Optionally set all global interrupts to be group 1.
+	 */
+	for (i = 32; i < gic_irqs; i += 32)
+		writel_relaxed(0xffffffff, base + GIC_DIST_IGROUP + i * 4 / 32);
+
 	gic_dist_config(base, gic_irqs, NULL);
 
-	writel_relaxed(1, base + GIC_DIST_CTRL);
+	/*
+	 * Set EnableGrp1/EnableGrp0 (bit 1 and 0) or EnableGrp (bit 0 only,
+	 * bit 1 ignored)
+	 */
+	writel_relaxed(3, base + GIC_DIST_CTRL);
 }
 
 static void gic_cpu_init(struct gic_chip_data *gic)
@@ -400,8 +410,17 @@ static void gic_cpu_init(struct gic_chip_data *gic)
 
 	gic_cpu_config(dist_base, NULL);
 
+	/*
+	 * Set all PPI and SGI interrupts to be group 1.
+	 *
+	 * If grouping is not available (not implemented or prohibited by
+	 * security mode) these registers are read-as-zero/write-ignored.
+	 */
+	writel_relaxed(0xfffffeff, dist_base + GIC_DIST_IGROUP + 0);
+	writel_relaxed(0xa0a0a000, dist_base + GIC_DIST_PRI + 8);
+
 	writel_relaxed(0xf0, base + GIC_CPU_PRIMASK);
-	writel_relaxed(1, base + GIC_CPU_CTRL);
+	writel_relaxed(0x1f, base + GIC_CPU_CTRL);
 }
 
 void gic_cpu_if_down(void)
@@ -485,7 +504,7 @@ static void gic_dist_restore(unsigned int gic_nr)
 		writel_relaxed(gic_data[gic_nr].saved_spi_enable[i],
 			dist_base + GIC_DIST_ENABLE_SET + i * 4);
 
-	writel_relaxed(1, dist_base + GIC_DIST_CTRL);
+	writel_relaxed(3, dist_base + GIC_DIST_CTRL);
 }
 
 static void gic_cpu_save(unsigned int gic_nr)
@@ -542,7 +561,7 @@ static void gic_cpu_restore(unsigned int gic_nr)
 		writel_relaxed(0xa0a0a0a0, dist_base + GIC_DIST_PRI + i * 4);
 
 	writel_relaxed(0xf0, cpu_base + GIC_CPU_PRIMASK);
-	writel_relaxed(1, cpu_base + GIC_CPU_CTRL);
+	writel_relaxed(0x1f, cpu_base + GIC_CPU_CTRL);
 }
 
 static int gic_notifier(struct notifier_block *self, unsigned long cmd,	void *v)
@@ -600,10 +619,18 @@ static void __init gic_pm_init(struct gic_chip_data *gic)
 #endif
 
 #ifdef CONFIG_SMP
+static bool sgi_is_nonsecure(int irq, struct gic_chip_data *gic)
+{
+	/* FIXME: this should be done in a more generic way */
+	return irq != 8;
+}
+
 static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 {
-	int cpu;
+	struct gic_chip_data *gic = &gic_data[0];
 	unsigned long flags, map = 0;
+	unsigned int softirq;
+	int cpu;
 
 	raw_spin_lock_irqsave(&irq_controller_lock, flags);
 
@@ -617,8 +644,14 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	 */
 	dmb(ishst);
 
+	softirq = map << 16 | irq;
+
+	/* SATT only has effect if we are running in the secure world */
+	if (sgi_is_nonsecure(irq, gic))
+		softirq |= 0x8000;
+
 	/* this always happens on GIC0 */
-	writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
+	writel_relaxed(softirq, gic_data_dist_base(gic) + GIC_DIST_SOFTINT);
 
 	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
 }
-- 
1.8.3.1
