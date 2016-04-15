From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 15 Apr 2016 18:11:55 +0100
Subject: [PATCH 44/45] KVM: arm/arm64: vgic-new: implement mapped IRQ handling
In-Reply-To: <1460740316-8755-1-git-send-email-andre.przywara@arm.com>
References: <1460740316-8755-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1460740316-8755-45-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now store the mapped hardware IRQ number in our struct, so we
don't need the irq_phys_map for the new VGIC.
Implement the hardware IRQ mapping on top of the reworked arch
timer interface.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Changelog RFC..v1:
- adapt to new arch_timer mapped IRQ interface
- implement inject_mapped_irq() as a macro (since it is identical to
  the "un-mapped" IRQ implementation)
---
 include/kvm/vgic/vgic.h  |  6 ++++++
 virt/kvm/arm/vgic/vgic.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/kvm/vgic/vgic.h b/include/kvm/vgic/vgic.h
index 6e5e6d7..eff6626 100644
--- a/include/kvm/vgic/vgic.h
+++ b/include/kvm/vgic/vgic.h
@@ -209,6 +209,12 @@ int kvm_vgic_hyp_init(void);
 
 int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int intid,
 			bool level);
+/* TODO: for compatibility with the old VGIC's timer implementation */
+#define kvm_vgic_inject_mapped_irq kvm_vgic_inject_irq
+
+int kvm_vgic_map_phys_irq(struct kvm_vcpu *vcpu, u32 virt_irq, u32 phys_irq);
+int kvm_vgic_unmap_phys_irq(struct kvm_vcpu *vcpu, unsigned int virt_irq);
+bool kvm_vgic_map_is_active(struct kvm_vcpu *vcpu, unsigned int virt_irq);
 
 int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu);
 
diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index f8252d4..15fd146 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -17,6 +17,8 @@
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
 #include <linux/list_sort.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
 
 #include "vgic.h"
 
@@ -296,6 +298,39 @@ int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int intid,
 
 	vcpu = kvm_get_vcpu(kvm, cpuid);
 	vgic_update_irq_pending(kvm, vcpu, intid, level);
+
+	return 0;
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
 	return 0;
 }
 
@@ -568,3 +603,15 @@ void vgic_kick_vcpus(struct kvm *kvm)
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
2.7.3
