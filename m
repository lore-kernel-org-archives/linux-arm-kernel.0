From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 17 Apr 2018 11:23:49 +0100
Subject: [PATCH] KVM: arm/arm64: VGIC: Kick new VCPU on interrupt migration
Message-ID: <20180417102349.3039-1-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When vgic_prune_ap_list() finds an interrupt that needs to be migrated
to a new VCPU, we should notify this VCPU of the pending interrupt,
since it requires immediate action.
Kick this VCPU once we have added the new IRQ to the list, but only
after dropping the locks.

Reported-by: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 virt/kvm/arm/vgic/vgic.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index e74baec76361..4b6d72939c42 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -594,6 +594,7 @@ static void vgic_prune_ap_list(struct kvm_vcpu *vcpu)
 
 	list_for_each_entry_safe(irq, tmp, &vgic_cpu->ap_list_head, ap_list) {
 		struct kvm_vcpu *target_vcpu, *vcpuA, *vcpuB;
+		bool target_vcpu_needs_kick = false;
 
 		spin_lock(&irq->irq_lock);
 
@@ -664,11 +665,18 @@ static void vgic_prune_ap_list(struct kvm_vcpu *vcpu)
 			list_del(&irq->ap_list);
 			irq->vcpu = target_vcpu;
 			list_add_tail(&irq->ap_list, &new_cpu->ap_list_head);
+			target_vcpu_needs_kick = true;
 		}
 
 		spin_unlock(&irq->irq_lock);
 		spin_unlock(&vcpuB->arch.vgic_cpu.ap_list_lock);
 		spin_unlock_irqrestore(&vcpuA->arch.vgic_cpu.ap_list_lock, flags);
+
+		if (target_vcpu_needs_kick) {
+			kvm_make_request(KVM_REQ_IRQ_PENDING, target_vcpu);
+			kvm_vcpu_kick(target_vcpu);
+		}
+
 		goto retry;
 	}
 
-- 
2.14.1
