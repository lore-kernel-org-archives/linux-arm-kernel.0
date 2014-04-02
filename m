From: anup.patel@linaro.org (Anup Patel)
Date: Wed,  2 Apr 2014 16:12:25 +0530
Subject: [PATCH v7 10/12] ARM/ARM64: KVM: Fix CPU_ON emulation for PSCI v0.2
In-Reply-To: <1396435347-20056-1-git-send-email-anup.patel@linaro.org>
References: <1396435347-20056-1-git-send-email-anup.patel@linaro.org>
Message-ID: <1396435347-20056-11-git-send-email-anup.patel@linaro.org>
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
---
 arch/arm/kvm/psci.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index d8335da..fdbd829 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -63,6 +63,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 	struct kvm_vcpu *vcpu = NULL, *tmp;
 	wait_queue_head_t *wq;
 	unsigned long cpu_id;
+	unsigned long context_id;
 	unsigned long mpidr;
 	phys_addr_t target_pc;
 	int i;
@@ -83,10 +84,17 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
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
 
@@ -101,6 +109,8 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 		kvm_vcpu_set_be(vcpu);
 
 	*vcpu_pc(vcpu) = target_pc;
+	if (kvm_psci_version(source_vcpu) != KVM_ARM_PSCI_0_1)
+		*vcpu_reg(vcpu, 0) = context_id;
 	vcpu->arch.pause = false;
 	smp_mb();		/* Make sure the above is visible */
 
-- 
1.7.9.5
