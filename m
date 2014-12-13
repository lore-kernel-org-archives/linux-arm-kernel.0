From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 13 Dec 2014 12:17:29 +0100
Subject: [PATCH v2 6/6] arm/arm64: KVM: Require in-kernel vgic for the arch
 timers
In-Reply-To: <1418469449-13277-1-git-send-email-christoffer.dall@linaro.org>
References: <1418469449-13277-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1418469449-13277-7-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is curently possible to run a VM with architected timers support
without creating an in-kernel VGIC, which will result in interrupts from
the virtual timer going nowhere.

To address this issue, move the architected timers initialization to the
time when we run a VCPU for the first time, and then only initialize
(and enable) the architected timers if we have a properly created and
initialized in-kernel VGIC.

When injecting interrupts from the virtual timer to the vgic, the
current setup should ensure that this never calls an on-demand init of
the VGIC, which is the only call path that could return an error from
kvm_vgic_inject_irq(), so capture the return value and raise a warning
if there's an error there.

We also change the kvm_timer_init() function from returning an int to be
a void function, since the function always succeeds.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/arm.c           | 15 +++++++++++----
 include/kvm/arm_arch_timer.h |  2 +-
 virt/kvm/arm/arch_timer.c    | 15 ++++++++++-----
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index d4da244..06f0431 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -127,8 +127,6 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	if (ret)
 		goto out_free_stage2_pgd;
 
-	kvm_timer_init(kvm);
-
 	/* Mark the initial VMID generation invalid */
 	kvm->arch.vmid_gen = 0;
 
@@ -424,6 +422,7 @@ static void update_vttbr(struct kvm *kvm)
 
 static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
 {
+	struct kvm *kvm = vcpu->kvm;
 	int ret;
 
 	if (likely(vcpu->arch.has_run_once))
@@ -435,12 +434,20 @@ static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
 	 * Map the VGIC hardware resources before running a vcpu the first
 	 * time on this VM.
 	 */
-	if (unlikely(!vgic_ready(vcpu->kvm))) {
-		ret = kvm_vgic_map_resources(vcpu->kvm);
+	if (unlikely(!vgic_ready(kvm))) {
+		ret = kvm_vgic_map_resources(kvm);
 		if (ret)
 			return ret;
 	}
 
+	/*
+	 * Initialize the Architected Timers only if we have an in-kernel VGIC
+	 * and it has been properly initialized, since we cannot handle
+	 * interrupts from the virtual timer with a userspace vgic.
+	 */
+	if (irqchip_in_kernel(kvm) && vgic_initialized(kvm))
+		kvm_timer_init(kvm);
+
 	return 0;
 }
 
diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
index ad9db60..c9bd045 100644
--- a/include/kvm/arm_arch_timer.h
+++ b/include/kvm/arm_arch_timer.h
@@ -60,7 +60,7 @@ struct arch_timer_cpu {
 
 #ifdef CONFIG_KVM_ARM_TIMER
 int kvm_timer_hyp_init(void);
-int kvm_timer_init(struct kvm *kvm);
+void kvm_timer_init(struct kvm *kvm);
 void kvm_timer_vcpu_reset(struct kvm_vcpu *vcpu,
 			  const struct kvm_irq_level *irq);
 void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu);
diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 22fa819..48ce5cb 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -61,12 +61,14 @@ static void timer_disarm(struct arch_timer_cpu *timer)
 
 static void kvm_timer_inject_irq(struct kvm_vcpu *vcpu)
 {
+	int ret;
 	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
 
 	timer->cntv_ctl |= ARCH_TIMER_CTRL_IT_MASK;
-	kvm_vgic_inject_irq(vcpu->kvm, vcpu->vcpu_id,
-			    timer->irq->irq,
-			    timer->irq->level);
+	ret = kvm_vgic_inject_irq(vcpu->kvm, vcpu->vcpu_id,
+				  timer->irq->irq,
+				  timer->irq->level);
+	WARN_ON(ret);
 }
 
 static irqreturn_t kvm_arch_timer_handler(int irq, void *dev_id)
@@ -307,12 +309,15 @@ void kvm_timer_vcpu_terminate(struct kvm_vcpu *vcpu)
 	timer_disarm(timer);
 }
 
-int kvm_timer_init(struct kvm *kvm)
+void kvm_timer_init(struct kvm *kvm)
 {
+	if (kvm->arch.timer.enabled)
+		return;
+
 	if (timecounter && wqueue) {
 		kvm->arch.timer.cntvoff = kvm_phys_timer_read();
 		kvm->arch.timer.enabled = 1;
 	}
 
-	return 0;
+	return;
 }
-- 
2.1.2.330.g565301e.dirty
