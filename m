From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jun 2011 10:25:36 +0100
Subject: [PATCH 20/23] ARM: entry: data abort: use r2 as base of pt_regs
	rather than stack
In-Reply-To: <20110629091853.GK21898@n2100.arm.linux.org.uk>
References: <20110629091853.GK21898@n2100.arm.linux.org.uk>
Message-ID: <E1Qbr1c-0002GW-5C@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we pass r2 into these helper functions as the pointer to
pt_regs, use r2 as the base of the registers on the stack rather
than using the stack pointer directly.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/abort-lv4t.S  |   24 ++++++++++++------------
 arch/arm/mm/proc-arm6_7.S |   14 +++++++-------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mm/abort-lv4t.S b/arch/arm/mm/abort-lv4t.S
index d432f31..921aaab 100644
--- a/arch/arm/mm/abort-lv4t.S
+++ b/arch/arm/mm/abort-lv4t.S
@@ -73,11 +73,11 @@ ENTRY(v4t_late_abort)
 	add	r6, r6, r6, lsr #4
 	and	r6, r6, #15			@ r6 = no. of registers to transfer.
 	and	r5, r8, #15 << 16		@ Extract 'n' from instruction
-	ldr	r7, [sp, r5, lsr #14]		@ Get register 'Rn'
+	ldr	r7, [r2, r5, lsr #14]		@ Get register 'Rn'
 	tst	r8, #1 << 23			@ Check U bit
 	subne	r7, r7, r6, lsl #2		@ Undo increment
 	addeq	r7, r7, r6, lsl #2		@ Undo decrement
-	str	r7, [sp, r5, lsr #14]		@ Put register 'Rn'
+	str	r7, [r2, r5, lsr #14]		@ Put register 'Rn'
 	b	do_DataAbort
 
 .data_arm_lateldrhpre:
@@ -88,14 +88,14 @@ ENTRY(v4t_late_abort)
 	tst	r8, #1 << 22			@ if (immediate offset)
 	andne	r6, r8, #0xf00			@ { immediate high nibble
 	orrne	r6, r5, r6, lsr #4		@   combine nibbles } else
-	ldreq	r6, [sp, r5, lsl #2]		@ { load Rm value }
+	ldreq	r6, [r2, r5, lsl #2]		@ { load Rm value }
 .data_arm_apply_r6_and_rn:
 	and	r5, r8, #15 << 16		@ Extract 'n' from instruction
-	ldr	r7, [sp, r5, lsr #14]		@ Get register 'Rn'
+	ldr	r7, [r2, r5, lsr #14]		@ Get register 'Rn'
 	tst	r8, #1 << 23			@ Check U bit
 	subne	r7, r7, r6			@ Undo incrmenet
 	addeq	r7, r7, r6			@ Undo decrement
-	str	r7, [sp, r5, lsr #14]		@ Put register 'Rn'
+	str	r7, [r2, r5, lsr #14]		@ Put register 'Rn'
 	b	do_DataAbort
 
 .data_arm_lateldrpreconst:
@@ -105,11 +105,11 @@ ENTRY(v4t_late_abort)
 	movs	r9, r8, lsl #20			@ Get offset
 	beq	do_DataAbort			@ zero -> no fixup
 	and	r5, r8, #15 << 16		@ Extract 'n' from instruction
-	ldr	r7, [sp, r5, lsr #14]		@ Get register 'Rn'
+	ldr	r7, [r2, r5, lsr #14]		@ Get register 'Rn'
 	tst	r8, #1 << 23			@ Check U bit
 	subne	r7, r7, r9, lsr #20		@ Undo increment
 	addeq	r7, r7, r9, lsr #20		@ Undo decrement
-	str	r7, [sp, r5, lsr #14]		@ Put register 'Rn'
+	str	r7, [r2, r5, lsr #14]		@ Put register 'Rn'
 	b	do_DataAbort
 
 .data_arm_lateldrprereg:
@@ -117,7 +117,7 @@ ENTRY(v4t_late_abort)
 	beq	do_DataAbort			@ no writeback -> no fixup
 .data_arm_lateldrpostreg:
 	and	r7, r8, #15			@ Extract 'm' from instruction
-	ldr	r6, [sp, r7, lsl #2]		@ Get register 'Rm'
+	ldr	r6, [r2, r7, lsl #2]		@ Get register 'Rm'
 	mov	r5, r8, lsr #7			@ get shift count
 	ands	r5, r5, #31
 	and	r7, r8, #0x70			@ get shift type
@@ -201,11 +201,11 @@ ENTRY(v4t_late_abort)
 	movs	r7, r8, lsr #9			@ C = r8 bit 8 (R bit)
 	adc	r6, r6, r6, lsr #4		@ high + low nibble + R bit
 	and	r6, r6, #15			@ number of regs to transfer
-	ldr	r7, [sp, #13 << 2]
+	ldr	r7, [r2, #13 << 2]
 	tst	r8, #1 << 11
 	addeq	r7, r7, r6, lsl #2		@ increment SP if PUSH
 	subne	r7, r7, r6, lsl #2		@ decrement SP if POP
-	str	r7, [sp, #13 << 2]
+	str	r7, [r2, #13 << 2]
 	b	do_DataAbort
 
 .data_thumb_ldmstm:
@@ -217,8 +217,8 @@ ENTRY(v4t_late_abort)
 	add	r6, r6, r9, lsr #2
 	add	r6, r6, r6, lsr #4
 	and	r5, r8, #7 << 8
-	ldr	r7, [sp, r5, lsr #6]
+	ldr	r7, [r2, r5, lsr #6]
 	and	r6, r6, #15			@ number of regs to transfer
 	sub	r7, r7, r6, lsl #2		@ always decrement
-	str	r7, [sp, r5, lsr #6]
+	str	r7, [r2, r5, lsr #6]
 	b	do_DataAbort
diff --git a/arch/arm/mm/proc-arm6_7.S b/arch/arm/mm/proc-arm6_7.S
index d755d5b..141906e 100644
--- a/arch/arm/mm/proc-arm6_7.S
+++ b/arch/arm/mm/proc-arm6_7.S
@@ -96,20 +96,20 @@ ENTRY(cpu_arm6_data_abort)
 	add	r6, r6, r6, lsr #4
 	and	r6, r6, #15			@ r6 = no. of registers to transfer.
 	and	r5, r8, #15 << 16		@ Extract 'n' from instruction
-	ldr	r7, [sp, r5, lsr #14]		@ Get register 'Rn'
+	ldr	r7, [r2, r5, lsr #14]		@ Get register 'Rn'
 	tst	r8, #1 << 23			@ Check U bit
 	subne	r7, r7, r6, lsl #2		@ Undo increment
 	addeq	r7, r7, r6, lsl #2		@ Undo decrement
-	str	r7, [sp, r5, lsr #14]		@ Put register 'Rn'
+	str	r7, [r2, r5, lsr #14]		@ Put register 'Rn'
 	b	do_DataAbort
 
 .data_arm_apply_r6_and_rn:
 	and	r5, r8, #15 << 16		@ Extract 'n' from instruction
-	ldr	r7, [sp, r5, lsr #14]		@ Get register 'Rn'
+	ldr	r7, [r2, r5, lsr #14]		@ Get register 'Rn'
 	tst	r8, #1 << 23			@ Check U bit
 	subne	r7, r7, r6			@ Undo incrmenet
 	addeq	r7, r7, r6			@ Undo decrement
-	str	r7, [sp, r5, lsr #14]		@ Put register 'Rn'
+	str	r7, [r2, r5, lsr #14]		@ Put register 'Rn'
 	b	do_DataAbort
 
 .data_arm_lateldrpreconst:
@@ -119,11 +119,11 @@ ENTRY(cpu_arm6_data_abort)
 	movs	r9, r8, lsl #20			@ Get offset
 	beq	do_DataAbort			@ zero -> no fixup
 	and	r5, r8, #15 << 16		@ Extract 'n' from instruction
-	ldr	r7, [sp, r5, lsr #14]		@ Get register 'Rn'
+	ldr	r7, [r2, r5, lsr #14]		@ Get register 'Rn'
 	tst	r8, #1 << 23			@ Check U bit
 	subne	r7, r7, r9, lsr #20		@ Undo increment
 	addeq	r7, r7, r9, lsr #20		@ Undo decrement
-	str	r7, [sp, r5, lsr #14]		@ Put register 'Rn'
+	str	r7, [r2, r5, lsr #14]		@ Put register 'Rn'
 	b	do_DataAbort
 
 .data_arm_lateldrprereg:
@@ -131,7 +131,7 @@ ENTRY(cpu_arm6_data_abort)
 	beq	do_DataAbort			@ no writeback -> no fixup
 .data_arm_lateldrpostreg:
 	and	r7, r8, #15			@ Extract 'm' from instruction
-	ldr	r6, [sp, r7, lsl #2]		@ Get register 'Rm'
+	ldr	r6, [r2, r7, lsl #2]		@ Get register 'Rm'
 	mov	r5, r8, lsr #7			@ get shift count
 	ands	r5, r5, #31
 	and	r7, r8, #0x70			@ get shift type
-- 
1.7.4.4
