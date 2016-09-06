From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  6 Sep 2016 14:02:04 +0100
Subject: [PATCH 06/19] arm64: KVM: Route asynchronous aborts
In-Reply-To: <1473166937-15271-1-git-send-email-marc.zyngier@arm.com>
References: <1473166937-15271-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1473166937-15271-7-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we now have some basic handling to EL1-triggered aborts, we can
actually report them to KVM.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp/hyp-entry.S | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index d6cae54..d2f6640 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -120,6 +120,12 @@ el1_irq:
 	mov	x0, #ARM_EXCEPTION_IRQ
 	b	__guest_exit
 
+el1_error:
+	stp     x0, x1, [sp, #-16]!
+	mrs	x1, tpidr_el2
+	mov	x0, #ARM_EXCEPTION_EL1_SERROR
+	b	__guest_exit
+
 ENTRY(__hyp_do_panic)
 	mov	lr, #(PSR_F_BIT | PSR_I_BIT | PSR_A_BIT | PSR_D_BIT |\
 		      PSR_MODE_EL1h)
@@ -148,7 +154,6 @@ ENDPROC(\label)
 	invalid_vector	el1_sync_invalid
 	invalid_vector	el1_irq_invalid
 	invalid_vector	el1_fiq_invalid
-	invalid_vector	el1_error_invalid
 
 	.ltorg
 
@@ -168,10 +173,10 @@ ENTRY(__kvm_hyp_vector)
 	ventry	el1_sync			// Synchronous 64-bit EL1
 	ventry	el1_irq				// IRQ 64-bit EL1
 	ventry	el1_fiq_invalid			// FIQ 64-bit EL1
-	ventry	el1_error_invalid		// Error 64-bit EL1
+	ventry	el1_error			// Error 64-bit EL1
 
 	ventry	el1_sync			// Synchronous 32-bit EL1
 	ventry	el1_irq				// IRQ 32-bit EL1
 	ventry	el1_fiq_invalid			// FIQ 32-bit EL1
-	ventry	el1_error_invalid		// Error 32-bit EL1
+	ventry	el1_error			// Error 32-bit EL1
 ENDPROC(__kvm_hyp_vector)
-- 
2.1.4
