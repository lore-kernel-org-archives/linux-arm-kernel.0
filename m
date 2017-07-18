From: jintack.lim@linaro.org (Jintack Lim)
Date: Tue, 18 Jul 2017 11:58:52 -0500
Subject: [RFC PATCH v2 26/38] KVM: arm64: Add macros to support the virtual
 EL2 with VHE
In-Reply-To: <1500397144-16232-1-git-send-email-jintack.lim@linaro.org>
References: <1500397144-16232-1-git-send-email-jintack.lim@linaro.org>
Message-ID: <1500397144-16232-27-git-send-email-jintack.lim@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These macros will be used to support the virtual EL2 with VHE.

Signed-off-by: Jintack Lim <jintack.lim@linaro.org>
---
 arch/arm64/include/asm/kvm_emulate.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 3017234..68aafbd 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -173,6 +173,30 @@ static inline bool vcpu_mode_el2(const struct kvm_vcpu *vcpu)
 	return mode == PSR_MODE_EL2h || mode == PSR_MODE_EL2t;
 }
 
+static inline bool vcpu_el2_e2h_is_set(const struct kvm_vcpu *vcpu)
+{
+	return (vcpu_sys_reg(vcpu, HCR_EL2) & HCR_E2H);
+}
+
+static inline bool vcpu_el2_tge_is_set(const struct kvm_vcpu *vcpu)
+{
+	return (vcpu_sys_reg(vcpu, HCR_EL2) & HCR_TGE);
+}
+
+static inline bool is_hyp_ctxt(const struct kvm_vcpu *vcpu)
+{
+	/*
+	 * We are in a hypervisor context if the vcpu mode is EL2 or
+	 * E2H and TGE bits are set. The latter means we are in the user space
+	 * of the VHE kernel. ARMv8.1 ARM describes this as 'InHost'
+	 */
+	if (vcpu_mode_el2(vcpu) ||
+	    (vcpu_el2_e2h_is_set(vcpu) && vcpu_el2_tge_is_set(vcpu)))
+		return true;
+
+	return false;
+}
+
 static inline u32 kvm_vcpu_get_hsr(const struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.fault.esr_el2;
-- 
1.9.1
