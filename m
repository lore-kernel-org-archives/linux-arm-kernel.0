From: julien.thierry@arm.com (Julien Thierry)
Date: Mon, 12 Nov 2018 11:57:00 +0000
Subject: [PATCH v6 09/24] arm64: kvm: Unmask PMR before entering guest
In-Reply-To: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1542023835-21446-10-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Interrupts masked by ICC_PMR_EL1 will not be signaled to the CPU. This
means that hypervisor will not receive masked interrupts while running a
guest.

Avoid this by making sure ICC_PMR_EL1 is unmasked when we enter a guest.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: kvmarm at lists.cs.columbia.edu
---
 arch/arm64/include/asm/kvm_host.h | 12 ++++++++++++
 arch/arm64/kvm/hyp/switch.c       | 16 ++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 52fbc82..31c7e9a 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -24,6 +24,7 @@
 
 #include <linux/types.h>
 #include <linux/kvm_types.h>
+#include <asm/arch_gicv3.h>
 #include <asm/cpufeature.h>
 #include <asm/daifflags.h>
 #include <asm/fpsimd.h>
@@ -471,6 +472,17 @@ static inline int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
 static inline void kvm_arm_vhe_guest_enter(void)
 {
 	local_daif_mask();
+
+	/*
+	 * Having IRQs masked via PMR when entering the guest means the GIC
+	 * will not signal the CPU of interrupts of lower priority, and the
+	 * only way to get out will be via guest exceptions.
+	 * Naturally, we want to avoid this.
+	 */
+	if (system_supports_irq_prio_masking()) {
+		gic_write_pmr(GIC_PRIO_IRQON);
+		dsb(sy);
+	}
 }
 
 static inline void kvm_arm_vhe_guest_exit(void)
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 7cc175c..e5ea193 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -22,6 +22,7 @@
 
 #include <kvm/arm_psci.h>
 
+#include <asm/arch_gicv3.h>
 #include <asm/cpufeature.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_emulate.h>
@@ -537,6 +538,17 @@ int __hyp_text __kvm_vcpu_run_nvhe(struct kvm_vcpu *vcpu)
 	struct kvm_cpu_context *guest_ctxt;
 	u64 exit_code;
 
+	/*
+	 * Having IRQs masked via PMR when entering the guest means the GIC
+	 * will not signal the CPU of interrupts of lower priority, and the
+	 * only way to get out will be via guest exceptions.
+	 * Naturally, we want to avoid this.
+	 */
+	if (system_supports_irq_prio_masking()) {
+		gic_write_pmr(GIC_PRIO_IRQON);
+		dsb(sy);
+	}
+
 	vcpu = kern_hyp_va(vcpu);
 
 	host_ctxt = kern_hyp_va(vcpu->arch.host_cpu_context);
@@ -589,6 +601,10 @@ int __hyp_text __kvm_vcpu_run_nvhe(struct kvm_vcpu *vcpu)
 	 */
 	__debug_switch_to_host(vcpu);
 
+	/* Returning to host will clear PSR.I, remask PMR if needed */
+	if (system_supports_irq_prio_masking())
+		gic_write_pmr(GIC_PRIO_IRQOFF);
+
 	return exit_code;
 }
 
-- 
1.9.1
