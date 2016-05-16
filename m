From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 16 May 2016 10:53:48 +0100
Subject: [PATCH v4 03/56] KVM: arm/arm64: vgic: avoid map in
 kvm_vgic_map_is_active()
In-Reply-To: <1463392481-26583-1-git-send-email-andre.przywara@arm.com>
References: <1463392481-26583-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1463392481-26583-61-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For getting the active state of a mapped IRQ, we actually only need
the virtual IRQ number, not the pointer to the mapping entry.
Pass the virtual IRQ number from the arch timer to the VGIC directly.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Eric Auger <eric.auger@linaro.org>
---
Changelog v1 .. v2:
- rewrap phys_active determination to fit in 80 characters

 include/kvm/arm_vgic.h    | 2 +-
 virt/kvm/arm/arch_timer.c | 6 ++----
 virt/kvm/arm/vgic.c       | 6 +++---
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index e22f015..9830232 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -348,7 +348,7 @@ int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu);
 struct irq_phys_map *kvm_vgic_map_phys_irq(struct kvm_vcpu *vcpu,
 					   int virt_irq, int irq);
 int kvm_vgic_unmap_phys_irq(struct kvm_vcpu *vcpu, struct irq_phys_map *map);
-bool kvm_vgic_map_is_active(struct kvm_vcpu *vcpu, struct irq_phys_map *map);
+bool kvm_vgic_map_is_active(struct kvm_vcpu *vcpu, unsigned int virt_irq);
 
 #define irqchip_in_kernel(k)	(!!((k)->arch.vgic.in_kernel))
 #define vgic_initialized(k)	(!!((k)->arch.vgic.nr_cpus))
diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index a9c6c1c..37f82c1 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -274,10 +274,8 @@ void kvm_timer_flush_hwstate(struct kvm_vcpu *vcpu)
 	* to ensure that hardware interrupts from the timer triggers a guest
 	* exit.
 	*/
-	if (timer->irq.level || kvm_vgic_map_is_active(vcpu, timer->map))
-		phys_active = true;
-	else
-		phys_active = false;
+	phys_active = timer->irq.level ||
+			kvm_vgic_map_is_active(vcpu, timer->map->virt_irq);
 
 	/*
 	 * We want to avoid hitting the (re)distributor as much as
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 81c557c..2fd43a6 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1102,18 +1102,18 @@ static bool dist_active_irq(struct kvm_vcpu *vcpu)
 	return test_bit(vcpu->vcpu_id, dist->irq_active_on_cpu);
 }
 
-bool kvm_vgic_map_is_active(struct kvm_vcpu *vcpu, struct irq_phys_map *map)
+bool kvm_vgic_map_is_active(struct kvm_vcpu *vcpu, unsigned int virt_irq)
 {
 	int i;
 
 	for (i = 0; i < vcpu->arch.vgic_cpu.nr_lr; i++) {
 		struct vgic_lr vlr = vgic_get_lr(vcpu, i);
 
-		if (vlr.irq == map->virt_irq && vlr.state & LR_STATE_ACTIVE)
+		if (vlr.irq == virt_irq && vlr.state & LR_STATE_ACTIVE)
 			return true;
 	}
 
-	return vgic_irq_is_active(vcpu, map->virt_irq);
+	return vgic_irq_is_active(vcpu, virt_irq);
 }
 
 /*
-- 
2.8.2
