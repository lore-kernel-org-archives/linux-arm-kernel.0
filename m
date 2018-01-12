From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 12 Jan 2018 13:07:45 +0100
Subject: [PATCH v3 39/41] KVM: arm/arm64: Handle VGICv3 save/restore from the
 main VGIC code on VHE
In-Reply-To: <20180112120747.27999-1-christoffer.dall@linaro.org>
References: <20180112120747.27999-1-christoffer.dall@linaro.org>
Message-ID: <20180112120747.27999-40-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just like we can program the GICv2 hypervisor control interface directly
from the core vgic code, we can do the same for the GICv3 hypervisor
control interface on VHE systems.

We do this by simply calling the save/restore functions when we have VHE
and we can then get rid of the save/restore function calls from the VHE
world switch function.

One caveat is that we now write GICv3 system register state before the
potential early exit path in the run loop, and because we sync back
state in the early exit path, we have to ensure that we read a
consistent GIC state from the sync path, even though we have never
actually run the guest with the newly written GIC state.  We solve this
by inserting an ISB in the early exit path.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/kvm/hyp/switch.c | 3 ---
 virt/kvm/arm/arm.c          | 1 +
 virt/kvm/arm/vgic/vgic.c    | 5 +++++
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 74b7d7598a51..9187afca181a 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -395,8 +395,6 @@ int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 	activate_traps_vhe(vcpu);
 	__activate_vm(vcpu->kvm);
 
-	__vgic_restore_state(vcpu);
-
 	sysreg_restore_guest_state_vhe(guest_ctxt);
 	__debug_switch_to_guest(vcpu);
 
@@ -408,7 +406,6 @@ int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 	} while (fixup_guest_exit(vcpu, &exit_code));
 
 	sysreg_save_guest_state_vhe(guest_ctxt);
-	__vgic_save_state(vcpu);
 
 	deactivate_traps_vhe(vcpu);
 
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 6bce8f9c55db..7aad3aa43dc9 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -716,6 +716,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		if (ret <= 0 || need_new_vmid_gen(vcpu->kvm) ||
 		    kvm_request_pending(vcpu)) {
 			vcpu->mode = OUTSIDE_GUEST_MODE;
+			isb(); /* Ensure work in x_flush_hwstate is committed */
 			kvm_pmu_sync_hwstate(vcpu);
 			if (static_branch_unlikely(&userspace_irqchip_in_use))
 				kvm_timer_sync_hwstate(vcpu);
diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index 12e2a28f437e..d0a19a8c196a 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -19,6 +19,7 @@
 #include <linux/list_sort.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <asm/kvm_hyp.h>
 
 #include "vgic.h"
 
@@ -753,6 +754,8 @@ static inline void vgic_save_state(struct kvm_vcpu *vcpu)
 {
 	if (!static_branch_unlikely(&kvm_vgic_global_state.gicv3_cpuif))
 		vgic_v2_save_state(vcpu);
+	else if (has_vhe())
+		__vgic_v3_save_state(vcpu);
 }
 
 /* Sync back the hardware VGIC state into our emulation after a guest's run. */
@@ -777,6 +780,8 @@ static inline void vgic_restore_state(struct kvm_vcpu *vcpu)
 {
 	if (!static_branch_unlikely(&kvm_vgic_global_state.gicv3_cpuif))
 		vgic_v2_restore_state(vcpu);
+	else if (has_vhe())
+		__vgic_v3_restore_state(vcpu);
 }
 
 /* Flush our emulation state into the GIC hardware before entering the guest. */
-- 
2.14.2
