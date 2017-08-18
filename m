From: gengdongjiu@huawei.com (Dongjiu Geng)
Date: Fri, 18 Aug 2017 22:11:52 +0800
Subject: [PATCH v5 2/7] KVM: arm64: Save ESR_EL2 on guest SError
In-Reply-To: <1503065517-7920-1-git-send-email-gengdongjiu@huawei.com>
References: <1503065517-7920-1-git-send-email-gengdongjiu@huawei.com>
Message-ID: <1503065517-7920-3-git-send-email-gengdongjiu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: James Morse <james.morse@arm.com>

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
index 945e79c641c4..c6f17c7675ad 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -226,13 +226,20 @@ static bool __hyp_text __translate_far_to_hpfar(u64 far, u64 *hpfar)
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
@@ -321,6 +328,8 @@ int __hyp_text __kvm_vcpu_run(struct kvm_vcpu *vcpu)
 	 */
 	if (exit_code == ARM_EXCEPTION_TRAP && !__populate_fault_info(vcpu))
 		goto again;
+	else if (ARM_EXCEPTION_CODE(exit_code) == ARM_EXCEPTION_EL1_SERROR)
+		__populate_fault_info_esr(vcpu);
 
 	if (static_branch_unlikely(&vgic_v2_cpuif_trap) &&
 	    exit_code == ARM_EXCEPTION_TRAP) {
-- 
2.14.0
