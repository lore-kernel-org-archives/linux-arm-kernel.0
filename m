From: james.morse@arm.com (James Morse)
Date: Thu,  5 Oct 2017 20:18:09 +0100
Subject: [PATCH v3 17/20] KVM: arm64: Save ESR_EL2 on guest SError
In-Reply-To: <20171005191812.5678-1-james.morse@arm.com>
References: <20171005191812.5678-1-james.morse@arm.com>
Message-ID: <20171005191812.5678-18-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we exit a guest due to an SError the vcpu fault info isn't updated
with the ESR. Today this is only done for traps.

The v8.2 RAS Extensions define ISS values for SError. Update the vcpu's
fault_info with the ESR on SError so that handle_exit() can determine
if this was a RAS SError and decode its severity.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/kvm/hyp/switch.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index af37658223a0..cba6d8ac105c 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -230,13 +230,20 @@ static bool __hyp_text __translate_far_to_hpfar(u64 far, u64 *hpfar)
 	return true;
 }
 
+static void __hyp_text __populate_fault_info_esr(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.fault.esr_el2 = read_sysreg_el2(esr);
+}
+
 static bool __hyp_text __populate_fault_info(struct kvm_vcpu *vcpu)
 {
-	u64 esr = read_sysreg_el2(esr);
-	u8 ec = ESR_ELx_EC(esr);
+	u8 ec;
+	u64 esr;
 	u64 hpfar, far;
 
-	vcpu->arch.fault.esr_el2 = esr;
+	__populate_fault_info_esr(vcpu);
+	esr = vcpu->arch.fault.esr_el2;
+	ec = ESR_ELx_EC(esr);
 
 	if (ec != ESR_ELx_EC_DABT_LOW && ec != ESR_ELx_EC_IABT_LOW)
 		return true;
@@ -325,6 +332,8 @@ int __hyp_text __kvm_vcpu_run(struct kvm_vcpu *vcpu)
 	 */
 	if (exit_code == ARM_EXCEPTION_TRAP && !__populate_fault_info(vcpu))
 		goto again;
+	else if (ARM_EXCEPTION_CODE(exit_code) == ARM_EXCEPTION_EL1_SERROR)
+		__populate_fault_info_esr(vcpu);
 
 	if (static_branch_unlikely(&vgic_v2_cpuif_trap) &&
 	    exit_code == ARM_EXCEPTION_TRAP) {
-- 
2.13.3
