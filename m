From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jun 2011 10:23:15 +0100
Subject: [PATCH 13/23] ARM: entry: instrument usr exception handlers with
	irqsoff tracing
In-Reply-To: <20110629091853.GK21898@n2100.arm.linux.org.uk>
References: <20110629091853.GK21898@n2100.arm.linux.org.uk>
Message-ID: <E1QbqzL-0002Fq-C1@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we no longer re-enable interrupts in these exception handlers, add
the irqsoff tracing calls to them so that the kernel tracks the state
more accurately.

Note that these calls are conditional on IRQSOFF_TRACER:

  kernel ----------> user ---------> kernel
          ^ irqs enabled   ^ irqs disabled

No kernel code can run on the local CPU until we've re-entered the
kernel through one of the exception handlers - and userspace can not
take any locks etc.  So, the kernel doesn't care about the IRQ mask
state while userspace is running unless we're doing IRQ off latency
tracing.  So, we can (and do) avoid the overhead of updating the IRQ
mask state on every kernel->user and user->kernel transition.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/entry-armv.S |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 474934c..c01cdb1 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -421,6 +421,11 @@ ENDPROC(__pabt_svc)
 	.align	5
 __dabt_usr:
 	usr_entry
+
+#ifdef CONFIG_IRQSOFF_TRACER
+	bl	trace_hardirqs_off
+#endif
+
 	kuser_cmpxchg_check
 	dabt_helper
 
@@ -433,12 +438,12 @@ ENDPROC(__dabt_usr)
 	.align	5
 __irq_usr:
 	usr_entry
-	kuser_cmpxchg_check
 
 #ifdef CONFIG_IRQSOFF_TRACER
 	bl	trace_hardirqs_off
 #endif
 
+	kuser_cmpxchg_check
 	irq_handler
 	get_thread_info tsk
 	mov	why, #0
@@ -451,6 +456,11 @@ ENDPROC(__irq_usr)
 	.align	5
 __und_usr:
 	usr_entry
+
+#ifdef CONFIG_IRQSOFF_TRACER
+	bl	trace_hardirqs_off
+#endif
+
 	mov	r2, r4
 	mov	r3, r5
 
@@ -669,6 +679,11 @@ ENDPROC(__und_usr_unknown)
 	.align	5
 __pabt_usr:
 	usr_entry
+
+#ifdef CONFIG_IRQSOFF_TRACER
+	bl	trace_hardirqs_off
+#endif
+
 	pabt_helper
 	mov	r2, sp				@ regs
 	bl	do_PrefetchAbort		@ call abort handler
-- 
1.7.4.4
