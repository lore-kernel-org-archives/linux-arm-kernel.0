From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu,  4 Dec 2014 15:02:24 +0000
Subject: [PATCH] vgic: move reset initialization into vgic_init_maps()
Message-ID: <1417705344-747-1-git-send-email-peter.maydell@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VGIC initialization currently happens in three phases:
 (1) kvm_vgic_create() (triggered by userspace GIC creation)
 (2) vgic_init_maps() (triggered by userspace GIC register read/write
     requests, or from kvm_vgic_init() if not already run)
 (3) kvm_vgic_init() (triggered by first VM run)

We were doing initialization of some state to correspond with the
state of a freshly-reset GIC in kvm_vgic_init(); this is too late,
since it will overwrite changes made by userspace using the
register access APIs before the VM is run. Move this initialization
earlier, into the vgic_init_maps() phase.

This fixes a bug where QEMU could successfully restore a saved
VM state snapshot into a VM that had already been run, but could
not restore it "from cold" using the -loadvm command line option
(the symptoms being that the restored VM would run but interrupts
were ignored).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
You could make a good argument for renaming vgic_init_maps() and
kvm_vgic_init() (eg vgic_init() and vgic_first_run() ?)...

 virt/kvm/arm/vgic.c | 49 ++++++++++++++++---------------------------------
 1 file changed, 16 insertions(+), 33 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 3aaca49..d2bc745 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1726,39 +1726,14 @@ static int vgic_vcpu_init_maps(struct kvm_vcpu *vcpu, int nr_irqs)
 
 	int sz = (nr_irqs - VGIC_NR_PRIVATE_IRQS) / 8;
 	vgic_cpu->pending_shared = kzalloc(sz, GFP_KERNEL);
-	vgic_cpu->vgic_irq_lr_map = kzalloc(nr_irqs, GFP_KERNEL);
+	vgic_cpu->vgic_irq_lr_map = kmalloc(nr_irqs, GFP_KERNEL);
 
 	if (!vgic_cpu->pending_shared || !vgic_cpu->vgic_irq_lr_map) {
 		kvm_vgic_vcpu_destroy(vcpu);
 		return -ENOMEM;
 	}
 
-	return 0;
-}
-
-/**
- * kvm_vgic_vcpu_init - Initialize per-vcpu VGIC state
- * @vcpu: pointer to the vcpu struct
- *
- * Initialize the vgic_cpu struct and vgic_dist struct fields pertaining to
- * this vcpu and enable the VGIC for this VCPU
- */
-static void kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
-{
-	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
-	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
-	int i;
-
-	for (i = 0; i < dist->nr_irqs; i++) {
-		if (i < VGIC_NR_PPIS)
-			vgic_bitmap_set_irq_val(&dist->irq_enabled,
-						vcpu->vcpu_id, i, 1);
-		if (i < VGIC_NR_PRIVATE_IRQS)
-			vgic_bitmap_set_irq_val(&dist->irq_cfg,
-						vcpu->vcpu_id, i, VGIC_CFG_EDGE);
-
-		vgic_cpu->vgic_irq_lr_map[i] = LR_EMPTY;
-	}
+	memset(vgic_cpu->vgic_irq_lr_map, LR_EMPTY, nr_irqs);
 
 	/*
 	 * Store the number of LRs per vcpu, so we don't have to go
@@ -1767,7 +1742,7 @@ static void kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
 	 */
 	vgic_cpu->nr_lr = vgic->nr_lr;
 
-	vgic_enable(vcpu);
+	return 0;
 }
 
 void kvm_vgic_destroy(struct kvm *kvm)
@@ -1865,11 +1840,23 @@ static int vgic_init_maps(struct kvm *kvm)
 			kvm_err("VGIC: Failed to allocate vcpu memory\n");
 			break;
 		}
+		for (i = 0; i < dist->nr_irqs; i++) {
+			if (i < VGIC_NR_PPIS)
+				vgic_bitmap_set_irq_val(&dist->irq_enabled,
+							vcpu->vcpu_id, i, 1);
+			if (i < VGIC_NR_PRIVATE_IRQS)
+				vgic_bitmap_set_irq_val(&dist->irq_cfg,
+							vcpu->vcpu_id, i,
+							VGIC_CFG_EDGE);
+		}
 	}
 
 	for (i = VGIC_NR_PRIVATE_IRQS; i < dist->nr_irqs; i += 4)
 		vgic_set_target_reg(kvm, 0, i);
 
+	kvm_for_each_vcpu(i, vcpu, kvm)
+		vgic_enable(vcpu);
+
 out:
 	if (ret)
 		kvm_vgic_destroy(kvm);
@@ -1888,8 +1875,7 @@ out:
  */
 int kvm_vgic_init(struct kvm *kvm)
 {
-	struct kvm_vcpu *vcpu;
-	int ret = 0, i;
+	int ret = 0;
 
 	if (!irqchip_in_kernel(kvm))
 		return 0;
@@ -1920,9 +1906,6 @@ int kvm_vgic_init(struct kvm *kvm)
 		goto out;
 	}
 
-	kvm_for_each_vcpu(i, vcpu, kvm)
-		kvm_vgic_vcpu_init(vcpu);
-
 	kvm->arch.vgic.ready = true;
 out:
 	if (ret)
-- 
2.1.1
