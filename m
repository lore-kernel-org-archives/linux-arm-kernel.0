From: eric.auger@linaro.org (Eric Auger)
Date: Wed, 11 Feb 2015 09:32:19 +0100
Subject: [RFC v4 09/13] KVM: arm: rename pause into power_off
In-Reply-To: <1423643543-24409-1-git-send-email-eric.auger@linaro.org>
References: <1423643543-24409-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1423643543-24409-10-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kvm_vcpu_arch pause field is renamed into power_off to prepare
for the introduction of a new pause field.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 arch/arm/include/asm/kvm_host.h |  4 ++--
 arch/arm/kvm/arm.c              | 10 +++++-----
 arch/arm/kvm/psci.c             | 10 +++++-----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 9cbcc53..87f0921 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -128,8 +128,8 @@ struct kvm_vcpu_arch {
 	 * here.
 	 */
 
-	/* Don't run the guest on this vcpu */
-	bool pause;
+	/* vcpu power-off state*/
+	bool power_off;
 
 	/* IO related fields */
 	struct kvm_decode mmio_decode;
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 61586a3..6f63ab7 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -459,7 +459,7 @@ static void vcpu_pause(struct kvm_vcpu *vcpu)
 {
 	wait_queue_head_t *wq = kvm_arch_vcpu_wq(vcpu);
 
-	wait_event_interruptible(*wq, !vcpu->arch.pause);
+	wait_event_interruptible(*wq, !vcpu->arch.power_off);
 }
 
 static int kvm_vcpu_initialized(struct kvm_vcpu *vcpu)
@@ -509,7 +509,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 		update_vttbr(vcpu->kvm);
 
-		if (vcpu->arch.pause)
+		if (vcpu->arch.power_off)
 			vcpu_pause(vcpu);
 
 		kvm_vgic_flush_hwstate(vcpu);
@@ -731,12 +731,12 @@ static int kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu *vcpu,
 	vcpu_reset_hcr(vcpu);
 
 	/*
-	 * Handle the "start in power-off" case by marking the VCPU as paused.
+	 * Handle the "start in power-off" case.
 	 */
 	if (test_bit(KVM_ARM_VCPU_POWER_OFF, vcpu->arch.features))
-		vcpu->arch.pause = true;
+		vcpu->arch.power_off = true;
 	else
-		vcpu->arch.pause = false;
+		vcpu->arch.power_off = false;
 
 	return 0;
 }
diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index 58cb324..ec0bd13 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -60,7 +60,7 @@ static unsigned long kvm_psci_vcpu_suspend(struct kvm_vcpu *vcpu)
 
 static void kvm_psci_vcpu_off(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.pause = true;
+	vcpu->arch.power_off = true;
 }
 
 static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
@@ -92,7 +92,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 	 */
 	if (!vcpu)
 		return PSCI_RET_INVALID_PARAMS;
-	if (!vcpu->arch.pause) {
+	if (!vcpu->arch.power_off) {
 		if (kvm_psci_version(source_vcpu) != KVM_ARM_PSCI_0_1)
 			return PSCI_RET_ALREADY_ON;
 		else
@@ -120,7 +120,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 	 * the general puspose registers are undefined upon CPU_ON.
 	 */
 	*vcpu_reg(vcpu, 0) = context_id;
-	vcpu->arch.pause = false;
+	vcpu->arch.power_off = false;
 	smp_mb();		/* Make sure the above is visible */
 
 	wq = kvm_arch_vcpu_wq(vcpu);
@@ -157,7 +157,7 @@ static unsigned long kvm_psci_vcpu_affinity_info(struct kvm_vcpu *vcpu)
 	kvm_for_each_vcpu(i, tmp, kvm) {
 		mpidr = kvm_vcpu_get_mpidr(tmp);
 		if (((mpidr & target_affinity_mask) == target_affinity) &&
-		    !tmp->arch.pause) {
+		    !tmp->arch.power_off) {
 			return PSCI_0_2_AFFINITY_LEVEL_ON;
 		}
 	}
@@ -180,7 +180,7 @@ static void kvm_prepare_system_event(struct kvm_vcpu *vcpu, u32 type)
 	 * re-initialized.
 	 */
 	kvm_for_each_vcpu(i, tmp, vcpu->kvm) {
-		tmp->arch.pause = true;
+		tmp->arch.power_off = true;
 		kvm_vcpu_kick(tmp);
 	}
 
-- 
1.9.1
