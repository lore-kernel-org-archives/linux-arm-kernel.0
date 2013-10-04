From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  4 Oct 2013 13:16:15 +0100
Subject: [RFC PATCH 2/5] arm/arm64: KVM: vgic: kill VGIC_NR_SHARED_IRQS
In-Reply-To: <1380888978-27725-1-git-send-email-marc.zyngier@arm.com>
References: <1380888978-27725-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1380888978-27725-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

having a dynamic number of supported interrupts means that we
cannot relly on VGIC_NR_SHARED_IRQS anymore, as the upper bound
is not known anymore.

Just nuke it.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/kvm/arm_vgic.h |  1 -
 virt/kvm/arm/vgic.c    | 12 +++++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 3cc3a9f..8ce9c08 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -30,7 +30,6 @@
 #define VGIC_NR_SGIS		16
 #define VGIC_NR_PPIS		16
 #define VGIC_NR_PRIVATE_IRQS	(VGIC_NR_SGIS + VGIC_NR_PPIS)
-#define VGIC_NR_SHARED_IRQS	(VGIC_NR_IRQS - VGIC_NR_PRIVATE_IRQS)
 #define VGIC_MAX_CPUS		KVM_MAX_VCPUS
 #define VGIC_MAX_LRS		(1 << 6)
 
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index f16c848..951b560 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -821,6 +821,7 @@ static int compute_pending_for_cpu(struct kvm_vcpu *vcpu)
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
 	unsigned long *pending, *enabled, *pend_percpu, *pend_shared;
 	unsigned long pending_private, pending_shared;
+	int nr_shared_irqs = dist->nr_irqs - VGIC_NR_PRIVATE_IRQS;
 	int vcpu_id;
 
 	vcpu_id = vcpu->vcpu_id;
@@ -833,15 +834,15 @@ static int compute_pending_for_cpu(struct kvm_vcpu *vcpu)
 
 	pending = vgic_bitmap_get_shared_map(&dist->irq_state);
 	enabled = vgic_bitmap_get_shared_map(&dist->irq_enabled);
-	bitmap_and(pend_shared, pending, enabled, VGIC_NR_SHARED_IRQS);
+	bitmap_and(pend_shared, pending, enabled, nr_shared_irqs);
 	bitmap_and(pend_shared, pend_shared,
 		   vgic_bitmap_get_shared_map(&dist->irq_spi_target[vcpu_id]),
-		   VGIC_NR_SHARED_IRQS);
+		   nr_shared_irqs);
 
 	pending_private = find_first_bit(pend_percpu, VGIC_NR_PRIVATE_IRQS);
-	pending_shared = find_first_bit(pend_shared, VGIC_NR_SHARED_IRQS);
+	pending_shared = find_first_bit(pend_shared, nr_shared_irqs);
 	return (pending_private < VGIC_NR_PRIVATE_IRQS ||
-		pending_shared < VGIC_NR_SHARED_IRQS);
+		pending_shared < nr_shared_irqs);
 }
 
 /*
@@ -1002,6 +1003,7 @@ static void __kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu)
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+	int nr_shared_irqs = dist->nr_irqs - VGIC_NR_PRIVATE_IRQS;
 	int i, vcpu_id;
 	int overflow = 0;
 
@@ -1030,7 +1032,7 @@ static void __kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu)
 	}
 
 	/* SPIs */
-	for_each_set_bit(i, vgic_cpu->pending_shared, VGIC_NR_SHARED_IRQS) {
+	for_each_set_bit(i, vgic_cpu->pending_shared, nr_shared_irqs) {
 		if (!vgic_queue_hwirq(vcpu, i + VGIC_NR_PRIVATE_IRQS))
 			overflow = 1;
 	}
-- 
1.8.2.3
