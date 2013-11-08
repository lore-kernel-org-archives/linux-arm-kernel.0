From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu,  7 Nov 2013 17:32:02 -0800
Subject: [PATCH 4/4] arm/arm64: KVM: PSCI: use MPIDR to identify a target CPU
In-Reply-To: <1383874322-12328-1-git-send-email-christoffer.dall@linaro.org>
References: <1383874322-12328-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1383874322-12328-5-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

The KVM PSCI code blindly assumes that vcpu_id and MPIDR are
the same thing. This is true when vcpus are organized as a flat
topology, but is wrong when trying to emulate any other topology
(such as A15 clusters).

Change the KVM PSCI CPU_ON code to look at the MPIDR instead
of the vcpu_id to pick a target CPU.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/include/asm/kvm_emulate.h   |    5 +++++
 arch/arm/kvm/psci.c                  |   17 +++++++++++++----
 arch/arm64/include/asm/kvm_emulate.h |    5 +++++
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
index a464e8d..708e4d8 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -157,4 +157,9 @@ static inline u32 kvm_vcpu_hvc_get_imm(struct kvm_vcpu *vcpu)
 	return kvm_vcpu_get_hsr(vcpu) & HSR_HVC_IMM_MASK;
 }
 
+static inline unsigned long kvm_vcpu_get_mpidr(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.cp15[c0_MPIDR];
+}
+
 #endif /* __ARM_KVM_EMULATE_H__ */
diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index 86a693a..3112631 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -18,6 +18,7 @@
 #include <linux/kvm_host.h>
 #include <linux/wait.h>
 
+#include <asm/cputype.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_psci.h>
 
@@ -34,22 +35,30 @@ static void kvm_psci_vcpu_off(struct kvm_vcpu *vcpu)
 static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 {
 	struct kvm *kvm = source_vcpu->kvm;
-	struct kvm_vcpu *vcpu;
+	struct kvm_vcpu *vcpu = NULL, *tmp;
 	wait_queue_head_t *wq;
 	unsigned long cpu_id;
+	unsigned long mpidr;
 	phys_addr_t target_pc;
+	int i;
 
 	cpu_id = *vcpu_reg(source_vcpu, 1);
 	if (vcpu_mode_is_32bit(source_vcpu))
 		cpu_id &= ~((u32) 0);
 
-	if (cpu_id >= atomic_read(&kvm->online_vcpus))
+	kvm_for_each_vcpu(i, tmp, kvm) {
+		mpidr = kvm_vcpu_get_mpidr(tmp);
+		if ((mpidr & MPIDR_HWID_BITMASK) == (cpu_id & MPIDR_HWID_BITMASK)) {
+			vcpu = tmp;
+			break;
+		}
+	}
+
+	if (!vcpu)
 		return KVM_PSCI_RET_INVAL;
 
 	target_pc = *vcpu_reg(source_vcpu, 2);
 
-	vcpu = kvm_get_vcpu(kvm, cpu_id);
-
 	wq = kvm_arch_vcpu_wq(vcpu);
 	if (!waitqueue_active(wq))
 		return KVM_PSCI_RET_INVAL;
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index eec0738..6df93cd 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -177,4 +177,9 @@ static inline u8 kvm_vcpu_trap_get_fault(const struct kvm_vcpu *vcpu)
 	return kvm_vcpu_get_hsr(vcpu) & ESR_EL2_FSC_TYPE;
 }
 
+static inline unsigned long kvm_vcpu_get_mpidr(struct kvm_vcpu *vcpu)
+{
+	return vcpu_sys_reg(vcpu, MPIDR_EL1);
+}
+
 #endif /* __ARM64_KVM_EMULATE_H__ */
-- 
1.7.10.4
