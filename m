From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 28 Jun 2017 16:04:03 +0100
Subject: [PATCH v2 44/52] KVM: arm/arm64: GICv4: Handle MOVALL applied to a vPE
In-Reply-To: <20170628150411.15846-1-marc.zyngier@arm.com>
References: <20170628150411.15846-1-marc.zyngier@arm.com>
Message-ID: <20170628150411.15846-45-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current implementation of MOVALL doesn't allow us to call
into the core ITS code as we hold a number of spinlocks.

Let's try a method used in other parts of the code, were we copy
the intids of the candicate interrupts, and then do whatever
we need to do with them outside of the critical section.

This allows us to move the interrupts one by one, at the expense
of a bit of CPU time. Who cares? MOVALL is such a stupid command
anyway...

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-its.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 21a7b3f00107..b40f46e5a79d 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -1147,11 +1147,12 @@ static int vgic_its_cmd_handle_invall(struct kvm *kvm, struct vgic_its *its,
 static int vgic_its_cmd_handle_movall(struct kvm *kvm, struct vgic_its *its,
 				      u64 *its_cmd)
 {
-	struct vgic_dist *dist = &kvm->arch.vgic;
 	u32 target1_addr = its_cmd_get_target_addr(its_cmd);
 	u32 target2_addr = its_cmd_mask_field(its_cmd, 3, 16, 32);
 	struct kvm_vcpu *vcpu1, *vcpu2;
 	struct vgic_irq *irq;
+	u32 *intids;
+	int irq_count, i;
 
 	if (target1_addr >= atomic_read(&kvm->online_vcpus) ||
 	    target2_addr >= atomic_read(&kvm->online_vcpus))
@@ -1163,19 +1164,31 @@ static int vgic_its_cmd_handle_movall(struct kvm *kvm, struct vgic_its *its,
 	vcpu1 = kvm_get_vcpu(kvm, target1_addr);
 	vcpu2 = kvm_get_vcpu(kvm, target2_addr);
 
-	spin_lock(&dist->lpi_list_lock);
+	irq_count = vgic_copy_lpi_list(vcpu1, &intids);
+	if (irq_count < 0)
+		return irq_count;
 
-	list_for_each_entry(irq, &dist->lpi_list_head, lpi_list) {
-		spin_lock(&irq->irq_lock);
+	for (i = 0; i < irq_count; i++) {
+		irq = vgic_get_irq(kvm, NULL, intids[i]);
+		if (!irq)
+			continue;
 
 		if (irq->target_vcpu == vcpu1)
 			irq->target_vcpu = vcpu2;
 
-		spin_unlock(&irq->irq_lock);
-	}
+		if (irq->hw) {
+			struct its_vlpi_map map;
 
-	spin_unlock(&dist->lpi_list_lock);
+			if (!its_get_vlpi(irq->host_irq, &map)) {
+				map.vpe_idx = vcpu2->vcpu_id;
+				its_map_vlpi(irq->host_irq, &map);
+			}
+		}
 
+		vgic_put_irq(kvm, irq);
+	}
+
+	kfree(intids);
 	return 0;
 }
 
-- 
2.11.0
