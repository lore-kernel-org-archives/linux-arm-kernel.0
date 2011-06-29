From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jun 2011 10:20:34 +0100
Subject: [PATCH 05/23] ARM: entry: abort-macro: specify registers to be used
	for macros
In-Reply-To: <20110629091853.GK21898@n2100.arm.linux.org.uk>
References: <20110629091853.GK21898@n2100.arm.linux.org.uk>
Message-ID: <E1Qbqwk-0002F0-AF@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Require all callers of abort macros to specify the registers to be
used.  This improves the documentation at the callsites as to which
registers are being used by this assembly code.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/abort-ev4t.S  |    2 +-
 arch/arm/mm/abort-ev5t.S  |    4 ++--
 arch/arm/mm/abort-ev5tj.S |    4 ++--
 arch/arm/mm/abort-ev6.S   |    4 ++--
 arch/arm/mm/abort-macro.S |   30 +++++++++++++++---------------
 5 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mm/abort-ev4t.S b/arch/arm/mm/abort-ev4t.S
index b628254..9910123 100644
--- a/arch/arm/mm/abort-ev4t.S
+++ b/arch/arm/mm/abort-ev4t.S
@@ -22,7 +22,7 @@
 ENTRY(v4t_early_abort)
 	mrc	p15, 0, r1, c5, c0, 0		@ get FSR
 	mrc	p15, 0, r0, c6, c0, 0		@ get FAR
-	do_thumb_abort
+	do_thumb_abort fsr=r1, pc=r2, psr=r3, tmp=r3
 	ldreq	r3, [r2]			@ read aborted ARM instruction
 	bic	r1, r1, #1 << 11 | 1 << 10	@ clear bits 11 and 10 of FSR
 	tst	r3, #1 << 20			@ check write
diff --git a/arch/arm/mm/abort-ev5t.S b/arch/arm/mm/abort-ev5t.S
index 02251b5..800e8d4 100644
--- a/arch/arm/mm/abort-ev5t.S
+++ b/arch/arm/mm/abort-ev5t.S
@@ -22,10 +22,10 @@
 ENTRY(v5t_early_abort)
 	mrc	p15, 0, r1, c5, c0, 0		@ get FSR
 	mrc	p15, 0, r0, c6, c0, 0		@ get FAR
-	do_thumb_abort
+	do_thumb_abort fsr=r1, pc=r2, psr=r3, tmp=r3
 	ldreq	r3, [r2]			@ read aborted ARM instruction
 	bic	r1, r1, #1 << 11		@ clear bits 11 of FSR
-	do_ldrd_abort
+	do_ldrd_abort tmp=r2, insn=r3
 	tst	r3, #1 << 20			@ check write
 	orreq	r1, r1, #1 << 11
 	mov	pc, lr
diff --git a/arch/arm/mm/abort-ev5tj.S b/arch/arm/mm/abort-ev5tj.S
index bce68d6..bcb58d2 100644
--- a/arch/arm/mm/abort-ev5tj.S
+++ b/arch/arm/mm/abort-ev5tj.S
@@ -25,9 +25,9 @@ ENTRY(v5tj_early_abort)
 	bic	r1, r1, #1 << 11 | 1 << 10	@ clear bits 11 and 10 of FSR
 	tst	r3, #PSR_J_BIT			@ Java?
 	movne	pc, lr
-	do_thumb_abort
+	do_thumb_abort fsr=r1, pc=r2, psr=r3, tmp=r3
 	ldreq	r3, [r2]			@ read aborted ARM instruction
-	do_ldrd_abort
+	do_ldrd_abort tmp=r2, insn=r3
 	tst	r3, #1 << 20			@ L = 0 -> write
 	orreq	r1, r1, #1 << 11		@ yes.
 	mov	pc, lr
diff --git a/arch/arm/mm/abort-ev6.S b/arch/arm/mm/abort-ev6.S
index 1478aa5..ef526e7 100644
--- a/arch/arm/mm/abort-ev6.S
+++ b/arch/arm/mm/abort-ev6.S
@@ -35,12 +35,12 @@ ENTRY(v6_early_abort)
 	bic	r1, r1, #1 << 11		@ clear bit 11 of FSR
 	tst	r3, #PSR_J_BIT			@ Java?
 	movne	pc, lr
-	do_thumb_abort
+	do_thumb_abort fsr=r1, pc=r2, psr=r3, tmp=r3
 	ldreq	r3, [r2]			@ read aborted ARM instruction
 #ifdef CONFIG_CPU_ENDIAN_BE8
 	reveq	r3, r3
 #endif
-	do_ldrd_abort
+	do_ldrd_abort tmp=r2, insn=r3
 	tst	r3, #1 << 20			@ L = 0 -> write
 	orreq	r1, r1, #1 << 11		@ yes.
 	mov	pc, lr
diff --git a/arch/arm/mm/abort-macro.S b/arch/arm/mm/abort-macro.S
index d7cb1bf..8d3b9f9 100644
--- a/arch/arm/mm/abort-macro.S
+++ b/arch/arm/mm/abort-macro.S
@@ -9,33 +9,33 @@
  *
  */
 
-	.macro	do_thumb_abort
-	tst	r3, #PSR_T_BIT
+	.macro	do_thumb_abort, fsr, pc, psr, tmp
+	tst	\psr, #PSR_T_BIT
 	beq	not_thumb
-	ldrh	r3, [r2]			@ Read aborted Thumb instruction
-	and	r3, r3, # 0xfe00		@ Mask opcode field
-	cmp	r3, # 0x5600			@ Is it ldrsb?
-	orreq	r3, r3, #1 << 11		@ Set L-bit if yes
-	tst	r3, #1 << 11			@ L = 0 -> write
-	orreq	r1, r1, #1 << 11		@ yes.
+	ldrh	\tmp, [\pc]			@ Read aborted Thumb instruction
+	and	\tmp, \tmp, # 0xfe00		@ Mask opcode field
+	cmp	\tmp, # 0x5600			@ Is it ldrsb?
+	orreq	\tmp, \tmp, #1 << 11		@ Set L-bit if yes
+	tst	\tmp, #1 << 11			@ L = 0 -> write
+	orreq	\psr, \psr, #1 << 11		@ yes.
 	mov	pc, lr
 not_thumb:
 	.endm
 
 /*
- * We check for the following insturction encoding for LDRD.
+ * We check for the following instruction encoding for LDRD.
  *
- * [27:25] == 0
+ * [27:25] == 000
  *   [7:4] == 1101
  *    [20] == 0
  */
- 	.macro	do_ldrd_abort
- 	tst	r3, #0x0e000000			@ [27:25] == 0
+	.macro	do_ldrd_abort, tmp, insn
+	tst	\insn, #0x0e000000		@ [27:25] == 0
 	bne	not_ldrd
-	and	r2, r3, #0x000000f0		@ [7:4] == 1101
-	cmp	r2, #0x000000d0
+	and	\tmp, \insn, #0x000000f0	@ [7:4] == 1101
+	cmp	\tmp, #0x000000d0
 	bne	not_ldrd
-	tst	r3, #1 << 20			@ [20] == 0
+	tst	\insn, #1 << 20			@ [20] == 0
 	moveq	pc, lr
 not_ldrd:
 	.endm
-- 
1.7.4.4
