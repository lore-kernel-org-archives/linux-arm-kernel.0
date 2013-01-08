From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Tue, 08 Jan 2013 13:41:57 -0500
Subject: [PATCH v5 05/12] ARM: KVM: VGIC accept vcpu and dist base addresses
 from user space
In-Reply-To: <20130108184116.46558.3558.stgit@ubuntu>
References: <20130108184116.46558.3558.stgit@ubuntu>
Message-ID: <20130108184157.46558.95327.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

User space defines the model to emulate to a guest and should therefore
decide which addresses are used for both the virtual CPU interface
directly mapped in the guest physical address space and for the emulated
distributor interface, which is mapped in software by the in-kernel VGIC
support.

Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 Documentation/virtual/kvm/api.txt |    1 +
 arch/arm/include/asm/kvm_vgic.h   |    9 +++++
 arch/arm/include/uapi/asm/kvm.h   |    3 ++
 arch/arm/kvm/arm.c                |   14 ++++++++
 arch/arm/kvm/vgic.c               |   62 +++++++++++++++++++++++++++++++++++++
 5 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 668956f..34d3ee9 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2218,6 +2218,7 @@ Errors:
   ENXIO:  Device not supported on current system
   EEXIST: Address already set
   E2BIG:  Address outside guest physical address space
+  EBUSY:  Address overlaps with other device range
 
 struct kvm_device_address {
 	__u64 id;
diff --git a/arch/arm/include/asm/kvm_vgic.h b/arch/arm/include/asm/kvm_vgic.h
index fcfd530..270dcd2 100644
--- a/arch/arm/include/asm/kvm_vgic.h
+++ b/arch/arm/include/asm/kvm_vgic.h
@@ -22,6 +22,9 @@
 #include <asm/hardware/gic.h>
 
 struct vgic_dist {
+	/* Distributor and vcpu interface mapping in the guest */
+	phys_addr_t		vgic_dist_base;
+	phys_addr_t		vgic_cpu_base;
 };
 
 struct vgic_cpu {
@@ -33,6 +36,7 @@ struct kvm_run;
 struct kvm_exit_mmio;
 
 #ifdef CONFIG_KVM_ARM_VGIC
+int kvm_vgic_set_addr(struct kvm *kvm, unsigned long type, u64 addr);
 bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		      struct kvm_exit_mmio *mmio);
 
@@ -42,6 +46,11 @@ static inline int kvm_vgic_hyp_init(void)
 	return 0;
 }
 
+static inline int kvm_vgic_set_addr(struct kvm *kvm, unsigned long type, u64 addr)
+{
+	return 0;
+}
+
 static inline int kvm_vgic_init(struct kvm *kvm)
 {
 	return 0;
diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
index 09911a7..94e893b 100644
--- a/arch/arm/include/uapi/asm/kvm.h
+++ b/arch/arm/include/uapi/asm/kvm.h
@@ -78,6 +78,9 @@ struct kvm_regs {
 #define KVM_VGIC_V2_ADDR_TYPE_DIST	0
 #define KVM_VGIC_V2_ADDR_TYPE_CPU	1
 
+#define KVM_VGIC_V2_DIST_SIZE		0x1000
+#define KVM_VGIC_V2_CPU_SIZE		0x2000
+
 struct kvm_vcpu_init {
 	__u32 target;
 	__u32 features[7];
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 85c4cdf..4c2b057 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -858,7 +858,19 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 static int kvm_vm_ioctl_set_device_address(struct kvm *kvm,
 					   struct kvm_device_address *dev_addr)
 {
-	return -ENODEV;
+	unsigned long dev_id, type;
+
+	dev_id = (dev_addr->id & KVM_DEVICE_ID_MASK) >> KVM_DEVICE_ID_SHIFT;
+	type = (dev_addr->id & KVM_DEVICE_TYPE_MASK) >> KVM_DEVICE_TYPE_SHIFT;
+
+	switch (dev_id) {
+	case KVM_ARM_DEVICE_VGIC_V2:
+		if (!vgic_present)
+			return -ENXIO;
+		return kvm_vgic_set_addr(kvm, type, dev_addr->addr);
+	default:
+		return -ENODEV;
+	}
 }
 
 long kvm_arch_vm_ioctl(struct file *filp,
diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
index 1feee5a..cdb7671 100644
--- a/arch/arm/kvm/vgic.c
+++ b/arch/arm/kvm/vgic.c
@@ -22,6 +22,9 @@
 #include <linux/io.h>
 #include <asm/kvm_emulate.h>
 
+#define VGIC_ADDR_UNDEF		(-1)
+#define IS_VGIC_ADDR_UNDEF(_x)  ((_x) == VGIC_ADDR_UNDEF)
+
 #define ACCESS_READ_VALUE	(1 << 0)
 #define ACCESS_READ_RAZ		(0 << 0)
 #define ACCESS_READ_MASK(x)	((x) & (1 << 0))
@@ -142,3 +145,62 @@ bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
 {
 	return KVM_EXIT_MMIO;
 }
+
+static bool vgic_ioaddr_overlap(struct kvm *kvm)
+{
+	phys_addr_t dist = kvm->arch.vgic.vgic_dist_base;
+	phys_addr_t cpu = kvm->arch.vgic.vgic_cpu_base;
+
+	if (IS_VGIC_ADDR_UNDEF(dist) || IS_VGIC_ADDR_UNDEF(cpu))
+		return 0;
+	if ((dist <= cpu && dist + KVM_VGIC_V2_DIST_SIZE > cpu) ||
+	    (cpu <= dist && cpu + KVM_VGIC_V2_CPU_SIZE > dist))
+		return -EBUSY;
+	return 0;
+}
+
+static int vgic_ioaddr_assign(struct kvm *kvm, phys_addr_t *ioaddr,
+			      phys_addr_t addr, phys_addr_t size)
+{
+	int ret;
+
+	if (!IS_VGIC_ADDR_UNDEF(*ioaddr))
+		return -EEXIST;
+	if (addr + size < addr)
+		return -EINVAL;
+
+	ret = vgic_ioaddr_overlap(kvm);
+	if (ret)
+		return ret;
+	*ioaddr = addr;
+	return ret;
+}
+
+int kvm_vgic_set_addr(struct kvm *kvm, unsigned long type, u64 addr)
+{
+	int r = 0;
+	struct vgic_dist *vgic = &kvm->arch.vgic;
+
+	if (addr & ~KVM_PHYS_MASK)
+		return -E2BIG;
+
+	if (addr & ~PAGE_MASK)
+		return -EINVAL;
+
+	mutex_lock(&kvm->lock);
+	switch (type) {
+	case KVM_VGIC_V2_ADDR_TYPE_DIST:
+		r = vgic_ioaddr_assign(kvm, &vgic->vgic_dist_base,
+				       addr, KVM_VGIC_V2_DIST_SIZE);
+		break;
+	case KVM_VGIC_V2_ADDR_TYPE_CPU:
+		r = vgic_ioaddr_assign(kvm, &vgic->vgic_cpu_base,
+				       addr, KVM_VGIC_V2_CPU_SIZE);
+		break;
+	default:
+		r = -ENODEV;
+	}
+
+	mutex_unlock(&kvm->lock);
+	return r;
+}
