From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 24 May 2016 11:08:56 +0200
Subject: [PULL 02/59] KVM: arm/arm64: vgic: streamline
 vgic_update_irq_pending() interface
In-Reply-To: <1464080993-10884-1-git-send-email-christoffer.dall@linaro.org>
References: <1464080993-10884-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1464080993-10884-3-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>

We actually don't use the irq_phys_map parameter in
vgic_update_irq_pending(), so let's just remove it.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Eric Auger <eric.auger@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 60668a7..f6c6172 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1521,7 +1521,6 @@ static int vgic_validate_injection(struct kvm_vcpu *vcpu, int irq, int level)
 }
 
 static int vgic_update_irq_pending(struct kvm *kvm, int cpuid,
-				   struct irq_phys_map *map,
 				   unsigned int irq_num, bool level)
 {
 	struct vgic_dist *dist = &kvm->arch.vgic;
@@ -1660,7 +1659,7 @@ int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
 	if (map)
 		return -EINVAL;
 
-	return vgic_update_irq_pending(kvm, cpuid, NULL, irq_num, level);
+	return vgic_update_irq_pending(kvm, cpuid, irq_num, level);
 }
 
 /**
@@ -1686,7 +1685,7 @@ int kvm_vgic_inject_mapped_irq(struct kvm *kvm, int cpuid,
 	if (ret)
 		return ret;
 
-	return vgic_update_irq_pending(kvm, cpuid, map, map->virt_irq, level);
+	return vgic_update_irq_pending(kvm, cpuid, map->virt_irq, level);
 }
 
 static irqreturn_t vgic_maintenance_handler(int irq, void *data)
-- 
2.1.2.330.g565301e.dirty
