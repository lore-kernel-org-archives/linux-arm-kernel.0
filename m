From: will.deacon@arm.com (Will Deacon)
Date: Mon, 29 Nov 2010 17:34:44 +0000
Subject: [PATCH 4/8] ARM: hw_breakpoint: disable preemption during debug
	exception handling
In-Reply-To: <1291052088-17243-1-git-send-email-will.deacon@arm.com>
References: <1291052088-17243-1-git-send-email-will.deacon@arm.com>
Message-ID: <1291052088-17243-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM, debug exceptions occur in the form of data or prefetch aborts.
One difference is that debug exceptions require access to per-cpu banked
registers and data structures which are not saved in the low-level exception
code. For kernels built with CONFIG_PREEMPT, there is an unlikely scenario
that the debug handler ends up running on a different CPU from the one
that originally signalled the event, resulting in random data being read
from the wrong registers.

This patch adds a debug_entry macro to the low-level exception handling
code which checks whether the taken exception is a debug exception. If
it is, the preempt count for the faulting process is incremented. After
the debug handler has finished, the count is decremented.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/entry-armv.S    |    4 ++++
 arch/arm/kernel/entry-header.S  |   19 +++++++++++++++++++
 arch/arm/kernel/hw_breakpoint.c |   14 +++++++++-----
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index c09e357..34bbef0 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -198,6 +198,7 @@ __dabt_svc:
 	@
 	@ set desired IRQ state, then call main handler
 	@
+	debug_entry r1
 	msr	cpsr_c, r9
 	mov	r2, sp
 	bl	do_DataAbort
@@ -324,6 +325,7 @@ __pabt_svc:
 #else
 	bl	CPU_PABORT_HANDLER
 #endif
+	debug_entry r1
 	msr	cpsr_c, r9			@ Maybe enable interrupts
 	mov	r2, sp				@ regs
 	bl	do_PrefetchAbort		@ call abort handler
@@ -439,6 +441,7 @@ __dabt_usr:
 	@
 	@ IRQs on, then call the main handler
 	@
+	debug_entry r1
 	enable_irq
 	mov	r2, sp
 	adr	lr, BSYM(ret_from_exception)
@@ -703,6 +706,7 @@ __pabt_usr:
 #else
 	bl	CPU_PABORT_HANDLER
 #endif
+	debug_entry r1
 	enable_irq				@ Enable interrupts
 	mov	r2, sp				@ regs
 	bl	do_PrefetchAbort		@ call abort handler
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index d93f976..ae94649 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -165,6 +165,25 @@
 	.endm
 #endif	/* !CONFIG_THUMB2_KERNEL */
 
+	@
+	@ Debug exceptions are taken as prefetch or data aborts.
+	@ We must disable preemption during the handler so that
+	@ we can access the debug registers safely.
+	@
+	.macro	debug_entry, fsr
+#if defined(CONFIG_HAVE_HW_BREAKPOINT) && defined(CONFIG_PREEMPT)
+	ldr	r4, =0x40f		@ mask out fsr.fs
+	and	r5, r4, \fsr
+	cmp	r5, #2			@ debug exception
+	bne	1f
+	get_thread_info r10
+	ldr	r6, [r10, #TI_PREEMPT]	@ get preempt count
+	add	r11, r6, #1		@ increment it
+	str	r11, [r10, #TI_PREEMPT]
+1:
+#endif
+	.endm
+
 /*
  * These are the registers used in the syscall handler, and allow us to
  * have in theory up to 7 arguments to a function - r0 to r6.
diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 550d949..61eeb41 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -737,12 +737,12 @@ unlock:
 
 /*
  * Called from either the Data Abort Handler [watchpoint] or the
- * Prefetch Abort Handler [breakpoint].
+ * Prefetch Abort Handler [breakpoint] with preemption disabled.
  */
 static int hw_breakpoint_pending(unsigned long addr, unsigned int fsr,
 				 struct pt_regs *regs)
 {
-	int ret = 1; /* Unhandled fault. */
+	int ret = 0;
 	u32 dscr;
 
 	/* We only handle watchpoints and hardware breakpoints. */
@@ -759,11 +759,15 @@ static int hw_breakpoint_pending(unsigned long addr, unsigned int fsr,
 		watchpoint_handler(addr, regs);
 		break;
 	default:
-		goto out;
+		ret = 1; /* Unhandled fault. */
 	}
 
-	ret = 0;
-out:
+	/*
+	 * Re-enable preemption after it was disabled in the
+	 * low-level exception handling code.
+	 */
+	preempt_enable();
+
 	return ret;
 }
 
-- 
1.7.0.4
