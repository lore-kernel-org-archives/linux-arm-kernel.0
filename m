From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 22 Nov 2013 15:57:19 -0800
Subject: [PATCH 3/3] arm/arm64: KVM: vgic: Use non-atomic bitops
In-Reply-To: <1385164639-18710-1-git-send-email-christoffer.dall@linaro.org>
References: <1385164639-18710-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1385164639-18710-4-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the use of atomic bitops to use the non-atomic versions.  All
these operations are protected under a spinlock so using atomic
operations is simply a waste of cycles.

The test_and_clear_bit operations saves us ~500 cycles per world switch
on TC2 on average.

Changing the remaining bitops to their non-atomic versions saves us ~50
cycles over 100 repetitions of the average world-switch time of ~120,000
worls switches.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index ecee766..8f52d41 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -128,9 +128,9 @@ static void vgic_bitmap_set_irq_val(struct vgic_bitmap *x, int cpuid,
 	}
 
 	if (val)
-		set_bit(irq, reg);
+		__set_bit(irq, reg);
 	else
-		clear_bit(irq, reg);
+		__clear_bit(irq, reg);
 }
 
 static unsigned long *vgic_bitmap_get_cpu_map(struct vgic_bitmap *x, int cpuid)
@@ -219,19 +219,19 @@ static void vgic_dist_irq_clear(struct kvm_vcpu *vcpu, int irq)
 static void vgic_cpu_irq_set(struct kvm_vcpu *vcpu, int irq)
 {
 	if (irq < VGIC_NR_PRIVATE_IRQS)
-		set_bit(irq, vcpu->arch.vgic_cpu.pending_percpu);
+		__set_bit(irq, vcpu->arch.vgic_cpu.pending_percpu);
 	else
-		set_bit(irq - VGIC_NR_PRIVATE_IRQS,
-			vcpu->arch.vgic_cpu.pending_shared);
+		__set_bit(irq - VGIC_NR_PRIVATE_IRQS,
+			  vcpu->arch.vgic_cpu.pending_shared);
 }
 
 static void vgic_cpu_irq_clear(struct kvm_vcpu *vcpu, int irq)
 {
 	if (irq < VGIC_NR_PRIVATE_IRQS)
-		clear_bit(irq, vcpu->arch.vgic_cpu.pending_percpu);
+		__clear_bit(irq, vcpu->arch.vgic_cpu.pending_percpu);
 	else
-		clear_bit(irq - VGIC_NR_PRIVATE_IRQS,
-			  vcpu->arch.vgic_cpu.pending_shared);
+		__clear_bit(irq - VGIC_NR_PRIVATE_IRQS,
+			    vcpu->arch.vgic_cpu.pending_shared);
 }
 
 static u32 mmio_data_read(struct kvm_exit_mmio *mmio, u32 mask)
@@ -466,9 +466,9 @@ static void vgic_set_target_reg(struct kvm *kvm, u32 val, int irq)
 		kvm_for_each_vcpu(c, vcpu, kvm) {
 			bmap = vgic_bitmap_get_shared_map(&dist->irq_spi_target[c]);
 			if (c == target)
-				set_bit(irq + i, bmap);
+				__set_bit(irq + i, bmap);
 			else
-				clear_bit(irq + i, bmap);
+				__clear_bit(irq + i, bmap);
 		}
 	}
 }
@@ -812,14 +812,14 @@ static void vgic_update_state(struct kvm *kvm)
 	int c;
 
 	if (!dist->enabled) {
-		set_bit(0, &dist->irq_pending_on_cpu);
+		__set_bit(0, &dist->irq_pending_on_cpu);
 		return;
 	}
 
 	kvm_for_each_vcpu(c, vcpu, kvm) {
 		if (compute_pending_for_cpu(vcpu)) {
 			pr_debug("CPU%d has pending interrupts\n", c);
-			set_bit(c, &dist->irq_pending_on_cpu);
+			__set_bit(c, &dist->irq_pending_on_cpu);
 		}
 	}
 }
@@ -848,7 +848,7 @@ static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu)
 
 		if (!vgic_irq_is_enabled(vcpu, irq)) {
 			vgic_cpu->vgic_irq_lr_map[irq] = LR_EMPTY;
-			clear_bit(lr, vgic_cpu->lr_used);
+			__clear_bit(lr, vgic_cpu->lr_used);
 			vgic_cpu->vgic_lr[lr] &= ~GICH_LR_STATE;
 			if (vgic_irq_is_active(vcpu, irq))
 				vgic_irq_clear_active(vcpu, irq);
@@ -893,7 +893,7 @@ static bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
 	kvm_debug("LR%d allocated for IRQ%d %x\n", lr, irq, sgi_source_id);
 	vgic_cpu->vgic_lr[lr] = MK_LR_PEND(sgi_source_id, irq);
 	vgic_cpu->vgic_irq_lr_map[irq] = lr;
-	set_bit(lr, vgic_cpu->lr_used);
+	__set_bit(lr, vgic_cpu->lr_used);
 
 	if (!vgic_irq_is_edge(vcpu, irq))
 		vgic_cpu->vgic_lr[lr] |= GICH_LR_EOI;
@@ -912,7 +912,7 @@ static bool vgic_queue_sgi(struct kvm_vcpu *vcpu, int irq)
 
 	for_each_set_bit(c, &sources, VGIC_MAX_CPUS) {
 		if (vgic_queue_irq(vcpu, c, irq))
-			clear_bit(c, &sources);
+			__clear_bit(c, &sources);
 	}
 
 	dist->irq_sgi_sources[vcpu_id][irq] = sources;
@@ -920,7 +920,7 @@ static bool vgic_queue_sgi(struct kvm_vcpu *vcpu, int irq)
 	/*
 	 * If the sources bitmap has been cleared it means that we
 	 * could queue all the SGIs onto link registers (see the
-	 * clear_bit above), and therefore we are done with them in
+	 * __clear_bit above), and therefore we are done with them in
 	 * our emulated gic and can get rid of them.
 	 */
 	if (!sources) {
@@ -1003,7 +1003,7 @@ epilog:
 		 * us. Claim we don't have anything pending. We'll
 		 * adjust that if needed while exiting.
 		 */
-		clear_bit(vcpu_id, &dist->irq_pending_on_cpu);
+		__clear_bit(vcpu_id, &dist->irq_pending_on_cpu);
 	}
 }
 
@@ -1040,7 +1040,7 @@ static bool vgic_process_maintenance(struct kvm_vcpu *vcpu)
 			 * Despite being EOIed, the LR may not have
 			 * been marked as empty.
 			 */
-			set_bit(lr, (unsigned long *)vgic_cpu->vgic_elrsr);
+			__set_bit(lr, (unsigned long *)vgic_cpu->vgic_elrsr);
 			vgic_cpu->vgic_lr[lr] &= ~GICH_LR_ACTIVE_BIT;
 		}
 	}
@@ -1069,7 +1069,7 @@ static void __kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
 			 vgic_cpu->nr_lr) {
 		int irq;
 
-		if (!test_and_clear_bit(lr, vgic_cpu->lr_used))
+		if (!__test_and_clear_bit(lr, vgic_cpu->lr_used))
 			continue;
 
 		irq = vgic_cpu->vgic_lr[lr] & GICH_LR_VIRTUALID;
@@ -1082,7 +1082,7 @@ static void __kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
 	pending = find_first_zero_bit((unsigned long *)vgic_cpu->vgic_elrsr,
 				      vgic_cpu->nr_lr);
 	if (level_pending || pending < vgic_cpu->nr_lr)
-		set_bit(vcpu->vcpu_id, &dist->irq_pending_on_cpu);
+		__set_bit(vcpu->vcpu_id, &dist->irq_pending_on_cpu);
 }
 
 void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu)
@@ -1200,7 +1200,7 @@ static bool vgic_update_irq_state(struct kvm *kvm, int cpuid,
 
 	if (level) {
 		vgic_cpu_irq_set(vcpu, irq_num);
-		set_bit(cpuid, &dist->irq_pending_on_cpu);
+		__set_bit(cpuid, &dist->irq_pending_on_cpu);
 	}
 
 out:
-- 
1.8.4.3
