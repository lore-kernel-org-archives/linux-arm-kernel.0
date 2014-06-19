From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 19 Jun 2014 10:21:28 +0100
Subject: [PATCH v2 4/9] arm/arm64: KVM: vgic: kill VGIC_MAX_CPUS
In-Reply-To: <1403169693-13982-1-git-send-email-marc.zyngier@arm.com>
References: <1403169693-13982-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1403169693-13982-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now have the information about the number of CPU interfaces in
the distributor itself. Let's get rid of VGIC_MAX_CPUS, and just
rely on KVM_MAX_VCPUS where we don't have the choice. Yet.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/arm.c     | 2 +-
 include/kvm/arm_vgic.h | 3 +--
 virt/kvm/arm/vgic.c    | 6 +++---
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 9548bc9..14ba035 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -811,7 +811,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	switch (ioctl) {
 	case KVM_CREATE_IRQCHIP: {
 		if (vgic_present)
-			return kvm_vgic_create(kvm, VGIC_MAX_CPUS, VGIC_NR_IRQS);
+			return kvm_vgic_create(kvm, KVM_MAX_VCPUS, VGIC_NR_IRQS);
 		else
 			return -ENXIO;
 	}
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index b5072b7..5853a67 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -29,13 +29,12 @@
 #define VGIC_NR_SGIS		16
 #define VGIC_NR_PPIS		16
 #define VGIC_NR_PRIVATE_IRQS	(VGIC_NR_SGIS + VGIC_NR_PPIS)
-#define VGIC_MAX_CPUS		KVM_MAX_VCPUS
 
 #define VGIC_V2_MAX_LRS		(1 << 6)
 #define VGIC_V3_MAX_LRS		16
 
 /* Sanity checks... */
-#if (VGIC_MAX_CPUS > 8)
+#if (KVM_MAX_VCPUS > 8)
 #error	Invalid number of CPU interfaces
 #endif
 
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 4b1f0a6..07b6450 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1184,7 +1184,7 @@ static bool vgic_queue_sgi(struct kvm_vcpu *vcpu, int irq)
 
 	sources = *vgic_get_sgi_sources(dist, vcpu_id, irq);
 
-	for_each_set_bit(c, &sources, VGIC_MAX_CPUS) {
+	for_each_set_bit(c, &sources, dist->nr_cpus) {
 		if (vgic_queue_irq(vcpu, c, irq))
 			clear_bit(c, &sources);
 	}
@@ -1564,7 +1564,7 @@ int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
 	if (ret)
 		return ret;
 
-	if (vcpu->vcpu_id >= VGIC_MAX_CPUS)
+	if (vcpu->vcpu_id >= dist->nr_cpus)
 		return -EBUSY;
 
 	for (i = 0; i < VGIC_NR_IRQS; i++) {
@@ -2193,7 +2193,7 @@ static void vgic_destroy(struct kvm_device *dev)
 
 static int vgic_create(struct kvm_device *dev, u32 type)
 {
-	return kvm_vgic_create(dev->kvm, VGIC_MAX_CPUS, VGIC_NR_IRQS);
+	return kvm_vgic_create(dev->kvm, KVM_MAX_VCPUS, VGIC_NR_IRQS);
 }
 
 struct kvm_device_ops kvm_arm_vgic_v2_ops = {
-- 
1.8.3.4
