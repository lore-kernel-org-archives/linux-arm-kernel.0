From: alex.shi@linaro.org (Alex Shi)
Date: Fri,  9 Mar 2018 17:07:15 +0800
Subject: [PATCH 32/39] arm/arm64: KVM: Turn kvm_psci_version into a static
 inline
In-Reply-To: <20180309090722.26279-1-alex.shi@linaro.org>
References: <20180309090722.26279-1-alex.shi@linaro.org>
Message-ID: <20180309090722.26279-33-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

commit a4097b351118 upstream.

We're about to need kvm_psci_version in HYP too. So let's turn it
into a static inline, and pass the kvm structure as a second
parameter (so that HYP can do a kern_hyp_va on it).

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm/kvm/psci.c    | 12 ++----------
 include/kvm/arm_psci.h | 21 ++++++++++++++++++++-
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index a74e3a67ef7a..6f691d7b9fdc 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -121,7 +121,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 	if (!vcpu)
 		return PSCI_RET_INVALID_PARAMS;
 	if (!vcpu->arch.power_off) {
-		if (kvm_psci_version(source_vcpu) != KVM_ARM_PSCI_0_1)
+		if (kvm_psci_version(source_vcpu, kvm) != KVM_ARM_PSCI_0_1)
 			return PSCI_RET_ALREADY_ON;
 		else
 			return PSCI_RET_INVALID_PARAMS;
@@ -231,14 +231,6 @@ static void kvm_psci_system_reset(struct kvm_vcpu *vcpu)
 	kvm_prepare_system_event(vcpu, KVM_SYSTEM_EVENT_RESET);
 }
 
-int kvm_psci_version(struct kvm_vcpu *vcpu)
-{
-	if (test_bit(KVM_ARM_VCPU_PSCI_0_2, vcpu->arch.features))
-		return KVM_ARM_PSCI_LATEST;
-
-	return KVM_ARM_PSCI_0_1;
-}
-
 static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
@@ -396,7 +388,7 @@ static int kvm_psci_0_1_call(struct kvm_vcpu *vcpu)
  */
 static int kvm_psci_call(struct kvm_vcpu *vcpu)
 {
-	switch (kvm_psci_version(vcpu)) {
+	switch (kvm_psci_version(vcpu, vcpu->kvm)) {
 	case KVM_ARM_PSCI_1_0:
 		return kvm_psci_1_0_call(vcpu);
 	case KVM_ARM_PSCI_0_2:
diff --git a/include/kvm/arm_psci.h b/include/kvm/arm_psci.h
index ed1dd8088f1c..e518e4e3dfb5 100644
--- a/include/kvm/arm_psci.h
+++ b/include/kvm/arm_psci.h
@@ -18,6 +18,7 @@
 #ifndef __KVM_ARM_PSCI_H__
 #define __KVM_ARM_PSCI_H__
 
+#include <linux/kvm_host.h>
 #include <uapi/linux/psci.h>
 
 #define KVM_ARM_PSCI_0_1	PSCI_VERSION(0, 1)
@@ -26,7 +27,25 @@
 
 #define KVM_ARM_PSCI_LATEST	KVM_ARM_PSCI_1_0
 
-int kvm_psci_version(struct kvm_vcpu *vcpu);
+/*
+ * We need the KVM pointer independently from the vcpu as we can call
+ * this from HYP, and need to apply kern_hyp_va on it...
+ */
+static inline int kvm_psci_version(struct kvm_vcpu *vcpu, struct kvm *kvm)
+{
+	/*
+	 * Our PSCI implementation stays the same across versions from
+	 * v0.2 onward, only adding the few mandatory functions (such
+	 * as FEATURES with 1.0) that are required by newer
+	 * revisions. It is thus safe to return the latest.
+	 */
+	if (test_bit(KVM_ARM_VCPU_PSCI_0_2, vcpu->arch.features))
+		return KVM_ARM_PSCI_LATEST;
+
+	return KVM_ARM_PSCI_0_1;
+}
+
+
 int kvm_hvc_call_handler(struct kvm_vcpu *vcpu);
 
 #endif /* __KVM_ARM_PSCI_H__ */
-- 
2.16.2.440.gc6284da
