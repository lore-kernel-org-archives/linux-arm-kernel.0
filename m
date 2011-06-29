From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jun 2011 10:22:35 +0100
Subject: [PATCH 11/23] ARM: entry: avoid enabling interrupts in prefetch/data
	abort handlers
In-Reply-To: <20110629091853.GK21898@n2100.arm.linux.org.uk>
References: <20110629091853.GK21898@n2100.arm.linux.org.uk>
Message-ID: <E1Qbqyh-0002Fh-3Y@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid enabling interrupts if the parent context had interrupts enabled
in the abort handler assembly code, and move this into the breakpoint/
page/alignment fault handlers instead.

This gets rid of some special-casing for the breakpoint fault handlers
from the low level abort handler path.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/entry-armv.S    |   43 +++++++++++++++++---------------------
 arch/arm/kernel/entry-header.S  |   19 -----------------
 arch/arm/kernel/hw_breakpoint.c |    6 +++-
 arch/arm/mm/alignment.c         |    3 ++
 arch/arm/mm/fault.c             |    4 +++
 5 files changed, 30 insertions(+), 45 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index ee425f7..8048056 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -185,20 +185,15 @@ ENDPROC(__und_invalid)
 __dabt_svc:
 	svc_entry
 
-	@
-	@ get ready to re-enable interrupts if appropriate
-	@
-	mrs	r9, cpsr
-	tst	r5, #PSR_I_BIT
-	biceq	r9, r9, #PSR_I_BIT
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	trace_hardirqs_off
+#endif
 
 	dabt_helper
 
 	@
-	@ set desired IRQ state, then call main handler
+	@ call main handler
 	@
-	debug_entry r1
-	msr	cpsr_c, r9
 	mov	r2, sp
 	bl	do_DataAbort
 
@@ -211,6 +206,12 @@ __dabt_svc:
 	@ restore SPSR and restart the instruction
 	@
 	ldr	r5, [sp, #S_PSR]
+#ifdef CONFIG_TRACE_IRQFLAGS
+	tst	r5, #PSR_I_BIT
+	bleq	trace_hardirqs_on
+	tst	r5, #PSR_I_BIT
+	blne	trace_hardirqs_off
+#endif
 	svc_exit r5				@ return from exception
  UNWIND(.fnend		)
 ENDPROC(__dabt_svc)
@@ -307,16 +308,11 @@ ENDPROC(__und_svc)
 __pabt_svc:
 	svc_entry
 
-	@
-	@ re-enable interrupts if appropriate
-	@
-	mrs	r9, cpsr
-	tst	r5, #PSR_I_BIT
-	biceq	r9, r9, #PSR_I_BIT
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	trace_hardirqs_off
+#endif
 
 	pabt_helper
-	debug_entry r1
-	msr	cpsr_c, r9			@ Maybe enable interrupts
 	mov	r2, sp				@ regs
 	bl	do_PrefetchAbort		@ call abort handler
 
@@ -329,6 +325,12 @@ __pabt_svc:
 	@ restore SPSR and restart the instruction
 	@
 	ldr	r5, [sp, #S_PSR]
+#ifdef CONFIG_TRACE_IRQFLAGS
+	tst	r5, #PSR_I_BIT
+	bleq	trace_hardirqs_on
+	tst	r5, #PSR_I_BIT
+	blne	trace_hardirqs_off
+#endif
 	svc_exit r5				@ return from exception
  UNWIND(.fnend		)
 ENDPROC(__pabt_svc)
@@ -412,11 +414,6 @@ __dabt_usr:
 	kuser_cmpxchg_check
 	dabt_helper
 
-	@
-	@ IRQs on, then call the main handler
-	@
-	debug_entry r1
-	enable_irq
 	mov	r2, sp
 	adr	lr, BSYM(ret_from_exception)
 	b	do_DataAbort
@@ -663,8 +660,6 @@ ENDPROC(__und_usr_unknown)
 __pabt_usr:
 	usr_entry
 	pabt_helper
-	debug_entry r1
-	enable_irq				@ Enable interrupts
 	mov	r2, sp				@ regs
 	bl	do_PrefetchAbort		@ call abort handler
  UNWIND(.fnend		)
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 051166c..4d6ad83 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -165,25 +165,6 @@
 	.endm
 #endif	/* !CONFIG_THUMB2_KERNEL */
 
-	@
-	@ Debug exceptions are taken as prefetch or data aborts.
-	@ We must disable preemption during the handler so that
-	@ we can access the debug registers safely.
-	@
-	.macro	debug_entry, fsr
-#if defined(CONFIG_HAVE_HW_BREAKPOINT) && defined(CONFIG_PREEMPT)
-	ldr	r4, =0x40f		@ mask out fsr.fs
-	and	r5, r4, \fsr
-	cmp	r5, #2			@ debug exception
-	bne	1f
-	get_thread_info r10
-	ldr	r6, [r10, #TI_PREEMPT]	@ get preempt count
-	add	r11, r6, #1		@ increment it
-	str	r11, [r10, #TI_PREEMPT]
-1:
-#endif
-	.endm
-
 /*
  * These are the registers used in the syscall handler, and allow us to
  * have in theory up to 7 arguments to a function - r0 to r6.
diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 87acc25..b813e1e 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -804,8 +804,10 @@ static int hw_breakpoint_pending(unsigned long addr, unsigned int fsr,
 	int ret = 0;
 	u32 dscr;
 
-	/* We must be called with preemption disabled. */
-	WARN_ON(preemptible());
+	preempt_disable();
+
+	if (interrupts_enabled(regs))
+		local_irq_enable();
 
 	/* We only handle watchpoints and hardware breakpoints. */
 	ARM_DBG_READ(c1, 0, dscr);
diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 724ba3b..be7c638 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -727,6 +727,9 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	int isize = 4;
 	int thumb2_32b = 0;
 
+	if (interrupts_enabled(regs))
+		local_irq_enable();
+
 	instrptr = instruction_pointer(regs);
 
 	fs = get_fs();
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index bc0e1d8..20e5d51 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -285,6 +285,10 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	tsk = current;
 	mm  = tsk->mm;
 
+	/* Enable interrupts if they were enabled in the parent context. */
+	if (interrupts_enabled(regs))
+		local_irq_enable();
+
 	/*
 	 * If we're in an interrupt or have no user
 	 * context, we must not take the fault..
-- 
1.7.4.4
