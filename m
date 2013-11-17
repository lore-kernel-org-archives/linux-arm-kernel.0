From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 16 Nov 2013 20:30:18 -0800
Subject: [PATCH v3 7/9] KVM: arm-vgic: Support unqueueing of LRs to the dist
In-Reply-To: <1384662620-13795-1-git-send-email-christoffer.dall@linaro.org>
References: <1384662620-13795-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1384662620-13795-8-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To properly access the VGIC state from user space it is very unpractical
to have to loop through all the LRs in all register access functions.
Instead, support moving all pending state from LRs to the distributor,
but leave active state LRs alone.

Note that to accurately present the active and pending state to VCPUs
reading these distributor registers from a live VM, we would have to
stop all other VPUs than the calling VCPU and ask each CPU to unqueue
their LR state onto the distributor and add fields to track active state
on the distributor side as well.  We don't have any users of such
functionality yet and there are other inaccuracies of the GIC emulation,
so don't provide accurate synchronized access to this state just yet.
However, when the time comes, having this function should help.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Changelog[3]:
 - New patch in series
---
 virt/kvm/arm/vgic.c |   80 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 75 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index ecf6dcf..44c669b 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -589,6 +589,72 @@ static bool handle_mmio_sgi_reg(struct kvm_vcpu *vcpu,
 	return false;
 }
 
+#define LR_CPUID(lr)	\
+	(((lr) & GICH_LR_PHYSID_CPUID) >> GICH_LR_PHYSID_CPUID_SHIFT)
+#define LR_IRQID(lr)	\
+	((lr) & GICH_LR_VIRTUALID)
+
+static void vgic_retire_lr(int lr_nr, int irq, struct vgic_cpu *vgic_cpu)
+{
+	clear_bit(lr_nr, vgic_cpu->lr_used);
+	vgic_cpu->vgic_lr[lr_nr] &= ~GICH_LR_STATE;
+	vgic_cpu->vgic_irq_lr_map[irq] = LR_EMPTY;
+}
+
+/**
+ * vgic_unqueue_irqs - move pending IRQs from LRs to the distributor
+ * @vgic_cpu: Pointer to the vgic_cpu struct holding the LRs
+ *
+ * Move any pending IRQs that have already been assigned to LRs back to the
+ * emulated distributor state so that the complete emulated state can be read
+ * from the main emulation structures without investigating the LRs.
+ *
+ * Note that IRQs in the active state in the LRs get their pending state moved
+ * to the distributor but the active state stays in the LRs, because we don't
+ * track the active state on the distributor side.
+ */
+static void vgic_unqueue_irqs(struct kvm_vcpu *vcpu)
+{
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+	int vcpu_id = vcpu->vcpu_id;
+	int i, irq, source_cpu;
+	u32 *lr;
+
+	for_each_set_bit(i, vgic_cpu->lr_used, vgic_cpu->nr_lr) {
+		lr = &vgic_cpu->vgic_lr[i];
+		irq = LR_IRQID(*lr);
+		source_cpu = LR_CPUID(*lr);
+
+		/*
+		 * If the LR holds only an active interrupt (not pending) then
+		 * just leave it alone.
+		 */
+		if (!__test_and_clear_bit(__ffs(GICH_LR_PENDING_BIT),
+					  (unsigned long *)lr))
+			continue;
+
+		/*
+		 * If the interrupt was only pending (not "active" or "pending
+		 * and active") then we have effectively cleared the LR and it
+		 * should be marked as free for other use.
+		 */
+		if (!(*lr & GICH_LR_STATE))
+			vgic_retire_lr(i, irq, vgic_cpu);
+
+		/*
+		 * Finally, reestablish the pending state on the distributor
+		 * and the CPU interface.  It may have already been pending,
+		 * but that is fine, then we are only setting a few bits that
+		 * were already set.
+		 */
+		vgic_dist_irq_set(vcpu, irq);
+		if (irq < VGIC_NR_SGIS)
+			dist->irq_sgi_sources[vcpu_id][irq] |= 1 << source_cpu;
+		vgic_update_state(vcpu->kvm);
+	}
+}
+
 static bool handle_mmio_sgi_clear(struct kvm_vcpu *vcpu,
 				  struct kvm_exit_mmio *mmio,
 				  phys_addr_t offset)
@@ -848,8 +914,6 @@ static void vgic_update_state(struct kvm *kvm)
 	}
 }
 
-#define LR_CPUID(lr)	\
-	(((lr) & GICH_LR_PHYSID_CPUID) >> GICH_LR_PHYSID_CPUID_SHIFT)
 #define MK_LR_PEND(src, irq)	\
 	(GICH_LR_PENDING_BIT | ((src) << GICH_LR_PHYSID_CPUID_SHIFT) | (irq))
 
@@ -871,9 +935,7 @@ static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu)
 		int irq = vgic_cpu->vgic_lr[lr] & GICH_LR_VIRTUALID;
 
 		if (!vgic_irq_is_enabled(vcpu, irq)) {
-			vgic_cpu->vgic_irq_lr_map[irq] = LR_EMPTY;
-			clear_bit(lr, vgic_cpu->lr_used);
-			vgic_cpu->vgic_lr[lr] &= ~GICH_LR_STATE;
+			vgic_retire_lr(lr, irq, vgic_cpu);
 			if (vgic_irq_is_active(vcpu, irq))
 				vgic_irq_clear_active(vcpu, irq);
 		}
@@ -1664,6 +1726,14 @@ static int vgic_attr_regs_access(struct kvm_device *dev,
 		}
 	}
 
+	/*
+	 * Move all pending IRQs from the LRs on all VCPUs so the pending
+	 * state can be properly represented in the register state accessible
+	 * through this API.
+	 */
+	kvm_for_each_vcpu(c, tmp_vcpu, dev->kvm)
+		vgic_unqueue_irqs(tmp_vcpu);
+
 	offset -= r->base;
 	r->handle_mmio(vcpu, &mmio, offset);
 	spin_unlock(&vgic->lock);
-- 
1.7.10.4
