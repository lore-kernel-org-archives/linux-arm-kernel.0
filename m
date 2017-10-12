From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 12 Oct 2017 12:41:19 +0200
Subject: [PATCH 15/37] KVM: arm64: Don't deactivate VM on VHE systems
In-Reply-To: <20171012104141.26902-1-christoffer.dall@linaro.org>
References: <20171012104141.26902-1-christoffer.dall@linaro.org>
Message-ID: <20171012104141.26902-16-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to reset the VTTBR to zero when exiting the guest on
VHE systems.  VHE systems don't use stage 2 translations for the EL2&0
translation regime used by the host.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/kvm/hyp/switch.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index b72dc66..2cedf12 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -136,13 +136,13 @@ static void __hyp_text __deactivate_traps(struct kvm_vcpu *vcpu)
 	write_sysreg(0, pmuserenr_el0);
 }
 
-static void __hyp_text __activate_vm(struct kvm_vcpu *vcpu)
+static inline void __hyp_text __activate_vm(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = kern_hyp_va(vcpu->kvm);
 	write_sysreg(kvm->arch.vttbr, vttbr_el2);
 }
 
-static void __hyp_text __deactivate_vm(struct kvm_vcpu *vcpu)
+static inline void __hyp_text __deactivate_vm(struct kvm_vcpu *vcpu)
 {
 	write_sysreg(0, vttbr_el2);
 }
@@ -360,7 +360,6 @@ int kvm_vcpu_run(struct kvm_vcpu *vcpu)
 	__vgic_save_state(vcpu);
 
 	__deactivate_traps(vcpu);
-	__deactivate_vm(vcpu);
 
 	__sysreg_restore_host_state(host_ctxt);
 
-- 
2.9.0
