From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jun 2011 10:26:16 +0100
Subject: [PATCH 22/23] ARM: entry: data abort: ensure r5 is preserved by
	abort functions
In-Reply-To: <20110629091853.GK21898@n2100.arm.linux.org.uk>
References: <20110629091853.GK21898@n2100.arm.linux.org.uk>
Message-ID: <E1Qbr2G-0002Ge-Ce@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/abort-lv4t.S  |   48 ++++++++++++++++++++------------------------
 arch/arm/mm/proc-arm6_7.S |   33 +++++++++++++++---------------
 2 files changed, 38 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mm/abort-lv4t.S b/arch/arm/mm/abort-lv4t.S
index 54b6d27..f398258 100644
--- a/arch/arm/mm/abort-lv4t.S
+++ b/arch/arm/mm/abort-lv4t.S
@@ -7,11 +7,7 @@
  *	   : r4 = aborted context pc
  *	   : r5 = aborted context psr
  *
- * Returns : r0 = address of abort
- *	   : r1 = FSR, bit 11 = write
- *	   : r2-r8 = corrupted
- *	   : r9 = preserved
- *	   : sp = pointer to registers
+ * Returns : r4-r5, r10-r11, r13 preserved
  *
  * Purpose : obtain information about current aborted instruction.
  * Note: we read user space.  This means we might cause a data
@@ -72,30 +68,30 @@ ENTRY(v4t_late_abort)
 	add	r6, r6, r6, lsr #8
 	add	r6, r6, r6, lsr #4
 	and	r6, r6, #15			@ r6 = no. of registers to transfer.
-	and	r5, r8, #15 << 16		@ Extract 'n' from instruction
-	ldr	r7, [r2, r5, lsr #14]		@ Get register 'Rn'
+	and	r9, r8, #15 << 16		@ Extract 'n' from instruction
+	ldr	r7, [r2, r9, lsr #14]		@ Get register 'Rn'
 	tst	r8, #1 << 23			@ Check U bit
 	subne	r7, r7, r6, lsl #2		@ Undo increment
 	addeq	r7, r7, r6, lsl #2		@ Undo decrement
-	str	r7, [r2, r5, lsr #14]		@ Put register 'Rn'
+	str	r7, [r2, r9, lsr #14]		@ Put register 'Rn'
 	b	do_DataAbort
 
 .data_arm_lateldrhpre:
 	tst	r8, #1 << 21			@ Check writeback bit
 	beq	do_DataAbort			@ No writeback -> no fixup
 .data_arm_lateldrhpost:
-	and	r5, r8, #0x00f			@ get Rm / low nibble of immediate value
+	and	r9, r8, #0x00f			@ get Rm / low nibble of immediate value
 	tst	r8, #1 << 22			@ if (immediate offset)
 	andne	r6, r8, #0xf00			@ { immediate high nibble
-	orrne	r6, r5, r6, lsr #4		@   combine nibbles } else
-	ldreq	r6, [r2, r5, lsl #2]		@ { load Rm value }
+	orrne	r6, r9, r6, lsr #4		@   combine nibbles } else
+	ldreq	r6, [r2, r9, lsl #2]		@ { load Rm value }
 .data_arm_apply_r6_and_rn:
-	and	r5, r8, #15 << 16		@ Extract 'n' from instruction
-	ldr	r7, [r2, r5, lsr #14]		@ Get register 'Rn'
+	and	r9, r8, #15 << 16		@ Extract 'n' from instruction
+	ldr	r7, [r2, r9, lsr #14]		@ Get register 'Rn'
 	tst	r8, #1 << 23			@ Check U bit
 	subne	r7, r7, r6			@ Undo incrmenet
 	addeq	r7, r7, r6			@ Undo decrement
-	str	r7, [r2, r5, lsr #14]		@ Put register 'Rn'
+	str	r7, [r2, r9, lsr #14]		@ Put register 'Rn'
 	b	do_DataAbort
 
 .data_arm_lateldrpreconst:
@@ -104,12 +100,12 @@ ENTRY(v4t_late_abort)
 .data_arm_lateldrpostconst:
 	movs	r6, r8, lsl #20			@ Get offset
 	beq	do_DataAbort			@ zero -> no fixup
-	and	r5, r8, #15 << 16		@ Extract 'n' from instruction
-	ldr	r7, [r2, r5, lsr #14]		@ Get register 'Rn'
+	and	r9, r8, #15 << 16		@ Extract 'n' from instruction
+	ldr	r7, [r2, r9, lsr #14]		@ Get register 'Rn'
 	tst	r8, #1 << 23			@ Check U bit
 	subne	r7, r7, r6, lsr #20		@ Undo increment
 	addeq	r7, r7, r6, lsr #20		@ Undo decrement
-	str	r7, [r2, r5, lsr #14]		@ Put register 'Rn'
+	str	r7, [r2, r9, lsr #14]		@ Put register 'Rn'
 	b	do_DataAbort
 
 .data_arm_lateldrprereg:
@@ -118,14 +114,14 @@ ENTRY(v4t_late_abort)
 .data_arm_lateldrpostreg:
 	and	r7, r8, #15			@ Extract 'm' from instruction
 	ldr	r6, [r2, r7, lsl #2]		@ Get register 'Rm'
-	mov	r5, r8, lsr #7			@ get shift count
-	ands	r5, r5, #31
+	mov	r9, r8, lsr #7			@ get shift count
+	ands	r9, r9, #31
 	and	r7, r8, #0x70			@ get shift type
 	orreq	r7, r7, #8			@ shift count = 0
 	add	pc, pc, r7
 	nop
 
-	mov	r6, r6, lsl r5			@ 0: LSL #!0
+	mov	r6, r6, lsl r9			@ 0: LSL #!0
 	b	.data_arm_apply_r6_and_rn
 	b	.data_arm_apply_r6_and_rn	@ 1: LSL #0
 	nop
@@ -133,7 +129,7 @@ ENTRY(v4t_late_abort)
 	nop
 	b	.data_unknown			@ 3: MUL?
 	nop
-	mov	r6, r6, lsr r5			@ 4: LSR #!0
+	mov	r6, r6, lsr r9			@ 4: LSR #!0
 	b	.data_arm_apply_r6_and_rn
 	mov	r6, r6, lsr #32			@ 5: LSR #32
 	b	.data_arm_apply_r6_and_rn
@@ -141,7 +137,7 @@ ENTRY(v4t_late_abort)
 	nop
 	b	.data_unknown			@ 7: MUL?
 	nop
-	mov	r6, r6, asr r5			@ 8: ASR #!0
+	mov	r6, r6, asr r9			@ 8: ASR #!0
 	b	.data_arm_apply_r6_and_rn
 	mov	r6, r6, asr #32			@ 9: ASR #32
 	b	.data_arm_apply_r6_and_rn
@@ -149,7 +145,7 @@ ENTRY(v4t_late_abort)
 	nop
 	b	.data_unknown			@ B: MUL?
 	nop
-	mov	r6, r6, ror r5			@ C: ROR #!0
+	mov	r6, r6, ror r9			@ C: ROR #!0
 	b	.data_arm_apply_r6_and_rn
 	mov	r6, r6, rrx			@ D: RRX
 	b	.data_arm_apply_r6_and_rn
@@ -216,9 +212,9 @@ ENTRY(v4t_late_abort)
 	and	r6, r6, #0x33
 	add	r6, r6, r9, lsr #2
 	add	r6, r6, r6, lsr #4
-	and	r5, r8, #7 << 8
-	ldr	r7, [r2, r5, lsr #6]
+	and	r9, r8, #7 << 8
+	ldr	r7, [r2, r9, lsr #6]
 	and	r6, r6, #15			@ number of regs to transfer
 	sub	r7, r7, r6, lsl #2		@ always decrement
-	str	r7, [r2, r5, lsr #6]
+	str	r7, [r2, r9, lsr #6]
 	b	do_DataAbort
diff --git a/arch/arm/mm/proc-arm6_7.S b/arch/arm/mm/proc-arm6_7.S
index 4d96311..50e3543 100644
--- a/arch/arm/mm/proc-arm6_7.S
+++ b/arch/arm/mm/proc-arm6_7.S
@@ -35,8 +35,7 @@ ENTRY(cpu_arm7_dcache_clean_area)
  *
  * Purpose : obtain information about current aborted instruction
  *
- * Returns : r0 = address of abort
- *	   : r1 = FSR
+ * Returns : r4-r5, r10-r11, r13 preserved
  */
 
 ENTRY(cpu_arm7_data_abort)
@@ -95,21 +94,21 @@ ENTRY(cpu_arm6_data_abort)
 	add	r6, r6, r6, lsr #8
 	add	r6, r6, r6, lsr #4
 	and	r6, r6, #15			@ r6 = no. of registers to transfer.
-	and	r5, r8, #15 << 16		@ Extract 'n' from instruction
-	ldr	r7, [r2, r5, lsr #14]		@ Get register 'Rn'
+	and	r9, r8, #15 << 16		@ Extract 'n' from instruction
+	ldr	r7, [r2, r9, lsr #14]		@ Get register 'Rn'
 	tst	r8, #1 << 23			@ Check U bit
 	subne	r7, r7, r6, lsl #2		@ Undo increment
 	addeq	r7, r7, r6, lsl #2		@ Undo decrement
-	str	r7, [r2, r5, lsr #14]		@ Put register 'Rn'
+	str	r7, [r2, r9, lsr #14]		@ Put register 'Rn'
 	b	do_DataAbort
 
 .data_arm_apply_r6_and_rn:
-	and	r5, r8, #15 << 16		@ Extract 'n' from instruction
-	ldr	r7, [r2, r5, lsr #14]		@ Get register 'Rn'
+	and	r9, r8, #15 << 16		@ Extract 'n' from instruction
+	ldr	r7, [r2, r9, lsr #14]		@ Get register 'Rn'
 	tst	r8, #1 << 23			@ Check U bit
 	subne	r7, r7, r6			@ Undo incrmenet
 	addeq	r7, r7, r6			@ Undo decrement
-	str	r7, [r2, r5, lsr #14]		@ Put register 'Rn'
+	str	r7, [r2, r9, lsr #14]		@ Put register 'Rn'
 	b	do_DataAbort
 
 .data_arm_lateldrpreconst:
@@ -118,12 +117,12 @@ ENTRY(cpu_arm6_data_abort)
 .data_arm_lateldrpostconst:
 	movs	r6, r8, lsl #20			@ Get offset
 	beq	do_DataAbort			@ zero -> no fixup
-	and	r5, r8, #15 << 16		@ Extract 'n' from instruction
-	ldr	r7, [r2, r5, lsr #14]		@ Get register 'Rn'
+	and	r9, r8, #15 << 16		@ Extract 'n' from instruction
+	ldr	r7, [r2, r9, lsr #14]		@ Get register 'Rn'
 	tst	r8, #1 << 23			@ Check U bit
 	subne	r7, r7, r6, lsr #20		@ Undo increment
 	addeq	r7, r7, r6, lsr #20		@ Undo decrement
-	str	r7, [r2, r5, lsr #14]		@ Put register 'Rn'
+	str	r7, [r2, r9, lsr #14]		@ Put register 'Rn'
 	b	do_DataAbort
 
 .data_arm_lateldrprereg:
@@ -132,14 +131,14 @@ ENTRY(cpu_arm6_data_abort)
 .data_arm_lateldrpostreg:
 	and	r7, r8, #15			@ Extract 'm' from instruction
 	ldr	r6, [r2, r7, lsl #2]		@ Get register 'Rm'
-	mov	r5, r8, lsr #7			@ get shift count
-	ands	r5, r5, #31
+	mov	r9, r8, lsr #7			@ get shift count
+	ands	r9, r9, #31
 	and	r7, r8, #0x70			@ get shift type
 	orreq	r7, r7, #8			@ shift count = 0
 	add	pc, pc, r7
 	nop
 
-	mov	r6, r6, lsl r5			@ 0: LSL #!0
+	mov	r6, r6, lsl r9			@ 0: LSL #!0
 	b	.data_arm_apply_r6_and_rn
 	b	.data_arm_apply_r6_and_rn	@ 1: LSL #0
 	nop
@@ -147,7 +146,7 @@ ENTRY(cpu_arm6_data_abort)
 	nop
 	b	.data_unknown			@ 3: MUL?
 	nop
-	mov	r6, r6, lsr r5			@ 4: LSR #!0
+	mov	r6, r6, lsr r9			@ 4: LSR #!0
 	b	.data_arm_apply_r6_and_rn
 	mov	r6, r6, lsr #32			@ 5: LSR #32
 	b	.data_arm_apply_r6_and_rn
@@ -155,7 +154,7 @@ ENTRY(cpu_arm6_data_abort)
 	nop
 	b	.data_unknown			@ 7: MUL?
 	nop
-	mov	r6, r6, asr r5			@ 8: ASR #!0
+	mov	r6, r6, asr r9			@ 8: ASR #!0
 	b	.data_arm_apply_r6_and_rn
 	mov	r6, r6, asr #32			@ 9: ASR #32
 	b	.data_arm_apply_r6_and_rn
@@ -163,7 +162,7 @@ ENTRY(cpu_arm6_data_abort)
 	nop
 	b	.data_unknown			@ B: MUL?
 	nop
-	mov	r6, r6, ror r5			@ C: ROR #!0
+	mov	r6, r6, ror r9			@ C: ROR #!0
 	b	.data_arm_apply_r6_and_rn
 	mov	r6, r6, rrx			@ D: RRX
 	b	.data_arm_apply_r6_and_rn
-- 
1.7.4.4
