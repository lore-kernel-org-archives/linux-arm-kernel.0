From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  1 Jun 2018 16:27:33 +0100
Subject: [PATCH 19/33] KVM: arm64: Fold redundant exit code checks out of
 fixup_guest_exit()
In-Reply-To: <20180601152747.23613-1-marc.zyngier@arm.com>
References: <20180601152747.23613-1-marc.zyngier@arm.com>
Message-ID: <20180601152747.23613-20-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Martin <Dave.Martin@arm.com>

The entire tail of fixup_guest_exit() is contained in if statements
of the form if (x && *exit_code == ARM_EXCEPTION_TRAP).  As a result,
we can check just once and bail out of the function early, allowing
the remaining if conditions to be simplified.

The only awkward case is where *exit_code is changed to
ARM_EXCEPTION_EL1_SERROR in the case of an illegal GICv2 CPU
interface access: in that case, the GICv3 trap handling code is
skipped using a goto.  This avoids pointlessly evaluating the
static branch check for the GICv3 case, even though we can't have
vgic_v2_cpuif_trap and vgic_v3_cpuif_trap true simultaneously
unless we have a GICv3 and GICv2 on the host: that sounds stupid,
but I haven't satisfied myself that it can't happen.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp/switch.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 18d0faa8c806..4fbee9502162 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -387,11 +387,13 @@ static bool __hyp_text fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
 	 * same PC once the SError has been injected, and replay the
 	 * trapping instruction.
 	 */
-	if (*exit_code == ARM_EXCEPTION_TRAP && !__populate_fault_info(vcpu))
+	if (*exit_code != ARM_EXCEPTION_TRAP)
+		goto exit;
+
+	if (!__populate_fault_info(vcpu))
 		return true;
 
-	if (static_branch_unlikely(&vgic_v2_cpuif_trap) &&
-	    *exit_code == ARM_EXCEPTION_TRAP) {
+	if (static_branch_unlikely(&vgic_v2_cpuif_trap)) {
 		bool valid;
 
 		valid = kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_DABT_LOW &&
@@ -417,11 +419,12 @@ static bool __hyp_text fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
 					*vcpu_cpsr(vcpu) &= ~DBG_SPSR_SS;
 				*exit_code = ARM_EXCEPTION_EL1_SERROR;
 			}
+
+			goto exit;
 		}
 	}
 
 	if (static_branch_unlikely(&vgic_v3_cpuif_trap) &&
-	    *exit_code == ARM_EXCEPTION_TRAP &&
 	    (kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_SYS64 ||
 	     kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_CP15_32)) {
 		int ret = __vgic_v3_perform_cpuif_access(vcpu);
@@ -430,6 +433,7 @@ static bool __hyp_text fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
 			return true;
 	}
 
+exit:
 	/* Return to the host kernel and handle the exit */
 	return false;
 }
-- 
2.17.1
