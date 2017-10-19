From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 19 Oct 2017 16:48:35 +0100
Subject: [PATCH v4 27/26] KVM: arm/arm64: GICv4: Prevent userspace from
 changing doorbell affinity
In-Reply-To: <20171006153401.5481-1-marc.zyngier@arm.com>
References: <20171006153401.5481-1-marc.zyngier@arm.com>
Message-ID: <20171019154835.17942-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We so far allocate the doorbell interrupts without taking any
special measure regarding the affinity of these interrupts. We
simply move them around as required when the vcpu gets scheduled
on a different CPU.

But that's counting without userspace (and the evil irqbalance) that
can try and move the VPE interrupt around, causing the ITS code
to emit VMOVP commands and remap the doorbell to another redistributor.
Worse, this can happen while the vcpu is running, causing all kind
of trouble if the VPE is already resident, and we end-up in UNPRED
territory.

So let's take a definitive action and prevent userspace from messing
with us. This is just a matter of adding IRQ_NO_BALANCING to the
set of flags we already have, letting the kernel in sole control
of the affinity.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-v4.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

This extra patch goes on top of the current GICv4 patches, and is hence
being posted with a weird sequence number...

diff --git a/virt/kvm/arm/vgic/vgic-v4.c b/virt/kvm/arm/vgic/vgic-v4.c
index b87806fea554..c3dbab714328 100644
--- a/virt/kvm/arm/vgic/vgic-v4.c
+++ b/virt/kvm/arm/vgic/vgic-v4.c
@@ -89,6 +89,8 @@
  * reason), the doorbell interrupt is disabled.
  */
 
+#define DB_IRQ_FLAGS	(IRQ_NOAUTOEN | IRQ_DISABLE_UNLAZY | IRQ_NO_BALANCING)
+
 static irqreturn_t vgic_v4_doorbell_handler(int irq, void *info)
 {
 	struct kvm_vcpu *vcpu = info;
@@ -149,7 +151,7 @@ int vgic_v4_init(struct kvm *kvm)
 		 * doorbell could kick us out of the guest too
 		 * early...
 		 */
-		irq_set_status_flags(irq, IRQ_NOAUTOEN | IRQ_DISABLE_UNLAZY);
+		irq_set_status_flags(irq, DB_IRQ_FLAGS);
 		ret = request_irq(irq, vgic_v4_doorbell_handler,
 				  0, "vcpu", vcpu);
 		if (ret) {
@@ -187,7 +189,7 @@ void vgic_v4_teardown(struct kvm *kvm)
 		struct kvm_vcpu *vcpu = kvm_get_vcpu(kvm, i);
 		int irq = its_vm->vpes[i]->irq;
 
-		irq_clear_status_flags(irq, IRQ_NOAUTOEN | IRQ_DISABLE_UNLAZY);
+		irq_clear_status_flags(irq, DB_IRQ_FLAGS);
 		free_irq(irq, vcpu);
 	}
 
-- 
2.14.1
