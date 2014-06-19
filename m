From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 19 Jun 2014 10:21:30 +0100
Subject: [PATCH v2 6/9] arm/arm64: KVM: vgic: kill VGIC_NR_IRQS
In-Reply-To: <1403169693-13982-1-git-send-email-marc.zyngier@arm.com>
References: <1403169693-13982-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1403169693-13982-7-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nuke VGIC_NR_IRQS entierly, now that the distributor instance
contains the number of IRQ allocated to this GIC.

Also add VGIC_NR_IRQS_LEGACY to preserve the current API.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/arm.c     |  2 +-
 include/kvm/arm_vgic.h |  6 +++---
 virt/kvm/arm/vgic.c    | 13 +++++++------
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 14ba035..66c14ef 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -811,7 +811,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	switch (ioctl) {
 	case KVM_CREATE_IRQCHIP: {
 		if (vgic_present)
-			return kvm_vgic_create(kvm, KVM_MAX_VCPUS, VGIC_NR_IRQS);
+			return kvm_vgic_create(kvm, KVM_MAX_VCPUS, VGIC_NR_IRQS_LEGACY);
 		else
 			return -ENXIO;
 	}
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 3014145..cf17b68 100644
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
index 13ead5d..17ceb8a 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -373,7 +373,7 @@ static bool handle_mmio_misc(struct kvm_vcpu *vcpu,
 
 	case 4:			/* GICD_TYPER */
 		reg  = (atomic_read(&vcpu->kvm->online_vcpus) - 1) << 5;
-		reg |= (VGIC_NR_IRQS >> 5) - 1;
+		reg |= (vcpu->kvm->arch.vgic.nr_irqs >> 5) - 1;
 		vgic_reg_access(mmio, &reg, word_offset,
 				ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
 		break;
@@ -1164,13 +1164,14 @@ static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu)
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
 
@@ -1387,7 +1388,7 @@ static void __kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
 
 		vlr = vgic_get_lr(vcpu, lr);
 
-		BUG_ON(vlr.irq >= VGIC_NR_IRQS);
+		BUG_ON(vlr.irq >= dist->nr_irqs);
 		vgic_cpu->vgic_irq_lr_map[vlr.irq] = LR_EMPTY;
 	}
 
@@ -1601,7 +1602,7 @@ int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
 	if (vcpu->vcpu_id >= dist->nr_cpus)
 		return -EBUSY;
 
-	for (i = 0; i < VGIC_NR_IRQS; i++) {
+	for (i = 0; i < dist->nr_irqs; i++) {
 		if (i < VGIC_NR_PPIS)
 			vgic_bitmap_set_irq_val(&dist->irq_enabled,
 						vcpu->vcpu_id, i, 1);
@@ -1798,7 +1799,7 @@ int kvm_vgic_init(struct kvm *kvm)
 		goto out;
 	}
 
-	for (i = VGIC_NR_PRIVATE_IRQS; i < VGIC_NR_IRQS; i += 4)
+	for (i = VGIC_NR_PRIVATE_IRQS; i < kvm->arch.vgic.nr_irqs; i += 4)
 		vgic_set_target_reg(kvm, 0, i);
 
 	kvm->arch.vgic.ready = true;
@@ -2227,7 +2228,7 @@ static void vgic_destroy(struct kvm_device *dev)
 
 static int vgic_create(struct kvm_device *dev, u32 type)
 {
-	return kvm_vgic_create(dev->kvm, KVM_MAX_VCPUS, VGIC_NR_IRQS);
+	return kvm_vgic_create(dev->kvm, KVM_MAX_VCPUS, VGIC_NR_IRQS_LEGACY);
 }
 
 struct kvm_device_ops kvm_arm_vgic_v2_ops = {
-- 
1.8.3.4
