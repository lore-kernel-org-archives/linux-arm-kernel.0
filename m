From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 24 Nov 2015 18:35:32 +0100
Subject: [PULL 4/8] KVM: arm/arm64: Fix preemptible timer active state
 crazyness
In-Reply-To: <1448386536-30118-1-git-send-email-christoffer.dall@linaro.org>
References: <1448386536-30118-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1448386536-30118-5-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We were setting the physical active state on the GIC distributor in a
preemptible section, which could cause us to set the active state on
different physical CPU from the one we were actually going to run on,
hacoc ensues.

Since we are no longer descheduling/scheduling soft timers in the
flush/sync timer functions, simply moving the timer flush into a
non-preemptible section.

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/arm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index eab83b2..e06fd29 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -564,17 +564,12 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 			vcpu_sleep(vcpu);
 
 		/*
-		 * Disarming the background timer must be done in a
-		 * preemptible context, as this call may sleep.
-		 */
-		kvm_timer_flush_hwstate(vcpu);
-
-		/*
 		 * Preparing the interrupts to be injected also
 		 * involves poking the GIC, which must be done in a
 		 * non-preemptible context.
 		 */
 		preempt_disable();
+		kvm_timer_flush_hwstate(vcpu);
 		kvm_vgic_flush_hwstate(vcpu);
 
 		local_irq_disable();
-- 
2.1.2.330.g565301e.dirty
