From: alex.shi@linaro.org (Alex Shi)
Date: Fri,  9 Mar 2018 17:07:16 +0800
Subject: [PATCH 33/39] arm64: KVM: Report SMCCC_ARCH_WORKAROUND_1 BP hardening
 support
In-Reply-To: <20180309090722.26279-1-alex.shi@linaro.org>
References: <20180309090722.26279-1-alex.shi@linaro.org>
Message-ID: <20180309090722.26279-34-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

commit 6167ec5c9145 upstream.

A new feature of SMCCC 1.1 is that it offers firmware-based CPU
workarounds. In particular, SMCCC_ARCH_WORKAROUND_1 provides
BP hardening for CVE-2017-5715.

If the host has some mitigation for this issue, report that
we deal with it using SMCCC_ARCH_WORKAROUND_1, as we apply the
host workaround on every guest exit.

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm/include/asm/kvm_host.h   | 6 ++++++
 arch/arm/kvm/psci.c               | 9 ++++++++-
 arch/arm64/include/asm/kvm_host.h | 6 ++++++
 include/linux/arm-smccc.h         | 5 +++++
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 6692982c9b57..2009894d9a8a 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -237,4 +237,10 @@ static inline void kvm_arm_setup_debug(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arm_clear_debug(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arm_reset_debug_ptr(struct kvm_vcpu *vcpu) {}
 
+static inline bool kvm_arm_harden_branch_predictor(void)
+{
+	/* No way to detect it yet, pretend it is not there. */
+	return false;
+}
+
 #endif /* __ARM_KVM_HOST_H__ */
diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index 6f691d7b9fdc..d06852e9c189 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -404,13 +404,20 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 {
 	u32 func_id = smccc_get_function(vcpu);
 	u32 val = PSCI_RET_NOT_SUPPORTED;
+	u32 feature;
 
 	switch (func_id) {
 	case ARM_SMCCC_VERSION_FUNC_ID:
 		val = ARM_SMCCC_VERSION_1_1;
 		break;
 	case ARM_SMCCC_ARCH_FEATURES_FUNC_ID:
-		/* Nothing supported yet */
+		feature = smccc_get_arg1(vcpu);
+		switch(feature) {
+		case ARM_SMCCC_ARCH_WORKAROUND_1:
+			if (kvm_arm_harden_branch_predictor())
+				val = 0;
+			break;
+		}
 		break;
 	default:
 		return kvm_psci_call(vcpu);
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index a35ce7266aac..ae0de3a9c759 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -258,4 +258,10 @@ void kvm_arm_setup_debug(struct kvm_vcpu *vcpu);
 void kvm_arm_clear_debug(struct kvm_vcpu *vcpu);
 void kvm_arm_reset_debug_ptr(struct kvm_vcpu *vcpu);
 
+
+static inline bool kvm_arm_harden_branch_predictor(void)
+{
+	return cpus_have_cap(ARM64_HARDEN_BRANCH_PREDICTOR);
+}
+
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 80e6a6bb8a20..a5ed4511af47 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -76,6 +76,11 @@
 			   ARM_SMCCC_SMC_32,				\
 			   0, 1)
 
+#define ARM_SMCCC_ARCH_WORKAROUND_1					\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
+			   ARM_SMCCC_SMC_32,				\
+			   0, 0x8000)
+
 /**
  * struct arm_smccc_res - Result from SMC/HVC call
  * @a0-a3 result values from registers 0 to 3
-- 
2.16.2.440.gc6284da
