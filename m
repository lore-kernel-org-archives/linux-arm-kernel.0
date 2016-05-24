From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 24 May 2016 11:09:01 +0200
Subject: [PULL 07/59] KVM: arm/arm64: arch_timer: Remove irq_phys_map
In-Reply-To: <1464080993-10884-1-git-send-email-christoffer.dall@linaro.org>
References: <1464080993-10884-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1464080993-10884-8-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>

Now that the interface between the arch timer and the VGIC does not
require passing the irq_phys_map entry pointer anymore, let's remove
it from the virtual arch timer and use the virtual IRQ number instead
directly.
The remaining pointer returned by kvm_vgic_map_phys_irq() will be
removed in the following patch.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Eric Auger <eric.auger@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 include/kvm/arm_arch_timer.h |  3 ---
 virt/kvm/arm/arch_timer.c    | 10 ++++------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
index b651aed..a47b7de 100644
--- a/include/kvm/arm_arch_timer.h
+++ b/include/kvm/arm_arch_timer.h
@@ -53,9 +53,6 @@ struct arch_timer_cpu {
 	/* Timer IRQ */
 	struct kvm_irq_level		irq;
 
-	/* VGIC mapping */
-	struct irq_phys_map		*map;
-
 	/* Active IRQ state caching */
 	bool				active_cleared_last;
 };
diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index e45895a..458d4d8 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -175,10 +175,10 @@ static void kvm_timer_update_irq(struct kvm_vcpu *vcpu, bool new_level)
 
 	timer->active_cleared_last = false;
 	timer->irq.level = new_level;
-	trace_kvm_timer_update_irq(vcpu->vcpu_id, timer->map->virt_irq,
+	trace_kvm_timer_update_irq(vcpu->vcpu_id, timer->irq.irq,
 				   timer->irq.level);
 	ret = kvm_vgic_inject_mapped_irq(vcpu->kvm, vcpu->vcpu_id,
-					 timer->map->virt_irq,
+					 timer->irq.irq,
 					 timer->irq.level);
 	WARN_ON(ret);
 }
@@ -276,7 +276,7 @@ void kvm_timer_flush_hwstate(struct kvm_vcpu *vcpu)
 	* exit.
 	*/
 	phys_active = timer->irq.level ||
-			kvm_vgic_map_is_active(vcpu, timer->map->virt_irq);
+			kvm_vgic_map_is_active(vcpu, timer->irq.irq);
 
 	/*
 	 * We want to avoid hitting the (re)distributor as much as
@@ -378,7 +378,6 @@ int kvm_timer_vcpu_reset(struct kvm_vcpu *vcpu,
 	if (WARN_ON(IS_ERR(map)))
 		return PTR_ERR(map);
 
-	timer->map = map;
 	return 0;
 }
 
@@ -504,8 +503,7 @@ void kvm_timer_vcpu_terminate(struct kvm_vcpu *vcpu)
 	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
 
 	timer_disarm(timer);
-	if (timer->map)
-		kvm_vgic_unmap_phys_irq(vcpu, timer->map->virt_irq);
+	kvm_vgic_unmap_phys_irq(vcpu, timer->irq.irq);
 }
 
 void kvm_timer_enable(struct kvm *kvm)
-- 
2.1.2.330.g565301e.dirty
