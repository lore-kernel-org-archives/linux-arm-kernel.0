From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 19 Jun 2014 10:45:40 +0100
Subject: [PATCH 02/14] arm/arm64: KVM: pass down user space provided GIC type
 into vGIC code
In-Reply-To: <1403171152-24067-1-git-send-email-andre.przywara@arm.com>
References: <1403171152-24067-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1403171152-24067-3-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the introduction of a second emulated GIC model we need to let
userspace specify the GIC model to use for each VM. Pass the
userspace provided value down into the vGIC code to differentiate
later.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/kvm/arm.c     |    2 +-
 include/kvm/arm_vgic.h |    4 ++--
 virt/kvm/arm/vgic.c    |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 9ffe962..fa37fa1 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -804,7 +804,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	switch (ioctl) {
 	case KVM_CREATE_IRQCHIP: {
 		if (vgic_present)
-			return kvm_vgic_create(kvm);
+			return kvm_vgic_create(kvm, KVM_DEV_TYPE_ARM_VGIC_V2);
 		else
 			return -ENXIO;
 	}
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index f5788cf..4feac9a 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -231,7 +231,7 @@ struct kvm_exit_mmio;
 int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write);
 int kvm_vgic_hyp_init(void);
 int kvm_vgic_init(struct kvm *kvm);
-int kvm_vgic_create(struct kvm *kvm);
+int kvm_vgic_create(struct kvm *kvm, u32 type);
 void kvm_vgic_destroy(struct kvm *kvm);
 void kvm_vgic_vcpu_destroy(struct kvm_vcpu *vcpu);
 void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu);
@@ -282,7 +282,7 @@ static inline int kvm_vgic_init(struct kvm *kvm)
 	return 0;
 }
 
-static inline int kvm_vgic_create(struct kvm *kvm)
+static inline int kvm_vgic_create(struct kvm *kvm, u32 type)
 {
 	return 0;
 }
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 68ac9c6..8f1daf2 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1832,7 +1832,7 @@ out:
 	return ret;
 }
 
-int kvm_vgic_create(struct kvm *kvm)
+int kvm_vgic_create(struct kvm *kvm, u32 type)
 {
 	int i, vcpu_lock_idx = -1, ret = 0;
 	struct kvm_vcpu *vcpu;
@@ -2284,7 +2284,7 @@ static void vgic_destroy(struct kvm_device *dev)
 
 static int vgic_create(struct kvm_device *dev, u32 type)
 {
-	return kvm_vgic_create(dev->kvm);
+	return kvm_vgic_create(dev->kvm, type);
 }
 
 struct kvm_device_ops kvm_arm_vgic_v2_ops = {
-- 
1.7.9.5
