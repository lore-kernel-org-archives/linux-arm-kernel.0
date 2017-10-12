From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 12 Oct 2017 12:41:30 +0200
Subject: [PATCH 26/37] KVM: arm64: Prepare to handle traps on deferred AArch32
 sysregs
In-Reply-To: <20171012104141.26902-1-christoffer.dall@linaro.org>
References: <20171012104141.26902-1-christoffer.dall@linaro.org>
Message-ID: <20171012104141.26902-27-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Handle accesses to any AArch32 EL1 system registers where we can defer
saving and restoring them to vcpu_load and vcpu_put, and which are
stored in special EL2 registers only used support 32-bit guests.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/kvm/inject_fault.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
index f4513fc..02990f5 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -59,9 +59,18 @@ static void vcpu_set_elr_el1(struct kvm_vcpu *vcpu, u64 val)
 /* Set the SPSR for the current mode */
 static void vcpu_set_spsr(struct kvm_vcpu *vcpu, u64 val)
 {
-	if (vcpu_mode_is_32bit(vcpu))
+	if (vcpu_mode_is_32bit(vcpu)) {
+		if (vcpu->arch.sysregs_loaded_on_cpu)
+			__sysreg32_save_state(vcpu);
+
 		*vcpu_spsr32(vcpu) = val;
 
+		if (vcpu->arch.sysregs_loaded_on_cpu)
+			__sysreg32_restore_state(vcpu);
+
+		return;
+	}
+
 	if (vcpu->arch.sysregs_loaded_on_cpu)
 		write_sysreg_el1(val, spsr);
 	else
@@ -129,11 +138,13 @@ static void inject_abt32(struct kvm_vcpu *vcpu, bool is_pabt,
 	 *   IFAR:  mapped to FAR_EL1
 	 *   DFSR:  mapped to ESR_EL1
 	 *   TTBCR: mapped to TCR_EL1
+	 *   IFSR:  stored in IFSR32_EL2
 	 */
 	if (vcpu->arch.sysregs_loaded_on_cpu) {
 		vcpu->arch.ctxt.sys_regs[FAR_EL1] = read_sysreg_el1(far);
 		vcpu->arch.ctxt.sys_regs[ESR_EL1] = read_sysreg_el1(esr);
 		vcpu->arch.ctxt.sys_regs[TCR_EL1] = read_sysreg_el1(tcr);
+		vcpu->arch.ctxt.sys_regs[IFSR32_EL2] = read_sysreg(ifsr32_el2);
 	}
 
 	if (is_pabt) {
@@ -161,6 +172,7 @@ static void inject_abt32(struct kvm_vcpu *vcpu, bool is_pabt,
 	if (vcpu->arch.sysregs_loaded_on_cpu) {
 		write_sysreg_el1(vcpu->arch.ctxt.sys_regs[FAR_EL1], far);
 		write_sysreg_el1(vcpu->arch.ctxt.sys_regs[ESR_EL1], esr);
+		write_sysreg(vcpu->arch.ctxt.sys_regs[IFSR32_EL2], ifsr32_el2);
 	}
 }
 
-- 
2.9.0
