From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 25 Aug 2015 16:42:03 +0100
Subject: [PATCH v2 09/10] ARM: entry: provide uaccess assembly macro hooks
In-Reply-To: <20150825154026.GT7557@n2100.arm.linux.org.uk>
References: <20150825154026.GT7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZUGMN-00007p-4V@rmk-PC.arm.linux.org.uk>
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
 arch/arm/include/asm/assembler.h | 17 +++++++++++++++++
 arch/arm/kernel/entry-armv.S     | 30 ++++++++++++++++++++++--------
 arch/arm/kernel/entry-common.S   |  2 ++
 arch/arm/kernel/entry-header.S   |  5 +++++
 arch/arm/mm/abort-ev4.S          |  1 +
 arch/arm/mm/abort-ev5t.S         |  1 +
 arch/arm/mm/abort-ev5tj.S        |  1 +
 arch/arm/mm/abort-ev6.S          |  7 ++++---
 arch/arm/mm/abort-ev7.S          |  1 +
 arch/arm/mm/abort-lv4t.S         |  2 ++
 arch/arm/mm/abort-macro.S        |  1 +
 11 files changed, 57 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 4abe57279c66..a91177043467 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -445,6 +445,23 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 #endif
 	.endm
 
+	.macro	uaccess_disable, tmp, isb=1
+	.endm
+
+	.macro	uaccess_enable, tmp, isb=1
+	.endm
+
+	.macro	uaccess_save, tmp
+	.endm
+
+	.macro	uaccess_restore
+	.endm
+
+	.macro	uaccess_save_and_disable, tmp
+	uaccess_save \tmp
+	uaccess_disable \tmp
+	.endm
+
 	.irp	c,,eq,ne,cs,cc,mi,pl,vs,vc,hi,ls,ge,lt,gt,le,hs,lo
 	.macro	ret\c, reg
 #if __LINUX_ARM_ARCH__ < 6
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index d19adcf6c580..61f00a3f3047 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -149,10 +149,10 @@ ENDPROC(__und_invalid)
 #define SPFIX(code...)
 #endif
 
-	.macro	svc_entry, stack_hole=0, trace=1
+	.macro	svc_entry, stack_hole=0, trace=1, uaccess=1
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
@@ -185,6 +185,11 @@ ENDPROC(__und_invalid)
 	@
 	stmia	r7, {r2 - r6}
 
+	uaccess_save r0
+	.if \uaccess
+	uaccess_disable r0
+	.endif
+
 	.if \trace
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bl	trace_hardirqs_off
@@ -194,7 +199,7 @@ ENDPROC(__und_invalid)
 
 	.align	5
 __dabt_svc:
-	svc_entry
+	svc_entry uaccess=0
 	mov	r2, sp
 	dabt_helper
  THUMB(	ldr	r5, [sp, #S_PSR]	)	@ potentially updated CPSR
@@ -368,7 +373,7 @@ ENDPROC(__fiq_abt)
 #error "sizeof(struct pt_regs) must be a multiple of 8"
 #endif
 
-	.macro	usr_entry, trace=1
+	.macro	usr_entry, trace=1, uaccess=1
  UNWIND(.fnstart	)
  UNWIND(.cantunwind	)	@ don't unwind the user space
 	sub	sp, sp, #S_FRAME_SIZE
@@ -400,6 +405,10 @@ ENDPROC(__fiq_abt)
  ARM(	stmdb	r0, {sp, lr}^			)
  THUMB(	store_user_sp_lr r0, r1, S_SP - S_PC	)
 
+	.if \uaccess
+	uaccess_disable ip
+	.endif
+
 	@ Enable the alignment trap while in kernel mode
  ATRAP(	teq	r8, r7)
  ATRAP( mcrne	p15, 0, r8, c1, c0, 0)
@@ -435,7 +444,7 @@ ENDPROC(__fiq_abt)
 
 	.align	5
 __dabt_usr:
-	usr_entry
+	usr_entry uaccess=0
 	kuser_cmpxchg_check
 	mov	r2, sp
 	dabt_helper
@@ -458,7 +467,7 @@ ENDPROC(__irq_usr)
 
 	.align	5
 __und_usr:
-	usr_entry
+	usr_entry uaccess=0
 
 	mov	r2, r4
 	mov	r3, r5
@@ -484,6 +493,8 @@ __und_usr:
 1:	ldrt	r0, [r4]
  ARM_BE8(rev	r0, r0)				@ little endian instruction
 
+	uaccess_disable ip
+
 	@ r0 = 32-bit ARM instruction which caused the exception
 	@ r2 = PC value for the following instruction (:= regs->ARM_pc)
 	@ r4 = PC value for the faulting instruction
@@ -518,9 +529,10 @@ __und_usr_thumb:
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
@@ -715,6 +727,8 @@ ENDPROC(no_fp)
 __und_usr_fault_32:
 	mov	r1, #4
 	b	1f
+__und_usr_fault_16_pan:
+	uaccess_disable ip
 __und_usr_fault_16:
 	mov	r1, #2
 1:	mov	r0, sp
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
index 1a0045abead7..220ac24900cc 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -215,6 +215,7 @@
 	blne	trace_hardirqs_off
 #endif
 	.endif
+	uaccess_restore
 	msr	spsr_cxsf, \rpsr
 #if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_32v6K)
 	@ We must avoid clrex due to Cortex-A15 erratum #830321
@@ -241,6 +242,7 @@
 	@ on the stack remains correct).
 	@
 	.macro  svc_exit_via_fiq
+	uaccess_restore
 	mov	r0, sp
 	ldmib	r0, {r1 - r14}	@ abort is deadly from here onward (it will
 				@ clobber state restored below)
@@ -253,6 +255,7 @@
 	.endm
 
 	.macro	restore_user_regs, fast = 0, offset = 0
+	uaccess_enable r1, isb=0
 	mov	r2, sp
 	ldr	r1, [r2, #\offset + S_PSR]	@ get calling cpsr
 	ldr	lr, [r2, #\offset + S_PC]!	@ get pc
@@ -329,6 +332,7 @@
 	 * part of each exception entry and exit sequence.
 	 */
 	.macro	restore_user_regs, fast = 0, offset = 0
+	uaccess_enable r1, isb=0
 	.if	\offset
 	add	sp, #\offset
 	.endif
@@ -336,6 +340,7 @@
 	.endm
 #else	/* ifdef CONFIG_CPU_V7M */
 	.macro	restore_user_regs, fast = 0, offset = 0
+	uaccess_enable r1, isb=0
 	mov	r2, sp
 	load_user_sp_lr r2, r3, \offset + S_SP	@ calling sp, lr
 	ldr	r1, [sp, #\offset + S_PSR]	@ get calling cpsr
diff --git a/arch/arm/mm/abort-ev4.S b/arch/arm/mm/abort-ev4.S
index 54473cd4aba9..b3b31e30cadd 100644
--- a/arch/arm/mm/abort-ev4.S
+++ b/arch/arm/mm/abort-ev4.S
@@ -19,6 +19,7 @@ ENTRY(v4_early_abort)
 	mrc	p15, 0, r1, c5, c0, 0		@ get FSR
 	mrc	p15, 0, r0, c6, c0, 0		@ get FAR
 	ldr	r3, [r4]			@ read aborted ARM instruction
+	uaccess_disable ip			@ disable userspace access
 	bic	r1, r1, #1 << 11 | 1 << 10	@ clear bits 11 and 10 of FSR
 	tst	r3, #1 << 20			@ L = 1 -> write?
 	orreq	r1, r1, #1 << 11		@ yes.
diff --git a/arch/arm/mm/abort-ev5t.S b/arch/arm/mm/abort-ev5t.S
index c913031b79cc..a6a381a6caa5 100644
--- a/arch/arm/mm/abort-ev5t.S
+++ b/arch/arm/mm/abort-ev5t.S
@@ -21,6 +21,7 @@ ENTRY(v5t_early_abort)
 	mrc	p15, 0, r0, c6, c0, 0		@ get FAR
 	do_thumb_abort fsr=r1, pc=r4, psr=r5, tmp=r3
 	ldreq	r3, [r4]			@ read aborted ARM instruction
+	uaccess_disable ip			@ disable user access
 	bic	r1, r1, #1 << 11		@ clear bits 11 of FSR
 	teq_ldrd tmp=ip, insn=r3		@ insn was LDRD?
 	beq	do_DataAbort			@ yes
diff --git a/arch/arm/mm/abort-ev5tj.S b/arch/arm/mm/abort-ev5tj.S
index 1b80d71adb0f..00ab011bef58 100644
--- a/arch/arm/mm/abort-ev5tj.S
+++ b/arch/arm/mm/abort-ev5tj.S
@@ -24,6 +24,7 @@ ENTRY(v5tj_early_abort)
 	bne	do_DataAbort
 	do_thumb_abort fsr=r1, pc=r4, psr=r5, tmp=r3
 	ldreq	r3, [r4]			@ read aborted ARM instruction
+	uaccess_disable ip			@ disable userspace access
 	teq_ldrd tmp=ip, insn=r3		@ insn was LDRD?
 	beq	do_DataAbort			@ yes
 	tst	r3, #1 << 20			@ L = 0 -> write
diff --git a/arch/arm/mm/abort-ev6.S b/arch/arm/mm/abort-ev6.S
index 113704f30e9f..8801a15aa105 100644
--- a/arch/arm/mm/abort-ev6.S
+++ b/arch/arm/mm/abort-ev6.S
@@ -26,17 +26,18 @@ ENTRY(v6_early_abort)
 	ldr	ip, =0x4107b36
 	mrc	p15, 0, r3, c0, c0, 0		@ get processor id
 	teq	ip, r3, lsr #4			@ r0 ARM1136?
-	bne	do_DataAbort
+	bne	1f
 	tst	r5, #PSR_J_BIT			@ Java?
 	tsteq	r5, #PSR_T_BIT			@ Thumb?
-	bne	do_DataAbort
+	bne	1f
 	bic	r1, r1, #1 << 11		@ clear bit 11 of FSR
 	ldr	r3, [r4]			@ read aborted ARM instruction
  ARM_BE8(rev	r3, r3)
 
 	teq_ldrd tmp=ip, insn=r3		@ insn was LDRD?
-	beq	do_DataAbort			@ yes
+	beq	1f				@ yes
 	tst	r3, #1 << 20			@ L = 0 -> write
 	orreq	r1, r1, #1 << 11		@ yes.
 #endif
+1:	uaccess_disable ip			@ disable userspace access
 	b	do_DataAbort
diff --git a/arch/arm/mm/abort-ev7.S b/arch/arm/mm/abort-ev7.S
index 4812ad054214..e8d0e08c227f 100644
--- a/arch/arm/mm/abort-ev7.S
+++ b/arch/arm/mm/abort-ev7.S
@@ -15,6 +15,7 @@
 ENTRY(v7_early_abort)
 	mrc	p15, 0, r1, c5, c0, 0		@ get FSR
 	mrc	p15, 0, r0, c6, c0, 0		@ get FAR
+	uaccess_disable ip			@ disable userspace access
 
 	/*
 	 * V6 code adjusts the returned DFSR.
diff --git a/arch/arm/mm/abort-lv4t.S b/arch/arm/mm/abort-lv4t.S
index f3982580c273..6d8e8e3365d1 100644
--- a/arch/arm/mm/abort-lv4t.S
+++ b/arch/arm/mm/abort-lv4t.S
@@ -26,6 +26,7 @@ ENTRY(v4t_late_abort)
 #endif
 	bne	.data_thumb_abort
 	ldr	r8, [r4]			@ read arm instruction
+	uaccess_disable ip			@ disable userspace access
 	tst	r8, #1 << 20			@ L = 1 -> write?
 	orreq	r1, r1, #1 << 11		@ yes.
 	and	r7, r8, #15 << 24
@@ -155,6 +156,7 @@ ENTRY(v4t_late_abort)
 
 .data_thumb_abort:
 	ldrh	r8, [r4]			@ read instruction
+	uaccess_disable ip			@ disable userspace access
 	tst	r8, #1 << 11			@ L = 1 -> write?
 	orreq	r1, r1, #1 << 8			@ yes
 	and	r7, r8, #15 << 12
diff --git a/arch/arm/mm/abort-macro.S b/arch/arm/mm/abort-macro.S
index 50d6c0a900b1..4509bee4e081 100644
--- a/arch/arm/mm/abort-macro.S
+++ b/arch/arm/mm/abort-macro.S
@@ -13,6 +13,7 @@
 	tst	\psr, #PSR_T_BIT
 	beq	not_thumb
 	ldrh	\tmp, [\pc]			@ Read aborted Thumb instruction
+	uaccess_disable ip			@ disable userspace access
 	and	\tmp, \tmp, # 0xfe00		@ Mask opcode field
 	cmp	\tmp, # 0x5600			@ Is it ldrsb?
 	orreq	\tmp, \tmp, #1 << 11		@ Set L-bit if yes
-- 
2.1.0
