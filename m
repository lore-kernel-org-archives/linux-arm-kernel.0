From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 14 Aug 2014 13:18:44 +0100
Subject: [PATCH 2/6] arm/arm64: KVM: Rename irq_active to irq_queued
In-Reply-To: <1405003196-12403-3-git-send-email-christoffer.dall@linaro.org>
 (Christoffer Dall's message of "Thu, 10 Jul 2014 15:39:52 +0100")
References: <1405003196-12403-1-git-send-email-christoffer.dall@linaro.org>
 <1405003196-12403-3-git-send-email-christoffer.dall@linaro.org>
Message-ID: <87mwb7s1qz.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On Thu, Jul 10 2014 at  3:39:52 pm BST, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> We have a special bitmap on the distributor struct to keep track of when
> level-triggered interrupts are queued on the list registers.  This was
> named irq_active, which is confusing, because the active state of an
> interrupt as per the GIC spec is a different thing, not specifically
> related to edge-triggered/level-triggered configurations but rather
> indicates an interrupt which has been ack'ed but not yet eoi'ed.
>
> Rename the bitmap and the corresponding accessor functions to irq_queued
> to clarify what this is actually used for.
>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

So to illustrate what I was going on about the first time you summitted
this patch, have a look at my below take on this. It is basically yours,
but just with the bitmap named "irq_can_sample", which is exactly what
this bitmap is about.

What do you think?

Thanks,

	M.

>From b6f864841878a5509e7d03581a224e270b25dd02 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <marc.zyngier@arm.com>
Date: Thu, 14 Aug 2014 13:14:34 +0100
Subject: [PATCH] KVM: arm: vgic: rename irq_active to irq_can sample

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/kvm/arm_vgic.h |  4 ++--
 virt/kvm/arm/vgic.c    | 35 +++++++++++++++++++----------------
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 35b0c12..385d771 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -143,8 +143,8 @@ struct vgic_dist {
 	/* Interrupt 'pin' level */
 	struct vgic_bitmap	irq_state;
 
-	/* Level-triggered interrupt in progress */
-	struct vgic_bitmap	irq_active;
+	/* Can we sample the pending bit to inject an interrupt? */
+	struct vgic_bitmap	irq_can_sample;
 
 	/* Interrupt priority. Not used yet. */
 	struct vgic_bytemap	irq_priority;
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 73eba79..1dedf03 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -60,12 +60,12 @@
  * the 'line' again. This is achieved as such:
  *
  * - When a level interrupt is moved onto a vcpu, the corresponding
- *   bit in irq_active is set. As long as this bit is set, the line
+ *   bit in irq_can_sample is cleared. As long as this bit is 0, the line
  *   will be ignored for further interrupts. The interrupt is injected
  *   into the vcpu with the GICH_LR_EOI bit set (generate a
  *   maintenance interrupt on EOI).
  * - When the interrupt is EOIed, the maintenance interrupt fires,
- *   and clears the corresponding bit in irq_active. This allow the
+ *   and sets the corresponding bit in irq_can_sample. This allow the
  *   interrupt line to be sampled again.
  */
 
@@ -196,25 +196,25 @@ static int vgic_irq_is_enabled(struct kvm_vcpu *vcpu, int irq)
 	return vgic_bitmap_get_irq_val(&dist->irq_enabled, vcpu->vcpu_id, irq);
 }
 
-static int vgic_irq_is_active(struct kvm_vcpu *vcpu, int irq)
+static int vgic_irq_can_sample(struct kvm_vcpu *vcpu, int irq)
 {
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
 
-	return vgic_bitmap_get_irq_val(&dist->irq_active, vcpu->vcpu_id, irq);
+	return vgic_bitmap_get_irq_val(&dist->irq_can_sample, vcpu->vcpu_id, irq);
 }
 
-static void vgic_irq_set_active(struct kvm_vcpu *vcpu, int irq)
+static void vgic_irq_allow_sample(struct kvm_vcpu *vcpu, int irq)
 {
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
 
-	vgic_bitmap_set_irq_val(&dist->irq_active, vcpu->vcpu_id, irq, 1);
+	vgic_bitmap_set_irq_val(&dist->irq_can_sample, vcpu->vcpu_id, irq, 1);
 }
 
-static void vgic_irq_clear_active(struct kvm_vcpu *vcpu, int irq)
+static void vgic_irq_forbid_sample(struct kvm_vcpu *vcpu, int irq)
 {
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
 
-	vgic_bitmap_set_irq_val(&dist->irq_active, vcpu->vcpu_id, irq, 0);
+	vgic_bitmap_set_irq_val(&dist->irq_can_sample, vcpu->vcpu_id, irq, 0);
 }
 
 static int vgic_dist_irq_is_pending(struct kvm_vcpu *vcpu, int irq)
@@ -1079,8 +1079,8 @@ static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu)
 
 		if (!vgic_irq_is_enabled(vcpu, vlr.irq)) {
 			vgic_retire_lr(lr, vlr.irq, vcpu);
-			if (vgic_irq_is_active(vcpu, vlr.irq))
-				vgic_irq_clear_active(vcpu, vlr.irq);
+			if (!vgic_irq_can_sample(vcpu, vlr.irq))
+				vgic_irq_allow_sample(vcpu, vlr.irq);
 		}
 	}
 }
@@ -1170,7 +1170,7 @@ static bool vgic_queue_sgi(struct kvm_vcpu *vcpu, int irq)
 
 static bool vgic_queue_hwirq(struct kvm_vcpu *vcpu, int irq)
 {
-	if (vgic_irq_is_active(vcpu, irq))
+	if (!vgic_irq_can_sample(vcpu, irq))
 		return true; /* level interrupt, already queued */
 
 	if (vgic_queue_irq(vcpu, 0, irq)) {
@@ -1178,7 +1178,7 @@ static bool vgic_queue_hwirq(struct kvm_vcpu *vcpu, int irq)
 			vgic_dist_irq_clear(vcpu, irq);
 			vgic_cpu_irq_clear(vcpu, irq);
 		} else {
-			vgic_irq_set_active(vcpu, irq);
+			vgic_irq_forbid_sample(vcpu, irq);
 		}
 
 		return true;
@@ -1252,8 +1252,8 @@ static bool vgic_process_maintenance(struct kvm_vcpu *vcpu)
 
 	if (status & INT_STATUS_EOI) {
 		/*
-		 * Some level interrupts have been EOIed. Clear their
-		 * active bit.
+		 * Some level interrupts have been EOIed. Allow them
+		 * to be resampled.
 		 */
 		u64 eisr = vgic_get_eisr(vcpu);
 		unsigned long *eisr_ptr = (unsigned long *)&eisr;
@@ -1262,7 +1262,7 @@ static bool vgic_process_maintenance(struct kvm_vcpu *vcpu)
 		for_each_set_bit(lr, eisr_ptr, vgic->nr_lr) {
 			struct vgic_lr vlr = vgic_get_lr(vcpu, lr);
 
-			vgic_irq_clear_active(vcpu, vlr.irq);
+			vgic_irq_allow_sample(vcpu, vlr.irq);
 			WARN_ON(vlr.state & LR_STATE_MASK);
 			vlr.state = 0;
 			vgic_set_lr(vcpu, lr, vlr);
@@ -1429,7 +1429,7 @@ static bool vgic_update_irq_state(struct kvm *kvm, int cpuid,
 		goto out;
 	}
 
-	if (is_level && vgic_irq_is_active(vcpu, irq_num)) {
+	if (is_level && !vgic_irq_can_sample(vcpu, irq_num)) {
 		/*
 		 * Level interrupt in progress, will be picked up
 		 * when EOId.
@@ -1506,6 +1506,9 @@ int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
 		if (i < VGIC_NR_PRIVATE_IRQS)
 			vgic_bitmap_set_irq_val(&dist->irq_cfg,
 						vcpu->vcpu_id, i, VGIC_CFG_EDGE);
+		/* Let vcpu0 also allow sampling of SPIs */
+		if (i < VGIC_NR_PRIVATE_IRQS || vcpu->vcpu_id == 0)
+			vgic_irq_allow_sample(vcpu, i);
 
 		vgic_cpu->vgic_irq_lr_map[i] = LR_EMPTY;
 	}
-- 
2.0.0


-- 
Jazz is not dead. It just smells funny.
