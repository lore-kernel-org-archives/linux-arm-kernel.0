From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 May 2010 15:45:39 +0100
Subject: [RESEND PATCH] ARM: fix 'unannotated irqs-on' lockdep warning
In-Reply-To: <20100524222033.12b25f2a@tom-lei>
References: <1274615328-27953-1-git-send-email-tom.leiming@gmail.com>
	<20100523123801.GC950@n2100.arm.linux.org.uk>
	<AANLkTikRp0EHxshKYq39p18ymoRNAtyHrNm3yq6A49-r@mail.gmail.com>
	<20100523141300.GD950@n2100.arm.linux.org.uk>
	<AANLkTinV9Na9zxYMIfTr893Ynnc0YOk2B6uPKEa9s4R1@mail.gmail.com>
	<20100523194746.GE950@n2100.arm.linux.org.uk>
	<20100524112355.18424622@tom-lei>
	<20100524071921.GA17528@n2100.arm.linux.org.uk>
	<20100524101416.GA21117@n2100.arm.linux.org.uk>
	<20100524222033.12b25f2a@tom-lei>
Message-ID: <20100524144539.GE21117@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 24, 2010 at 10:20:33PM +0800, Ming Lei wrote:
> On Mon, 24 May 2010 11:14:16 +0100
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > Right, I see what the problem is now - it's all to do with threads
> > created with kernel_thread() confusing lockdep.
> > 
> > I'm of the opinion that all your changes in entry*.S are the wrong
> > way to fix this - not only does it add additional overhead where
> > none is really necessary, it adds additional complexity.
> > 
> > So, here's a patch to solve the warning you quoted.
> 
> No, your patch does not fix the issue, I still can see the lockdep
> warning after applying it against Linux 2.6.34-next-20100524.

No, my patch fixes the issue you raised in the dump.  This is a new
lockdep issue which is unrelated to the first dump.

What's wrong is:

commit 0d928b0b616d1c5c5fe76019a87cba171ca91633
Author: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Date:   Thu Aug 13 20:38:17 2009 +0200

    Complete irq tracing support for ARM

    Before this patch enabling and disabling irqs in assembler code and by
    the hardware wasn't tracked completly.

    I had to transpose two instructions in arch/arm/lib/bitops.h because
    restore_irqs doesn't preserve the flags with CONFIG_TRACE_IRQFLAGS=y

    Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
    Cc: Russell King <linux@arm.linux.org.uk>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Ingo Molnar <mingo@redhat.com>

    Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

which needs to be redone with a little more understanding, like the
following patch.  Note: you will need the previous patch as well,
which is separate because it addresses a *different* issue.

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 7ee48e7..3fd7861 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -162,8 +162,6 @@ ENDPROC(__und_invalid)
 	@  r4 - orig_r0 (see pt_regs definition in ptrace.h)
 	@
 	stmia	r5, {r0 - r4}
-
-	asm_trace_hardirqs_off
 	.endm
 
 	.align	5
@@ -204,7 +202,7 @@ __dabt_svc:
 	@
 	@ IRQs off again before pulling preserved data off the stack
 	@
-	disable_irq
+	disable_irq_notrace
 
 	@
 	@ restore SPSR and restart the instruction
@@ -218,6 +216,9 @@ ENDPROC(__dabt_svc)
 __irq_svc:
 	svc_entry
 
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	trace_hardirqs_off
+#endif
 #ifdef CONFIG_PREEMPT
 	get_thread_info tsk
 	ldr	r8, [tsk, #TI_PREEMPT]		@ get preempt count
@@ -291,7 +292,7 @@ __und_svc:
 	@
 	@ IRQs off again before pulling preserved data off the stack
 	@
-1:	disable_irq
+1:	disable_irq_notrace
 
 	@
 	@ restore SPSR and restart the instruction
@@ -327,7 +328,7 @@ __pabt_svc:
 	@
 	@ IRQs off again before pulling preserved data off the stack
 	@
-	disable_irq
+	disable_irq_notrace
 
 	@
 	@ restore SPSR and restart the instruction
@@ -393,8 +394,6 @@ ENDPROC(__pabt_svc)
 	@ Clear FP to mark the first stack frame
 	@
 	zero_fp
-
-	asm_trace_hardirqs_off
 	.endm
 
 	.macro	kuser_cmpxchg_check
@@ -465,9 +464,6 @@ __irq_usr:
  THUMB(	movne	r0, #0		)
  THUMB(	strne	r0, [r0]	)
 #endif
-#ifdef CONFIG_TRACE_IRQFLAGS
-	bl	trace_hardirqs_on
-#endif
 
 	mov	why, #0
 	b	ret_to_user
