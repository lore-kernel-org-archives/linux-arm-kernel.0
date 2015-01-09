From: andre.przywara@arm.com (Andre Przywara)
Date: Fri,  9 Jan 2015 11:54:20 +0000
Subject: [PATCH v6 02/20] arm/arm64: KVM: pass down user space provided GIC
 type into vGIC code
In-Reply-To: <1420804478-17354-1-git-send-email-andre.przywara@arm.com>
References: <1420804478-17354-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1420804478-17354-3-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the introduction of a second emulated GIC model we need to let
userspace specify the GIC model to use for each VM. Pass the
userspace provided value down into the vGIC code and store it there
to differentiate later.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
Changelog v5...v6:
 (add Acked-by)

Changelog v4...v5:
 (none)

Changelog v3...v4:
 (added Acked-by)

 arch/arm/kvm/arm.c     |    2 +-
 include/kvm/arm_vgic.h |    7 +++++--
 virt/kvm/arm/vgic.c    |    5 +++--
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index d0fadd6..dd1a689 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -821,7 +821,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
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
index c84f53df..6215e76 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1935,7 +1935,7 @@ out:
 	return ret;
 }
 
-int kvm_vgic_create(struct kvm *kvm)
+int kvm_vgic_create(struct kvm *kvm, u32 type)
 {
 	int i, vcpu_lock_idx = -1, ret;
 	struct kvm_vcpu *vcpu;
@@ -1967,6 +1967,7 @@ int kvm_vgic_create(struct kvm *kvm)
 
 	spin_lock_init(&kvm->arch.vgic.lock);
 	kvm->arch.vgic.in_kernel = true;
+	kvm->arch.vgic.vgic_model = type;
 	kvm->arch.vgic.vctrl_base = vgic->vctrl_base;
 	kvm->arch.vgic.vgic_dist_base = VGIC_ADDR_UNDEF;
 	kvm->arch.vgic.vgic_cpu_base = VGIC_ADDR_UNDEF;
@@ -2404,7 +2405,7 @@ static void vgic_destroy(struct kvm_device *dev)
 
 static int vgic_create(struct kvm_device *dev, u32 type)
 {
-	return kvm_vgic_create(dev->kvm);
+	return kvm_vgic_create(dev->kvm, type);
 }
 
 static struct kvm_device_ops kvm_arm_vgic_v2_ops = {
-- 
1.7.9.5
