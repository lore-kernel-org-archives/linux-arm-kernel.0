From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jun 2011 10:23:35 +0100
Subject: [PATCH 14/23] ARM: entry: consolidate trace_hardirqs_off into
	(svc|usr)_entry macros
In-Reply-To: <20110629091853.GK21898@n2100.arm.linux.org.uk>
References: <20110629091853.GK21898@n2100.arm.linux.org.uk>
Message-ID: <E1Qbqzf-0002Fv-FB@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All handlers now call trace_hardirqs_off, so move this common code into
the (svc|usr)_entry assembler macros.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/entry-armv.S |   47 +++++++----------------------------------
 1 files changed, 8 insertions(+), 39 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index c01cdb1..1da985f 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -179,16 +179,15 @@ ENDPROC(__und_invalid)
 	@  r6 - orig_r0 (see pt_regs definition in ptrace.h)
 	@
 	stmia	r7, {r2 - r6}
-	.endm
-
-	.align	5
-__dabt_svc:
-	svc_entry
 
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bl	trace_hardirqs_off
 #endif
+	.endm
 
+	.align	5
+__dabt_svc:
+	svc_entry
 	dabt_helper
 
 	@
@@ -219,11 +218,6 @@ ENDPROC(__dabt_svc)
 	.align	5
 __irq_svc:
 	svc_entry
-
-#ifdef CONFIG_TRACE_IRQFLAGS
-	bl	trace_hardirqs_off
-#endif
-
 	irq_handler
 
 #ifdef CONFIG_PREEMPT
@@ -267,11 +261,6 @@ __und_svc:
 #else
 	svc_entry
 #endif
-
-#ifdef CONFIG_TRACE_IRQFLAGS
-	bl	trace_hardirqs_off
-#endif
-
 	@
 	@ call emulation code, which returns using r9 if it has emulated
 	@ the instruction, or the more conventional lr if we are to treat
@@ -317,11 +306,6 @@ ENDPROC(__und_svc)
 	.align	5
 __pabt_svc:
 	svc_entry
-
-#ifdef CONFIG_TRACE_IRQFLAGS
-	bl	trace_hardirqs_off
-#endif
-
 	pabt_helper
 	mov	r2, sp				@ regs
 	bl	do_PrefetchAbort		@ call abort handler
@@ -401,6 +385,10 @@ ENDPROC(__pabt_svc)
 	@ Clear FP to mark the first stack frame
 	@
 	zero_fp
+
+#ifdef CONFIG_IRQSOFF_TRACER
+	bl	trace_hardirqs_off
+#endif
 	.endm
 
 	.macro	kuser_cmpxchg_check
@@ -421,11 +409,6 @@ ENDPROC(__pabt_svc)
 	.align	5
 __dabt_usr:
 	usr_entry
-
-#ifdef CONFIG_IRQSOFF_TRACER
-	bl	trace_hardirqs_off
-#endif
-
 	kuser_cmpxchg_check
 	dabt_helper
 
@@ -438,11 +421,6 @@ ENDPROC(__dabt_usr)
 	.align	5
 __irq_usr:
 	usr_entry
-
-#ifdef CONFIG_IRQSOFF_TRACER
-	bl	trace_hardirqs_off
-#endif
-
 	kuser_cmpxchg_check
 	irq_handler
 	get_thread_info tsk
@@ -457,10 +435,6 @@ ENDPROC(__irq_usr)
 __und_usr:
 	usr_entry
 
-#ifdef CONFIG_IRQSOFF_TRACER
-	bl	trace_hardirqs_off
-#endif
-
 	mov	r2, r4
 	mov	r3, r5
 
@@ -679,11 +653,6 @@ ENDPROC(__und_usr_unknown)
 	.align	5
 __pabt_usr:
 	usr_entry
-
-#ifdef CONFIG_IRQSOFF_TRACER
-	bl	trace_hardirqs_off
-#endif
-
 	pabt_helper
 	mov	r2, sp				@ regs
 	bl	do_PrefetchAbort		@ call abort handler
-- 
1.7.4.4
