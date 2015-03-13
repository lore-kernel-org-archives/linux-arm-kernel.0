From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Fri, 13 Mar 2015 17:02:55 +0000
Subject: [PATCH v3 4/5] arm/arm64: KVM: Fix migration race in the arch timer
In-Reply-To: <1426266176-14933-1-git-send-email-alex.bennee@linaro.org>
References: <1426266176-14933-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1426266176-14933-5-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

When a VCPU is no longer running, we currently check to see if it has a
timer scheduled in the future, and if it does, we schedule a host
hrtimer to notify is in case the timer expires while the VCPU is still
not running.  When the hrtimer fires, we mask the guest's timer and
inject the timer IRQ (still relying on the guest unmasking the time when
it receives the IRQ).

This is all good and fine, but when migration a VM (checkpoint/restore)
this introduces a race.  It is unlikely, but possible, for the following
sequence of events to happen:

 1. Userspace stops the VM
 2. Hrtimer for VCPU is scheduled
 3. Userspace checkpoints the VGIC state (no pending timer interrupts)
 4. The hrtimer fires, schedules work in a workqueue
 5. Workqueue function runs, masks the timer and injects timer interrupt
 6. Userspace checkpoints the timer state (timer masked)

At restore time, you end up with a masked timer without any timer
interrupts and your guest halts never receiving timer interrupts.

Fix this by only kicking the VCPU in the workqueue function, and sample
the expired state of the timer when entering the guest again and inject
the interrupt and mask the timer only then.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 38721d2..eb93240 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -269,7 +269,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 
 int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
 {
-	return 0;
+	return kvm_timer_should_fire(vcpu);
 }
 
 int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
index b3f45a5..98cc9f4 100644
--- a/include/kvm/arm_arch_timer.h
+++ b/include/kvm/arm_arch_timer.h
@@ -72,6 +72,8 @@ void kvm_timer_vcpu_terminate(struct kvm_vcpu *vcpu);
 u64 kvm_arm_timer_get_reg(struct kvm_vcpu *, u64 regid);
 int kvm_arm_timer_set_reg(struct kvm_vcpu *, u64 regid, u64 value);
 
+bool kvm_timer_should_fire(struct kvm_vcpu *vcpu);
+
 #else
 static inline int kvm_timer_hyp_init(void)
 {
@@ -96,6 +98,11 @@ static inline u64 kvm_arm_timer_get_reg(struct kvm_vcpu *vcpu, u64 regid)
 {
 	return 0;
 }
+
+static inline bool kvm_timer_should_fire(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
 #endif
 
 #endif
diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 6e54f35..98c95f2 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -85,13 +85,22 @@ static irqreturn_t kvm_arch_timer_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+/*
+ * Work function for handling the backup timer that we schedule when a vcpu is
+ * no longer running, but had a timer programmed to fire in the future.
+ */
 static void kvm_timer_inject_irq_work(struct work_struct *work)
 {
 	struct kvm_vcpu *vcpu;
 
 	vcpu = container_of(work, struct kvm_vcpu, arch.timer_cpu.expired);
 	vcpu->arch.timer_cpu.armed = false;
-	kvm_timer_inject_irq(vcpu);
+
+	/*
+	 * If the vcpu is blocked we want to wake it up so that it will see
+	 * the timer has expired when entering the guest.
+	 */
+	kvm_vcpu_kick(vcpu);
 }
 
 static enum hrtimer_restart kvm_timer_expire(struct hrtimer *hrt)
@@ -102,6 +111,21 @@ static enum hrtimer_restart kvm_timer_expire(struct hrtimer *hrt)
 	return HRTIMER_NORESTART;
 }
 
+bool kvm_timer_should_fire(struct kvm_vcpu *vcpu)
+{
+	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
+	cycle_t cval, now;
+
+	if ((timer->cntv_ctl & ARCH_TIMER_CTRL_IT_MASK) ||
+		!(timer->cntv_ctl & ARCH_TIMER_CTRL_ENABLE))
+		return false;
+
+	cval = timer->cntv_cval;
+	now = kvm_phys_timer_read() - vcpu->kvm->arch.timer.cntvoff;
+
+	return cval <= now;
+}
+
 /**
  * kvm_timer_flush_hwstate - prepare to move the virt timer to the cpu
  * @vcpu: The vcpu pointer
@@ -119,6 +143,13 @@ void kvm_timer_flush_hwstate(struct kvm_vcpu *vcpu)
 	 * populate the CPU timer again.
 	 */
 	timer_disarm(timer);
+
+	/*
+	 * If the timer expired while we were not scheduled, now is the time
+	 * to inject it.
+	 */
+	if (kvm_timer_should_fire(vcpu))
+		kvm_timer_inject_irq(vcpu);
 }
 
 /**
@@ -134,16 +165,9 @@ void kvm_timer_sync_hwstate(struct kvm_vcpu *vcpu)
 	cycle_t cval, now;
 	u64 ns;
 
-	if ((timer->cntv_ctl & ARCH_TIMER_CTRL_IT_MASK) ||
-		!(timer->cntv_ctl & ARCH_TIMER_CTRL_ENABLE))
-		return;
-
-	cval = timer->cntv_cval;
-	now = kvm_phys_timer_read() - vcpu->kvm->arch.timer.cntvoff;
-
 	BUG_ON(timer_is_armed(timer));
 
-	if (cval <= now) {
+	if (kvm_timer_should_fire(vcpu)) {
 		/*
 		 * Timer has already expired while we were not
 		 * looking. Inject the interrupt and carry on.
@@ -152,6 +176,9 @@ void kvm_timer_sync_hwstate(struct kvm_vcpu *vcpu)
 		return;
 	}
 
+	cval = timer->cntv_cval;
+	now = kvm_phys_timer_read() - vcpu->kvm->arch.timer.cntvoff;
+
 	ns = cyclecounter_cyc2ns(timecounter->cc, cval - now, timecounter->mask,
 				 &timecounter->frac);
 	timer_arm(timer, ns);
-- 
2.3.2
