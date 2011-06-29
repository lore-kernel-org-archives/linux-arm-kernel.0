From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jun 2011 10:24:35 +0100
Subject: [PATCH 17/23] ARM: entry: data abort: arrange for CPU abort helpers
	to take pc/psr in r4/r5
In-Reply-To: <20110629091853.GK21898@n2100.arm.linux.org.uk>
References: <20110629091853.GK21898@n2100.arm.linux.org.uk>
Message-ID: <E1Qbr0d-0002GD-QQ@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Re-jig the CPU abort helpers to take the PC/PSR in r4/r5 rather
than r2/r3.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/entry-armv.S |    6 ++----
 arch/arm/mm/abort-ev4.S      |    8 +++-----
 arch/arm/mm/abort-ev4t.S     |    8 ++++----
 arch/arm/mm/abort-ev5t.S     |    8 ++++----
 arch/arm/mm/abort-ev5tj.S    |   12 +++++-------
 arch/arm/mm/abort-ev6.S      |   12 +++++-------
 arch/arm/mm/abort-ev7.S      |    4 ++--
 arch/arm/mm/abort-lv4t.S     |   12 ++++++------
 arch/arm/mm/abort-nommu.S    |    4 ++--
 arch/arm/mm/proc-arm6_7.S    |   10 +++++-----
 10 files changed, 38 insertions(+), 46 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 54c07a8..36c9409 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -56,14 +56,12 @@
 	.endm
 
 	.macro	dabt_helper
-	mov	r2, r4
-	mov	r3, r5
 
 	@
 	@ Call the processor-specific abort handler:
 	@
-	@  r2 - aborted context pc
-	@  r3 - aborted context cpsr
+	@  r4 - aborted context pc
+	@  r5 - aborted context psr
 	@
 	@ The abort handler must return the aborted address in r0, and
 	@ the fault status register in r1.  r9 must be preserved.
diff --git a/arch/arm/mm/abort-ev4.S b/arch/arm/mm/abort-ev4.S
index 4f18f9e..beb112b 100644
--- a/arch/arm/mm/abort-ev4.S
+++ b/arch/arm/mm/abort-ev4.S
@@ -3,8 +3,8 @@
 /*
  * Function: v4_early_abort
  *
- * Params  : r2 = address of aborted instruction
- *         : r3 = saved SPSR
+ * Params  : r4 = aborted context pc
+ *	   : r5 = aborted context psr
  *
  * Returns : r0 = address of abort
  *	   : r1 = FSR, bit 11 = write
@@ -21,10 +21,8 @@
 ENTRY(v4_early_abort)
 	mrc	p15, 0, r1, c5, c0, 0		@ get FSR
 	mrc	p15, 0, r0, c6, c0, 0		@ get FAR
-	ldr	r3, [r2]			@ read aborted ARM instruction
+	ldr	r3, [r4]			@ read aborted ARM instruction
 	bic	r1, r1, #1 << 11 | 1 << 10	@ clear bits 11 and 10 of FSR
 	tst	r3, #1 << 20			@ L = 1 -> write?
 	orreq	r1, r1, #1 << 11		@ yes.
 	mov	pc, lr
-
-
diff --git a/arch/arm/mm/abort-ev4t.S b/arch/arm/mm/abort-ev4t.S
index 9910123..eaa4ac0 100644
--- a/arch/arm/mm/abort-ev4t.S
+++ b/arch/arm/mm/abort-ev4t.S
@@ -4,8 +4,8 @@
 /*
  * Function: v4t_early_abort
  *
- * Params  : r2 = address of aborted instruction
- *         : r3 = saved SPSR
+ * Params  : r4 = aborted context pc
+ *	   : r5 = aborted context psr
  *
  * Returns : r0 = address of abort
  *	   : r1 = FSR, bit 11 = write
@@ -22,8 +22,8 @@
 ENTRY(v4t_early_abort)
 	mrc	p15, 0, r1, c5, c0, 0		@ get FSR
 	mrc	p15, 0, r0, c6, c0, 0		@ get FAR
-	do_thumb_abort fsr=r1, pc=r2, psr=r3, tmp=r3
-	ldreq	r3, [r2]			@ read aborted ARM instruction
+	do_thumb_abort fsr=r1, pc=r4, psr=r5, tmp=r3
+	ldreq	r3, [r4]			@ read aborted ARM instruction
 	bic	r1, r1, #1 << 11 | 1 << 10	@ clear bits 11 and 10 of FSR
 	tst	r3, #1 << 20			@ check write
 	orreq	r1, r1, #1 << 11
diff --git a/arch/arm/mm/abort-ev5t.S b/arch/arm/mm/abort-ev5t.S
index 800e8d4..97eee7c 100644
--- a/arch/arm/mm/abort-ev5t.S
+++ b/arch/arm/mm/abort-ev5t.S
@@ -4,8 +4,8 @@
 /*
  * Function: v5t_early_abort
  *
- * Params  : r2 = address of aborted instruction
- *         : r3 = saved SPSR
+ * Params  : r4 = aborted context pc
+ *	   : r5 = aborted context psr
  *
  * Returns : r0 = address of abort
  *	   : r1 = FSR, bit 11 = write
@@ -22,8 +22,8 @@
 ENTRY(v5t_early_abort)
 	mrc	p15, 0, r1, c5, c0, 0		@ get FSR
 	mrc	p15, 0, r0, c6, c0, 0		@ get FAR
-	do_thumb_abort fsr=r1, pc=r2, psr=r3, tmp=r3
-	ldreq	r3, [r2]			@ read aborted ARM instruction
+	do_thumb_abort fsr=r1, pc=r4, psr=r5, tmp=r3
+	ldreq	r3, [r4]			@ read aborted ARM instruction
 	bic	r1, r1, #1 << 11		@ clear bits 11 of FSR
 	do_ldrd_abort tmp=r2, insn=r3
 	tst	r3, #1 << 20			@ check write
diff --git a/arch/arm/mm/abort-ev5tj.S b/arch/arm/mm/abort-ev5tj.S
index bcb58d2..9a365cf 100644
--- a/arch/arm/mm/abort-ev5tj.S
+++ b/arch/arm/mm/abort-ev5tj.S
@@ -4,8 +4,8 @@
 /*
  * Function: v5tj_early_abort
  *
- * Params  : r2 = address of aborted instruction
- *         : r3 = saved SPSR
+ * Params  : r4 = aborted context pc
+ *	   : r5 = aborted context psr
  *
  * Returns : r0 = address of abort
  *	   : r1 = FSR, bit 11 = write
@@ -23,13 +23,11 @@ ENTRY(v5tj_early_abort)
 	mrc	p15, 0, r1, c5, c0, 0		@ get FSR
 	mrc	p15, 0, r0, c6, c0, 0		@ get FAR
 	bic	r1, r1, #1 << 11 | 1 << 10	@ clear bits 11 and 10 of FSR
-	tst	r3, #PSR_J_BIT			@ Java?
+	tst	r5, #PSR_J_BIT			@ Java?
 	movne	pc, lr
-	do_thumb_abort fsr=r1, pc=r2, psr=r3, tmp=r3
-	ldreq	r3, [r2]			@ read aborted ARM instruction
+	do_thumb_abort fsr=r1, pc=r4, psr=r5, tmp=r3
+	ldreq	r3, [r4]			@ read aborted ARM instruction
 	do_ldrd_abort tmp=r2, insn=r3
 	tst	r3, #1 << 20			@ L = 0 -> write
 	orreq	r1, r1, #1 << 11		@ yes.
 	mov	pc, lr
-
-
diff --git a/arch/arm/mm/abort-ev6.S b/arch/arm/mm/abort-ev6.S
index ef526e7..52db4a3 100644
--- a/arch/arm/mm/abort-ev6.S
+++ b/arch/arm/mm/abort-ev6.S
@@ -4,8 +4,8 @@
 /*
  * Function: v6_early_abort
  *
- * Params  : r2 = address of aborted instruction
- *         : r3 = saved SPSR
+ * Params  : r4 = aborted context pc
+ *	   : r5 = aborted context psr
  *
  * Returns : r0 = address of abort
  *	   : r1 = FSR, bit 11 = write
@@ -33,10 +33,10 @@ ENTRY(v6_early_abort)
  * The test below covers all the write situations, including Java bytecodes
  */
 	bic	r1, r1, #1 << 11		@ clear bit 11 of FSR
-	tst	r3, #PSR_J_BIT			@ Java?
+	tst	r5, #PSR_J_BIT			@ Java?
 	movne	pc, lr
-	do_thumb_abort fsr=r1, pc=r2, psr=r3, tmp=r3
-	ldreq	r3, [r2]			@ read aborted ARM instruction
+	do_thumb_abort fsr=r1, pc=r4, psr=r5, tmp=r3
+	ldreq	r3, [r4]			@ read aborted ARM instruction
 #ifdef CONFIG_CPU_ENDIAN_BE8
 	reveq	r3, r3
 #endif
@@ -44,5 +44,3 @@ ENTRY(v6_early_abort)
 	tst	r3, #1 << 20			@ L = 0 -> write
 	orreq	r1, r1, #1 << 11		@ yes.
 	mov	pc, lr
-
-
diff --git a/arch/arm/mm/abort-ev7.S b/arch/arm/mm/abort-ev7.S
index ec88b15..6cb5143 100644
--- a/arch/arm/mm/abort-ev7.S
+++ b/arch/arm/mm/abort-ev7.S
@@ -3,8 +3,8 @@
 /*
  * Function: v7_early_abort
  *
- * Params  : r2 = address of aborted instruction
- *         : r3 = saved SPSR
+ * Params  : r4 = aborted context pc
+ *	   : r5 = aborted context psr
  *
  * Returns : r0 = address of abort
  *	   : r1 = FSR, bit 11 = write
diff --git a/arch/arm/mm/abort-lv4t.S b/arch/arm/mm/abort-lv4t.S
index 9fb7b0e..fea7514 100644
--- a/arch/arm/mm/abort-lv4t.S
+++ b/arch/arm/mm/abort-lv4t.S
@@ -3,8 +3,8 @@
 /*
  * Function: v4t_late_abort
  *
- * Params  : r2 = address of aborted instruction
- *         : r3 = saved SPSR
+ * Params  : r4 = aborted context pc
+ *	   : r5 = aborted context psr
  *
  * Returns : r0 = address of abort
  *	   : r1 = FSR, bit 11 = write
@@ -18,7 +18,7 @@
  * picture.  Unfortunately, this does happen.  We live with it.
  */
 ENTRY(v4t_late_abort)
-	tst	r3, #PSR_T_BIT			@ check for thumb mode
+	tst	r5, #PSR_T_BIT			@ check for thumb mode
 #ifdef CONFIG_CPU_CP15_MMU
 	mrc	p15, 0, r1, c5, c0, 0		@ get FSR
 	mrc	p15, 0, r0, c6, c0, 0		@ get FAR
@@ -28,7 +28,7 @@ ENTRY(v4t_late_abort)
 	mov	r1, #0
 #endif
 	bne	.data_thumb_abort
-	ldr	r8, [r2]			@ read arm instruction
+	ldr	r8, [r4]			@ read arm instruction
 	tst	r8, #1 << 20			@ L = 1 -> write?
 	orreq	r1, r1, #1 << 11		@ yes.
 	and	r7, r8, #15 << 24
@@ -52,7 +52,7 @@ ENTRY(v4t_late_abort)
 /* e */	b	.data_unknown
 /* f */
 .data_unknown:	@ Part of jumptable
-	mov	r0, r2
+	mov	r0, r4
 	mov	r1, r8
 	mov	r2, sp
 	bl	baddataabort
@@ -159,7 +159,7 @@ ENTRY(v4t_late_abort)
 	b	.data_unknown			@ F: MUL?
 
 .data_thumb_abort:
-	ldrh	r8, [r2]			@ read instruction
+	ldrh	r8, [r4]			@ read instruction
 	tst	r8, #1 << 11			@ L = 1 -> write?
 	orreq	r1, r1, #1 << 8			@ yes
 	and	r7, r8, #15 << 12
diff --git a/arch/arm/mm/abort-nommu.S b/arch/arm/mm/abort-nommu.S
index 625e580..9eaef6f 100644
--- a/arch/arm/mm/abort-nommu.S
+++ b/arch/arm/mm/abort-nommu.S
@@ -3,8 +3,8 @@
 /*
  * Function: nommu_early_abort
  *
- * Params  : r2 = address of aborted instruction
- *         : r3 = saved SPSR
+ * Params  : r4 = aborted context pc
+ *	   : r5 = aborted context psr
  *
  * Returns : r0 = 0 (abort address)
  *	   : r1 = 0 (FSR)
diff --git a/arch/arm/mm/proc-arm6_7.S b/arch/arm/mm/proc-arm6_7.S
index 5f79dc4..e7be700 100644
--- a/arch/arm/mm/proc-arm6_7.S
+++ b/arch/arm/mm/proc-arm6_7.S
@@ -29,8 +29,8 @@ ENTRY(cpu_arm7_dcache_clean_area)
 /*
  * Function: arm6_7_data_abort ()
  *
- * Params  : r2 = address of aborted instruction
- *	   : sp = pointer to registers
+ * Params  : r4 = aborted context pc
+ *	   : r5 = aborted context psr
  *
  * Purpose : obtain information about current aborted instruction
  *
@@ -41,7 +41,7 @@ ENTRY(cpu_arm7_dcache_clean_area)
 ENTRY(cpu_arm7_data_abort)
 	mrc	p15, 0, r1, c5, c0, 0		@ get FSR
 	mrc	p15, 0, r0, c6, c0, 0		@ get FAR
-	ldr	r8, [r2]			@ read arm instruction
+	ldr	r8, [r4]			@ read arm instruction
 	tst	r8, #1 << 20			@ L = 0 -> write?
 	orreq	r1, r1, #1 << 11		@ yes.
 	and	r7, r8, #15 << 24
@@ -65,7 +65,7 @@ ENTRY(cpu_arm7_data_abort)
 /* e */	b	.data_unknown
 /* f */
 .data_unknown:	@ Part of jumptable
-	mov	r0, r2
+	mov	r0, r4
 	mov	r1, r8
 	mov	r2, sp
 	bl	baddataabort
@@ -74,7 +74,7 @@ ENTRY(cpu_arm7_data_abort)
 ENTRY(cpu_arm6_data_abort)
 	mrc	p15, 0, r1, c5, c0, 0		@ get FSR
 	mrc	p15, 0, r0, c6, c0, 0		@ get FAR
-	ldr	r8, [r2]			@ read arm instruction
+	ldr	r8, [r4]			@ read arm instruction
 	tst	r8, #1 << 20			@ L = 0 -> write?
 	orreq	r1, r1, #1 << 11		@ yes.
 	and	r7, r8, #14 << 24
-- 
1.7.4.4
