From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 27 Sep 2016 21:08:04 +0200
Subject: [PATCH 1/3] KVM: arm/arm64: Cleanup the arch timer code's irqchip
 checking
In-Reply-To: <20160927190806.22988-1-christoffer.dall@linaro.org>
References: <20160927190806.22988-1-christoffer.dall@linaro.org>
Message-ID: <20160927190806.22988-2-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we check if we have an in-kernel irqchip and if the vgic was
properly implemented several places in the arch timer code.  But, we
already predicate our enablement of the arm timers on having a valid
and initialized gic, so we can simply check if the timers are enabled or
not.

This also gets rid of the ugly "error that's not an error but used to
signal that the timer shouldn't poke the gic" construct we have.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/arch_timer.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 27a1f63..824ed26 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -171,8 +171,6 @@ static void kvm_timer_update_irq(struct kvm_vcpu *vcpu, bool new_level)
 	int ret;
 	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
 
-	BUG_ON(!vgic_initialized(vcpu->kvm));
-
 	timer->active_cleared_last = false;
 	timer->irq.level = new_level;
 	trace_kvm_timer_update_irq(vcpu->vcpu_id, timer->irq.irq,
@@ -187,7 +185,7 @@ static void kvm_timer_update_irq(struct kvm_vcpu *vcpu, bool new_level)
  * Check if there was a change in the timer state (should we raise or lower
  * the line level to the GIC).
  */
-static int kvm_timer_update_state(struct kvm_vcpu *vcpu)
+static void kvm_timer_update_state(struct kvm_vcpu *vcpu)
 {
 	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
 
@@ -197,13 +195,11 @@ static int kvm_timer_update_state(struct kvm_vcpu *vcpu)
 	 * because the guest would never see the interrupt.  Instead wait
 	 * until we call this function from kvm_timer_flush_hwstate.
 	 */
-	if (!vgic_initialized(vcpu->kvm) || !timer->enabled)
-		return -ENODEV;
+	if (!timer->enabled)
+		return;
 
 	if (kvm_timer_should_fire(vcpu) != timer->irq.level)
 		kvm_timer_update_irq(vcpu, !timer->irq.level);
-
-	return 0;
 }
 
 /*
@@ -255,9 +251,11 @@ void kvm_timer_flush_hwstate(struct kvm_vcpu *vcpu)
 	bool phys_active;
 	int ret;
 
-	if (kvm_timer_update_state(vcpu))
+	if (unlikely(!timer->enabled))
 		return;
 
+	kvm_timer_update_state(vcpu);
+
 	/*
 	* If we enter the guest with the virtual input level to the VGIC
 	* asserted, then we have already told the VGIC what we need to, and
-- 
2.9.0
