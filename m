From: anup.patel@linaro.org (Anup Patel)
Date: Fri, 21 Mar 2014 18:23:33 +0530
Subject: [PATCH v5 10/11] ARM/ARM64: KVM: Emulate PSCI v0.2 CPU_SUSPEND
In-Reply-To: <1395406414-11707-1-git-send-email-anup.patel@linaro.org>
References: <1395406414-11707-1-git-send-email-anup.patel@linaro.org>
Message-ID: <1395406414-11707-11-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds emulation of PSCI v0.2 CPU_SUSPEND function call for
KVM ARM/ARM64. This is a CPU-level function call which can suspend
current CPU or current CPU cluster. We don't have VCPU clusters in
KVM so for KVM we simply suspend the current VCPU.

The CPU_SUSPEND emulation is not tested much because currently there
is no CPUIDLE driver in Linux kernel that uses PSCI CPU_SUSPEND. The
PSCI CPU_SUSPEND implementation in ARM64 kernel was tested using a
Simple CPUIDLE driver which is not published due to unstable DT-bindings
for PSCI.
(For more info, http://lwn.net/Articles/574950/)

Even if we had stable DT-bindings for PSCI and CPUIDLE driver that
uses PSCI CPU_SUSPEND then still we need to define SUSPEND states
for KVM ARM/ARM64.

Due to this, the CPU_SUSPEND emulation added by this patch only pause
current VCPU and to wakeup a suspended VCPU we need to explicity call
PSCI CPU_ON from Guest.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
---
 arch/arm/kvm/psci.c |   24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index 1e85452..e32ad10 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -52,6 +52,22 @@ static unsigned long psci_affinity_mask(unsigned long affinity_level)
 	return affinity_mask;
 }
 
+static unsigned long kvm_psci_vcpu_suspend(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * NOTE: Currently, we don't have any wakeup events for KVM
+	 * hence VCPU suspend turns-out to be same as VCPU off request.
+	 * This means to suspend a VCPU we simply set the pause flag
+	 * and update VCPU registers as-per wakeup parameters provided
+	 * via r2 & r3 (or x2 & x3).
+	 */
+	vcpu->arch.pause = true;
+	*vcpu_pc(vcpu) = *vcpu_reg(vcpu, 2);
+	*vcpu_reg(vcpu, 0) = *vcpu_reg(vcpu, 3);
+
+	return KVM_PSCI_RET_SUCCESS;
+}
+
 static void kvm_psci_vcpu_off(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.pause = true;
@@ -195,6 +211,10 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
 		 */
 		val = 2;
 		break;
+	case KVM_PSCI_0_2_FN_CPU_SUSPEND:
+	case KVM_PSCI_0_2_FN64_CPU_SUSPEND:
+		val = kvm_psci_vcpu_suspend(vcpu);
+		break;
 	case KVM_PSCI_0_2_FN_CPU_OFF:
 		kvm_psci_vcpu_off(vcpu);
 		val = KVM_PSCI_RET_SUCCESS;
@@ -232,10 +252,6 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
 		val = KVM_PSCI_RET_SUCCESS;
 		ret = 0;
 		break;
-	case KVM_PSCI_0_2_FN_CPU_SUSPEND:
-	case KVM_PSCI_0_2_FN64_CPU_SUSPEND:
-		val = KVM_PSCI_RET_NI;
-		break;
 	default:
 		return -EINVAL;
 	}
-- 
1.7.9.5
