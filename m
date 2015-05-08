From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 08 May 2015 18:35:25 +0100
Subject: [PATCH 1/3] ARM: proc-v7: move CPU errata out of line
In-Reply-To: <20150508173505.GL2067@n2100.arm.linux.org.uk>
References: <20150508173505.GL2067@n2100.arm.linux.org.uk>
Message-ID: <E1YqmBJ-0000NW-TI@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than having a long sprawling __v7_setup function, which is hard
to maintain properly, move the CPU errata out of line.

While doing this, it was discovered that the Cortex-A15 errata had been
incorrectly added:

	ldr	r10, =0x00000c08	@ Cortex-A8 primary part number
	teq	r0, r10
	bne	2f
/* Cortex-A8 errata */
	b	3f
2:	ldr	r10, =0x00000c09	@ Cortex-A9 primary part number
	teq	r0, r10
	bne	3f
/* Cortex-A9 errata */
3:	ldr	r10, =0x00000c0f	@ Cortex-A15 primary part number
	teq	r0, r10
	bne	4f
/* Cortex-A15 errata */
4:

This results in the Cortex-A15 test always being executed after the
Cortex-A8 and Cortex-A9 errata, which is obviously not what is intended.
The 'b 3f' labels should have been updated to 'b 4f'.  The new structure
of:

	/* Cortex-A8 Errata */
	ldr	r10, =0x00000c08	@ Cortex-A8 primary part number
	teq	r0, r10
	beq	__ca8_errata

	/* Cortex-A9 Errata */
	ldr	r10, =0x00000c09	@ Cortex-A9 primary part number
	teq	r0, r10
	beq	__ca9_errata

	/* Cortex-A15 Errata */
	ldr	r10, =0x00000c0f	@ Cortex-A15 primary part number
	teq	r0, r10
	beq	__ca15_errata

__errata_finish:

is much cleaner and easier to see that this kind of thing doesn't
happen.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/proc-v7.S | 143 +++++++++++++++++++++++++++-----------------------
 1 file changed, 78 insertions(+), 65 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 873230912894..48031ee36e4c 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -252,6 +252,12 @@ ENDPROC(cpu_pj4b_do_resume)
  *	Initialise TLB, Caches, and MMU state ready to switch the MMU
  *	on.  Return in r0 the new CP15 C1 control register setting.
  *
+ *	r1, r2, r4, r5, r9 must be preserved.
+ *	r4: TTBR0 (low word)
+ *	r5: TTBR0 (high word if LPAE)
+ *	r8: TTBR1
+ *	r9: Main ID register
+ *
  *	This should be able to cover all ARMv7 cores.
  *
  *	It is assumed that:
@@ -279,6 +285,70 @@ __v7_ca17mp_setup:
 #endif
 	b	__v7_setup
 
+__ca8_errata:
+#if defined(CONFIG_ARM_ERRATA_430973) && !defined(CONFIG_ARCH_MULTIPLATFORM)
+	teq	r3, #0x00100000			@ only present in r1p*
+	mrceq	p15, 0, r10, c1, c0, 1		@ read aux control register
+	orreq	r10, r10, #(1 << 6)		@ set IBE to 1
+	mcreq	p15, 0, r10, c1, c0, 1		@ write aux control register
+#endif
+#ifdef CONFIG_ARM_ERRATA_458693
+	teq	r6, #0x20			@ only present in r2p0
+	mrceq	p15, 0, r10, c1, c0, 1		@ read aux control register
+	orreq	r10, r10, #(1 << 5)		@ set L1NEON to 1
+	orreq	r10, r10, #(1 << 9)		@ set PLDNOP to 1
+	mcreq	p15, 0, r10, c1, c0, 1		@ write aux control register
+#endif
+#ifdef CONFIG_ARM_ERRATA_460075
+	teq	r6, #0x20			@ only present in r2p0
+	mrceq	p15, 1, r10, c9, c0, 2		@ read L2 cache aux ctrl register
+	tsteq	r10, #1 << 22
+	orreq	r10, r10, #(1 << 22)		@ set the Write Allocate disable bit
+	mcreq	p15, 1, r10, c9, c0, 2		@ write the L2 cache aux ctrl register
+#endif
+	b	__errata_finish
+
+__ca9_errata:
+#ifdef CONFIG_ARM_ERRATA_742230
+	cmp	r6, #0x22			@ only present up to r2p2
+	mrcle	p15, 0, r10, c15, c0, 1		@ read diagnostic register
+	orrle	r10, r10, #1 << 4		@ set bit #4
+	mcrle	p15, 0, r10, c15, c0, 1		@ write diagnostic register
+#endif
+#ifdef CONFIG_ARM_ERRATA_742231
+	teq	r6, #0x20			@ present in r2p0
+	teqne	r6, #0x21			@ present in r2p1
+	teqne	r6, #0x22			@ present in r2p2
+	mrceq	p15, 0, r10, c15, c0, 1		@ read diagnostic register
+	orreq	r10, r10, #1 << 12		@ set bit #12
+	orreq	r10, r10, #1 << 22		@ set bit #22
+	mcreq	p15, 0, r10, c15, c0, 1		@ write diagnostic register
+#endif
+#ifdef CONFIG_ARM_ERRATA_743622
+	teq	r3, #0x00200000			@ only present in r2p*
+	mrceq	p15, 0, r10, c15, c0, 1		@ read diagnostic register
+	orreq	r10, r10, #1 << 6		@ set bit #6
+	mcreq	p15, 0, r10, c15, c0, 1		@ write diagnostic register
+#endif
+#if defined(CONFIG_ARM_ERRATA_751472) && defined(CONFIG_SMP)
+	ALT_SMP(cmp r6, #0x30)			@ present prior to r3p0
+	ALT_UP_B(1f)
+	mrclt	p15, 0, r10, c15, c0, 1		@ read diagnostic register
+	orrlt	r10, r10, #1 << 11		@ set bit #11
+	mcrlt	p15, 0, r10, c15, c0, 1		@ write diagnostic register
+1:
+#endif
+	b	__errata_finish
+
+__ca15_errata:
+#ifdef CONFIG_ARM_ERRATA_773022
+	cmp	r6, #0x4			@ only present up to r0p4
+	mrcle	p15, 0, r10, c1, c0, 1		@ read aux control register
+	orrle	r10, r10, #1 << 1		@ disable loop buffer
+	mcrle	p15, 0, r10, c1, c0, 1		@ write aux control register
+#endif
+	b	__errata_finish
+
 __v7_pj4b_setup:
 #ifdef CONFIG_CPU_PJ4B
 
@@ -342,7 +412,7 @@ __v7_setup:
 	mrc	p15, 0, r0, c0, c0, 0		@ read main ID register
 	and	r10, r0, #0xff000000		@ ARM?
 	teq	r10, #0x41000000
-	bne	3f
+	bne	__errata_finish
 	and	r3, r0, #0x00f00000		@ variant
 	and	r6, r0, #0x0000000f		@ revision
 	orr	r6, r6, r3, lsr #20-4		@ combine variant and revision
@@ -351,77 +421,20 @@ __v7_setup:
 	/* Cortex-A8 Errata */
 	ldr	r10, =0x00000c08		@ Cortex-A8 primary part number
 	teq	r0, r10
-	bne	2f
-#if defined(CONFIG_ARM_ERRATA_430973) && !defined(CONFIG_ARCH_MULTIPLATFORM)
-
-	teq	r3, #0x00100000			@ only present in r1p*
-	mrceq	p15, 0, r10, c1, c0, 1		@ read aux control register
-	orreq	r10, r10, #(1 << 6)		@ set IBE to 1
-	mcreq	p15, 0, r10, c1, c0, 1		@ write aux control register
-#endif
-#ifdef CONFIG_ARM_ERRATA_458693
-	teq	r6, #0x20			@ only present in r2p0
-	mrceq	p15, 0, r10, c1, c0, 1		@ read aux control register
-	orreq	r10, r10, #(1 << 5)		@ set L1NEON to 1
-	orreq	r10, r10, #(1 << 9)		@ set PLDNOP to 1
-	mcreq	p15, 0, r10, c1, c0, 1		@ write aux control register
-#endif
-#ifdef CONFIG_ARM_ERRATA_460075
-	teq	r6, #0x20			@ only present in r2p0
-	mrceq	p15, 1, r10, c9, c0, 2		@ read L2 cache aux ctrl register
-	tsteq	r10, #1 << 22
-	orreq	r10, r10, #(1 << 22)		@ set the Write Allocate disable bit
-	mcreq	p15, 1, r10, c9, c0, 2		@ write the L2 cache aux ctrl register
-#endif
-	b	3f
+	beq	__ca8_errata
 
 	/* Cortex-A9 Errata */
-2:	ldr	r10, =0x00000c09		@ Cortex-A9 primary part number
+	ldr	r10, =0x00000c09		@ Cortex-A9 primary part number
 	teq	r0, r10
-	bne	3f
-#ifdef CONFIG_ARM_ERRATA_742230
-	cmp	r6, #0x22			@ only present up to r2p2
-	mrcle	p15, 0, r10, c15, c0, 1		@ read diagnostic register
-	orrle	r10, r10, #1 << 4		@ set bit #4
-	mcrle	p15, 0, r10, c15, c0, 1		@ write diagnostic register
-#endif
-#ifdef CONFIG_ARM_ERRATA_742231
-	teq	r6, #0x20			@ present in r2p0
-	teqne	r6, #0x21			@ present in r2p1
-	teqne	r6, #0x22			@ present in r2p2
-	mrceq	p15, 0, r10, c15, c0, 1		@ read diagnostic register
-	orreq	r10, r10, #1 << 12		@ set bit #12
-	orreq	r10, r10, #1 << 22		@ set bit #22
-	mcreq	p15, 0, r10, c15, c0, 1		@ write diagnostic register
-#endif
-#ifdef CONFIG_ARM_ERRATA_743622
-	teq	r3, #0x00200000			@ only present in r2p*
-	mrceq	p15, 0, r10, c15, c0, 1		@ read diagnostic register
-	orreq	r10, r10, #1 << 6		@ set bit #6
-	mcreq	p15, 0, r10, c15, c0, 1		@ write diagnostic register
-#endif
-#if defined(CONFIG_ARM_ERRATA_751472) && defined(CONFIG_SMP)
-	ALT_SMP(cmp r6, #0x30)			@ present prior to r3p0
-	ALT_UP_B(1f)
-	mrclt	p15, 0, r10, c15, c0, 1		@ read diagnostic register
-	orrlt	r10, r10, #1 << 11		@ set bit #11
-	mcrlt	p15, 0, r10, c15, c0, 1		@ write diagnostic register
-1:
-#endif
+	beq	__ca9_errata
 
 	/* Cortex-A15 Errata */
-3:	ldr	r10, =0x00000c0f		@ Cortex-A15 primary part number
+	ldr	r10, =0x00000c0f		@ Cortex-A15 primary part number
 	teq	r0, r10
-	bne	4f
-
-#ifdef CONFIG_ARM_ERRATA_773022
-	cmp	r6, #0x4			@ only present up to r0p4
-	mrcle	p15, 0, r10, c1, c0, 1		@ read aux control register
-	orrle	r10, r10, #1 << 1		@ disable loop buffer
-	mcrle	p15, 0, r10, c1, c0, 1		@ write aux control register
-#endif
+	beq	__ca15_errata
 
-4:	mov	r10, #0
+__errata_finish:
+	mov	r10, #0
 	mcr	p15, 0, r10, c7, c5, 0		@ I+BTB cache invalidate
 #ifdef CONFIG_MMU
 	mcr	p15, 0, r10, c8, c7, 0		@ invalidate I + D TLBs
-- 
1.8.3.1
