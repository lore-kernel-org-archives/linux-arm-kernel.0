From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 16 Nov 2013 20:30:13 -0800
Subject: [PATCH v3 2/9] KVM: arm-vgic: Support KVM_CREATE_DEVICE for VGIC
In-Reply-To: <1384662620-13795-1-git-send-email-christoffer.dall@linaro.org>
References: <1384662620-13795-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1384662620-13795-3-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support creating the ARM VGIC device through the KVM_CREATE_DEVICE
ioctl, which can then later be leveraged to use the
KVM_{GET/SET}_DEVICE_ATTR, which is useful both for setting addresses in
a more generic API than the ARM-specific one and is useful for
save/restore of VGIC state.

Adds KVM_CAP_DEVICE_CTRL to ARM capabilities.

Note that we change the check for creating a VGIC from bailing out if
any VCPUs were created, to bailing out if any VCPUs were ever run.  This
is an important distinction that shouldn't break anything, but allows
creating the VGIC after the VCPUs have been created.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Changelog[v3]:
 - Prevent race in kvm_vgic_create by trying to take all the vcpu
   locks before creating the vgic.

Changelog[v2]:
 - None
---
 Documentation/virtual/kvm/devices/arm-vgic.txt |   10 ++++
 arch/arm/kvm/arm.c                             |    1 +
 include/linux/kvm_host.h                       |    1 +
 include/uapi/linux/kvm.h                       |    1 +
 virt/kvm/arm/vgic.c                            |   58 +++++++++++++++++++++++-
 virt/kvm/kvm_main.c                            |    6 ++-
 6 files changed, 74 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/virtual/kvm/devices/arm-vgic.txt

diff --git a/Documentation/virtual/kvm/devices/arm-vgic.txt b/Documentation/virtual/kvm/devices/arm-vgic.txt
new file mode 100644
index 0000000..38f27f7
--- /dev/null
+++ b/Documentation/virtual/kvm/devices/arm-vgic.txt
@@ -0,0 +1,10 @@
+ARM Virtual Generic Interrupt Controller (VGIC)
+===============================================
+
+Device types supported:
+  KVM_DEV_TYPE_ARM_VGIC_V2     ARM Generic Interrupt Controller v2.0
+
+Only one VGIC instance may be instantiated through either this API or the
+legacy KVM_CREATE_IRQCHIP api.  The created VGIC will act as the VM interrupt
+controller, requiring emulated user-space devices to inject interrupts to the
+VGIC instead of directly to CPUs.
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index e80b6a1..984908d 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -190,6 +190,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 	case KVM_CAP_IRQCHIP:
 		r = vgic_present;
 		break;
+	case KVM_CAP_DEVICE_CTRL:
 	case KVM_CAP_USER_MEMORY:
 	case KVM_CAP_SYNC_MMU:
 	case KVM_CAP_DESTROY_MEMORY_REGION_WORKS:
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9523d2a..e68d9db 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1076,6 +1076,7 @@ struct kvm_device *kvm_device_from_filp(struct file *filp);
 extern struct kvm_device_ops kvm_mpic_ops;
 extern struct kvm_device_ops kvm_xics_ops;
 extern struct kvm_device_ops kvm_vfio_ops;
+extern struct kvm_device_ops kvm_arm_vgic_ops;
 
 #ifdef CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 902f124..b647c29 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -853,6 +853,7 @@ struct kvm_device_attr {
 #define  KVM_DEV_VFIO_GROUP			1
 #define   KVM_DEV_VFIO_GROUP_ADD			1
 #define   KVM_DEV_VFIO_GROUP_DEL			2
+#define KVM_DEV_TYPE_ARM_VGIC_V2	5
 
 /*
  * ioctls for VM fds
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 5e9df47..e3fbb5e 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1433,20 +1433,40 @@ out:
 
 int kvm_vgic_create(struct kvm *kvm)
 {
-	int ret = 0;
+	int i, vcpu_lock_idx = -1, ret = 0;
+	struct kvm_vcpu *vcpu;
 
 	mutex_lock(&kvm->lock);
 
-	if (atomic_read(&kvm->online_vcpus) || kvm->arch.vgic.vctrl_base) {
+	if (kvm->arch.vgic.vctrl_base) {
 		ret = -EEXIST;
 		goto out;
 	}
 
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		if (!mutex_trylock(&vcpu->mutex))
+			goto out_unlock;
+		vcpu_lock_idx = i;
+	}
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		if (vcpu->arch.has_run_once) {
+			ret = -EBUSY;
+			goto out_unlock;
+		}
+	}
+
 	spin_lock_init(&kvm->arch.vgic.lock);
 	kvm->arch.vgic.vctrl_base = vgic_vctrl_base;
 	kvm->arch.vgic.vgic_dist_base = VGIC_ADDR_UNDEF;
 	kvm->arch.vgic.vgic_cpu_base = VGIC_ADDR_UNDEF;
 
+out_unlock:
+	for (; vcpu_lock_idx >= 0; vcpu_lock_idx--) {
+		vcpu = kvm_get_vcpu(kvm, vcpu_lock_idx);
+		mutex_unlock(&vcpu->mutex);
+	}
+
 out:
 	mutex_unlock(&kvm->lock);
 	return ret;
@@ -1510,3 +1530,37 @@ int kvm_vgic_set_addr(struct kvm *kvm, unsigned long type, u64 addr)
 	mutex_unlock(&kvm->lock);
 	return r;
 }
+
+static int vgic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
+{
+	return -ENXIO;
+}
+
+static int vgic_get_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
+{
+	return -ENXIO;
+}
+
+static int vgic_has_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
+{
+	return -ENXIO;
+}
+
+static void vgic_destroy(struct kvm_device *dev)
+{
+	kfree(dev);
+}
+
+static int vgic_create(struct kvm_device *dev, u32 type)
+{
+	return kvm_vgic_create(dev->kvm);
+}
+
+struct kvm_device_ops kvm_arm_vgic_ops = {
+	.name = "kvm-arm-vgic",
+	.create = vgic_create,
+	.destroy = vgic_destroy,
+	.set_attr = vgic_set_attr,
+	.get_attr = vgic_get_attr,
+	.has_attr = vgic_has_attr,
+};
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 10015d6..fb8bb21 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2278,7 +2278,11 @@ static int kvm_ioctl_create_device(struct kvm *kvm,
 #ifdef CONFIG_KVM_VFIO
 	case KVM_DEV_TYPE_VFIO:
 		ops = &kvm_vfio_ops;
-		break;
+#endif
+#ifdef CONFIG_KVM_ARM_VGIC
+	case KVM_DEV_TYPE_ARM_VGIC_V2:
+		ops = &kvm_arm_vgic_ops;
+	break;
 #endif
 	default:
 		return -ENODEV;
-- 
1.7.10.4
