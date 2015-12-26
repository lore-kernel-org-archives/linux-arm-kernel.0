From: m.smarduch@samsung.com (Mario Smarduch)
Date: Sat, 26 Dec 2015 13:54:58 -0800
Subject: [PATCH v6 4/6] arm: KVM: Delete unused macros
In-Reply-To: <1451166900-3711-1-git-send-email-m.smarduch@samsung.com>
References: <1451166900-3711-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1451166900-3711-5-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

set_hcptr is no longer used so delete it.

Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm/kvm/interrupts_head.S | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/arch/arm/kvm/interrupts_head.S b/arch/arm/kvm/interrupts_head.S
index 51a5950..f4d8311 100644
--- a/arch/arm/kvm/interrupts_head.S
+++ b/arch/arm/kvm/interrupts_head.S
@@ -589,35 +589,6 @@ ARM_BE8(rev	r6, r6  )
 	mcr	p15, 4, r2, c1, c1, 3
 .endm
 
-/* Configures the HCPTR (Hyp Coprocessor Trap Register) on entry/return
- * (hardware reset value is 0). Keep previous value in r2.
- * An ISB is emited on vmexit/vmtrap, but executed on vmexit only if
- * VFP wasn't already enabled (always executed on vmtrap).
- * If a label is specified with vmexit, it is branched to if VFP wasn't
- * enabled.
- */
-.macro set_hcptr operation, mask, label = none
-	mrc	p15, 4, r2, c1, c1, 2
-	ldr	r3, =\mask
-	.if \operation == vmentry
-	orr	r3, r2, r3		@ Trap coproc-accesses defined in mask
-	.else
-	bic	r3, r2, r3		@ Don't trap defined coproc-accesses
-	.endif
-	mcr	p15, 4, r3, c1, c1, 2
-	.if \operation != vmentry
-	.if \operation == vmexit
-	tst	r2, #(HCPTR_TCP(10) | HCPTR_TCP(11))
-	beq	1f
-	.endif
-	isb
-	.if \label != none
-	b	\label
-	.endif
-1:
-	.endif
-.endm
-
 /* Configures the HDCR (Hyp Debug Configuration Register) on entry/return
  * (hardware reset value is 0) */
 .macro set_hdcr operation
-- 
1.9.1
