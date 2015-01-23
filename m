From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Jan 2015 11:02:45 +0100
Subject: [GIT PULL 16/36] arm/arm64: KVM: pass down user space provided GIC
 type into vGIC code
In-Reply-To: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
References: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1422007385-14730-17-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>

With the introduction of a second emulated GIC model we need to let
userspace specify the GIC model to use for each VM. Pass the
userspace provided value down into the vGIC code and store it there
to differentiate later.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/arm.c     |  2 +-
 include/kvm/arm_vgic.h |  7 +++++--
 virt/kvm/arm/vgic.c    | 15 +++++++++++++--
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index a7b94ec..3a51ffca 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -851,7 +851,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	switch (ioctl) {
 	case KVM_CREATE_IRQCHIP: {
 		if (vgic_present)
-			return kvm_vgic_create(kvm);
+			return kvm_vgic_create(kvm, KVM_DEV_TYPE_ARM_VGIC_V2);
 		else
 			return -ENXIO;
 	}
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index ac4888d..525ce42 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -140,6 +140,9 @@ struct vgic_dist {
 	bool			in_kernel;
 	bool			ready;
 
+	/* vGIC model the kernel emulates for the guest (GICv2 or GICv3) */
+	u32			vgic_model;
+
 	int			nr_cpus;
 	int			nr_irqs;
 
@@ -275,7 +278,7 @@ struct kvm_exit_mmio;
 int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write);
 int kvm_vgic_hyp_init(void);
 int kvm_vgic_map_resources(struct kvm *kvm);
-int kvm_vgic_create(struct kvm *kvm);
+int kvm_vgic_create(struct kvm *kvm, u32 type);
 void kvm_vgic_destroy(struct kvm *kvm);
 void kvm_vgic_vcpu_destroy(struct kvm_vcpu *vcpu);
 void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu);
@@ -327,7 +330,7 @@ static inline int kvm_vgic_map_resources(struct kvm *kvm)
 	return 0;
 }
 
-static inline int kvm_vgic_create(struct kvm *kvm)
+static inline int kvm_vgic_create(struct kvm *kvm, u32 type)
 {
 	return 0;
 }
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index c84f53df..283038e 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1698,6 +1698,16 @@ int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
 	int vcpu_id;
 
 	if (unlikely(!vgic_initialized(kvm))) {
+		/*
+		 * We only provide the automatic initialization of the VGIC
+		 * for the legacy case of a GICv2. Any other type must
+		 * be explicitly initialized once setup with the respective
+		 * KVM device call.
+		 */
+		if (kvm->arch.vgic.vgic_model != KVM_DEV_TYPE_ARM_VGIC_V2) {
+			ret = -EBUSY;
+			goto out;
+		}
 		mutex_lock(&kvm->lock);
 		ret = vgic_init(kvm);
 		mutex_unlock(&kvm->lock);
@@ -1935,7 +1945,7 @@ out:
 	return ret;
 }
 
-int kvm_vgic_create(struct kvm *kvm)
+int kvm_vgic_create(struct kvm *kvm, u32 type)
 {
 	int i, vcpu_lock_idx = -1, ret;
 	struct kvm_vcpu *vcpu;
@@ -1967,6 +1977,7 @@ int kvm_vgic_create(struct kvm *kvm)
 
 	spin_lock_init(&kvm->arch.vgic.lock);
 	kvm->arch.vgic.in_kernel = true;
+	kvm->arch.vgic.vgic_model = type;
 	kvm->arch.vgic.vctrl_base = vgic->vctrl_base;
 	kvm->arch.vgic.vgic_dist_base = VGIC_ADDR_UNDEF;
 	kvm->arch.vgic.vgic_cpu_base = VGIC_ADDR_UNDEF;
@@ -2404,7 +2415,7 @@ static void vgic_destroy(struct kvm_device *dev)
 
 static int vgic_create(struct kvm_device *dev, u32 type)
 {
-	return kvm_vgic_create(dev->kvm);
+	return kvm_vgic_create(dev->kvm, type);
 }
 
 static struct kvm_device_ops kvm_arm_vgic_v2_ops = {
-- 
2.1.2.330.g565301e.dirty
