From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 21 Aug 2015 14:31:51 +0100
Subject: [PATCH 8/9] ARM: entry: provide uaccess assembly macro hooks
In-Reply-To: <20150821133043.GV7557@n2100.arm.linux.org.uk>
References: <20150821133043.GV7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZSmQB-0002zT-A6@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide hooks into the kernel entry and exit paths to permit control
of userspace visibility to the kernel.  The intended use is:

- on entry to kernel from user, uaccess_disable will be called to
  disable userspace visibility
- on exit from kernel to user, uaccess_enable will be called to
  enable userspace visibility
- on entry from a kernel exception, uaccess_save_and_disable will be
  called to save the current userspace visibility setting, and disable
  access
- on exit from a kernel exception, uaccess_restore will be called to
  restore the userspace visibility as it was before the exception
  occurred.

These hooks allows us to keep userspace visibility disabled for the
vast majority of the kernel, except for localised regions where we
want to explicitly access userspace.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/entry-armv.S   | 25 ++++++++++++++++++-------
 arch/arm/kernel/entry-common.S |  2 ++
 arch/arm/kernel/entry-header.S | 17 +++++++++++++++++
 3 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index d19adcf6c580..f6102b39517c 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -152,7 +152,7 @@ ENDPROC(__und_invalid)
 	.macro	svc_entry, stack_hole=0, trace=1
  UNWIND(.fnstart		)
  UNWIND(.save {r0 - pc}		)
-	sub	sp, sp, #(S_FRAME_SIZE + \stack_hole - 4)
+	sub	sp, sp, #(S_FRAME_SIZE + 8 + \stack_hole - 4)
 #ifdef CONFIG_THUMB2_KERNEL
  SPFIX(	str	r0, [sp]	)	@ temporarily saved
  SPFIX(	mov	r0, sp		)
@@ -167,7 +167,7 @@ ENDPROC(__und_invalid)
 	ldmia	r0, {r3 - r5}
 	add	r7, sp, #S_SP - 4	@ here for interlock avoidance
 	mov	r6, #-1			@  ""  ""      ""       ""
-	add	r2, sp, #(S_FRAME_SIZE + \stack_hole - 4)
+	add	r2, sp, #(S_FRAME_SIZE + 8 + \stack_hole - 4)
  SPFIX(	addeq	r2, r2, #4	)
 	str	r3, [sp, #-4]!		@ save the "real" r0 copied
 					@ from the exception stack
@@ -185,6 +185,8 @@ ENDPROC(__und_invalid)
 	@
 	stmia	r7, {r2 - r6}
 
+	uaccess_save_and_disable r0
+
 	.if \trace
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bl	trace_hardirqs_off
@@ -368,7 +370,7 @@ ENDPROC(__fiq_abt)
 #error "sizeof(struct pt_regs) must be a multiple of 8"
 #endif
 
-	.macro	usr_entry, trace=1
+	.macro	usr_entry, trace=1, uaccess=1
  UNWIND(.fnstart	)
  UNWIND(.cantunwind	)	@ don't unwind the user space
 	sub	sp, sp, #S_FRAME_SIZE
@@ -400,6 +402,10 @@ ENDPROC(__fiq_abt)
  ARM(	stmdb	r0, {sp, lr}^			)
  THUMB(	store_user_sp_lr r0, r1, S_SP - S_PC	)
 
+	.if \uaccess
+	uaccess_disable ip
+	.endif
+
 	@ Enable the alignment trap while in kernel mode
  ATRAP(	teq	r8, r7)
  ATRAP( mcrne	p15, 0, r8, c1, c0, 0)
@@ -458,7 +464,7 @@ ENDPROC(__irq_usr)
 
 	.align	5
 __und_usr:
-	usr_entry
+	usr_entry uaccess=0
 
 	mov	r2, r4
 	mov	r3, r5
@@ -484,6 +490,8 @@ __und_usr:
 1:	ldrt	r0, [r4]
  ARM_BE8(rev	r0, r0)				@ little endian instruction
 
+	uaccess_disable ip
+
 	@ r0 = 32-bit ARM instruction which caused the exception
 	@ r2 = PC value for the following instruction (:= regs->ARM_pc)
 	@ r4 = PC value for the faulting instruction
@@ -518,9 +526,10 @@ __und_usr_thumb:
 2:	ldrht	r5, [r4]
 ARM_BE8(rev16	r5, r5)				@ little endian instruction
 	cmp	r5, #0xe800			@ 32bit instruction if xx != 0
-	blo	__und_usr_fault_16		@ 16bit undefined instruction
+	blo	__und_usr_fault_16_pan		@ 16bit undefined instruction
 3:	ldrht	r0, [r2]
 ARM_BE8(rev16	r0, r0)				@ little endian instruction
+	uaccess_disable ip
 	add	r2, r2, #2			@ r2 is PC + 2, make it PC + 4
 	str	r2, [sp, #S_PC]			@ it's a 2x16bit instr, update
 	orr	r0, r0, r5, lsl #16
@@ -715,6 +724,8 @@ ENDPROC(no_fp)
 __und_usr_fault_32:
 	mov	r1, #4
 	b	1f
+__und_usr_fault_16_pan:
+	uaccess_disable ip
 __und_usr_fault_16:
 	mov	r1, #2
 1:	mov	r0, sp
@@ -769,7 +780,7 @@ ENTRY(__switch_to)
  THUMB(	str	lr, [ip], #4		   )
 	ldr	r4, [r2, #TI_TP_VALUE]
 	ldr	r5, [r2, #TI_TP_VALUE + 4]
-#ifdef CONFIG_CPU_USE_DOMAINS
+#if defined(CONFIG_CPU_USE_DOMAINS) || defined(CONFIG_CPU_SW_DOMAIN_PAN)
 	mrc	p15, 0, r6, c3, c0, 0		@ Get domain register
 	str	r6, [r1, #TI_CPU_DOMAIN]	@ Save old domain register
 	ldr	r6, [r2, #TI_CPU_DOMAIN]
@@ -780,7 +791,7 @@ ENTRY(__switch_to)
 	ldr	r8, =__stack_chk_guard
 	ldr	r7, [r7, #TSK_STACK_CANARY]
 #endif
-#ifdef CONFIG_CPU_USE_DOMAINS
+#if defined(CONFIG_CPU_USE_DOMAINS) || defined(CONFIG_CPU_SW_DOMAIN_PAN)
 	mcr	p15, 0, r6, c3, c0, 0		@ Set domain register
 #endif
 	mov	r5, r0
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 92828a1dec80..189154980703 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -173,6 +173,8 @@ ENTRY(vector_swi)
  USER(	ldr	scno, [lr, #-4]		)	@ get SWI instruction
 #endif
 
+	uaccess_disable tbl
+
 	adr	tbl, sys_call_table		@ load syscall table pointer
 
 #if defined(CONFIG_OABI_COMPAT)
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 1a0045abead7..3aa6c3742182 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -53,6 +53,18 @@
 #endif
 	.endm
 
+	.macro	uaccess_disable, tmp
+	.endm
+
+	.macro	uaccess_enable, tmp
+	.endm
+
+	.macro	uaccess_save_and_disable, tmp
+	.endm
+
+	.macro	uaccess_restore
+	.endm
+
 #ifdef CONFIG_CPU_V7M
 /*
  * ARMv7-M exception entry/exit macros.
@@ -215,6 +227,7 @@
 	blne	trace_hardirqs_off
 #endif
 	.endif
+	uaccess_restore
 	msr	spsr_cxsf, \rpsr
 #if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_32v6K)
 	@ We must avoid clrex due to Cortex-A15 erratum #830321
@@ -241,6 +254,7 @@
 	@ on the stack remains correct).
 	@
 	.macro  svc_exit_via_fiq
+	uaccess_restore
 	mov	r0, sp
 	ldmib	r0, {r1 - r14}	@ abort is deadly from here onward (it will
 				@ clobber state restored below)
@@ -253,6 +267,7 @@
 	.endm
 
 	.macro	restore_user_regs, fast = 0, offset = 0
+	uaccess_enable r1
 	mov	r2, sp
 	ldr	r1, [r2, #\offset + S_PSR]	@ get calling cpsr
 	ldr	lr, [r2, #\offset + S_PC]!	@ get pc
@@ -329,6 +344,7 @@
 	 * part of each exception entry and exit sequence.
 	 */
 	.macro	restore_user_regs, fast = 0, offset = 0
+	uaccess_enable r1
 	.if	\offset
 	add	sp, #\offset
 	.endif
@@ -336,6 +352,7 @@
 	.endm
 #else	/* ifdef CONFIG_CPU_V7M */
 	.macro	restore_user_regs, fast = 0, offset = 0
+	uaccess_enable r1
 	mov	r2, sp
 	load_user_sp_lr r2, r3, \offset + S_SP	@ calling sp, lr
 	ldr	r1, [sp, #\offset + S_PSR]	@ get calling cpsr
-- 
2.1.0
