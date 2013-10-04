From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  4 Oct 2013 13:16:18 +0100
Subject: [RFC PATCH 5/5] arm/arm64: KVM: vgic: kill VGIC_NR_IRQS
In-Reply-To: <1380888978-27725-1-git-send-email-marc.zyngier@arm.com>
References: <1380888978-27725-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1380888978-27725-6-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nuke VGIC_NR_IRQS entierly, now that the distributor instance
contains the number of IRQ allocated to this GIC.

Also add VGIC_NR_IRQS_LEGACY to preserve the current API.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/arm.c     |  2 +-
 include/kvm/arm_vgic.h |  6 +++---
 virt/kvm/arm/vgic.c    | 11 ++++++-----
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 2f465fe..2255719 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -789,7 +789,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	switch (ioctl) {
 	case KVM_CREATE_IRQCHIP: {
 		if (vgic_present)
-			return kvm_vgic_create(kvm, KVM_MAX_VCPUS, VGIC_NR_IRQS);
+			return kvm_vgic_create(kvm, KVM_MAX_VCPUS, VGIC_NR_IRQS_LEGACY);
 		else
 			return -ENXIO;
 	}
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index a57757d..03f497d 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -26,7 +26,7 @@
 #include <linux/types.h>
 #include <linux/irqchip/arm-gic.h>
 
-#define VGIC_NR_IRQS		256
+#define VGIC_NR_IRQS_LEGACY	256
 #define VGIC_NR_SGIS		16
 #define VGIC_NR_PPIS		16
 #define VGIC_NR_PRIVATE_IRQS	(VGIC_NR_SGIS + VGIC_NR_PPIS)
@@ -38,11 +38,11 @@
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
index c9d706b..357fd23 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -363,7 +363,7 @@ static bool handle_mmio_misc(struct kvm_vcpu *vcpu,
 
 	case 4:			/* TYPER */
 		reg  = (atomic_read(&vcpu->kvm->online_vcpus) - 1) << 5;
-		reg |= (VGIC_NR_IRQS >> 5) - 1;
+		reg |= (vcpu->kvm->arch.vgic.nr_irqs >> 5) - 1;
 		vgic_reg_access(mmio, &reg, word_offset,
 				ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
 		break;
@@ -941,12 +941,13 @@ static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu)
 static bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
 	int lr;
 
 	/* Sanitize the input... */
 	BUG_ON(sgi_source_id & ~7);
 	BUG_ON(sgi_source_id && irq >= VGIC_NR_SGIS);
-	BUG_ON(irq >= VGIC_NR_IRQS);
+	BUG_ON(irq >= dist->nr_irqs);
 
 	kvm_debug("Queue IRQ%d\n", irq);
 
@@ -1153,7 +1154,7 @@ static void __kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
 
 		irq = vgic_cpu->vgic_lr[lr] & GICH_LR_VIRTUALID;
 
-		BUG_ON(irq >= VGIC_NR_IRQS);
+		BUG_ON(irq >= dist->nr_irqs);
 		vgic_cpu->vgic_irq_lr_map[irq] = LR_EMPTY;
 	}
 
@@ -1363,7 +1364,7 @@ int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
 	if (vcpu->vcpu_id >= dist->nr_cpus)
 		return -EBUSY;
 
-	for (i = 0; i < VGIC_NR_IRQS; i++) {
+	for (i = 0; i < dist->nr_irqs; i++) {
 		if (i < VGIC_NR_PPIS)
 			vgic_bitmap_set_irq_val(&dist->irq_enabled,
 						vcpu->vcpu_id, i, 1);
@@ -1576,7 +1577,7 @@ int kvm_vgic_init(struct kvm *kvm)
 		goto out;
 	}
 
-	for (i = VGIC_NR_PRIVATE_IRQS; i < VGIC_NR_IRQS; i += 4)
+	for (i = VGIC_NR_PRIVATE_IRQS; i < kvm->arch.vgic.nr_irqs; i += 4)
 		vgic_set_target_reg(kvm, 0, i);
 
 	kvm_timer_init(kvm);
-- 
1.8.2.3
