From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jun 2011 10:25:16 +0100
Subject: [PATCH 19/23] ARM: entry: data abort: tail-call the main data abort
	handler
In-Reply-To: <20110629091853.GK21898@n2100.arm.linux.org.uk>
References: <20110629091853.GK21898@n2100.arm.linux.org.uk>
Message-ID: <E1Qbr1I-0002GR-1F@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tail-call the main C data abort handler code from the per-CPU helper
code.  Update the comments in the code wrt the new calling and return
register state.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/entry-armv.S |   14 +++---------
 arch/arm/mm/abort-ev4.S      |   11 +++------
 arch/arm/mm/abort-ev4t.S     |   11 +++------
 arch/arm/mm/abort-ev5t.S     |   11 +++------
 arch/arm/mm/abort-ev5tj.S    |   13 ++++-------
 arch/arm/mm/abort-ev6.S      |   13 ++++-------
 arch/arm/mm/abort-ev7.S      |   15 +++++--------
 arch/arm/mm/abort-lv4t.S     |   43 ++++++++++++++++++++---------------------
 arch/arm/mm/abort-macro.S    |    4 +-
 arch/arm/mm/abort-nommu.S    |    8 +++---
 arch/arm/mm/proc-arm6_7.S    |   29 +++++++++++++--------------
 11 files changed, 73 insertions(+), 99 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 36c9409..3fa90ae 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -60,6 +60,7 @@
 	@
 	@ Call the processor-specific abort handler:
 	@
+	@  r2 - pt_regs
 	@  r4 - aborted context pc
 	@  r5 - aborted context psr
 	@
@@ -186,13 +187,8 @@ ENDPROC(__und_invalid)
 	.align	5
 __dabt_svc:
 	svc_entry
-	dabt_helper
-
-	@
-	@ call main handler
-	@
 	mov	r2, sp
-	bl	do_DataAbort
+	dabt_helper
 
 	@
 	@ IRQs off again before pulling preserved data off the stack
@@ -407,11 +403,9 @@ ENDPROC(__pabt_svc)
 __dabt_usr:
 	usr_entry
 	kuser_cmpxchg_check
-	dabt_helper
-
 	mov	r2, sp
-	adr	lr, BSYM(ret_from_exception)
-	b	do_DataAbort
+	dabt_helper
+	b	ret_from_exception
  UNWIND(.fnend		)
 ENDPROC(__dabt_usr)
 
diff --git a/arch/arm/mm/abort-ev4.S b/arch/arm/mm/abort-ev4.S
index beb112b..54473cd 100644
--- a/arch/arm/mm/abort-ev4.S
+++ b/arch/arm/mm/abort-ev4.S
@@ -3,14 +3,11 @@
 /*
  * Function: v4_early_abort
  *
- * Params  : r4 = aborted context pc
+ * Params  : r2 = pt_regs
+ *	   : r4 = aborted context pc
  *	   : r5 = aborted context psr
  *
- * Returns : r0 = address of abort
- *	   : r1 = FSR, bit 11 = write
- *	   : r2-r8 = corrupted
- *	   : r9 = preserved
- *	   : sp = pointer to registers
+ * Returns : r4 - r11, r13 preserved
  *
  * Purpose : obtain information about current aborted instruction.
  * Note: we read user space.  This means we might cause a data
@@ -25,4 +22,4 @@ ENTRY(v4_early_abort)
 	bic	r1, r1, #1 << 11 | 1 << 10	@ clear bits 11 and 10 of FSR
 	tst	r3, #1 << 20			@ L = 1 -> write?
 	orreq	r1, r1, #1 << 11		@ yes.
-	mov	pc, lr
+	b	do_DataAbort
diff --git a/arch/arm/mm/abort-ev4t.S b/arch/arm/mm/abort-ev4t.S
index eaa4ac0..9da704e 100644
--- a/arch/arm/mm/abort-ev4t.S
+++ b/arch/arm/mm/abort-ev4t.S
@@ -4,14 +4,11 @@
 /*
  * Function: v4t_early_abort
  *
- * Params  : r4 = aborted context pc
+ * Params  : r2 = pt_regs
+ *	   : r4 = aborted context pc
  *	   : r5 = aborted context psr
  *
- * Returns : r0 = address of abort
- *	   : r1 = FSR, bit 11 = write
- *	   : r2-r8 = corrupted
- *	   : r9 = preserved
- *	   : sp = pointer to registers
+ * Returns : r4 - r11, r13 preserved
  *
  * Purpose : obtain information about current aborted instruction.
  * Note: we read user space.  This means we might cause a data
@@ -27,4 +24,4 @@ ENTRY(v4t_early_abort)
 	bic	r1, r1, #1 << 11 | 1 << 10	@ clear bits 11 and 10 of FSR
 	tst	r3, #1 << 20			@ check write
 	orreq	r1, r1, #1 << 11
-	mov	pc, lr
+	b	do_DataAbort
diff --git a/arch/arm/mm/abort-ev5t.S b/arch/arm/mm/abort-ev5t.S
index 751391a..a0908d4 100644
--- a/arch/arm/mm/abort-ev5t.S
+++ b/arch/arm/mm/abort-ev5t.S
@@ -4,14 +4,11 @@
 /*
  * Function: v5t_early_abort
  *
- * Params  : r4 = aborted context pc
+ * Params  : r2 = pt_regs
+ *	   : r4 = aborted context pc
  *	   : r5 = aborted context psr
  *
- * Returns : r0 = address of abort
- *	   : r1 = FSR, bit 11 = write
- *	   : r2-r8 = corrupted
- *	   : r9 = preserved
- *	   : sp = pointer to registers
+ * Returns : r4 - r11, r13 preserved
  *
  * Purpose : obtain information about current aborted instruction.
  * Note: we read user space.  This means we might cause a data
@@ -28,4 +25,4 @@ ENTRY(v5t_early_abort)
 	do_ldrd_abort tmp=ip, insn=r3
 	tst	r3, #1 << 20			@ check write
 	orreq	r1, r1, #1 << 11
-	mov	pc, lr
+	b	do_DataAbort
diff --git a/arch/arm/mm/abort-ev5tj.S b/arch/arm/mm/abort-ev5tj.S
index ccfbc93..4006b7a 100644
--- a/arch/arm/mm/abort-ev5tj.S
+++ b/arch/arm/mm/abort-ev5tj.S
@@ -4,14 +4,11 @@
 /*
  * Function: v5tj_early_abort
  *
- * Params  : r4 = aborted context pc
+ * Params  : r2 = pt_regs
+ *	   : r4 = aborted context pc
  *	   : r5 = aborted context psr
  *
- * Returns : r0 = address of abort
- *	   : r1 = FSR, bit 11 = write
- *	   : r2-r8 = corrupted
- *	   : r9 = preserved
- *	   : sp = pointer to registers
+ * Returns : r4 - r11, r13 preserved
  *
  * Purpose : obtain information about current aborted instruction.
  * Note: we read user space.  This means we might cause a data
@@ -24,10 +21,10 @@ ENTRY(v5tj_early_abort)
 	mrc	p15, 0, r0, c6, c0, 0		@ get FAR
 	bic	r1, r1, #1 << 11 | 1 << 10	@ clear bits 11 and 10 of FSR
 	tst	r5, #PSR_J_BIT			@ Java?
-	movne	pc, lr
+	bne	do_DataAbort
 	do_thumb_abort fsr=r1, pc=r4, psr=r5, tmp=r3
 	ldreq	r3, [r4]			@ read aborted ARM instruction
 	do_ldrd_abort tmp=ip, insn=r3
 	tst	r3, #1 << 20			@ L = 0 -> write
 	orreq	r1, r1, #1 << 11		@ yes.
-	mov	pc, lr
+	b	do_DataAbort
diff --git a/arch/arm/mm/abort-ev6.S b/arch/arm/mm/abort-ev6.S
index b64d886..ff1f7cc 100644
--- a/arch/arm/mm/abort-ev6.S
+++ b/arch/arm/mm/abort-ev6.S
@@ -4,14 +4,11 @@
 /*
  * Function: v6_early_abort
  *
- * Params  : r4 = aborted context pc
+ * Params  : r2 = pt_regs
+ *	   : r4 = aborted context pc
  *	   : r5 = aborted context psr
  *
- * Returns : r0 = address of abort
- *	   : r1 = FSR, bit 11 = write
- *	   : r2-r8 = corrupted
- *	   : r9 = preserved
- *	   : sp = pointer to registers
+ * Returns : r4 - r11, r13 preserved
  *
  * Purpose : obtain information about current aborted instruction.
  * Note: we read user space.  This means we might cause a data
@@ -34,7 +31,7 @@ ENTRY(v6_early_abort)
  */
 	bic	r1, r1, #1 << 11		@ clear bit 11 of FSR
 	tst	r5, #PSR_J_BIT			@ Java?
-	movne	pc, lr
+	bne	do_DataAbort
 	do_thumb_abort fsr=r1, pc=r4, psr=r5, tmp=r3
 	ldreq	r3, [r4]			@ read aborted ARM instruction
 #ifdef CONFIG_CPU_ENDIAN_BE8
@@ -43,4 +40,4 @@ ENTRY(v6_early_abort)
 	do_ldrd_abort tmp=ip, insn=r3
 	tst	r3, #1 << 20			@ L = 0 -> write
 	orreq	r1, r1, #1 << 11		@ yes.
-	mov	pc, lr
+	b	do_DataAbort
diff --git a/arch/arm/mm/abort-ev7.S b/arch/arm/mm/abort-ev7.S
index 6f98b3a..7033752 100644
--- a/arch/arm/mm/abort-ev7.S
+++ b/arch/arm/mm/abort-ev7.S
@@ -3,14 +3,11 @@
 /*
  * Function: v7_early_abort
  *
- * Params  : r4 = aborted context pc
+ * Params  : r2 = pt_regs
+ *	   : r4 = aborted context pc
  *	   : r5 = aborted context psr
  *
- * Returns : r0 = address of abort
- *	   : r1 = FSR, bit 11 = write
- *	   : r2-r8 = corrupted
- *	   : r9 = preserved
- *	   : sp = pointer to registers
+ * Returns : r4 - r11, r13 preserved
  *
  * Purpose : obtain information about current aborted instruction.
  */
@@ -37,18 +34,18 @@ ENTRY(v7_early_abort)
 	ldr	r3, =0x40d			@ On permission fault
 	and	r3, r1, r3
 	cmp	r3, #0x0d
-	movne	pc, lr
+	bne	do_DataAbort
 
 	mcr	p15, 0, r0, c7, c8, 0   	@ Retranslate FAR
 	isb
 	mrc	p15, 0, ip, c7, c4, 0   	@ Read the PAR
 	and	r3, ip, #0x7b   		@ On translation fault
 	cmp	r3, #0x0b
-	movne	pc, lr
+	bne	do_DataAbort
 	bic	r1, r1, #0xf			@ Fix up FSR FS[5:0]
 	and	ip, ip, #0x7e
 	orr	r1, r1, ip, LSR #1
 #endif
 
-	mov	pc, lr
+	b	do_DataAbort
 ENDPROC(v7_early_abort)
diff --git a/arch/arm/mm/abort-lv4t.S b/arch/arm/mm/abort-lv4t.S
index d032b1f..d432f31 100644
--- a/arch/arm/mm/abort-lv4t.S
+++ b/arch/arm/mm/abort-lv4t.S
@@ -3,7 +3,8 @@
 /*
  * Function: v4t_late_abort
  *
- * Params  : r4 = aborted context pc
+ * Params  : r2 = pt_regs
+ *	   : r4 = aborted context pc
  *	   : r5 = aborted context psr
  *
  * Returns : r0 = address of abort
@@ -47,20 +48,18 @@ ENTRY(v4t_late_abort)
 /* 9 */	b	.data_arm_ldmstm		@ ldm*b	rn, <rlist>
 /* a */	b	.data_unknown
 /* b */	b	.data_unknown
-/* c */	mov	pc, lr				@ ldc	rd, [rn], #m	@ Same as ldr	rd, [rn], #m
-/* d */	mov	pc, lr				@ ldc	rd, [rn, #m]
+/* c */	b	do_DataAbort			@ ldc	rd, [rn], #m	@ Same as ldr	rd, [rn], #m
+/* d */	b	do_DataAbort			@ ldc	rd, [rn, #m]
 /* e */	b	.data_unknown
 /* f */
 .data_unknown:	@ Part of jumptable
 	mov	r0, r4
 	mov	r1, r8
-	mov	r2, sp
-	bl	baddataabort
-	b	ret_from_exception
+	b	baddataabort
 
 .data_arm_ldmstm:
 	tst	r8, #1 << 21			@ check writeback bit
-	moveq	pc, lr				@ no writeback -> no fixup
+	beq	do_DataAbort			@ no writeback -> no fixup
 	mov	r7, #0x11
 	orr	r7, r7, #0x1100
 	and	r6, r8, r7
@@ -79,11 +78,11 @@ ENTRY(v4t_late_abort)
 	subne	r7, r7, r6, lsl #2		@ Undo increment
 	addeq	r7, r7, r6, lsl #2		@ Undo decrement
 	str	r7, [sp, r5, lsr #14]		@ Put register 'Rn'
-	mov	pc, lr
+	b	do_DataAbort
 
 .data_arm_lateldrhpre:
 	tst	r8, #1 << 21			@ Check writeback bit
-	moveq	pc, lr				@ No writeback -> no fixup
+	beq	do_DataAbort			@ No writeback -> no fixup
 .data_arm_lateldrhpost:
 	and	r5, r8, #0x00f			@ get Rm / low nibble of immediate value
 	tst	r8, #1 << 22			@ if (immediate offset)
@@ -97,25 +96,25 @@ ENTRY(v4t_late_abort)
 	subne	r7, r7, r6			@ Undo incrmenet
 	addeq	r7, r7, r6			@ Undo decrement
 	str	r7, [sp, r5, lsr #14]		@ Put register 'Rn'
-	mov	pc, lr
+	b	do_DataAbort
 
 .data_arm_lateldrpreconst:
 	tst	r8, #1 << 21			@ check writeback bit
-	moveq	pc, lr				@ no writeback -> no fixup
+	beq	do_DataAbort			@ no writeback -> no fixup
 .data_arm_lateldrpostconst:
 	movs	r9, r8, lsl #20			@ Get offset
-	moveq	pc, lr				@ zero -> no fixup
+	beq	do_DataAbort			@ zero -> no fixup
 	and	r5, r8, #15 << 16		@ Extract 'n' from instruction
 	ldr	r7, [sp, r5, lsr #14]		@ Get register 'Rn'
 	tst	r8, #1 << 23			@ Check U bit
 	subne	r7, r7, r9, lsr #20		@ Undo increment
 	addeq	r7, r7, r9, lsr #20		@ Undo decrement
 	str	r7, [sp, r5, lsr #14]		@ Put register 'Rn'
-	mov	pc, lr
+	b	do_DataAbort
 
 .data_arm_lateldrprereg:
 	tst	r8, #1 << 21			@ check writeback bit
-	moveq	pc, lr				@ no writeback -> no fixup
+	beq	do_DataAbort			@ no writeback -> no fixup
 .data_arm_lateldrpostreg:
 	and	r7, r8, #15			@ Extract 'm' from instruction
 	ldr	r6, [sp, r7, lsl #2]		@ Get register 'Rm'
@@ -172,10 +171,10 @@ ENTRY(v4t_late_abort)
 /* 3 */	b	.data_unknown
 /* 4 */	b	.data_unknown
 /* 5 */	b	.data_thumb_reg
-/* 6 */	mov	pc, lr
-/* 7 */	mov	pc, lr
-/* 8 */	mov	pc, lr
-/* 9 */	mov	pc, lr
+/* 6 */	b	do_DataAbort
+/* 7 */	b	do_DataAbort
+/* 8 */	b	do_DataAbort
+/* 9 */	b	do_DataAbort
 /* A */	b	.data_unknown
 /* B */	b	.data_thumb_pushpop
 /* C */	b	.data_thumb_ldmstm
@@ -185,10 +184,10 @@ ENTRY(v4t_late_abort)
 
 .data_thumb_reg:
 	tst	r8, #1 << 9
-	moveq	pc, lr
+	beq	do_DataAbort
 	tst	r8, #1 << 10			@ If 'S' (signed) bit is set
 	movne	r1, #0				@ it must be a load instr
-	mov	pc, lr
+	b	do_DataAbort
 
 .data_thumb_pushpop:
 	tst	r8, #1 << 10
@@ -207,7 +206,7 @@ ENTRY(v4t_late_abort)
 	addeq	r7, r7, r6, lsl #2		@ increment SP if PUSH
 	subne	r7, r7, r6, lsl #2		@ decrement SP if POP
 	str	r7, [sp, #13 << 2]
-	mov	pc, lr
+	b	do_DataAbort
 
 .data_thumb_ldmstm:
 	and	r6, r8, #0x55			@ hweight8(r8)
@@ -222,4 +221,4 @@ ENTRY(v4t_late_abort)
 	and	r6, r6, #15			@ number of regs to transfer
 	sub	r7, r7, r6, lsl #2		@ always decrement
 	str	r7, [sp, r5, lsr #6]
-	mov	pc, lr
+	b	do_DataAbort
diff --git a/arch/arm/mm/abort-macro.S b/arch/arm/mm/abort-macro.S
index af97a10..52162d5 100644
--- a/arch/arm/mm/abort-macro.S
+++ b/arch/arm/mm/abort-macro.S
@@ -18,7 +18,7 @@
 	orreq	\tmp, \tmp, #1 << 11		@ Set L-bit if yes
 	tst	\tmp, #1 << 11			@ L = 0 -> write
 	orreq	\psr, \psr, #1 << 11		@ yes.
-	mov	pc, lr
+	b	do_DataAbort
 not_thumb:
 	.endm
 
@@ -34,7 +34,7 @@ not_thumb:
 	bne	not_ldrd
 	and	\tmp, \insn, #0x000000f0	@ [7:4] == 1101
 	cmp	\tmp, #0x000000d0
-	moveq	pc, lr
+	beq	do_DataAbort
 not_ldrd:
 	.endm
 
diff --git a/arch/arm/mm/abort-nommu.S b/arch/arm/mm/abort-nommu.S
index 9eaef6f..119cb47 100644
--- a/arch/arm/mm/abort-nommu.S
+++ b/arch/arm/mm/abort-nommu.S
@@ -3,11 +3,11 @@
 /*
  * Function: nommu_early_abort
  *
- * Params  : r4 = aborted context pc
+ * Params  : r2 = pt_regs
+ *	   : r4 = aborted context pc
  *	   : r5 = aborted context psr
  *
- * Returns : r0 = 0 (abort address)
- *	   : r1 = 0 (FSR)
+ * Returns : r4 - r11, r13 preserved
  *
  * Note: There is no FSR/FAR on !CPU_CP15_MMU cores.
  *       Just fill zero into the registers.
@@ -16,5 +16,5 @@
 ENTRY(nommu_early_abort)
 	mov	r0, #0				@ clear r0, r1 (no FSR/FAR)
 	mov	r1, #0
-	mov	pc, lr
+	b	do_DataAbort
 ENDPROC(nommu_early_abort)
diff --git a/arch/arm/mm/proc-arm6_7.S b/arch/arm/mm/proc-arm6_7.S
index d4c328e..d755d5b 100644
--- a/arch/arm/mm/proc-arm6_7.S
+++ b/arch/arm/mm/proc-arm6_7.S
@@ -29,7 +29,8 @@ ENTRY(cpu_arm7_dcache_clean_area)
 /*
  * Function: arm6_7_data_abort ()
  *
- * Params  : r4 = aborted context pc
+ * Params  : r2 = pt_regs
+ *	   : r4 = aborted context pc
  *	   : r5 = aborted context psr
  *
  * Purpose : obtain information about current aborted instruction
@@ -49,7 +50,7 @@ ENTRY(cpu_arm7_data_abort)
 	nop
 
 /* 0 */	b	.data_unknown
-/* 1 */	mov	pc, lr				@ swp
+/* 1 */	b	do_DataAbort			@ swp
 /* 2 */	b	.data_unknown
 /* 3 */	b	.data_unknown
 /* 4 */	b	.data_arm_lateldrpostconst	@ ldr	rd, [rn], #m
@@ -60,16 +61,14 @@ ENTRY(cpu_arm7_data_abort)
 /* 9 */	b	.data_arm_ldmstm		@ ldm*b	rn, <rlist>
 /* a */	b	.data_unknown
 /* b */	b	.data_unknown
-/* c */	mov	pc, lr				@ ldc	rd, [rn], #m	@ Same as ldr	rd, [rn], #m
-/* d */	mov	pc, lr				@ ldc	rd, [rn, #m]
+/* c */	b	do_DataAbort			@ ldc	rd, [rn], #m	@ Same as ldr	rd, [rn], #m
+/* d */	b	do_DataAbort			@ ldc	rd, [rn, #m]
 /* e */	b	.data_unknown
 /* f */
 .data_unknown:	@ Part of jumptable
 	mov	r0, r4
 	mov	r1, r8
-	mov	r2, sp
-	bl	baddataabort
-	b	ret_from_exception
+	b	baddataabort
 
 ENTRY(cpu_arm6_data_abort)
 	mrc	p15, 0, r1, c5, c0, 0		@ get FSR
@@ -79,11 +78,11 @@ ENTRY(cpu_arm6_data_abort)
 	orreq	r1, r1, #1 << 11		@ yes.
 	and	r7, r8, #14 << 24
 	teq	r7, #8 << 24			@ was it ldm/stm
-	movne	pc, lr
+	bne	do_DataAbort
 
 .data_arm_ldmstm:
 	tst	r8, #1 << 21			@ check writeback bit
-	moveq	pc, lr				@ no writeback -> no fixup
+	beq	do_DataAbort			@ no writeback -> no fixup
 	mov	r7, #0x11
 	orr	r7, r7, #0x1100
 	and	r6, r8, r7
@@ -102,7 +101,7 @@ ENTRY(cpu_arm6_data_abort)
 	subne	r7, r7, r6, lsl #2		@ Undo increment
 	addeq	r7, r7, r6, lsl #2		@ Undo decrement
 	str	r7, [sp, r5, lsr #14]		@ Put register 'Rn'
-	mov	pc, lr
+	b	do_DataAbort
 
 .data_arm_apply_r6_and_rn:
 	and	r5, r8, #15 << 16		@ Extract 'n' from instruction
@@ -111,25 +110,25 @@ ENTRY(cpu_arm6_data_abort)
 	subne	r7, r7, r6			@ Undo incrmenet
 	addeq	r7, r7, r6			@ Undo decrement
 	str	r7, [sp, r5, lsr #14]		@ Put register 'Rn'
-	mov	pc, lr
+	b	do_DataAbort
 
 .data_arm_lateldrpreconst:
 	tst	r8, #1 << 21			@ check writeback bit
-	moveq	pc, lr				@ no writeback -> no fixup
+	beq	do_DataAbort			@ no writeback -> no fixup
 .data_arm_lateldrpostconst:
 	movs	r9, r8, lsl #20			@ Get offset
-	moveq	pc, lr				@ zero -> no fixup
+	beq	do_DataAbort			@ zero -> no fixup
 	and	r5, r8, #15 << 16		@ Extract 'n' from instruction
 	ldr	r7, [sp, r5, lsr #14]		@ Get register 'Rn'
 	tst	r8, #1 << 23			@ Check U bit
 	subne	r7, r7, r9, lsr #20		@ Undo increment
 	addeq	r7, r7, r9, lsr #20		@ Undo decrement
 	str	r7, [sp, r5, lsr #14]		@ Put register 'Rn'
-	mov	pc, lr
+	b	do_DataAbort
 
 .data_arm_lateldrprereg:
 	tst	r8, #1 << 21			@ check writeback bit
-	moveq	pc, lr				@ no writeback -> no fixup
+	beq	do_DataAbort			@ no writeback -> no fixup
 .data_arm_lateldrpostreg:
 	and	r7, r8, #15			@ Extract 'm' from instruction
 	ldr	r6, [sp, r7, lsl #2]		@ Get register 'Rm'
-- 
1.7.4.4
