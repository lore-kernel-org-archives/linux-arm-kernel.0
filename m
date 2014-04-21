From: anup.patel@linaro.org (Anup Patel)
Date: Mon, 21 Apr 2014 18:30:04 +0530
Subject: [PATCH v10 10/12] ARM/ARM64: KVM: Fix CPU_ON emulation for PSCI v0.2
In-Reply-To: <1398085206-30555-1-git-send-email-anup.patel@linaro.org>
References: <1398085206-30555-1-git-send-email-anup.patel@linaro.org>
Message-ID: <1398085206-30555-11-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As-per PSCI v0.2, the source CPU provides physical address of
"entry point" and "context id" for starting a target CPU. Also,
if target CPU is already running then we should return ALREADY_ON.

Current emulation of CPU_ON function does not consider physical
address of "context id" and returns INVALID_PARAMETERS if target
CPU is already running.

This patch updates kvm_psci_vcpu_on() such that it works for both
PSCI v0.1 and PSCI v0.2.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/psci.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index d04a47b..b582e99 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -48,6 +48,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 	struct kvm_vcpu *vcpu = NULL, *tmp;
 	wait_queue_head_t *wq;
 	unsigned long cpu_id;
+	unsigned long context_id;
 	unsigned long mpidr;
 	phys_addr_t target_pc;
 	int i;
@@ -68,10 +69,17 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 	 * Make sure the caller requested a valid CPU and that the CPU is
 	 * turned off.
 	 */
-	if (!vcpu || !vcpu->arch.pause)
+	if (!vcpu)
 		return PSCI_RET_INVALID_PARAMS;
+	if (!vcpu->arch.pause) {
+		if (kvm_psci_version(source_vcpu) != KVM_ARM_PSCI_0_1)
+			return PSCI_RET_ALREADY_ON;
+		else
+			return PSCI_RET_INVALID_PARAMS;
+	}
 
 	target_pc = *vcpu_reg(source_vcpu, 2);
+	context_id = *vcpu_reg(source_vcpu, 3);
 
 	kvm_reset_vcpu(vcpu);
 
@@ -86,6 +94,11 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 		kvm_vcpu_set_be(vcpu);
 
 	*vcpu_pc(vcpu) = target_pc;
+	/*
+	 * NOTE: We always update r0 (or x0) because for PSCI v0.1
+	 * the general puspose registers are undefined upon CPU_ON.
+	 */
+	*vcpu_reg(vcpu, 0) = context_id;
 	vcpu->arch.pause = false;
 	smp_mb();		/* Make sure the above is visible */
 
-- 
1.7.9.5
