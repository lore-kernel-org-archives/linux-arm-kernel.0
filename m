From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 13 Aug 2018 15:57:25 +0100
Subject: [PATCH 07/37] KVM: arm/arm64: Enable adaptative WFE trapping
In-Reply-To: <20180813145755.16566-1-marc.zyngier@arm.com>
References: <20180813145755.16566-1-marc.zyngier@arm.com>
Message-ID: <20180813145755.16566-8-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trapping blocking WFE is extremely beneficial in situations where
the system is oversubscribed, as it allows another thread to run
while being blocked. In a non-oversubscribed environment, this is
the complete opposite, and trapping WFE is just unnecessary overhead.

Let's only enable WFE trapping if the CPU has more than a single task
to run (that is, more than just the vcpu thread).

Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_emulate.h   | 10 ++++++++++
 arch/arm64/include/asm/kvm_emulate.h | 10 ++++++++++
 virt/kvm/arm/arm.c                   |  6 ++++++
 3 files changed, 26 insertions(+)

diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
index 6493bd479ddc..b50fe8380868 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -107,6 +107,16 @@ static inline unsigned long *vcpu_hcr(const struct kvm_vcpu *vcpu)
 	return (unsigned long *)&vcpu->arch.hcr;
 }
 
+static inline void vcpu_clear_wfe_traps(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.hcr &= ~HCR_TWE;
+}
+
+static inline void vcpu_set_wfe_traps(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.hcr |= HCR_TWE;
+}
+
 static inline bool vcpu_mode_is_32bit(const struct kvm_vcpu *vcpu)
 {
 	return 1;
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index dd98fdf33d99..bfefdd9a72eb 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -83,6 +83,16 @@ static inline unsigned long *vcpu_hcr(struct kvm_vcpu *vcpu)
 	return (unsigned long *)&vcpu->arch.hcr_el2;
 }
 
+static inline void vcpu_clear_wfe_traps(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.hcr_el2 &= ~HCR_TWE;
+}
+
+static inline void vcpu_set_wfe_traps(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.hcr_el2 |= HCR_TWE;
+}
+
 static inline void vcpu_set_vsesr(struct kvm_vcpu *vcpu, u64 vsesr)
 {
 	vcpu->arch.vsesr_el2 = vsesr;
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 04e554cae3a2..8e66b89a3db2 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -30,6 +30,7 @@
 #include <linux/kvm.h>
 #include <linux/kvm_irqfd.h>
 #include <linux/irqbypass.h>
+#include <linux/sched/stat.h>
 #include <trace/events/kvm.h>
 #include <kvm/arm_pmu.h>
 #include <kvm/arm_psci.h>
@@ -380,6 +381,11 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	kvm_timer_vcpu_load(vcpu);
 	kvm_vcpu_load_sysregs(vcpu);
 	kvm_arch_vcpu_load_fp(vcpu);
+
+	if (single_task_running())
+		vcpu_clear_wfe_traps(vcpu);
+	else
+		vcpu_set_wfe_traps(vcpu);
 }
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
-- 
2.18.0
