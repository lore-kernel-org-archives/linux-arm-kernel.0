From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 11 Feb 2016 18:39:55 +0000
Subject: [PATCH v4 14/23] arm64: KVM: VHE: Make __fpsimd_enabled VHE aware
In-Reply-To: <1455216004-19499-1-git-send-email-marc.zyngier@arm.com>
References: <1455216004-19499-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1455216004-19499-15-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As non-VHE and VHE have different ways to express the trapping of
FPSIMD registers to EL2, make __fpsimd_enabled a patchable predicate
and provide a VHE implementation.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_arm.h |  3 +++
 arch/arm64/kvm/hyp/hyp.h         |  5 +----
 arch/arm64/kvm/hyp/switch.c      | 19 +++++++++++++++++++
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index bef6e92..f416714 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -218,4 +218,7 @@
 	ECN(SOFTSTP_CUR), ECN(WATCHPT_LOW), ECN(WATCHPT_CUR), \
 	ECN(BKPT32), ECN(VECTOR32), ECN(BRK64)
 
+#define CPACR_EL1_FPEN		(3 << 20)
+#define CPACR_EL1_TTA		(1 << 28)
+
 #endif /* __ARM64_KVM_ARM_H__ */
diff --git a/arch/arm64/kvm/hyp/hyp.h b/arch/arm64/kvm/hyp/hyp.h
index 5dfa883..44eaff7 100644
--- a/arch/arm64/kvm/hyp/hyp.h
+++ b/arch/arm64/kvm/hyp/hyp.h
@@ -171,10 +171,7 @@ void __debug_cond_restore_host_state(struct kvm_vcpu *vcpu);
 
 void __fpsimd_save_state(struct user_fpsimd_state *fp_regs);
 void __fpsimd_restore_state(struct user_fpsimd_state *fp_regs);
-static inline bool __fpsimd_enabled(void)
-{
-	return !(read_sysreg(cptr_el2) & CPTR_EL2_TFP);
-}
+bool __fpsimd_enabled(void);
 
 u64 __guest_enter(struct kvm_vcpu *vcpu, struct kvm_cpu_context *host_ctxt);
 void __noreturn __hyp_do_panic(unsigned long, ...);
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 68f3cba..0d82ae9 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -17,6 +17,25 @@
 
 #include "hyp.h"
 
+static bool __hyp_text __fpsimd_enabled_nvhe(void)
+{
+	return !(read_sysreg(cptr_el2) & CPTR_EL2_TFP);
+}
+
+static bool __hyp_text __fpsimd_enabled_vhe(void)
+{
+	return !!(read_sysreg(cpacr_el1) & CPACR_EL1_FPEN);
+}
+
+static hyp_alternate_select(__fpsimd_is_enabled,
+			    __fpsimd_enabled_nvhe, __fpsimd_enabled_vhe,
+			    ARM64_HAS_VIRT_HOST_EXTN);
+
+bool __hyp_text __fpsimd_enabled(void)
+{
+	return __fpsimd_is_enabled()();
+}
+
 static void __hyp_text __activate_traps(struct kvm_vcpu *vcpu)
 {
 	u64 val;
-- 
2.1.4
