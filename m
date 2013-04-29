From: anup.patel@linaro.org (Anup Patel)
Date: Mon, 29 Apr 2013 12:55:47 +0530
Subject: [PATCH V2] ARM: KVM: Allow host virt timer irq to be different from
 guest timer virt irq
Message-ID: <1367220347-5625-1-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arch_timer irq numbers (or PPI numbers) are implementation dependent
so, the host virtual timer irq number can be different from guest virtual
timer irq number.

This patch ensures that host virtual timer irq number is read from DTB and
guest virtual timer irq is determined based on vcpu target type.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
---
 arch/arm/include/asm/kvm_arch_timer.h |    4 ++++
 arch/arm/kvm/arch_timer.c             |   27 ++++++++++++++++++++-------
 arch/arm/kvm/reset.c                  |   11 +++++++++++
 3 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/kvm_arch_timer.h b/arch/arm/include/asm/kvm_arch_timer.h
index 68cb9e1..eeb2a3f 100644
--- a/arch/arm/include/asm/kvm_arch_timer.h
+++ b/arch/arm/include/asm/kvm_arch_timer.h
@@ -61,6 +61,8 @@ struct arch_timer_cpu {
 #ifdef CONFIG_KVM_ARM_TIMER
 int kvm_timer_hyp_init(void);
 int kvm_timer_init(struct kvm *kvm);
+void kvm_timer_vcpu_reset(struct kvm_vcpu *vcpu, 
+			  const struct kvm_irq_level *irq);
 void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu);
 void kvm_timer_flush_hwstate(struct kvm_vcpu *vcpu);
 void kvm_timer_sync_hwstate(struct kvm_vcpu *vcpu);
@@ -76,6 +78,8 @@ static inline int kvm_timer_init(struct kvm *kvm)
 	return 0;
 }
 
+static inline void kvm_timer_vcpu_reset(struct kvm_vcpu *vcpu, 
+					const struct kvm_irq_level *irq) {}
 static inline void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu) {}
 static inline void kvm_timer_flush_hwstate(struct kvm_vcpu *vcpu) {}
 static inline void kvm_timer_sync_hwstate(struct kvm_vcpu *vcpu) {}
diff --git a/arch/arm/kvm/arch_timer.c b/arch/arm/kvm/arch_timer.c
index 49a7516..c64b597 100644
--- a/arch/arm/kvm/arch_timer.c
+++ b/arch/arm/kvm/arch_timer.c
@@ -30,7 +30,7 @@
 
 static struct timecounter *timecounter;
 static struct workqueue_struct *wqueue;
-static struct kvm_irq_level timer_irq = {
+static struct kvm_irq_level host_timer_irq = {
 	.level	= 1,
 };
 
@@ -67,8 +67,8 @@ static void kvm_timer_inject_irq(struct kvm_vcpu *vcpu)
 
 	timer->cntv_ctl |= ARCH_TIMER_CTRL_IT_MASK;
 	kvm_vgic_inject_irq(vcpu->kvm, vcpu->vcpu_id,
-			    vcpu->arch.timer_cpu.irq->irq,
-			    vcpu->arch.timer_cpu.irq->level);
+			    timer->irq->irq,
+			    timer->irq->level);
 }
 
 static irqreturn_t kvm_arch_timer_handler(int irq, void *dev_id)
@@ -156,6 +156,20 @@ void kvm_timer_sync_hwstate(struct kvm_vcpu *vcpu)
 	timer_arm(timer, ns);
 }
 
+void kvm_timer_vcpu_reset(struct kvm_vcpu *vcpu, 
+			  const struct kvm_irq_level *irq)
+{
+	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
+
+	/*
+	 * The vcpu timer irq number cannot be determined in 
+	 * kvm_timer_vcpu_init() because it is called much before
+	 * kvm_vcpu_set_target(). To handle this, we determine
+	 * vcpu timer irq number when the vcpu is resetted.
+	 */
+	timer->irq = irq;
+}
+
 void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu)
 {
 	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
@@ -163,12 +177,11 @@ void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu)
 	INIT_WORK(&timer->expired, kvm_timer_inject_irq_work);
 	hrtimer_init(&timer->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 	timer->timer.function = kvm_timer_expire;
-	timer->irq = &timer_irq;
 }
 
 static void kvm_timer_init_interrupt(void *info)
 {
-	enable_percpu_irq(timer_irq.irq, 0);
+	enable_percpu_irq(host_timer_irq.irq, 0);
 }
 
 
@@ -182,7 +195,7 @@ static int kvm_timer_cpu_notify(struct notifier_block *self,
 		break;
 	case CPU_DYING:
 	case CPU_DYING_FROZEN:
-		disable_percpu_irq(timer_irq.irq);
+		disable_percpu_irq(host_timer_irq.irq);
 		break;
 	}
 
@@ -230,7 +243,7 @@ int kvm_timer_hyp_init(void)
 		goto out;
 	}
 
-	timer_irq.irq = ppi;
+	host_timer_irq.irq = ppi;
 
 	err = register_cpu_notifier(&kvm_timer_cpu_nb);
 	if (err) {
diff --git a/arch/arm/kvm/reset.c b/arch/arm/kvm/reset.c
index b80256b..0b49ad7 100644
--- a/arch/arm/kvm/reset.c
+++ b/arch/arm/kvm/reset.c
@@ -26,6 +26,7 @@
 #include <asm/cputype.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_coproc.h>
+#include <asm/kvm_arch_timer.h>
 
 /******************************************************************************
  * Cortex-A15 Reset Values
@@ -37,6 +38,11 @@ static struct kvm_regs a15_regs_reset = {
 	.usr_regs.ARM_cpsr = SVC_MODE | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT,
 };
 
+static const struct kvm_irq_level a15_vtimer_irq = {
+	.irq = 27,
+	.level = 1,
+};
+
 
 /*******************************************************************************
  * Exported reset function
@@ -52,6 +58,7 @@ static struct kvm_regs a15_regs_reset = {
 int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct kvm_regs *cpu_reset;
+	const struct kvm_irq_level *cpu_vtimer_irq;
 
 	switch (vcpu->arch.target) {
 	case KVM_ARM_TARGET_CORTEX_A15:
@@ -59,6 +66,7 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 			return -EINVAL;
 		cpu_reset = &a15_regs_reset;
 		vcpu->arch.midr = read_cpuid_id();
+		cpu_vtimer_irq = &a15_vtimer_irq;
 		break;
 	default:
 		return -ENODEV;
@@ -70,5 +78,8 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	/* Reset CP15 registers */
 	kvm_reset_coprocs(vcpu);
 
+	/* Reset arch_timer context */
+	kvm_timer_vcpu_reset(vcpu, cpu_vtimer_irq);
+
 	return 0;
 }
-- 
1.7.9.5
