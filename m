From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Oct 2016 19:10:51 +0100
Subject: 4.7.6->4.8.1 Possible regression
In-Reply-To: <1476722858.483756177@f140.i.mail.ru>
References: <1476722858.483756177@f140.i.mail.ru>
Message-ID: <20161017181051.GI1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 07:47:38PM +0300, Alexander Shiyan wrote:
> Hello.
> 
> After a kernel update from 4.7.6 to 4.8.1, the bug appear once kernel run "init".

Please try this patch, thanks:

diff --git a/arch/arm/mm/abort-lv4t.S b/arch/arm/mm/abort-lv4t.S
index 6d8e8e3365d1..e81d09f1887d 100644
--- a/arch/arm/mm/abort-lv4t.S
+++ b/arch/arm/mm/abort-lv4t.S
@@ -48,7 +48,10 @@ ENTRY(v4t_late_abort)
 /* c */	b	do_DataAbort			@ ldc	rd, [rn], #m	@ Same as ldr	rd, [rn], #m
 /* d */	b	do_DataAbort			@ ldc	rd, [rn, #m]
 /* e */	b	.data_unknown
-/* f */
+/* f */	b	.data_unknown
+
+.data_unknown_r9:
+	ldr	r9, [sp], #4
 .data_unknown:	@ Part of jumptable
 	mov	r0, r4
 	mov	r1, r8
@@ -57,6 +60,7 @@ ENTRY(v4t_late_abort)
 .data_arm_ldmstm:
 	tst	r8, #1 << 21			@ check writeback bit
 	beq	do_DataAbort			@ no writeback -> no fixup
+	str	r9, [sp, #-4]!
 	mov	r7, #0x11
 	orr	r7, r7, #0x1100
 	and	r6, r8, r7
@@ -75,12 +79,14 @@ ENTRY(v4t_late_abort)
 	subne	r7, r7, r6, lsl #2		@ Undo increment
 	addeq	r7, r7, r6, lsl #2		@ Undo decrement
 	str	r7, [r2, r9, lsr #14]		@ Put register 'Rn'
+	ldr	r9, [sp], #4
 	b	do_DataAbort
 
 .data_arm_lateldrhpre:
 	tst	r8, #1 << 21			@ Check writeback bit
 	beq	do_DataAbort			@ No writeback -> no fixup
 .data_arm_lateldrhpost:
+	str	r9, [sp, #-4]!
 	and	r9, r8, #0x00f			@ get Rm / low nibble of immediate value
 	tst	r8, #1 << 22			@ if (immediate offset)
 	andne	r6, r8, #0xf00			@ { immediate high nibble
@@ -93,6 +99,7 @@ ENTRY(v4t_late_abort)
 	subne	r7, r7, r6			@ Undo incrmenet
 	addeq	r7, r7, r6			@ Undo decrement
 	str	r7, [r2, r9, lsr #14]		@ Put register 'Rn'
+	ldr	r9, [sp], #4
 	b	do_DataAbort
 
 .data_arm_lateldrpreconst:
@@ -101,12 +108,14 @@ ENTRY(v4t_late_abort)
 .data_arm_lateldrpostconst:
 	movs	r6, r8, lsl #20			@ Get offset
 	beq	do_DataAbort			@ zero -> no fixup
+	str	r9, [sp, #-4]!
 	and	r9, r8, #15 << 16		@ Extract 'n' from instruction
 	ldr	r7, [r2, r9, lsr #14]		@ Get register 'Rn'
 	tst	r8, #1 << 23			@ Check U bit
 	subne	r7, r7, r6, lsr #20		@ Undo increment
 	addeq	r7, r7, r6, lsr #20		@ Undo decrement
 	str	r7, [r2, r9, lsr #14]		@ Put register 'Rn'
+	ldr	r9, [sp], #4
 	b	do_DataAbort
 
 .data_arm_lateldrprereg:
@@ -115,6 +124,7 @@ ENTRY(v4t_late_abort)
 .data_arm_lateldrpostreg:
 	and	r7, r8, #15			@ Extract 'm' from instruction
 	ldr	r6, [r2, r7, lsl #2]		@ Get register 'Rm'
+	str	r9, [sp, #-4]!
 	mov	r9, r8, lsr #7			@ get shift count
 	ands	r9, r9, #31
 	and	r7, r8, #0x70			@ get shift type
@@ -126,33 +136,33 @@ ENTRY(v4t_late_abort)
 	b	.data_arm_apply_r6_and_rn
 	b	.data_arm_apply_r6_and_rn	@ 1: LSL #0
 	nop
-	b	.data_unknown			@ 2: MUL?
+	b	.data_unknown_r9		@ 2: MUL?
 	nop
-	b	.data_unknown			@ 3: MUL?
+	b	.data_unknown_r9		@ 3: MUL?
 	nop
 	mov	r6, r6, lsr r9			@ 4: LSR #!0
 	b	.data_arm_apply_r6_and_rn
 	mov	r6, r6, lsr #32			@ 5: LSR #32
 	b	.data_arm_apply_r6_and_rn
-	b	.data_unknown			@ 6: MUL?
+	b	.data_unknown_r9		@ 6: MUL?
 	nop
-	b	.data_unknown			@ 7: MUL?
+	b	.data_unknown_r9		@ 7: MUL?
 	nop
 	mov	r6, r6, asr r9			@ 8: ASR #!0
 	b	.data_arm_apply_r6_and_rn
 	mov	r6, r6, asr #32			@ 9: ASR #32
 	b	.data_arm_apply_r6_and_rn
-	b	.data_unknown			@ A: MUL?
+	b	.data_unknown_r9		@ A: MUL?
 	nop
-	b	.data_unknown			@ B: MUL?
+	b	.data_unknown_r9		@ B: MUL?
 	nop
 	mov	r6, r6, ror r9			@ C: ROR #!0
 	b	.data_arm_apply_r6_and_rn
 	mov	r6, r6, rrx			@ D: RRX
 	b	.data_arm_apply_r6_and_rn
-	b	.data_unknown			@ E: MUL?
+	b	.data_unknown_r9		@ E: MUL?
 	nop
-	b	.data_unknown			@ F: MUL?
+	b	.data_unknown_r9		@ F: MUL?
 
 .data_thumb_abort:
 	ldrh	r8, [r4]			@ read instruction
@@ -190,6 +200,7 @@ ENTRY(v4t_late_abort)
 .data_thumb_pushpop:
 	tst	r8, #1 << 10
 	beq	.data_unknown
+	str	r9, [sp, #-4]!
 	and	r6, r8, #0x55			@ hweight8(r8) + R bit
 	and	r9, r8, #0xaa
 	add	r6, r6, r9, lsr #1
@@ -204,9 +215,11 @@ ENTRY(v4t_late_abort)
 	addeq	r7, r7, r6, lsl #2		@ increment SP if PUSH
 	subne	r7, r7, r6, lsl #2		@ decrement SP if POP
 	str	r7, [r2, #13 << 2]
+	ldr	r9, [sp], #4
 	b	do_DataAbort
 
 .data_thumb_ldmstm:
+	str	r9, [sp, #-4]!
 	and	r6, r8, #0x55			@ hweight8(r8)
 	and	r9, r8, #0xaa
 	add	r6, r6, r9, lsr #1
@@ -219,4 +232,5 @@ ENTRY(v4t_late_abort)
 	and	r6, r6, #15			@ number of regs to transfer
 	sub	r7, r7, r6, lsl #2		@ always decrement
 	str	r7, [r2, r9, lsr #6]
+	ldr	r9, [sp], #4
 	b	do_DataAbort


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently@9.6Mbps down 400kbps up
according to speedtest.net.
