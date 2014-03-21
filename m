From: anup.patel@linaro.org (Anup Patel)
Date: Fri, 21 Mar 2014 18:23:29 +0530
Subject: [PATCH v5 06/11] ARM/ARM64: KVM: Emulate PSCI v0.2 SYSTEM_OFF and
 SYSTEM_RESET
In-Reply-To: <1395406414-11707-1-git-send-email-anup.patel@linaro.org>
References: <1395406414-11707-1-git-send-email-anup.patel@linaro.org>
Message-ID: <1395406414-11707-7-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PSCI v0.2 SYSTEM_OFF and SYSTEM_RESET functions are system-level
functions hence cannot be fully emulated by in-kernel PSCI emulation code.

To tackle this, we forward PSCI v0.2 SYSTEM_OFF and SYSTEM_RESET function
calls from vcpu to user space (i.e. QEMU or KVMTOOL) via kvm_run structure
using KVM_EXIT_SYSTEM_EVENT exit reasons.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
---
 arch/arm/kvm/psci.c |   32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index 252acd0..1f1720a 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -85,6 +85,23 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 	return KVM_PSCI_RET_SUCCESS;
 }
 
+static inline void kvm_prepare_system_event(struct kvm_vcpu *vcpu, u32 type)
+{
+	memset(&vcpu->run->system_event, 0, sizeof(vcpu->run->system_event));
+	vcpu->run->system_event.type = type;
+	vcpu->run->exit_reason = KVM_EXIT_SYSTEM_EVENT;
+}
+
+static void kvm_psci_system_off(struct kvm_vcpu *vcpu)
+{
+	kvm_prepare_system_event(vcpu, KVM_SYSTEM_EVENT_SHUTDOWN);
+}
+
+static void kvm_psci_system_reset(struct kvm_vcpu *vcpu)
+{
+	kvm_prepare_system_event(vcpu, KVM_SYSTEM_EVENT_RESET);
+}
+
 int kvm_psci_version(struct kvm_vcpu *vcpu)
 {
 	if (test_bit(KVM_ARM_VCPU_PSCI_0_2, vcpu->arch.features))
@@ -95,6 +112,7 @@ int kvm_psci_version(struct kvm_vcpu *vcpu)
 
 static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
 {
+	int ret = 1;
 	unsigned long psci_fn = *vcpu_reg(vcpu, 0) & ~((u32) 0);
 	unsigned long val;
 
@@ -114,13 +132,21 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
 	case KVM_PSCI_0_2_FN64_CPU_ON:
 		val = kvm_psci_vcpu_on(vcpu);
 		break;
+	case KVM_PSCI_0_2_FN_SYSTEM_OFF:
+		kvm_psci_system_off(vcpu);
+		val = KVM_PSCI_RET_SUCCESS;
+		ret = 0;
+		break;
+	case KVM_PSCI_0_2_FN_SYSTEM_RESET:
+		kvm_psci_system_reset(vcpu);
+		val = KVM_PSCI_RET_SUCCESS;
+		ret = 0;
+		break;
 	case KVM_PSCI_0_2_FN_CPU_SUSPEND:
 	case KVM_PSCI_0_2_FN_AFFINITY_INFO:
 	case KVM_PSCI_0_2_FN_MIGRATE:
 	case KVM_PSCI_0_2_FN_MIGRATE_INFO_TYPE:
 	case KVM_PSCI_0_2_FN_MIGRATE_INFO_UP_CPU:
-	case KVM_PSCI_0_2_FN_SYSTEM_OFF:
-	case KVM_PSCI_0_2_FN_SYSTEM_RESET:
 	case KVM_PSCI_0_2_FN64_CPU_SUSPEND:
 	case KVM_PSCI_0_2_FN64_AFFINITY_INFO:
 	case KVM_PSCI_0_2_FN64_MIGRATE:
@@ -132,7 +158,7 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
 	}
 
 	*vcpu_reg(vcpu, 0) = val;
-	return 1;
+	return ret;
 }
 
 static int kvm_psci_0_1_call(struct kvm_vcpu *vcpu)
-- 
1.7.9.5
