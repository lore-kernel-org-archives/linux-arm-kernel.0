From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 18 Oct 2013 18:19:06 +0100
Subject: [PATCH 4/4] ARM: KVM: drop limitation to 4 CPU VMs
In-Reply-To: <1382116746-8757-1-git-send-email-marc.zyngier@arm.com>
References: <1382116746-8757-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1382116746-8757-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the KVM/arm code knows about affinity, remove the hard
limit of 4 vcpus per VM.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/reset.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/kvm/reset.c b/arch/arm/kvm/reset.c
index d9bbd83..2c5add0 100644
--- a/arch/arm/kvm/reset.c
+++ b/arch/arm/kvm/reset.c
@@ -33,8 +33,6 @@
  * Cortex-A15 and Cortex-A7 Reset Values
  */
 
-static const int cortexa_max_cpu_idx = 3;
-
 static struct kvm_regs cortexa_regs_reset = {
 	.usr_regs.ARM_cpsr = SVC_MODE | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT,
 };
@@ -64,8 +62,6 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	switch (vcpu->arch.target) {
 	case KVM_ARM_TARGET_CORTEX_A7:
 	case KVM_ARM_TARGET_CORTEX_A15:
-		if (vcpu->vcpu_id > cortexa_max_cpu_idx)
-			return -EINVAL;
 		cpu_reset = &cortexa_regs_reset;
 		vcpu->arch.midr = read_cpuid_id();
 		cpu_vtimer_irq = &cortexa_vtimer_irq;
-- 
1.8.2.3
