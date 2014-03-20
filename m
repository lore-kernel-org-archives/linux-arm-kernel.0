From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 20 Mar 2014 11:53:04 +0000
Subject: [PATCH v2 17/19] arm64: KVM: move hcr_el2 setting into
 vgic-v2-switch.S
In-Reply-To: <1395316386-12617-1-git-send-email-marc.zyngier@arm.com>
References: <1395316386-12617-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1395316386-12617-18-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GICv3 requires the hcr_el2 switch to be tightly coupled with some
of the interrupt controller's register switch.

In order to have similar code paths, start moving the hcr_el2
manipulation code to the GICv2 switch code.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp.S            | 7 -------
 arch/arm64/kvm/vgic-v2-switch.S | 8 ++++++++
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index aed72d0..92b9120 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -335,11 +335,6 @@
 .endm
 
 .macro activate_traps
-	ldr	x2, [x0, #VCPU_IRQ_LINES]
-	ldr	x1, [x0, #VCPU_HCR_EL2]
-	orr	x2, x2, x1
-	msr	hcr_el2, x2
-
 	ldr	x2, =(CPTR_EL2_TTA)
 	msr	cptr_el2, x2
 
@@ -353,8 +348,6 @@
 .endm
 
 .macro deactivate_traps
-	mov	x2, #HCR_RW
-	msr	hcr_el2, x2
 	msr	cptr_el2, xzr
 	msr	hstr_el2, xzr
 
diff --git a/arch/arm64/kvm/vgic-v2-switch.S b/arch/arm64/kvm/vgic-v2-switch.S
index c5dc777..d36cd7a 100644
--- a/arch/arm64/kvm/vgic-v2-switch.S
+++ b/arch/arm64/kvm/vgic-v2-switch.S
@@ -85,6 +85,9 @@ CPU_BE(	rev	w5, w5 )
 	sub	w4, w4, #1
 	cbnz	w4, 1b
 2:
+	mov	x2, #HCR_RW
+	msr	hcr_el2, x2
+	isb
 .endm
 
 /*
@@ -92,6 +95,11 @@ CPU_BE(	rev	w5, w5 )
  * x0: Register pointing to VCPU struct
  */
 .macro restore_vgic_v2_state
+	ldr	x2, [x0, #VCPU_IRQ_LINES]
+	ldr	x1, [x0, #VCPU_HCR_EL2]
+	orr	x2, x2, x1
+	msr	hcr_el2, x2
+
 	/* Get VGIC VCTRL base into x2 */
 	ldr	x2, [x0, #VCPU_KVM]
 	kern_hyp_va	x2
-- 
1.8.3.4
