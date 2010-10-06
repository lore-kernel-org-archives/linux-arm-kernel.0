From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 06 Oct 2010 16:18:05 +0900
Subject: [PATCH 04/08] ARM: Convert __irq_svc and __usr_svc to macros
In-Reply-To: <20101006071731.28048.89938.sendpatchset@t400s>
References: <20101006071731.28048.89938.sendpatchset@t400s>
Message-ID: <20101006071805.28048.37136.sendpatchset@t400s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Convert __irq_usr and __irq_svc to macros and
keep the existing code as default implementation.

The macros will keep global symbols with the
name prefexed with "__irq_svc_" and "__irq_usr_".

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/include/asm/entry-header.S |   78 +++++++++++++++++++++++++++++++++++
 arch/arm/kernel/entry-armv.S        |   77 +---------------------------------
 2 files changed, 82 insertions(+), 73 deletions(-)

--- 0004/arch/arm/include/asm/entry-header.S
+++ work/arch/arm/include/asm/entry-header.S	2010-10-06 15:07:50.000000000 +0900
@@ -334,3 +334,81 @@ tsk	.req	r9		@ current thread_info
 #endif
 #endif
 	.endm
+
+	.macro	__irq_svc, name
+	.align	5
+	.globl	__irq_svc_\name
+__irq_svc_\name:
+	svc_entry
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	trace_hardirqs_off
+#endif
+#ifdef CONFIG_PREEMPT
+	get_thread_info tsk
+	ldr	r8, [tsk, #TI_PREEMPT]		@ get preempt count
+	add	r7, r8, #1			@ increment it
+	str	r7, [tsk, #TI_PREEMPT]
+#endif
+
+	irq_handler
+#ifdef CONFIG_PREEMPT
+	str	r8, [tsk, #TI_PREEMPT]		@ restore preempt count
+	ldr	r0, [tsk, #TI_FLAGS]		@ get flags
+	teq	r8, #0				@ if preempt count != 0
+	movne	r0, #0				@ force flags to 0
+	tst	r0, #_TIF_NEED_RESCHED
+	blne	svc_preempt
+#endif
+	ldr	r4, [sp, #S_PSR]		@ irqs are already disabled
+#ifdef CONFIG_TRACE_IRQFLAGS
+	tst	r4, #PSR_I_BIT
+	bleq	trace_hardirqs_on
+#endif
+	svc_exit r4				@ return from exception
+ UNWIND(.fnend		)
+ENDPROC(__irq_svc_\name)
+
+	.ltorg
+
+#ifdef CONFIG_PREEMPT
+svc_preempt:
+	mov	r8, lr
+1:	bl	preempt_schedule_irq		@ irq en/disable is done inside
+	ldr	r0, [tsk, #TI_FLAGS]		@ get new tasks TI_FLAGS
+	tst	r0, #_TIF_NEED_RESCHED
+	moveq	pc, r8				@ go again
+	b	1b
+#endif
+	.endm
+
+	.macro	__irq_usr, name
+	.align	5
+	.globl	__irq_usr_\name
+__irq_usr_\name:
+	usr_entry
+	kuser_cmpxchg_check
+
+	get_thread_info tsk
+#ifdef CONFIG_PREEMPT
+	ldr	r8, [tsk, #TI_PREEMPT]		@ get preempt count
+	add	r7, r8, #1			@ increment it
+	str	r7, [tsk, #TI_PREEMPT]
+#endif
+
+	irq_handler
+#ifdef CONFIG_PREEMPT
+	ldr	r0, [tsk, #TI_PREEMPT]
+	str	r8, [tsk, #TI_PREEMPT]
+	teq	r0, r7
+ ARM(	strne	r0, [r0, -r0]	)
+ THUMB(	movne	r0, #0		)
+ THUMB(	strne	r0, [r0]	)
+#endif
+
+	mov	why, #0
+	b	ret_to_user
+ UNWIND(.fnend		)
+ENDPROC(__irq_usr_\name)
+	.ltorg
+	.endm
--- 0004/arch/arm/kernel/entry-armv.S
+++ work/arch/arm/kernel/entry-armv.S	2010-10-06 15:07:23.000000000 +0900
@@ -128,49 +128,7 @@ __dabt_svc:
  UNWIND(.fnend		)
 ENDPROC(__dabt_svc)
 
-	.align	5
-__irq_svc:
-	svc_entry
-
-#ifdef CONFIG_TRACE_IRQFLAGS
-	bl	trace_hardirqs_off
-#endif
-#ifdef CONFIG_PREEMPT
-	get_thread_info tsk
-	ldr	r8, [tsk, #TI_PREEMPT]		@ get preempt count
-	add	r7, r8, #1			@ increment it
-	str	r7, [tsk, #TI_PREEMPT]
-#endif
-
-	irq_handler
-#ifdef CONFIG_PREEMPT
-	str	r8, [tsk, #TI_PREEMPT]		@ restore preempt count
-	ldr	r0, [tsk, #TI_FLAGS]		@ get flags
-	teq	r8, #0				@ if preempt count != 0
-	movne	r0, #0				@ force flags to 0
-	tst	r0, #_TIF_NEED_RESCHED
-	blne	svc_preempt
-#endif
-	ldr	r4, [sp, #S_PSR]		@ irqs are already disabled
-#ifdef CONFIG_TRACE_IRQFLAGS
-	tst	r4, #PSR_I_BIT
-	bleq	trace_hardirqs_on
-#endif
-	svc_exit r4				@ return from exception
- UNWIND(.fnend		)
-ENDPROC(__irq_svc)
-
-	.ltorg
-
-#ifdef CONFIG_PREEMPT
-svc_preempt:
-	mov	r8, lr
-1:	bl	preempt_schedule_irq		@ irq en/disable is done inside
-	ldr	r0, [tsk, #TI_FLAGS]		@ get new tasks TI_FLAGS
-	tst	r0, #_TIF_NEED_RESCHED
-	moveq	pc, r8				@ go again
-	b	1b
-#endif
+	__irq_svc	default
 
 	.align	5
 __und_svc:
@@ -300,34 +258,7 @@ __dabt_usr:
  UNWIND(.fnend		)
 ENDPROC(__dabt_usr)
 
-	.align	5
-__irq_usr:
-	usr_entry
-	kuser_cmpxchg_check
-
-	get_thread_info tsk
-#ifdef CONFIG_PREEMPT
-	ldr	r8, [tsk, #TI_PREEMPT]		@ get preempt count
-	add	r7, r8, #1			@ increment it
-	str	r7, [tsk, #TI_PREEMPT]
-#endif
-
-	irq_handler
-#ifdef CONFIG_PREEMPT
-	ldr	r0, [tsk, #TI_PREEMPT]
-	str	r8, [tsk, #TI_PREEMPT]
-	teq	r0, r7
- ARM(	strne	r0, [r0, -r0]	)
- THUMB(	movne	r0, #0		)
- THUMB(	strne	r0, [r0]	)
-#endif
-
-	mov	why, #0
-	b	ret_to_user
- UNWIND(.fnend		)
-ENDPROC(__irq_usr)
-
-	.ltorg
+	__irq_usr	default
 
 	.align	5
 __und_usr:
@@ -952,10 +883,10 @@ __stubs_start:
  */
 	vector_stub	irq, IRQ_MODE, 4
 
-	.long	__irq_usr			@  0  (USR_26 / USR_32)
+	.long	__irq_usr_default		@  0  (USR_26 / USR_32)
 	.long	__irq_invalid			@  1  (FIQ_26 / FIQ_32)
 	.long	__irq_invalid			@  2  (IRQ_26 / IRQ_32)
-	.long	__irq_svc			@  3  (SVC_26 / SVC_32)
+	.long	__irq_svc_default		@  3  (SVC_26 / SVC_32)
 	.long	__irq_invalid			@  4
 	.long	__irq_invalid			@  5
 	.long	__irq_invalid			@  6
