From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 16 May 2016 10:53:43 +0100
Subject: [PATCH v4 55/56] KVM: arm/arm64: vgic-new: implement mapped IRQ
 handling
In-Reply-To: <1463392481-26583-1-git-send-email-andre.przywara@arm.com>
References: <1463392481-26583-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1463392481-26583-56-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now store the mapped hardware IRQ number in our struct, so we
don't need the irq_phys_map for the new VGIC.
Implement the hardware IRQ mapping on top of the reworked arch
timer interface.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
---
Changelog RFC..v1:
- adapt to new arch_timer mapped IRQ interface
- implement inject_mapped_irq() as a macro (since it is identical to
  the "un-mapped" IRQ implementation)

Changelog v1 .. v2:
- replace inject_mapped_irq() macro with a separate implementation,
  which only allows mapped IRQs to be injected via this interface

 include/kvm/vgic/vgic.h  |  5 +++++
 virt/kvm/arm/vgic/vgic.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/include/kvm/vgic/vgic.h b/include/kvm/vgic/vgic.h
index 17b2a73..3fbd175 100644
--- a/include/kvm/vgic/vgic.h
+++ b/include/kvm/vgic/vgic.h
@@ -206,6 +206,11 @@ int kvm_vgic_hyp_init(void);
 
 int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int intid,
 			bool level);
+int kvm_vgic_inject_mapped_irq(struct kvm *kvm, int cpuid, unsigned int intid,
+			       bool level);
+int kvm_vgic_map_phys_irq(struct kvm_vcpu *vcpu, u32 virt_irq, u32 phys_irq);
+int kvm_vgic_unmap_phys_irq(struct kvm_vcpu *vcpu, unsigned int virt_irq);
+bool kvm_vgic_map_is_active(struct kvm_vcpu *vcpu, unsigned int virt_irq);
 
 int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu);
 
diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index fd2cac3..c22f7e2 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -312,6 +312,44 @@ int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int intid,
 	return vgic_update_irq_pending(kvm, cpuid, intid, level, false);
 }
 
+int kvm_vgic_inject_mapped_irq(struct kvm *kvm, int cpuid, unsigned int intid,
+			       bool level)
+{
+	return vgic_update_irq_pending(kvm, cpuid, intid, level, true);
+}
+
+int kvm_vgic_map_phys_irq(struct kvm_vcpu *vcpu, u32 virt_irq, u32 phys_irq)
+{
+	struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, virt_irq);
+
+	BUG_ON(!irq);
+
+	spin_lock(&irq->irq_lock);
+
+	irq->hw = true;
+	irq->hwintid = phys_irq;
+
+	spin_unlock(&irq->irq_lock);
+
+	return 0;
+}
+
+int kvm_vgic_unmap_phys_irq(struct kvm_vcpu *vcpu, unsigned int virt_irq)
+{
+	struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, virt_irq);
+
+	BUG_ON(!irq);
+
+	spin_lock(&irq->irq_lock);
+
+	irq->hw = false;
+	irq->hwintid = 0;
+
+	spin_unlock(&irq->irq_lock);
+
+	return 0;
+}
+
 /**
  * vgic_prune_ap_list - Remove non-relevant interrupts from the list
  *
@@ -563,3 +601,15 @@ void vgic_kick_vcpus(struct kvm *kvm)
 			kvm_vcpu_kick(vcpu);
 	}
 }
+
+bool kvm_vgic_map_is_active(struct kvm_vcpu *vcpu, unsigned int virt_irq)
+{
+	struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, virt_irq);
+	bool map_is_active;
+
+	spin_lock(&irq->irq_lock);
+	map_is_active = irq->hw && irq->active;
+	spin_unlock(&irq->irq_lock);
+
+	return map_is_active;
+}
-- 
2.8.2
