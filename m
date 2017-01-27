From: jintack@cs.columbia.edu (Jintack Lim)
Date: Thu, 26 Jan 2017 20:04:52 -0500
Subject: [RFC v2 02/10] KVM: arm/arm64: Move cntvoff to each timer context
In-Reply-To: <1485479100-4966-1-git-send-email-jintack@cs.columbia.edu>
References: <1485479100-4966-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1485479100-4966-3-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make cntvoff per each timer context. This is helpful to abstract kvm
timer functions to work with timer context without considering timer
types (e.g. physical timer or virtual timer).

This also would pave the way for ever doing adjustments of the cntvoff
on a per-CPU basis if that should ever make sense.

Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 arch/arm/include/asm/kvm_host.h   |  6 +++---
 arch/arm64/include/asm/kvm_host.h |  4 ++--
 include/kvm/arm_arch_timer.h      |  8 +++-----
 virt/kvm/arm/arch_timer.c         | 26 ++++++++++++++++++++------
 virt/kvm/arm/hyp/timer-sr.c       |  3 +--
 5 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index d5423ab..f5456a9 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -60,9 +60,6 @@ struct kvm_arch {
 	/* The last vcpu id that ran on each physical CPU */
 	int __percpu *last_vcpu_ran;
 
-	/* Timer */
-	struct arch_timer_kvm	timer;
-
 	/*
 	 * Anything that is not used directly from assembly code goes
 	 * here.
@@ -75,6 +72,9 @@ struct kvm_arch {
 	/* Stage-2 page table */
 	pgd_t *pgd;
 
+	/* A lock to synchronize cntvoff among all vtimer context of vcpus */
+	spinlock_t cntvoff_lock;
+
 	/* Interrupt controller */
 	struct vgic_dist	vgic;
 	int max_vcpus;
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index e505038..23749a8 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -71,8 +71,8 @@ struct kvm_arch {
 	/* Interrupt controller */
 	struct vgic_dist	vgic;
 
-	/* Timer */
-	struct arch_timer_kvm	timer;
+	/* A lock to synchronize cntvoff among all vtimer context of vcpus */
+	spinlock_t cntvoff_lock;
 };
 
 #define KVM_NR_MEM_OBJS     40
diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
index daad3c1..1b9c988 100644
--- a/include/kvm/arm_arch_timer.h
+++ b/include/kvm/arm_arch_timer.h
@@ -23,11 +23,6 @@
 #include <linux/hrtimer.h>
 #include <linux/workqueue.h>
 
-struct arch_timer_kvm {
-	/* Virtual offset */
-	u64			cntvoff;
-};
-
 struct arch_timer_context {
 	/* Registers: control register, timer value */
 	u32				cnt_ctl;
@@ -38,6 +33,9 @@ struct arch_timer_context {
 
 	/* Active IRQ state caching */
 	bool				active_cleared_last;
+
+	/* Virtual offset */
+	u64			cntvoff;
 };
 
 struct arch_timer_cpu {
diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 6740efa..fa4c042 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -101,9 +101,10 @@ static void kvm_timer_inject_irq_work(struct work_struct *work)
 static u64 kvm_timer_compute_delta(struct kvm_vcpu *vcpu)
 {
 	u64 cval, now;
+	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
 
-	cval = vcpu_vtimer(vcpu)->cnt_cval;
-	now = kvm_phys_timer_read() - vcpu->kvm->arch.timer.cntvoff;
+	cval = vtimer->cnt_cval;
+	now = kvm_phys_timer_read() - vtimer->cntvoff;
 
 	if (now < cval) {
 		u64 ns;
@@ -159,7 +160,7 @@ bool kvm_timer_should_fire(struct kvm_vcpu *vcpu)
 		return false;
 
 	cval = vtimer->cnt_cval;
-	now = kvm_phys_timer_read() - vcpu->kvm->arch.timer.cntvoff;
+	now = kvm_phys_timer_read() - vtimer->cntvoff;
 
 	return cval <= now;
 }
@@ -353,10 +354,23 @@ int kvm_timer_vcpu_reset(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+/* Make the updates of cntvoff for all vtimer contexts atomic */
+static void update_vtimer_cntvoff(struct kvm_vcpu *vcpu, u64 cntvoff)
+{
+	int i;
+
+	spin_lock(&vcpu->kvm->arch.cntvoff_lock);
+	kvm_for_each_vcpu(i, vcpu, vcpu->kvm)
+		vcpu_vtimer(vcpu)->cntvoff = cntvoff;
+	spin_unlock(&vcpu->kvm->arch.cntvoff_lock);
+}
+
 void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu)
 {
 	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
 
+	update_vtimer_cntvoff(vcpu, kvm_phys_timer_read());
+
 	INIT_WORK(&timer->expired, kvm_timer_inject_irq_work);
 	hrtimer_init(&timer->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 	timer->timer.function = kvm_timer_expire;
@@ -376,7 +390,7 @@ int kvm_arm_timer_set_reg(struct kvm_vcpu *vcpu, u64 regid, u64 value)
 		vtimer->cnt_ctl = value;
 		break;
 	case KVM_REG_ARM_TIMER_CNT:
-		vcpu->kvm->arch.timer.cntvoff = kvm_phys_timer_read() - value;
+		update_vtimer_cntvoff(vcpu, kvm_phys_timer_read() - value);
 		break;
 	case KVM_REG_ARM_TIMER_CVAL:
 		vtimer->cnt_cval = value;
@@ -397,7 +411,7 @@ u64 kvm_arm_timer_get_reg(struct kvm_vcpu *vcpu, u64 regid)
 	case KVM_REG_ARM_TIMER_CTL:
 		return vtimer->cnt_ctl;
 	case KVM_REG_ARM_TIMER_CNT:
-		return kvm_phys_timer_read() - vcpu->kvm->arch.timer.cntvoff;
+		return kvm_phys_timer_read() - vtimer->cntvoff;
 	case KVM_REG_ARM_TIMER_CVAL:
 		return vtimer->cnt_cval;
 	}
@@ -511,7 +525,7 @@ int kvm_timer_enable(struct kvm_vcpu *vcpu)
 
 void kvm_timer_init(struct kvm *kvm)
 {
-	kvm->arch.timer.cntvoff = kvm_phys_timer_read();
+	spin_lock_init(&kvm->arch.cntvoff_lock);
 }
 
 /*
diff --git a/virt/kvm/arm/hyp/timer-sr.c b/virt/kvm/arm/hyp/timer-sr.c
index 0cf0895..4734915 100644
--- a/virt/kvm/arm/hyp/timer-sr.c
+++ b/virt/kvm/arm/hyp/timer-sr.c
@@ -53,7 +53,6 @@ void __hyp_text __timer_save_state(struct kvm_vcpu *vcpu)
 
 void __hyp_text __timer_restore_state(struct kvm_vcpu *vcpu)
 {
-	struct kvm *kvm = kern_hyp_va(vcpu->kvm);
 	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
 	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
 	u64 val;
@@ -71,7 +70,7 @@ void __hyp_text __timer_restore_state(struct kvm_vcpu *vcpu)
 	}
 
 	if (timer->enabled) {
-		write_sysreg(kvm->arch.timer.cntvoff, cntvoff_el2);
+		write_sysreg(vtimer->cntvoff, cntvoff_el2);
 		write_sysreg_el0(vtimer->cnt_cval, cntv_cval);
 		isb();
 		write_sysreg_el0(vtimer->cnt_ctl, cntv_ctl);
-- 
1.9.1
