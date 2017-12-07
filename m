From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu,  7 Dec 2017 18:06:07 +0100
Subject: [PATCH v2 13/36] KVM: arm64: Don't deactivate VM on VHE systems
In-Reply-To: <20171207170630.592-1-christoffer.dall@linaro.org>
References: <20171207170630.592-1-christoffer.dall@linaro.org>
Message-ID: <20171207170630.592-14-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to reset the VTTBR to zero when exiting the guest on
VHE systems.  VHE systems don't use stage 2 translations for the EL2&0
translation regime used by the host.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---

Notes:
    Changes since v1:
     - Changed __activate_vm to take a kvm pointer
     - No longer adding inline attributes to functions

 arch/arm64/kvm/hyp/switch.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index eac2202a179c..e783e2371b7c 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -140,9 +140,8 @@ static void __hyp_text __deactivate_traps(struct kvm_vcpu *vcpu)
 	write_sysreg(0, pmuserenr_el0);
 }
 
-static void __hyp_text __activate_vm(struct kvm_vcpu *vcpu)
+static void __hyp_text __activate_vm(struct kvm *kvm)
 {
-	struct kvm *kvm = kern_hyp_va(vcpu->kvm);
 	write_sysreg(kvm->arch.vttbr, vttbr_el2);
 }
 
@@ -356,7 +355,7 @@ int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 	__sysreg_save_host_state(host_ctxt);
 
 	__activate_traps(vcpu);
-	__activate_vm(vcpu);
+	__activate_vm(vcpu->kvm);
 
 	__vgic_restore_state(vcpu);
 	__timer_enable_traps(vcpu);
@@ -382,7 +381,6 @@ int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 	__vgic_save_state(vcpu);
 
 	__deactivate_traps(vcpu);
-	__deactivate_vm(vcpu);
 
 	__sysreg_restore_host_state(host_ctxt);
 
@@ -411,7 +409,7 @@ int __hyp_text __kvm_vcpu_run_nvhe(struct kvm_vcpu *vcpu)
 	__sysreg_save_host_state(host_ctxt);
 
 	__activate_traps(vcpu);
-	__activate_vm(vcpu);
+	__activate_vm(kern_hyp_va(vcpu->kvm));
 
 	__vgic_restore_state(vcpu);
 	__timer_enable_traps(vcpu);
-- 
2.14.2
