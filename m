From: jintack@cs.columbia.edu (Jintack Lim)
Date: Thu, 26 Jan 2017 20:04:57 -0500
Subject: [RFC v2 07/10] KVM: arm/arm64: Set a background timer to the earliest
 timer expiration
In-Reply-To: <1485479100-4966-1-git-send-email-jintack@cs.columbia.edu>
References: <1485479100-4966-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1485479100-4966-8-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When scheduling a background timer, consider both of the virtual and
physical timer and pick the earliest expiration time.

Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 arch/arm/kvm/arm.c        |  3 ++-
 virt/kvm/arm/arch_timer.c | 55 ++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 9a34a3c..9e94f87 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -301,7 +301,8 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 
 int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
 {
-	return kvm_timer_should_fire(vcpu, vcpu_vtimer(vcpu));
+	return kvm_timer_should_fire(vcpu, vcpu_vtimer(vcpu)) ||
+		kvm_timer_should_fire(vcpu, vcpu_ptimer(vcpu));
 }
 
 void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu)
diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 3b6bd50..d3925e2 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -119,6 +119,35 @@ static u64 kvm_timer_compute_delta(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+static bool kvm_timer_irq_can_fire(struct arch_timer_context *timer_ctx)
+{
+	return !(timer_ctx->cnt_ctl & ARCH_TIMER_CTRL_IT_MASK) &&
+		(timer_ctx->cnt_ctl & ARCH_TIMER_CTRL_ENABLE);
+}
+
+/*
+ * Returns the earliest expiration time in ns among guest timers.
+ * Note that it will return 0 if none of timers can fire.
+ */
+static u64 kvm_timer_earliest_exp(struct kvm_vcpu *vcpu)
+{
+	u64 min_virt = ULLONG_MAX, min_phys = ULLONG_MAX;
+	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
+	struct arch_timer_context *ptimer = vcpu_ptimer(vcpu);
+
+	if (kvm_timer_irq_can_fire(vtimer))
+		min_virt = kvm_timer_compute_delta(vcpu, vtimer);
+
+	if (kvm_timer_irq_can_fire(ptimer))
+		min_phys = kvm_timer_compute_delta(vcpu, ptimer);
+
+	/* If none of timers can fire, then return 0 */
+	if ((min_virt == ULLONG_MAX) && (min_phys == ULLONG_MAX))
+		return 0;
+
+	return min(min_virt, min_phys);
+}
+
 static enum hrtimer_restart kvm_timer_expire(struct hrtimer *hrt)
 {
 	struct arch_timer_cpu *timer;
@@ -133,7 +162,7 @@ static enum hrtimer_restart kvm_timer_expire(struct hrtimer *hrt)
 	 * PoV (NTP on the host may have forced it to expire
 	 * early). If we should have slept longer, restart it.
 	 */
-	ns = kvm_timer_compute_delta(vcpu, vcpu_vtimer(vcpu));
+	ns = kvm_timer_earliest_exp(vcpu);
 	if (unlikely(ns)) {
 		hrtimer_forward_now(hrt, ns_to_ktime(ns));
 		return HRTIMER_RESTART;
@@ -143,12 +172,6 @@ static enum hrtimer_restart kvm_timer_expire(struct hrtimer *hrt)
 	return HRTIMER_NORESTART;
 }
 
-static bool kvm_timer_irq_can_fire(struct arch_timer_context *timer_ctx)
-{
-	return !(timer_ctx->cnt_ctl & ARCH_TIMER_CTRL_IT_MASK) &&
-		(timer_ctx->cnt_ctl & ARCH_TIMER_CTRL_ENABLE);
-}
-
 bool kvm_timer_should_fire(struct kvm_vcpu *vcpu,
 			   struct arch_timer_context *timer_ctx)
 {
@@ -233,26 +256,32 @@ void kvm_timer_schedule(struct kvm_vcpu *vcpu)
 {
 	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
 	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
+	struct arch_timer_context *ptimer = vcpu_ptimer(vcpu);
 
 	BUG_ON(timer_is_armed(timer));
 
 	/*
-	 * No need to schedule a background timer if the guest timer has
+	 * No need to schedule a background timer if any guest timer has
 	 * already expired, because kvm_vcpu_block will return before putting
 	 * the thread to sleep.
 	 */
-	if (kvm_timer_should_fire(vcpu, vtimer))
+	if (kvm_timer_should_fire(vcpu, vtimer) ||
+	    kvm_timer_should_fire(vcpu, ptimer))
 		return;
 
 	/*
-	 * If the timer is not capable of raising interrupts (disabled or
+	 * If both timers are not capable of raising interrupts (disabled or
 	 * masked), then there's no more work for us to do.
 	 */
-	if (!kvm_timer_irq_can_fire(vtimer))
+	if (!kvm_timer_irq_can_fire(vtimer) &&
+	    !kvm_timer_irq_can_fire(ptimer))
 		return;
 
-	/*  The timer has not yet expired, schedule a background timer */
-	timer_arm(timer, kvm_timer_compute_delta(vcpu, vtimer));
+	/*
+	 * The guest timers have not yet expired, schedule a background timer.
+	 * Set the earliest expiration time among the guest timers.
+	 */
+	timer_arm(timer, kvm_timer_earliest_exp(vcpu));
 }
 
 void kvm_timer_unschedule(struct kvm_vcpu *vcpu)
-- 
1.9.1
