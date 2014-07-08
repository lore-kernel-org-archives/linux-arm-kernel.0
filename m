From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  8 Jul 2014 12:09:05 +0100
Subject: [PATCH v3 6/9] arm/arm64: KVM: vgic: kill VGIC_NR_IRQS
In-Reply-To: <1404817748-31302-1-git-send-email-marc.zyngier@arm.com>
References: <1404817748-31302-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1404817748-31302-7-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nuke VGIC_NR_IRQS entierly, now that the distributor instance
contains the number of IRQ allocated to this GIC.

Also add VGIC_NR_IRQS_LEGACY to preserve the current API.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/kvm/arm_vgic.h |  6 +++---
 virt/kvm/arm/vgic.c    | 17 +++++++++++------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 98ab604..9feb7fe 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -25,7 +25,7 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
-#define VGIC_NR_IRQS		256
+#define VGIC_NR_IRQS_LEGACY	256
 #define VGIC_NR_SGIS		16
 #define VGIC_NR_PPIS		16
 #define VGIC_NR_PRIVATE_IRQS	(VGIC_NR_SGIS + VGIC_NR_PPIS)
@@ -39,11 +39,11 @@
 #error	Invalid number of CPU interfaces
 #endif
 
-#if (VGIC_NR_IRQS & 31)
+#if (VGIC_NR_IRQS_LEGACY & 31)
 #error "VGIC_NR_IRQS must be a multiple of 32"
 #endif
 
-#if (VGIC_NR_IRQS > VGIC_MAX_IRQS)
+#if (VGIC_NR_IRQS_LEGACY > VGIC_MAX_IRQS)
 #error "VGIC_NR_IRQS must be <= 1024"
 #endif
 
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index b2ef7ff..47a14a1 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -395,7 +395,7 @@ static bool handle_mmio_misc(struct kvm_vcpu *vcpu,
 
 	case 4:			/* GICD_TYPER */
 		reg  = (atomic_read(&vcpu->kvm->online_vcpus) - 1) << 5;
-		reg |= (VGIC_NR_IRQS >> 5) - 1;
+		reg |= (vcpu->kvm->arch.vgic.nr_irqs >> 5) - 1;
 		vgic_reg_access(mmio, &reg, word_offset,
 				ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
 		break;
@@ -1186,13 +1186,14 @@ static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu)
 static bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
 	struct vgic_lr vlr;
 	int lr;
 
 	/* Sanitize the input... */
 	BUG_ON(sgi_source_id & ~7);
 	BUG_ON(sgi_source_id && irq >= VGIC_NR_SGIS);
-	BUG_ON(irq >= VGIC_NR_IRQS);
+	BUG_ON(irq >= dist->nr_irqs);
 
 	kvm_debug("Queue IRQ%d\n", irq);
 
@@ -1409,7 +1410,7 @@ static void __kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
 
 		vlr = vgic_get_lr(vcpu, lr);
 
-		BUG_ON(vlr.irq >= VGIC_NR_IRQS);
+		BUG_ON(vlr.irq >= dist->nr_irqs);
 		vgic_cpu->vgic_irq_lr_map[vlr.irq] = LR_EMPTY;
 	}
 
@@ -1620,7 +1621,7 @@ int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
 	if (vcpu->vcpu_id >= dist->nr_cpus)
 		return -EBUSY;
 
-	for (i = 0; i < VGIC_NR_IRQS; i++) {
+	for (i = 0; i < dist->nr_irqs; i++) {
 		if (i < VGIC_NR_PPIS)
 			vgic_bitmap_set_irq_val(&dist->irq_enabled,
 						vcpu->vcpu_id, i, 1);
@@ -1759,7 +1760,11 @@ static int vgic_init_maps(struct kvm *kvm)
 	int ret, i;
 
 	nr_cpus = dist->nr_cpus = KVM_MAX_VCPUS;
-	nr_irqs = dist->nr_irqs = VGIC_NR_IRQS;
+
+	if (!dist->nr_irqs)
+		dist->nr_irqs = VGIC_NR_IRQS_LEGACY;
+
+	nr_irqs = dist->nr_irqs;
 
 	ret  = vgic_init_bitmap(&dist->irq_enabled, nr_cpus, nr_irqs);
 	ret |= vgic_init_bitmap(&dist->irq_state, nr_cpus, nr_irqs);
@@ -1841,7 +1846,7 @@ int kvm_vgic_init(struct kvm *kvm)
 		goto out;
 	}
 
-	for (i = VGIC_NR_PRIVATE_IRQS; i < VGIC_NR_IRQS; i += 4)
+	for (i = VGIC_NR_PRIVATE_IRQS; i < kvm->arch.vgic.nr_irqs; i += 4)
 		vgic_set_target_reg(kvm, 0, i);
 
 	kvm->arch.vgic.ready = true;
-- 
2.0.0
