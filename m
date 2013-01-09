From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 09 Jan 2013 11:26:10 -0500
Subject: [PATCH v5.1 1/2] KVM: ARM: Introduce KVM_SET_DEVICE_ADDRESS ioctl
In-Reply-To: <20130109162554.12103.38937.stgit@ubuntu>
References: <20130109162554.12103.38937.stgit@ubuntu>
Message-ID: <20130109162610.12103.342.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM (and possibly other architectures) some bits are specific to the
model being emulated for the guest and user space needs a way to tell
the kernel about those bits.  An example is mmio device base addresses,
where KVM must know the base address for a given device to properly
emulate mmio accesses within a certain address range or directly map a
device with virtualiation extensions into the guest address space.

We try to make this API slightly more generic than for our specific use,
but so far only the VGIC uses this feature.

Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 Documentation/virtual/kvm/api.txt |   37 +++++++++++++++++++++++++++++++++++++
 arch/arm/include/uapi/asm/kvm.h   |   13 +++++++++++++
 arch/arm/kvm/arm.c                |   23 ++++++++++++++++++++++-
 include/uapi/linux/kvm.h          |    8 ++++++++
 4 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 38066a7a..c2ebd9e 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2206,6 +2206,43 @@ This ioctl returns the guest registers that are supported for the
 KVM_GET_ONE_REG/KVM_SET_ONE_REG calls.
 
 
+4.80 KVM_ARM_SET_DEVICE_ADDR
+
+Capability: KVM_CAP_ARM_SET_DEVICE_ADDR
+Architectures: arm
+Type: vm ioctl
+Parameters: struct kvm_arm_device_address (in)
+Returns: 0 on success, -1 on error
+Errors:
+  ENODEV: The device id is unknown
+  ENXIO:  Device not supported on current system
+  EEXIST: Address already set
+  E2BIG:  Address outside guest physical address space
+
+struct kvm_arm_device_addr {
+	__u64 id;
+	__u64 addr;
+};
+
+Specify a device address in the guest's physical address space where guests
+can access emulated or directly exposed devices, which the host kernel needs
+to know about. The id field is an architecture specific identifier for a
+specific device.
+
+ARM divides the id field into two parts, a device id and an address type id
+specific to the individual device.
+
+ ?bits:  | 63        ...       32 | 31    ...    16 | 15    ...    0 |
+  field: |        0x00000000      |     device id   |  addr type id  |
+
+ARM currently only require this when using the in-kernel GIC support for the
+hardware VGIC features, using KVM_ARM_DEVICE_VGIC_V2 as the device id.  When
+setting the base address for the guest's mapping of the VGIC virtual CPU
+and distributor interface, the ioctl must be called after calling
+KVM_CREATE_IRQCHIP, but before calling KVM_RUN on any of the VCPUs.  Calling
+this ioctl twice for any of the base addresses will return -EEXIST.
+
+
 5. The kvm_run structure
 ------------------------
 
diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
index 73b9615..09911a7 100644
--- a/arch/arm/include/uapi/asm/kvm.h
+++ b/arch/arm/include/uapi/asm/kvm.h
@@ -65,6 +65,19 @@ struct kvm_regs {
 #define KVM_ARM_TARGET_CORTEX_A15	0
 #define KVM_ARM_NUM_TARGETS		1
 
+/* KVM_SET_DEVICE_ADDRESS ioctl id encoding */
+#define KVM_DEVICE_TYPE_SHIFT		0
+#define KVM_DEVICE_TYPE_MASK		(0xffff << KVM_DEVICE_TYPE_SHIFT)
+#define KVM_DEVICE_ID_SHIFT		16
+#define KVM_DEVICE_ID_MASK		(0xffff << KVM_DEVICE_ID_SHIFT)
+
+/* Supported device IDs */
+#define KVM_ARM_DEVICE_VGIC_V2		0
+
+/* Supported VGIC address types  */
+#define KVM_VGIC_V2_ADDR_TYPE_DIST	0
+#define KVM_VGIC_V2_ADDR_TYPE_CPU	1
+
 struct kvm_vcpu_init {
 	__u32 target;
 	__u32 features[7];
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index f42d828..ce6e455 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -165,6 +165,8 @@ int kvm_dev_ioctl_check_extension(long ext)
 	case KVM_CAP_COALESCED_MMIO:
 		r = KVM_COALESCED_MMIO_PAGE_OFFSET;
 		break;
+	case KVM_CAP_ARM_SET_DEVICE_ADDR:
+		r = 1;
 	case KVM_CAP_NR_VCPUS:
 		r = num_online_cpus();
 		break;
@@ -805,10 +807,29 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 	return -EINVAL;
 }
 
+static int kvm_vm_ioctl_set_device_addr(struct kvm *kvm,
+					struct kvm_arm_device_addr *dev_addr)
+{
+	return -ENODEV;
+}
+
 long kvm_arch_vm_ioctl(struct file *filp,
 		       unsigned int ioctl, unsigned long arg)
 {
-	return -EINVAL;
+	struct kvm *kvm = filp->private_data;
+	void __user *argp = (void __user *)arg;
+
+	switch (ioctl) {
+	case KVM_ARM_SET_DEVICE_ADDR: {
+		struct kvm_arm_device_addr dev_addr;
+
+		if (copy_from_user(&dev_addr, argp, sizeof(dev_addr)))
+			return -EFAULT;
+		return kvm_vm_ioctl_set_device_addr(kvm, &dev_addr);
+	}
+	default:
+		return -EINVAL;
+	}
 }
 
 static void cpu_init_hyp_mode(void *vector)
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index dc63665..1f68151 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -636,6 +636,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_IRQFD_RESAMPLE 82
 #define KVM_CAP_PPC_BOOKE_WATCHDOG 83
 #define KVM_CAP_PPC_HTAB_FD 84
+#define KVM_CAP_ARM_SET_DEVICE_ADDR 85
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -783,6 +784,11 @@ struct kvm_msi {
 	__u8  pad[16];
 };
 
+struct kvm_arm_device_addr {
+	__u64 id;
+	__u64 addr;
+};
+
 /*
  * ioctls for VM fds
  */
@@ -868,6 +874,8 @@ struct kvm_s390_ucas_mapping {
 #define KVM_ALLOCATE_RMA	  _IOR(KVMIO,  0xa9, struct kvm_allocate_rma)
 /* Available with KVM_CAP_PPC_HTAB_FD */
 #define KVM_PPC_GET_HTAB_FD	  _IOW(KVMIO,  0xaa, struct kvm_get_htab_fd)
+/* Available with KVM_CAP_SET_DEVICE_ADDR */
+#define KVM_ARM_SET_DEVICE_ADDR	  _IOW(KVMIO,  0xab, struct kvm_arm_device_addr)
 
 /*
  * ioctls for vcpu fds
