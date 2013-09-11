From: olof@lixom.net (Olof Johansson)
Date: Wed, 11 Sep 2013 15:27:41 -0700
Subject: [PATCH] ARM: kvm: rename cpu_reset to avoid name clash
Message-ID: <1378938461-10835-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cpu_reset is already #defined in <asm/proc-fns.h> as processor.reset,
so it expands here and causes problems.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/kvm/reset.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kvm/reset.c b/arch/arm/kvm/reset.c
index 71e08ba..c02ba4a 100644
--- a/arch/arm/kvm/reset.c
+++ b/arch/arm/kvm/reset.c
@@ -58,14 +58,14 @@ static const struct kvm_irq_level a15_vtimer_irq = {
  */
 int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 {
-	struct kvm_regs *cpu_reset;
+	struct kvm_regs *reset_regs;
 	const struct kvm_irq_level *cpu_vtimer_irq;
 
 	switch (vcpu->arch.target) {
 	case KVM_ARM_TARGET_CORTEX_A15:
 		if (vcpu->vcpu_id > a15_max_cpu_idx)
 			return -EINVAL;
-		cpu_reset = &a15_regs_reset;
+		reset_regs = &a15_regs_reset;
 		vcpu->arch.midr = read_cpuid_id();
 		cpu_vtimer_irq = &a15_vtimer_irq;
 		break;
@@ -74,7 +74,7 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	}
 
 	/* Reset core registers */
-	memcpy(&vcpu->arch.regs, cpu_reset, sizeof(vcpu->arch.regs));
+	memcpy(&vcpu->arch.regs, reset_regs, sizeof(vcpu->arch.regs));
 
 	/* Reset CP15 registers */
 	kvm_reset_coprocs(vcpu);
-- 
1.7.10.4
