From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jun 2011 10:24:55 +0100
Subject: [PATCH 18/23] ARM: entry: data abort: avoid using r2 in abort helpers
In-Reply-To: <20110629091853.GK21898@n2100.arm.linux.org.uk>
References: <20110629091853.GK21898@n2100.arm.linux.org.uk>
Message-ID: <E1Qbr0x-0002GN-Tp@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows us to pass the pt_regs pointer in to these functions
ready for tail-calling the abort handler.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/abort-ev5t.S  |    2 +-
 arch/arm/mm/abort-ev5tj.S |    2 +-
 arch/arm/mm/abort-ev6.S   |    2 +-
 arch/arm/mm/abort-ev7.S   |    8 ++++----
 arch/arm/mm/abort-lv4t.S  |   34 +++++++++++++++++-----------------
 arch/arm/mm/proc-arm6_7.S |   18 +++++++++---------
 6 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mm/abort-ev5t.S b/arch/arm/mm/abort-ev5t.S
index 97eee7c..751391a 100644
--- a/arch/arm/mm/abort-ev5t.S
+++ b/arch/arm/mm/abort-ev5t.S
@@ -25,7 +25,7 @@ ENTRY(v5t_early_abort)
 	do_thumb_abort fsr=r1, pc=r4, psr=r5, tmp=r3
 	ldreq	r3, [r4]			@ read aborted ARM instruction
 	bic	r1, r1, #1 << 11		@ clear bits 11 of FSR
-	do_ldrd_abort tmp=r2, insn=r3
+	do_ldrd_abort tmp=ip, insn=r3
 	tst	r3, #1 << 20			@ check write
 	orreq	r1, r1, #1 << 11
 	mov	pc, lr
diff --git a/arch/arm/mm/abort-ev5tj.S b/arch/arm/mm/abort-ev5tj.S
index 9a365cf..ccfbc93 100644
--- a/arch/arm/mm/abort-ev5tj.S
+++ b/arch/arm/mm/abort-ev5tj.S
@@ -27,7 +27,7 @@ ENTRY(v5tj_early_abort)
 	movne	pc, lr
 	do_thumb_abort fsr=r1, pc=r4, psr=r5, tmp=r3
 	ldreq	r3, [r4]			@ read aborted ARM instruction
-	do_ldrd_abort tmp=r2, insn=r3
+	do_ldrd_abort tmp=ip, insn=r3
 	tst	r3, #1 << 20			@ L = 0 -> write
 	orreq	r1, r1, #1 << 11		@ yes.
 	mov	pc, lr
diff --git a/arch/arm/mm/abort-ev6.S b/arch/arm/mm/abort-ev6.S
index 52db4a3..b64d886 100644
--- a/arch/arm/mm/abort-ev6.S
+++ b/arch/arm/mm/abort-ev6.S
@@ -40,7 +40,7 @@ ENTRY(v6_early_abort)
 #ifdef CONFIG_CPU_ENDIAN_BE8
 	reveq	r3, r3
 #endif
-	do_ldrd_abort tmp=r2, insn=r3
+	do_ldrd_abort tmp=ip, insn=r3
 	tst	r3, #1 << 20			@ L = 0 -> write
 	orreq	r1, r1, #1 << 11		@ yes.
 	mov	pc, lr
diff --git a/arch/arm/mm/abort-ev7.S b/arch/arm/mm/abort-ev7.S
index 6cb5143..6f98b3a 100644
--- a/arch/arm/mm/abort-ev7.S
+++ b/arch/arm/mm/abort-ev7.S
@@ -41,13 +41,13 @@ ENTRY(v7_early_abort)
 
 	mcr	p15, 0, r0, c7, c8, 0   	@ Retranslate FAR
 	isb
-	mrc	p15, 0, r2, c7, c4, 0   	@ Read the PAR
-	and	r3, r2, #0x7b   		@ On translation fault
+	mrc	p15, 0, ip, c7, c4, 0   	@ Read the PAR
+	and	r3, ip, #0x7b   		@ On translation fault
 	cmp	r3, #0x0b
 	movne	pc, lr
 	bic	r1, r1, #0xf			@ Fix up FSR FS[5:0]
-	and	r2, r2, #0x7e
-	orr	r1, r1, r2, LSR #1
+	and	ip, ip, #0x7e
+	orr	r1, r1, ip, LSR #1
 #endif
 
 	mov	pc, lr
diff --git a/arch/arm/mm/abort-lv4t.S b/arch/arm/mm/abort-lv4t.S
index fea7514..d032b1f 100644
--- a/arch/arm/mm/abort-lv4t.S
+++ b/arch/arm/mm/abort-lv4t.S
@@ -64,12 +64,12 @@ ENTRY(v4t_late_abort)
 	mov	r7, #0x11
 	orr	r7, r7, #0x1100
 	and	r6, r8, r7
-	and	r2, r8, r7, lsl #1
-	add	r6, r6, r2, lsr #1
-	and	r2, r8, r7, lsl #2
-	add	r6, r6, r2, lsr #2
-	and	r2, r8, r7, lsl #3
-	add	r6, r6, r2, lsr #3
+	and	r9, r8, r7, lsl #1
+	add	r6, r6, r9, lsr #1
+	and	r9, r8, r7, lsl #2
+	add	r6, r6, r9, lsr #2
+	and	r9, r8, r7, lsl #3
+	add	r6, r6, r9, lsr #3
 	add	r6, r6, r6, lsr #8
 	add	r6, r6, r6, lsr #4
 	and	r6, r6, #15			@ r6 = no. of registers to transfer.
@@ -103,13 +103,13 @@ ENTRY(v4t_late_abort)
 	tst	r8, #1 << 21			@ check writeback bit
 	moveq	pc, lr				@ no writeback -> no fixup
 .data_arm_lateldrpostconst:
-	movs	r2, r8, lsl #20			@ Get offset
+	movs	r9, r8, lsl #20			@ Get offset
 	moveq	pc, lr				@ zero -> no fixup
 	and	r5, r8, #15 << 16		@ Extract 'n' from instruction
 	ldr	r7, [sp, r5, lsr #14]		@ Get register 'Rn'
 	tst	r8, #1 << 23			@ Check U bit
-	subne	r7, r7, r2, lsr #20		@ Undo increment
-	addeq	r7, r7, r2, lsr #20		@ Undo decrement
+	subne	r7, r7, r9, lsr #20		@ Undo increment
+	addeq	r7, r7, r9, lsr #20		@ Undo decrement
 	str	r7, [sp, r5, lsr #14]		@ Put register 'Rn'
 	mov	pc, lr
 
@@ -194,11 +194,11 @@ ENTRY(v4t_late_abort)
 	tst	r8, #1 << 10
 	beq	.data_unknown
 	and	r6, r8, #0x55			@ hweight8(r8) + R bit
-	and	r2, r8, #0xaa
-	add	r6, r6, r2, lsr #1
-	and	r2, r6, #0xcc
+	and	r9, r8, #0xaa
+	add	r6, r6, r9, lsr #1
+	and	r9, r6, #0xcc
 	and	r6, r6, #0x33
-	add	r6, r6, r2, lsr #2
+	add	r6, r6, r9, lsr #2
 	movs	r7, r8, lsr #9			@ C = r8 bit 8 (R bit)
 	adc	r6, r6, r6, lsr #4		@ high + low nibble + R bit
 	and	r6, r6, #15			@ number of regs to transfer
@@ -211,11 +211,11 @@ ENTRY(v4t_late_abort)
 
 .data_thumb_ldmstm:
 	and	r6, r8, #0x55			@ hweight8(r8)
-	and	r2, r8, #0xaa
-	add	r6, r6, r2, lsr #1
-	and	r2, r6, #0xcc
+	and	r9, r8, #0xaa
+	add	r6, r6, r9, lsr #1
+	and	r9, r6, #0xcc
 	and	r6, r6, #0x33
-	add	r6, r6, r2, lsr #2
+	add	r6, r6, r9, lsr #2
 	add	r6, r6, r6, lsr #4
 	and	r5, r8, #7 << 8
 	ldr	r7, [sp, r5, lsr #6]
diff --git a/arch/arm/mm/proc-arm6_7.S b/arch/arm/mm/proc-arm6_7.S
index e7be700..d4c328e 100644
--- a/arch/arm/mm/proc-arm6_7.S
+++ b/arch/arm/mm/proc-arm6_7.S
@@ -87,12 +87,12 @@ ENTRY(cpu_arm6_data_abort)
 	mov	r7, #0x11
 	orr	r7, r7, #0x1100
 	and	r6, r8, r7
-	and	r2, r8, r7, lsl #1
-	add	r6, r6, r2, lsr #1
-	and	r2, r8, r7, lsl #2
-	add	r6, r6, r2, lsr #2
-	and	r2, r8, r7, lsl #3
-	add	r6, r6, r2, lsr #3
+	and	r9, r8, r7, lsl #1
+	add	r6, r6, r9, lsr #1
+	and	r9, r8, r7, lsl #2
+	add	r6, r6, r9, lsr #2
+	and	r9, r8, r7, lsl #3
+	add	r6, r6, r9, lsr #3
 	add	r6, r6, r6, lsr #8
 	add	r6, r6, r6, lsr #4
 	and	r6, r6, #15			@ r6 = no. of registers to transfer.
@@ -117,13 +117,13 @@ ENTRY(cpu_arm6_data_abort)
 	tst	r8, #1 << 21			@ check writeback bit
 	moveq	pc, lr				@ no writeback -> no fixup
 .data_arm_lateldrpostconst:
-	movs	r2, r8, lsl #20			@ Get offset
+	movs	r9, r8, lsl #20			@ Get offset
 	moveq	pc, lr				@ zero -> no fixup
 	and	r5, r8, #15 << 16		@ Extract 'n' from instruction
 	ldr	r7, [sp, r5, lsr #14]		@ Get register 'Rn'
 	tst	r8, #1 << 23			@ Check U bit
-	subne	r7, r7, r2, lsr #20		@ Undo increment
-	addeq	r7, r7, r2, lsr #20		@ Undo decrement
+	subne	r7, r7, r9, lsr #20		@ Undo increment
+	addeq	r7, r7, r9, lsr #20		@ Undo decrement
 	str	r7, [sp, r5, lsr #14]		@ Put register 'Rn'
 	mov	pc, lr
 
-- 
1.7.4.4
