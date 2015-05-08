From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 08 May 2015 18:35:36 +0100
Subject: [PATCH 3/3] ARM: proc-v7: sanitise and document registers around
 errata
In-Reply-To: <20150508173505.GL2067@n2100.arm.linux.org.uk>
References: <20150508173505.GL2067@n2100.arm.linux.org.uk>
Message-ID: <E1YqmBU-0000Ne-5d@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document that r13 is not a stack in the initialisation function, in
case anyone gets other ideas.

Document the registers available for the errata workarounds, and
specifically which registers contain parts of the MIDR register, as
well as which registers must be preserved.

Lastly, use the lowest numbered available register (r0) rather than
r10 for temporary storage.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/proc-v7.S | 68 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 19c1c8b7c3bb..003190ae9cd8 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -252,7 +252,7 @@ ENDPROC(cpu_pj4b_do_resume)
  *	Initialise TLB, Caches, and MMU state ready to switch the MMU
  *	on.  Return in r0 the new CP15 C1 control register setting.
  *
- *	r1, r2, r4, r5, r9 must be preserved.
+ *	r1, r2, r4, r5, r9, r13 must be preserved - r13 is not a stack
  *	r4: TTBR0 (low word)
  *	r5: TTBR0 (high word if LPAE)
  *	r8: TTBR1
@@ -285,57 +285,65 @@ __v7_ca17mp_setup:
 #endif
 	b	__v7_setup
 
+/*
+ * Errata:
+ *  r0, r10 available for use
+ *  r1, r2, r4, r5, r9, r13: must be preserved
+ *  r3: contains MIDR rX number in bits 23-20
+ *  r6: contains MIDR rXpY as 8-bit XY number
+ *  r9: MIDR
+ */
 __ca8_errata:
 #if defined(CONFIG_ARM_ERRATA_430973) && !defined(CONFIG_ARCH_MULTIPLATFORM)
 	teq	r3, #0x00100000			@ only present in r1p*
-	mrceq	p15, 0, r10, c1, c0, 1		@ read aux control register
-	orreq	r10, r10, #(1 << 6)		@ set IBE to 1
-	mcreq	p15, 0, r10, c1, c0, 1		@ write aux control register
+	mrceq	p15, 0, r0, c1, c0, 1		@ read aux control register
+	orreq	r0, r0, #(1 << 6)		@ set IBE to 1
+	mcreq	p15, 0, r0, c1, c0, 1		@ write aux control register
 #endif
 #ifdef CONFIG_ARM_ERRATA_458693
 	teq	r6, #0x20			@ only present in r2p0
-	mrceq	p15, 0, r10, c1, c0, 1		@ read aux control register
-	orreq	r10, r10, #(1 << 5)		@ set L1NEON to 1
-	orreq	r10, r10, #(1 << 9)		@ set PLDNOP to 1
-	mcreq	p15, 0, r10, c1, c0, 1		@ write aux control register
+	mrceq	p15, 0, r0, c1, c0, 1		@ read aux control register
+	orreq	r0, r0, #(1 << 5)		@ set L1NEON to 1
+	orreq	r0, r0, #(1 << 9)		@ set PLDNOP to 1
+	mcreq	p15, 0, r0, c1, c0, 1		@ write aux control register
 #endif
 #ifdef CONFIG_ARM_ERRATA_460075
 	teq	r6, #0x20			@ only present in r2p0
-	mrceq	p15, 1, r10, c9, c0, 2		@ read L2 cache aux ctrl register
-	tsteq	r10, #1 << 22
-	orreq	r10, r10, #(1 << 22)		@ set the Write Allocate disable bit
-	mcreq	p15, 1, r10, c9, c0, 2		@ write the L2 cache aux ctrl register
+	mrceq	p15, 1, r0, c9, c0, 2		@ read L2 cache aux ctrl register
+	tsteq	r0, #1 << 22
+	orreq	r0, r0, #(1 << 22)		@ set the Write Allocate disable bit
+	mcreq	p15, 1, r0, c9, c0, 2		@ write the L2 cache aux ctrl register
 #endif
 	b	__errata_finish
 
 __ca9_errata:
 #ifdef CONFIG_ARM_ERRATA_742230
 	cmp	r6, #0x22			@ only present up to r2p2
-	mrcle	p15, 0, r10, c15, c0, 1		@ read diagnostic register
-	orrle	r10, r10, #1 << 4		@ set bit #4
-	mcrle	p15, 0, r10, c15, c0, 1		@ write diagnostic register
+	mrcle	p15, 0, r0, c15, c0, 1		@ read diagnostic register
+	orrle	r0, r0, #1 << 4			@ set bit #4
+	mcrle	p15, 0, r0, c15, c0, 1		@ write diagnostic register
 #endif
 #ifdef CONFIG_ARM_ERRATA_742231
 	teq	r6, #0x20			@ present in r2p0
 	teqne	r6, #0x21			@ present in r2p1
 	teqne	r6, #0x22			@ present in r2p2
-	mrceq	p15, 0, r10, c15, c0, 1		@ read diagnostic register
-	orreq	r10, r10, #1 << 12		@ set bit #12
-	orreq	r10, r10, #1 << 22		@ set bit #22
-	mcreq	p15, 0, r10, c15, c0, 1		@ write diagnostic register
+	mrceq	p15, 0, r0, c15, c0, 1		@ read diagnostic register
+	orreq	r0, r0, #1 << 12		@ set bit #12
+	orreq	r0, r0, #1 << 22		@ set bit #22
+	mcreq	p15, 0, r0, c15, c0, 1		@ write diagnostic register
 #endif
 #ifdef CONFIG_ARM_ERRATA_743622
 	teq	r3, #0x00200000			@ only present in r2p*
-	mrceq	p15, 0, r10, c15, c0, 1		@ read diagnostic register
-	orreq	r10, r10, #1 << 6		@ set bit #6
-	mcreq	p15, 0, r10, c15, c0, 1		@ write diagnostic register
+	mrceq	p15, 0, r0, c15, c0, 1		@ read diagnostic register
+	orreq	r0, r0, #1 << 6			@ set bit #6
+	mcreq	p15, 0, r0, c15, c0, 1		@ write diagnostic register
 #endif
 #if defined(CONFIG_ARM_ERRATA_751472) && defined(CONFIG_SMP)
 	ALT_SMP(cmp r6, #0x30)			@ present prior to r3p0
 	ALT_UP_B(1f)
-	mrclt	p15, 0, r10, c15, c0, 1		@ read diagnostic register
-	orrlt	r10, r10, #1 << 11		@ set bit #11
-	mcrlt	p15, 0, r10, c15, c0, 1		@ write diagnostic register
+	mrclt	p15, 0, r0, c15, c0, 1		@ read diagnostic register
+	orrlt	r0, r0, #1 << 11		@ set bit #11
+	mcrlt	p15, 0, r0, c15, c0, 1		@ write diagnostic register
 1:
 #endif
 	b	__errata_finish
@@ -343,9 +351,9 @@ __ca9_errata:
 __ca15_errata:
 #ifdef CONFIG_ARM_ERRATA_773022
 	cmp	r6, #0x4			@ only present up to r0p4
-	mrcle	p15, 0, r10, c1, c0, 1		@ read aux control register
-	orrle	r10, r10, #1 << 1		@ disable loop buffer
-	mcrle	p15, 0, r10, c1, c0, 1		@ write aux control register
+	mrcle	p15, 0, r0, c1, c0, 1		@ read aux control register
+	orrle	r0, r0, #1 << 1			@ disable loop buffer
+	mcrle	p15, 0, r0, c1, c0, 1		@ write aux control register
 #endif
 	b	__errata_finish
 
@@ -409,8 +417,8 @@ __v7_setup:
 	bl      v7_flush_dcache_louis
 	ldmia	r12, {r0-r5, r7, r9, r11, lr}
 
-	and	r10, r9, #0xff000000		@ ARM?
-	teq	r10, #0x41000000
+	and	r0, r9, #0xff000000		@ ARM?
+	teq	r0, #0x41000000
 	bne	__errata_finish
 	and	r3, r9, #0x00f00000		@ variant
 	and	r6, r9, #0x0000000f		@ revision
-- 
1.8.3.1
