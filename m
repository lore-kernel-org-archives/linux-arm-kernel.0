From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 11 Sep 2014 12:09:10 +0100
Subject: [PATCH v4 3/8] arm/arm64: KVM: vgic: Parametrize VGIC_NR_SHARED_IRQS
In-Reply-To: <1410433755-3612-1-git-send-email-marc.zyngier@arm.com>
References: <1410433755-3612-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1410433755-3612-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Having a dynamic number of supported interrupts means that we
cannot relly on VGIC_NR_SHARED_IRQS being fixed anymore.

Instead, make it take the distributor structure as a parameter,
so it can return the right value.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/kvm/arm_vgic.h |  1 -
 virt/kvm/arm/vgic.c    | 16 +++++++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index bdaac57..bdeb451 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -29,7 +29,6 @@
 #define VGIC_NR_SGIS		16
 #define VGIC_NR_PPIS		16
 #define VGIC_NR_PRIVATE_IRQS	(VGIC_NR_SGIS + VGIC_NR_PPIS)
-#define VGIC_NR_SHARED_IRQS	(VGIC_NR_IRQS - VGIC_NR_PRIVATE_IRQS)
 #define VGIC_MAX_CPUS		KVM_MAX_VCPUS
 
 #define VGIC_V2_MAX_LRS		(1 << 6)
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 92c086e..93fe73b 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1083,11 +1083,17 @@ static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg)
 	}
 }
 
+static int vgic_nr_shared_irqs(struct vgic_dist *dist)
+{
+	return dist->nr_irqs - VGIC_NR_PRIVATE_IRQS;
+}
+
 static int compute_pending_for_cpu(struct kvm_vcpu *vcpu)
 {
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
 	unsigned long *pending, *enabled, *pend_percpu, *pend_shared;
 	unsigned long pending_private, pending_shared;
+	int nr_shared = vgic_nr_shared_irqs(dist);
 	int vcpu_id;
 
 	vcpu_id = vcpu->vcpu_id;
@@ -1100,15 +1106,15 @@ static int compute_pending_for_cpu(struct kvm_vcpu *vcpu)
 
 	pending = vgic_bitmap_get_shared_map(&dist->irq_pending);
 	enabled = vgic_bitmap_get_shared_map(&dist->irq_enabled);
-	bitmap_and(pend_shared, pending, enabled, VGIC_NR_SHARED_IRQS);
+	bitmap_and(pend_shared, pending, enabled, nr_shared);
 	bitmap_and(pend_shared, pend_shared,
 		   vgic_bitmap_get_shared_map(&dist->irq_spi_target[vcpu_id]),
-		   VGIC_NR_SHARED_IRQS);
+		   nr_shared);
 
 	pending_private = find_first_bit(pend_percpu, VGIC_NR_PRIVATE_IRQS);
-	pending_shared = find_first_bit(pend_shared, VGIC_NR_SHARED_IRQS);
+	pending_shared = find_first_bit(pend_shared, nr_shared);
 	return (pending_private < VGIC_NR_PRIVATE_IRQS ||
-		pending_shared < VGIC_NR_SHARED_IRQS);
+		pending_shared < vgic_nr_shared_irqs(dist));
 }
 
 /*
@@ -1365,7 +1371,7 @@ static void __kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu)
 	}
 
 	/* SPIs */
-	for_each_set_bit(i, vgic_cpu->pending_shared, VGIC_NR_SHARED_IRQS) {
+	for_each_set_bit(i, vgic_cpu->pending_shared, vgic_nr_shared_irqs(dist)) {
 		if (!vgic_queue_hwirq(vcpu, i + VGIC_NR_PRIVATE_IRQS))
 			overflow = 1;
 	}
-- 
2.0.4
