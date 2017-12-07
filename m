From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu,  7 Dec 2017 18:06:08 +0100
Subject: [PATCH v2 14/36] KVM: arm64: Remove noop calls to timer save/restore
 from VHE switch
In-Reply-To: <20171207170630.592-1-christoffer.dall@linaro.org>
References: <20171207170630.592-1-christoffer.dall@linaro.org>
Message-ID: <20171207170630.592-15-christoffer.dall@linaro.org>
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
 virt/kvm/arm/hyp/timer-sr.c | 36 ++++++++++++++----------------------
 2 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index e783e2371b7c..09aafa0470f7 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -358,7 +358,6 @@ int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 	__activate_vm(vcpu->kvm);
 
 	__vgic_restore_state(vcpu);
-	__timer_enable_traps(vcpu);
 
 	/*
 	 * We must restore the 32-bit state before the sysregs, thanks
@@ -377,7 +376,6 @@ int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 
 	__sysreg_save_guest_state(guest_ctxt);
 	__sysreg32_save_state(vcpu);
-	__timer_disable_traps(vcpu);
 	__vgic_save_state(vcpu);
 
 	__deactivate_traps(vcpu);
diff --git a/virt/kvm/arm/hyp/timer-sr.c b/virt/kvm/arm/hyp/timer-sr.c
index f24404b3c8df..752b37f9133c 100644
--- a/virt/kvm/arm/hyp/timer-sr.c
+++ b/virt/kvm/arm/hyp/timer-sr.c
@@ -29,32 +29,24 @@ void __hyp_text __kvm_timer_set_cntvoff(u32 cntvoff_low, u32 cntvoff_high)
 
 void __hyp_text __timer_disable_traps(struct kvm_vcpu *vcpu)
 {
-	/*
-	 * We don't need to do this for VHE since the host kernel runs in EL2
-	 * with HCR_EL2.TGE ==1, which makes those bits have no impact.
-	 */
-	if (!has_vhe()) {
-		u64 val;
+	u64 val;
 
-		/* Allow physical timer/counter access for the host */
-		val = read_sysreg(cnthctl_el2);
-		val |= CNTHCTL_EL1PCTEN | CNTHCTL_EL1PCEN;
-		write_sysreg(val, cnthctl_el2);
-	}
+	/* Allow physical timer/counter access for the host */
+	val = read_sysreg(cnthctl_el2);
+	val |= CNTHCTL_EL1PCTEN | CNTHCTL_EL1PCEN;
+	write_sysreg(val, cnthctl_el2);
 }
 
 void __hyp_text __timer_enable_traps(struct kvm_vcpu *vcpu)
 {
-	if (!has_vhe()) {
-		u64 val;
+	u64 val;
 
-		/*
-		 * Disallow physical timer access for the guest
-		 * Physical counter access is allowed
-		 */
-		val = read_sysreg(cnthctl_el2);
-		val &= ~CNTHCTL_EL1PCEN;
-		val |= CNTHCTL_EL1PCTEN;
-		write_sysreg(val, cnthctl_el2);
-	}
+	/*
+	 * Disallow physical timer access for the guest
+	 * Physical counter access is allowed
+	 */
+	val = read_sysreg(cnthctl_el2);
+	val &= ~CNTHCTL_EL1PCEN;
+	val |= CNTHCTL_EL1PCTEN;
+	write_sysreg(val, cnthctl_el2);
 }
-- 
2.14.2
