From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 10 Jul 2014 07:39:52 -0700
Subject: [PATCH 2/6] arm/arm64: KVM: Rename irq_active to irq_queued
In-Reply-To: <1405003196-12403-1-git-send-email-christoffer.dall@linaro.org>
References: <1405003196-12403-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1405003196-12403-3-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have a special bitmap on the distributor struct to keep track of when
level-triggered interrupts are queued on the list registers.  This was
named irq_active, which is confusing, because the active state of an
interrupt as per the GIC spec is a different thing, not specifically
related to edge-triggered/level-triggered configurations but rather
indicates an interrupt which has been ack'ed but not yet eoi'ed.

Rename the bitmap and the corresponding accessor functions to irq_queued
to clarify what this is actually used for.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 include/kvm/arm_vgic.h |  4 ++--
 virt/kvm/arm/vgic.c    | 28 ++++++++++++++--------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 388d442..7d8e61f 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -143,8 +143,8 @@ struct vgic_dist {
 	/* Interrupt state is pending on the distributor */
 	struct vgic_bitmap	irq_pending;
 
-	/* Level-triggered interrupt in progress */
-	struct vgic_bitmap	irq_active;
+	/* Level-triggered interrupt queued on VCPU interface */
+	struct vgic_bitmap	irq_queued;
 
 	/* Interrupt priority. Not used yet. */
 	struct vgic_bytemap	irq_priority;
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 661fa64..c5b1ad7 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -60,12 +60,12 @@
  * the 'line' again. This is achieved as such:
  *
  * - When a level interrupt is moved onto a vcpu, the corresponding
- *   bit in irq_active is set. As long as this bit is set, the line
+ *   bit in irq_queued is set. As long as this bit is set, the line
  *   will be ignored for further interrupts. The interrupt is injected
  *   into the vcpu with the GICH_LR_EOI bit set (generate a
  *   maintenance interrupt on EOI).
  * - When the interrupt is EOIed, the maintenance interrupt fires,
- *   and clears the corresponding bit in irq_active. This allow the
+ *   and clears the corresponding bit in irq_queued. This allow the
  *   interrupt line to be sampled again.
  */
 
@@ -196,25 +196,25 @@ static int vgic_irq_is_enabled(struct kvm_vcpu *vcpu, int irq)
 	return vgic_bitmap_get_irq_val(&dist->irq_enabled, vcpu->vcpu_id, irq);
 }
 
-static int vgic_irq_is_active(struct kvm_vcpu *vcpu, int irq)
+static int vgic_irq_is_queued(struct kvm_vcpu *vcpu, int irq)
 {
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
 
-	return vgic_bitmap_get_irq_val(&dist->irq_active, vcpu->vcpu_id, irq);
+	return vgic_bitmap_get_irq_val(&dist->irq_queued, vcpu->vcpu_id, irq);
 }
 
-static void vgic_irq_set_active(struct kvm_vcpu *vcpu, int irq)
+static void vgic_irq_set_queued(struct kvm_vcpu *vcpu, int irq)
 {
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
 
-	vgic_bitmap_set_irq_val(&dist->irq_active, vcpu->vcpu_id, irq, 1);
+	vgic_bitmap_set_irq_val(&dist->irq_queued, vcpu->vcpu_id, irq, 1);
 }
 
-static void vgic_irq_clear_active(struct kvm_vcpu *vcpu, int irq)
+static void vgic_irq_clear_queued(struct kvm_vcpu *vcpu, int irq)
 {
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
 
-	vgic_bitmap_set_irq_val(&dist->irq_active, vcpu->vcpu_id, irq, 0);
+	vgic_bitmap_set_irq_val(&dist->irq_queued, vcpu->vcpu_id, irq, 0);
 }
 
 static int vgic_dist_irq_is_pending(struct kvm_vcpu *vcpu, int irq)
@@ -1079,8 +1079,8 @@ static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu)
 
 		if (!vgic_irq_is_enabled(vcpu, vlr.irq)) {
 			vgic_retire_lr(lr, vlr.irq, vcpu);
-			if (vgic_irq_is_active(vcpu, vlr.irq))
-				vgic_irq_clear_active(vcpu, vlr.irq);
+			if (vgic_irq_is_queued(vcpu, vlr.irq))
+				vgic_irq_clear_queued(vcpu, vlr.irq);
 		}
 	}
 }
@@ -1170,7 +1170,7 @@ static bool vgic_queue_sgi(struct kvm_vcpu *vcpu, int irq)
 
 static bool vgic_queue_hwirq(struct kvm_vcpu *vcpu, int irq)
 {
-	if (vgic_irq_is_active(vcpu, irq))
+	if (vgic_irq_is_queued(vcpu, irq))
 		return true; /* level interrupt, already queued */
 
 	if (vgic_queue_irq(vcpu, 0, irq)) {
@@ -1178,7 +1178,7 @@ static bool vgic_queue_hwirq(struct kvm_vcpu *vcpu, int irq)
 			vgic_dist_irq_clear_pending(vcpu, irq);
 			vgic_cpu_irq_clear(vcpu, irq);
 		} else {
-			vgic_irq_set_active(vcpu, irq);
+			vgic_irq_set_queued(vcpu, irq);
 		}
 
 		return true;
@@ -1262,7 +1262,7 @@ static bool vgic_process_maintenance(struct kvm_vcpu *vcpu)
 		for_each_set_bit(lr, eisr_ptr, vgic->nr_lr) {
 			struct vgic_lr vlr = vgic_get_lr(vcpu, lr);
 
-			vgic_irq_clear_active(vcpu, vlr.irq);
+			vgic_irq_clear_queued(vcpu, vlr.irq);
 			WARN_ON(vlr.state & LR_STATE_MASK);
 			vlr.state = 0;
 			vgic_set_lr(vcpu, lr, vlr);
@@ -1429,7 +1429,7 @@ static bool vgic_update_irq_pending(struct kvm *kvm, int cpuid,
 		goto out;
 	}
 
-	if (level_triggered && vgic_irq_is_active(vcpu, irq_num)) {
+	if (level_triggered && vgic_irq_is_queued(vcpu, irq_num)) {
 		/*
 		 * Level interrupt in progress, will be picked up
 		 * when EOId.
-- 
2.0.0
