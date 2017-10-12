From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 12 Oct 2017 12:41:20 +0200
Subject: [PATCH 16/37] KVM: arm64: Remove noop calls to timer save/restore
 from VHE switch
In-Reply-To: <20171012104141.26902-1-christoffer.dall@linaro.org>
References: <20171012104141.26902-1-christoffer.dall@linaro.org>
Message-ID: <20171012104141.26902-17-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VHE switch function calls __timer_enable_traps and
__timer_disable_traps which don't do anything on VHE systems.
Therefore, simply remove these calls from the VHE switch function and
make the functions non-conditional as they are now only called from the
non-VHE switch path.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/kvm/hyp/switch.c |  2 --
 virt/kvm/arm/hyp/timer-sr.c | 10 ++--------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 2cedf12..b98b73b 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -336,7 +336,6 @@ int kvm_vcpu_run(struct kvm_vcpu *vcpu)
 	__activate_vm(vcpu);
 
 	__vgic_restore_state(vcpu);
-	__timer_enable_traps(vcpu);
 
 	/*
 	 * We must restore the 32-bit state before the sysregs, thanks
@@ -356,7 +355,6 @@ int kvm_vcpu_run(struct kvm_vcpu *vcpu)
 
 	__sysreg_save_guest_state(guest_ctxt);
 	__sysreg32_save_state(vcpu);
-	__timer_disable_traps(vcpu);
 	__vgic_save_state(vcpu);
 
 	__deactivate_traps(vcpu);
diff --git a/virt/kvm/arm/hyp/timer-sr.c b/virt/kvm/arm/hyp/timer-sr.c
index f398616..82c217e 100644
--- a/virt/kvm/arm/hyp/timer-sr.c
+++ b/virt/kvm/arm/hyp/timer-sr.c
@@ -53,16 +53,10 @@ void __hyp_text disable_el1_phys_timer_access(void)
 
 void __hyp_text __timer_disable_traps(struct kvm_vcpu *vcpu)
 {
-	/*
-	 * We don't need to do this for VHE since the host kernel runs in EL2
-	 * with HCR_EL2.TGE ==1, which makes those bits have no impact.
-	 */
-	if (!has_vhe())
-		enable_el1_phys_timer_access();
+	enable_el1_phys_timer_access();
 }
 
 void __hyp_text __timer_enable_traps(struct kvm_vcpu *vcpu)
 {
-	if (!has_vhe())
-		disable_el1_phys_timer_access();
+	disable_el1_phys_timer_access();
 }
-- 
2.9.0
