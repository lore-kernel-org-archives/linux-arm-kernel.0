From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 16 Mar 2015 10:59:43 +0000
Subject: [PATCH] arm: KVM: force execution of HCPTR access on VM exit
Message-ID: <1426503583-8958-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On VM entry, we disable access to the VFP registers in order to
perform a lazy save/restore of these registers.

On VM exit, we restore access, test if we did enable them before,
and save/restore the guest/host registers if necessary. In this
sequence, the FPEXC register is always accessed, irrespective
of the trapping configuration.

If the guest didn't touch the VFP registers, then the HCPTR access
has now enabled such access, but we're missing a barrier to ensure
architectural execution of the new HCPTR configuration. If the HCPTR
access has been delayed/reordered, the subsequent access to FPEXC
will cause a trap, which we aren't prepared to handle at all.

The fix is to introduce a barrier that only takes place if the
guest hasn't accessed its view of the VFP registers, making
the access to FPEXC safe.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/interrupts.S | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index 79caf79..3ac7aca 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -175,10 +175,13 @@ __kvm_vcpu_return:
 #ifdef CONFIG_VFPv3
 	@ Save floating point registers we if let guest use them.
 	tst	r2, #(HCPTR_TCP(10) | HCPTR_TCP(11))
-	bne	after_vfp_restore
+	beq	1f
+
+	isb	@ Force execution of HCPTR if we've just reenabled VFP access
+	b	after_vfp_restore
 
 	@ Switch VFP/NEON hardware state to the host's
-	add	r7, vcpu, #VCPU_VFP_GUEST
+1:	add	r7, vcpu, #VCPU_VFP_GUEST
 	store_vfp_state r7
 	add	r7, vcpu, #VCPU_VFP_HOST
 	ldr	r7, [r7]
-- 
2.1.4
