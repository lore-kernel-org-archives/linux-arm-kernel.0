From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 12 Oct 2017 12:41:38 +0200
Subject: [PATCH 34/37] KVM: arm/arm64: Handle VGICv3 save/restore from the
 main VGIC code on VHE
In-Reply-To: <20171012104141.26902-1-christoffer.dall@linaro.org>
References: <20171012104141.26902-1-christoffer.dall@linaro.org>
Message-ID: <20171012104141.26902-35-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just like we can program the GICv2 hypervisor control interface directly
from the core vgic code, we can do the same for the GICv3 hypervisor
control interface on VHE systems.

We do this by simply calling the save/restore functions when we have VHE
and we can then get rid of the save/restore function calls from the VHE
world switch function.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/kvm/hyp/switch.c | 3 ---
 virt/kvm/arm/vgic/vgic.c    | 4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 90da506..0cdf6ae 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -366,8 +366,6 @@ int kvm_vcpu_run(struct kvm_vcpu *vcpu)
 	activate_traps_vhe(vcpu);
 	__activate_vm(vcpu);
 
-	__vgic_restore_state(vcpu);
-
 	sysreg_restore_guest_state_vhe(guest_ctxt);
 	__debug_switch_to_guest(vcpu);
 
@@ -380,7 +378,6 @@ int kvm_vcpu_run(struct kvm_vcpu *vcpu)
 		goto again;
 
 	sysreg_save_guest_state_vhe(guest_ctxt);
-	__vgic_save_state(vcpu);
 
 	deactivate_traps_vhe(vcpu);
 
diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index 790fd66..f0072f7 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -689,6 +689,8 @@ static inline void vgic_save_state(struct kvm_vcpu *vcpu)
 {
 	if (!static_branch_unlikely(&kvm_vgic_global_state.gicv3_cpuif))
 		vgic_v2_save_state(vcpu);
+	else if (has_vhe())
+		__vgic_v3_save_state(vcpu);
 }
 
 /* Sync back the hardware VGIC state into our emulation after a guest's run. */
@@ -711,6 +713,8 @@ static inline void vgic_restore_state(struct kvm_vcpu *vcpu)
 {
 	if (!static_branch_unlikely(&kvm_vgic_global_state.gicv3_cpuif))
 		vgic_v2_restore_state(vcpu);
+	else if (has_vhe())
+		__vgic_v3_restore_state(vcpu);
 }
 
 /* Flush our emulation state into the GIC hardware before entering the guest. */
-- 
2.9.0
