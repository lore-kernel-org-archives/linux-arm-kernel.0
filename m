From: gengdongjiu@huawei.com (Dongjiu Geng)
Date: Fri, 18 Aug 2017 22:11:55 +0800
Subject: [PATCH v5 5/7] arm64: kvm: route synchronous external abort
 exceptions to el2
In-Reply-To: <1503065517-7920-1-git-send-email-gengdongjiu@huawei.com>
References: <1503065517-7920-1-git-send-email-gengdongjiu@huawei.com>
Message-ID: <1503065517-7920-6-git-send-email-gengdongjiu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv8.2 adds a new bit HCR_EL2.TEA which controls to
route synchronous external aborts to EL2, and add a
trap control bit HCR_EL2.TERR which will control to
trap all Non-secure EL1&0 error record accesses to EL2.

This patch will enable the two bits for the guest OS.
when an synchronous abort is generated in the guest OS,
it will trap to EL3 firmware, firmware will be according
to the HCR_EL2.TEA to decide to jump to hypervisor or host
OS. In the guest OS, RAS error record access will trap to
EL2.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 arch/arm64/include/asm/kvm_arm.h     | 2 ++
 arch/arm64/include/asm/kvm_emulate.h | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 61d694c2eae5..1188272003c4 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -23,6 +23,8 @@
 #include <asm/types.h>
 
 /* Hyp Configuration Register (HCR) bits */
+#define HCR_TEA		(UL(1) << 37)
+#define HCR_TERR	(UL(1) << 36)
 #define HCR_E2H		(UL(1) << 34)
 #define HCR_ID		(UL(1) << 33)
 #define HCR_CD		(UL(1) << 32)
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index fe39e6841326..47983db27de2 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -47,6 +47,13 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
 	vcpu->arch.hcr_el2 = HCR_GUEST_FLAGS;
 	if (is_kernel_in_hyp_mode())
 		vcpu->arch.hcr_el2 |= HCR_E2H;
+	if (cpus_have_const_cap(ARM64_HAS_RAS_EXTN)) {
+		/* route synchronous external abort exceptions to EL2 */
+		vcpu->arch.hcr_el2 |= HCR_TEA;
+		/* trap error record accesses */
+		vcpu->arch.hcr_el2 |= HCR_TERR;
+	}
+
 	if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features))
 		vcpu->arch.hcr_el2 &= ~HCR_RW;
 }
-- 
2.14.0
