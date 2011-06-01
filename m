From: ming.lei@canonical.com (Ming Lei)
Date: Wed, 1 Jun 2011 23:52:21 +0800
Subject: [PATCH] arm: fix lockdep warning of "unannotated irqs-off"
In-Reply-To: <20110601144630.GL3660@n2100.arm.linux.org.uk>
References: <20110601154259.12487694@tom-ThinkPad-T410>
	<20110601093436.GF3660@n2100.arm.linux.org.uk>
	<20110601211751.69b85eeb@tom-ThinkPad-T410>
	<20110601132233.GG3660@n2100.arm.linux.org.uk>
	<20110601222829.6eaad0e6@tom-ThinkPad-T410>
	<20110601144630.GL3660@n2100.arm.linux.org.uk>
Message-ID: <20110601235221.5aab9182@tom-ThinkPad-T410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Wed, 1 Jun 2011 15:46:30 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> I still don't see what the problem is.  

Simply speaking, there are two usages which does need to trace irq
disable and enable. One is to prove locking correctness in lockdep,
such as a lock can't be held in hardirq enable state if the lock
was held in hardirq context. Another is to trace the max time of
irq disable, which is implemented in ftrace.

If the former case is to be supported, CONFIG_PROVE_LOCKING should
be selected. If the latter is to be supported, CONFIG_IRQSOFF_TRACER
should be enabled. Both the two options will have to select
CONFIG_TRACE_IRQFLAGS.

If CONFIG_TRACE_IRQFLAGS is enabled, trace_hardirqs_off/on are surely
to be defined, but the implementation will be different between
CONFIG_PROVE_LOCKING case and non-CONFIG_PROVE_LOCKING case.
So you will find there are different implementations of
trace_hardirqs_off/on in kernel/lockdep.c and
kernel/trace/trace_irqsoff.c.

That is why the patch uses CONFIG_TRACE_IRQFLAGS as dependency.

> If CONFIG_IRQSOFF_TRACER is
> not set, then we do not tell the kernel that IRQs have been enabled
> upon exit to user space, and we do not tell the kernel that IRQs have
> been disabled upon entry to kernel space.
> 
> So your patch which makes us always report an IRQs off condition on
> entry to __irq_usr makes no sense what so ever to me.

Except for tracing max time of irq disable, lock proving has to be
supported if user needs it. So we should introduces the changes below
into the patch:

diff --git a/arch/arm/kernel/entry-common.S
b/arch/arm/kernel/entry-common.S index b2a27b6..9494792 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -69,7 +69,7 @@ ENTRY(ret_to_user_from_irq)
 	tst	r1, #_TIF_WORK_MASK
 	bne	work_pending
 no_work_pending:
-#if defined(CONFIG_IRQSOFF_TRACER)
+#if defined(CONFIG_TRACE_IRQFLAGS)
 	asm_trace_hardirqs_on
 #endif
 	/* perform architecture specific actions before user return */

In fact, the old dependency is wrong.

> 
> Please explain how we get to a situation where we're entering
> __irq_usr in the CONFIG_IRQSOFF_TRACER unset case where the kernel
> incorrectly believes that IRQs are unmasked.

Above should explain this.

> 
> Once you've done that, now analyze the case where
> CONFIG_IRQSOFF_TRACER is set.  There, we tell the kernel that IRQs
> are enabled before returning to userspace, and that IRQs are disabled
> when entering the kernel.  It is only _now_ that we're missing the
> irq-off annotation on entry to the interrupt handler.

I don't see there are any issue now.

> Ergo, it should depend on CONFIG_IRQSOFF_TRACER, not
> CONFIG_TRACE_IRQFLAGS.

So how about v2 of the patch below?

---
 arch/arm/kernel/entry-armv.S   |    6 +++++-
 arch/arm/kernel/entry-common.S |    4 +++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index e8d8856..7780dc9 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -435,6 +435,10 @@ __irq_usr:
 	usr_entry
 	kuser_cmpxchg_check
 
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl      trace_hardirqs_off
+#endif
+
 	get_thread_info tsk
 #ifdef CONFIG_PREEMPT
 	ldr	r8, [tsk, #TI_PREEMPT]		@ get preempt count
@@ -453,7 +457,7 @@ __irq_usr:
 #endif
 
 	mov	why, #0
-	b	ret_to_user
+	b	ret_to_user_from_irq
  UNWIND(.fnend		)
 ENDPROC(__irq_usr)
 
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 1e7b04a..9494792 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -64,17 +64,19 @@ work_resched:
 ENTRY(ret_to_user)
 ret_slow_syscall:
 	disable_irq				@ disable interrupts
+ENTRY(ret_to_user_from_irq)
 	ldr	r1, [tsk, #TI_FLAGS]
 	tst	r1, #_TIF_WORK_MASK
 	bne	work_pending
 no_work_pending:
-#if defined(CONFIG_IRQSOFF_TRACER)
+#if defined(CONFIG_TRACE_IRQFLAGS)
 	asm_trace_hardirqs_on
 #endif
 	/* perform architecture specific actions before user return */
 	arch_ret_to_user r1, lr
 
 	restore_user_regs fast = 0, offset = 0
+ENDPROC(ret_to_user_from_irq)
 ENDPROC(ret_to_user)
 
 /*
-- 
1.7.4.1



thanks,
--
Ming Lei
