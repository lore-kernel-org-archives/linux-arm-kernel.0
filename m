From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 15 Dec 2014 12:41:59 +0100
Subject: [GIT PULL 12/12] arm/arm64: KVM: Require in-kernel vgic for the arch
 timers
In-Reply-To: <1418643719-25966-1-git-send-email-christoffer.dall@linaro.org>
References: <1418643719-25966-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1418643719-25966-13-git-send-email-christoffer.dall@linaro.org>
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

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/arm.c           | 13 +++++++++++--
 include/kvm/arm_arch_timer.h | 10 ++++------
 virt/kvm/arm/arch_timer.c    | 30 ++++++++++++++++++++++--------
 3 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 66f37c4..2d6d910 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -425,6 +425,7 @@ static void update_vttbr(struct kvm *kvm)
 
 static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
 {
+	struct kvm *kvm = vcpu->kvm;
 	int ret;
 
 	if (likely(vcpu->arch.has_run_once))
@@ -436,12 +437,20 @@ static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
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
+	 * Enable the arch timers only if we have an in-kernel VGIC
+	 * and it has been properly initialized, since we cannot handle
+	 * interrupts from the virtual timer with a userspace gic.
+	 */
+	if (irqchip_in_kernel(kvm) && vgic_initialized(kvm))
+		kvm_timer_enable(kvm);
+
 	return 0;
 }
 
diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
index ad9db60..b3f45a5 100644
--- a/include/kvm/arm_arch_timer.h
+++ b/include/kvm/arm_arch_timer.h
@@ -60,7 +60,8 @@ struct arch_timer_cpu {
 
 #ifdef CONFIG_KVM_ARM_TIMER
 int kvm_timer_hyp_init(void);
-int kvm_timer_init(struct kvm *kvm);
+void kvm_timer_enable(struct kvm *kvm);
+void kvm_timer_init(struct kvm *kvm);
 void kvm_timer_vcpu_reset(struct kvm_vcpu *vcpu,
 			  const struct kvm_irq_level *irq);
 void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu);
@@ -77,11 +78,8 @@ static inline int kvm_timer_hyp_init(void)
 	return 0;
 };
 
-static inline int kvm_timer_init(struct kvm *kvm)
-{
-	return 0;
-}
-
+static inline void kvm_timer_enable(struct kvm *kvm) {}
+static inline void kvm_timer_init(struct kvm *kvm) {}
 static inline void kvm_timer_vcpu_reset(struct kvm_vcpu *vcpu,
 					const struct kvm_irq_level *irq) {}
 static inline void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu) {}
diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 22fa819..1c0772b 100644
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
@@ -307,12 +309,24 @@ void kvm_timer_vcpu_terminate(struct kvm_vcpu *vcpu)
 	timer_disarm(timer);
 }
 
-int kvm_timer_init(struct kvm *kvm)
+void kvm_timer_enable(struct kvm *kvm)
 {
-	if (timecounter && wqueue) {
-		kvm->arch.timer.cntvoff = kvm_phys_timer_read();
+	if (kvm->arch.timer.enabled)
+		return;
+
+	/*
+	 * There is a potential race here between VCPUs starting for the first
+	 * time, which may be enabling the timer multiple times.  That doesn't
+	 * hurt though, because we're just setting a variable to the same
+	 * variable that it already was.  The important thing is that all
+	 * VCPUs have the enabled variable set, before entering the guest, if
+	 * the arch timers are enabled.
+	 */
+	if (timecounter && wqueue)
 		kvm->arch.timer.enabled = 1;
-	}
+}
 
-	return 0;
+void kvm_timer_init(struct kvm *kvm)
+{
+	kvm->arch.timer.cntvoff = kvm_phys_timer_read();
 }
-- 
2.1.2.330.g565301e.dirty
