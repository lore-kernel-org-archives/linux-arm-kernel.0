From: anup.patel@linaro.org (Anup Patel)
Date: Thu, 25 Apr 2013 14:15:34 +0530
Subject: [PATCH] ARM: KVM: Allow host virtual timer irq number to be different
 from guest virtual timer irq number
Message-ID: <1366879534-31578-1-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arch_timer irq numbers (or PPI number) are implementation dependent so, the host virtual timer irq number can be different from guest virtual timer irq number.

Currently, we only have Cortex-A15 guest (for KVM ARMv7) and Cortex-A57 guest (for KVM ARMv8) supported. These guests have virtual timer irq number as 27.

This patch ensures that host virtual timer irq number is read from DTB and guest virtual timer irq is always 27.

Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
---
 arch/arm/kvm/arch_timer.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kvm/arch_timer.c b/arch/arm/kvm/arch_timer.c
index 49a7516..376abf0 100644
--- a/arch/arm/kvm/arch_timer.c
+++ b/arch/arm/kvm/arch_timer.c
@@ -30,10 +30,18 @@
 
 static struct timecounter *timecounter;
 static struct workqueue_struct *wqueue;
-static struct kvm_irq_level timer_irq = {
+static struct kvm_irq_level host_timer_irq = {
 	.level	= 1,
 };
 
+/* Guest virtual timer irq number will be based on type of guest we emulate. 
+ * For Cortex-A15 & Cortex-A57 guest, virtual timer irq is 27
+ */
+static struct kvm_irq_level guest_timer_irq = {
+	.irq = 27,
+	.level = 1,
+};
+
 static cycle_t kvm_phys_timer_read(void)
 {
 	return timecounter->cc->read(timecounter->cc);
@@ -163,12 +171,12 @@ void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu)
 	INIT_WORK(&timer->expired, kvm_timer_inject_irq_work);
 	hrtimer_init(&timer->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 	timer->timer.function = kvm_timer_expire;
-	timer->irq = &timer_irq;
+	timer->irq = &guest_timer_irq;
 }
 
 static void kvm_timer_init_interrupt(void *info)
 {
-	enable_percpu_irq(timer_irq.irq, 0);
+	enable_percpu_irq(host_timer_irq.irq, 0);
 }
 
 
@@ -182,7 +190,7 @@ static int kvm_timer_cpu_notify(struct notifier_block *self,
 		break;
 	case CPU_DYING:
 	case CPU_DYING_FROZEN:
-		disable_percpu_irq(timer_irq.irq);
+		disable_percpu_irq(host_timer_irq.irq);
 		break;
 	}
 
@@ -230,7 +238,7 @@ int kvm_timer_hyp_init(void)
 		goto out;
 	}
 
-	timer_irq.irq = ppi;
+	host_timer_irq.irq = ppi;
 
 	err = register_cpu_notifier(&kvm_timer_cpu_nb);
 	if (err) {
-- 
1.7.9.5
