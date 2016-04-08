From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri,  8 Apr 2016 11:52:13 +0200
Subject: [PULL 2/4] KVM: arm/arm64: Handle forward time correction gracefully
In-Reply-To: <1460109135-6612-1-git-send-email-christoffer.dall@linaro.org>
References: <1460109135-6612-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1460109135-6612-3-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

On a host that runs NTP, corrections can have a direct impact on
the background timer that we program on the behalf of a vcpu.

In particular, NTP performing a forward correction will result in
a timer expiring sooner than expected from a guest point of view.
Not a big deal, we kick the vcpu anyway.

But on wake-up, the vcpu thread is going to perform a check to
find out whether or not it should block. And at that point, the
timer check is going to say "timer has not expired yet, go back
to sleep". This results in the timer event being lost forever.

There are multiple ways to handle this. One would be record that
the timer has expired and let kvm_cpu_has_pending_timer return
true in that case, but that would be fairly invasive. Another is
to check for the "short sleep" condition in the hrtimer callback,
and restart the timer for the remaining time when the condition
is detected.

This patch implements the latter, with a bit of refactoring in
order to avoid too much code duplication.

Cc: <stable@vger.kernel.org>
Reported-by: Alexander Graf <agraf@suse.de>
Reviewed-by: Alexander Graf <agraf@suse.de>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/arch_timer.c | 49 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index a9ad4fe..9aaa35d 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -91,6 +91,8 @@ static void kvm_timer_inject_irq_work(struct work_struct *work)
 	vcpu = container_of(work, struct kvm_vcpu, arch.timer_cpu.expired);
 	vcpu->arch.timer_cpu.armed = false;
 
+	WARN_ON(!kvm_timer_should_fire(vcpu));
+
 	/*
 	 * If the vcpu is blocked we want to wake it up so that it will see
 	 * the timer has expired when entering the guest.
@@ -98,10 +100,46 @@ static void kvm_timer_inject_irq_work(struct work_struct *work)
 	kvm_vcpu_kick(vcpu);
 }
 
+static u64 kvm_timer_compute_delta(struct kvm_vcpu *vcpu)
+{
+	cycle_t cval, now;
+
+	cval = vcpu->arch.timer_cpu.cntv_cval;
+	now = kvm_phys_timer_read() - vcpu->kvm->arch.timer.cntvoff;
+
+	if (now < cval) {
+		u64 ns;
+
+		ns = cyclecounter_cyc2ns(timecounter->cc,
+					 cval - now,
+					 timecounter->mask,
+					 &timecounter->frac);
+		return ns;
+	}
+
+	return 0;
+}
+
 static enum hrtimer_restart kvm_timer_expire(struct hrtimer *hrt)
 {
 	struct arch_timer_cpu *timer;
+	struct kvm_vcpu *vcpu;
+	u64 ns;
+
 	timer = container_of(hrt, struct arch_timer_cpu, timer);
+	vcpu = container_of(timer, struct kvm_vcpu, arch.timer_cpu);
+
+	/*
+	 * Check that the timer has really expired from the guest's
+	 * PoV (NTP on the host may have forced it to expire
+	 * early). If we should have slept longer, restart it.
+	 */
+	ns = kvm_timer_compute_delta(vcpu);
+	if (unlikely(ns)) {
+		hrtimer_forward_now(hrt, ns_to_ktime(ns));
+		return HRTIMER_RESTART;
+	}
+
 	queue_work(wqueue, &timer->expired);
 	return HRTIMER_NORESTART;
 }
@@ -176,8 +214,6 @@ static int kvm_timer_update_state(struct kvm_vcpu *vcpu)
 void kvm_timer_schedule(struct kvm_vcpu *vcpu)
 {
 	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
-	u64 ns;
-	cycle_t cval, now;
 
 	BUG_ON(timer_is_armed(timer));
 
@@ -197,14 +233,7 @@ void kvm_timer_schedule(struct kvm_vcpu *vcpu)
 		return;
 
 	/*  The timer has not yet expired, schedule a background timer */
-	cval = timer->cntv_cval;
-	now = kvm_phys_timer_read() - vcpu->kvm->arch.timer.cntvoff;
-
-	ns = cyclecounter_cyc2ns(timecounter->cc,
-				 cval - now,
-				 timecounter->mask,
-				 &timecounter->frac);
-	timer_arm(timer, ns);
+	timer_arm(timer, kvm_timer_compute_delta(vcpu));
 }
 
 void kvm_timer_unschedule(struct kvm_vcpu *vcpu)
-- 
2.1.2.330.g565301e.dirty
