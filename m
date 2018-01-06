From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat,  6 Jan 2018 12:09:07 +0000
Subject: [PATCH 3/3] arm: KVM: Invalidate BTB on guest exit
In-Reply-To: <20180106120907.26701-1-marc.zyngier@arm.com>
References: <20180106120907.26701-1-marc.zyngier@arm.com>
Message-ID: <20180106120907.26701-4-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to avoid aliasing attacks against the branch predictor,
let's invalidate the BTB on guest exit. This is made complicated
by the fact that we cannot take a branch before invalidating the
BTB.

Another thing is that we perform the invalidation on all
implementations, no matter if they are affected or not.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/hyp/hyp-entry.S | 74 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 63 insertions(+), 11 deletions(-)

diff --git a/arch/arm/kvm/hyp/hyp-entry.S b/arch/arm/kvm/hyp/hyp-entry.S
index 95a2faefc070..aa8adfa64ec9 100644
--- a/arch/arm/kvm/hyp/hyp-entry.S
+++ b/arch/arm/kvm/hyp/hyp-entry.S
@@ -61,15 +61,60 @@
 __kvm_hyp_vector:
 	.global __kvm_hyp_vector
 
-	@ Hyp-mode exception vector
-	W(b)	hyp_reset
-	W(b)	hyp_undef
-	W(b)	hyp_svc
-	W(b)	hyp_pabt
-	W(b)	hyp_dabt
-	W(b)	hyp_hvc
-	W(b)	hyp_irq
-	W(b)	hyp_fiq
+	/*
+	 * We encode the exception entry in the bottom 3 bits of
+	 * SP, and we have to guarantee to be 8 bytes aligned.
+	 */
+	add	sp, sp, #1	/* Reset 	  7 */
+	add	sp, sp, #1	/* Undef	  6 */
+	add	sp, sp, #1	/* Syscall	  5 */
+	add	sp, sp, #1	/* Prefetch abort 4 */
+	add	sp, sp, #1	/* Data abort	  3 */
+	add	sp, sp, #1	/* HVC		  2 */
+	add	sp, sp, #1	/* IRQ		  1 */
+	add	sp, sp, #1	/* FIQ		  0 */
+
+	sub	sp, sp, #1
+
+	mcr	p15, 0, r0, c7, c5, 6	/* BPIALL */
+	isb
+
+	/*
+	 * As we cannot use any temporary registers and cannot
+	 * clobber SP, we can decode the exception entry using
+	 * an unrolled binary search.
+	 */
+	tst	sp, #4
+	bne	1f
+
+	tst	sp, #2
+	bne	3f
+
+	tst	sp, #1
+	bic	sp, sp, #0x7
+	bne	hyp_irq
+	b	hyp_irq
+
+1:
+	tst	sp, #2
+	bne	2f
+
+	tst	sp, #1
+	bic	sp, sp, #0x7
+	bne	hyp_svc
+	b	hyp_pabt
+
+2:
+	tst	sp, #1
+	bic	sp, sp, #0x7
+	bne	hyp_reset
+	b	hyp_undef
+
+3:
+	tst	sp, #1
+	bic	sp, sp, #0x7
+	bne	hyp_dabt
+	b	hyp_hvc
 
 .macro invalid_vector label, cause
 	.align
@@ -149,7 +194,14 @@ hyp_hvc:
 	bx	ip
 
 1:
-	push	{lr}
+	/*
+	 * Pushing r2 here is just a way of keeping the stack aligned to
+	 * 8 bytes on any path that can trigger a HYP exception. Here,
+	 * we may well be about to jump into the guest, and the guest
+	 * exit would otherwise be badly decoded by our fancy
+	 * "decode-exception-without-a-branch" code...
+	 */
+	push	{r2, lr}
 
 	mov	lr, r0
 	mov	r0, r1
@@ -159,7 +211,7 @@ hyp_hvc:
 THUMB(	orr	lr, #1)
 	blx	lr			@ Call the HYP function
 
-	pop	{lr}
+	pop	{r2, lr}
 	eret
 
 guest_trap:
-- 
2.14.2
