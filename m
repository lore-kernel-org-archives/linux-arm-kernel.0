From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 28 Mar 2018 13:51:57 +0100
Subject: [PATCH 28/85] KVM: arm64: Don't deactivate VM on VHE systems
In-Reply-To: <20180328125254.31380-1-marc.zyngier@arm.com>
References: <20180328125254.31380-1-marc.zyngier@arm.com>
Message-ID: <20180328125254.31380-29-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

There is no need to reset the VTTBR to zero when exiting the guest on
VHE systems.  VHE systems don't use stage 2 translations for the EL2&0
translation regime used by the host.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp/switch.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 1e26a81c0a16..9ffd802e775d 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -156,9 +156,8 @@ static void __hyp_text __deactivate_traps(struct kvm_vcpu *vcpu)
 	write_sysreg(0, pmuserenr_el0);
 }
 
-static void __hyp_text __activate_vm(struct kvm_vcpu *vcpu)
+static void __hyp_text __activate_vm(struct kvm *kvm)
 {
-	struct kvm *kvm = kern_hyp_va(vcpu->kvm);
 	write_sysreg(kvm->arch.vttbr, vttbr_el2);
 }
 
@@ -377,7 +376,7 @@ int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 	__sysreg_save_host_state(host_ctxt);
 
 	__activate_traps(vcpu);
-	__activate_vm(vcpu);
+	__activate_vm(vcpu->kvm);
 
 	__vgic_restore_state(vcpu);
 	__timer_enable_traps(vcpu);
@@ -405,7 +404,6 @@ int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 	__vgic_save_state(vcpu);
 
 	__deactivate_traps(vcpu);
-	__deactivate_vm(vcpu);
 
 	__sysreg_restore_host_state(host_ctxt);
 
@@ -440,7 +438,7 @@ int __hyp_text __kvm_vcpu_run_nvhe(struct kvm_vcpu *vcpu)
 	__sysreg_save_host_state(host_ctxt);
 
 	__activate_traps(vcpu);
-	__activate_vm(vcpu);
+	__activate_vm(kern_hyp_va(vcpu->kvm));
 
 	__vgic_restore_state(vcpu);
 	__timer_enable_traps(vcpu);
-- 
2.14.2
