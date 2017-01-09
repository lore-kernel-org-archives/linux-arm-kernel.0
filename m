From: jintack@cs.columbia.edu (Jintack Lim)
Date: Mon,  9 Jan 2017 01:23:59 -0500
Subject: [RFC 03/55] KVM: arm64: Add KVM nesting feature
In-Reply-To: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1483943091-1364-4-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

Set the initial exception level of the guest to EL2 if nested
virtualization feature is enabled.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 arch/arm64/include/asm/kvm_host.h | 2 +-
 arch/arm64/include/uapi/asm/kvm.h | 1 +
 arch/arm64/kvm/reset.c            | 8 ++++++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index e505038..c0c8b02 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -41,7 +41,7 @@
 
 #define KVM_MAX_VCPUS VGIC_V3_MAX_CPUS
 
-#define KVM_VCPU_MAX_FEATURES 4
+#define KVM_VCPU_MAX_FEATURES 5
 
 #define KVM_REQ_VCPU_EXIT	8
 
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 3051f86..78117bf 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -97,6 +97,7 @@ struct kvm_regs {
 #define KVM_ARM_VCPU_EL1_32BIT		1 /* CPU running a 32bit VM */
 #define KVM_ARM_VCPU_PSCI_0_2		2 /* CPU uses PSCI v0.2 */
 #define KVM_ARM_VCPU_PMU_V3		3 /* Support guest PMUv3 */
+#define KVM_ARM_VCPU_NESTED_VIRT	4 /* Support nested virtual EL2 */
 
 struct kvm_vcpu_init {
 	__u32 target;
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 74322c2..e6b0b20 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -41,6 +41,11 @@
 			PSR_F_BIT | PSR_D_BIT),
 };
 
+static const struct kvm_regs default_regs_reset_el2 = {
+	.regs.pstate = (PSR_MODE_EL2h | PSR_A_BIT | PSR_I_BIT |
+			PSR_F_BIT | PSR_D_BIT),
+};
+
 static const struct kvm_regs default_regs_reset32 = {
 	.regs.pstate = (COMPAT_PSR_MODE_SVC | COMPAT_PSR_A_BIT |
 			COMPAT_PSR_I_BIT | COMPAT_PSR_F_BIT),
@@ -124,6 +129,9 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 			if (!cpu_has_32bit_el1())
 				return -EINVAL;
 			cpu_reset = &default_regs_reset32;
+		} else if (test_bit(KVM_ARM_VCPU_NESTED_VIRT,
+				    vcpu->arch.features)) {
+			cpu_reset = &default_regs_reset_el2;
 		} else {
 			cpu_reset = &default_regs_reset;
 		}
-- 
1.9.1
