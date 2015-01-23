From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Jan 2015 11:03:02 +0100
Subject: [GIT PULL 33/36] arm/arm64: KVM: allow userland to request a virtual
 GICv3
In-Reply-To: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
References: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1422007385-14730-34-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>

With all of the GICv3 code in place now we allow userland to ask the
kernel for using a virtual GICv3 in the guest.
Also we provide the necessary support for guests setting the memory
addresses for the virtual distributor and redistributors.
This requires some userland code to make use of that feature and
explicitly ask for a virtual GICv3.
Document that KVM_CREATE_IRQCHIP only works for GICv2, but is
considered legacy and using KVM_CREATE_DEVICE is preferred.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 Documentation/virtual/kvm/api.txt              | 13 +++++---
 Documentation/virtual/kvm/devices/arm-vgic.txt | 22 ++++++++++--
 arch/arm64/include/uapi/asm/kvm.h              |  7 ++++
 include/kvm/arm_vgic.h                         |  4 +--
 virt/kvm/arm/vgic-v3-emul.c                    |  3 ++
 virt/kvm/arm/vgic.c                            | 46 ++++++++++++++++++--------
 6 files changed, 73 insertions(+), 22 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 0007fef..f4b19d7 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -612,11 +612,14 @@ Type: vm ioctl
 Parameters: none
 Returns: 0 on success, -1 on error
 
-Creates an interrupt controller model in the kernel.  On x86, creates a virtual
-ioapic, a virtual PIC (two PICs, nested), and sets up future vcpus to have a
-local APIC.  IRQ routing for GSIs 0-15 is set to both PIC and IOAPIC; GSI 16-23
-only go to the IOAPIC.  On ARM/arm64, a GIC is
-created. On s390, a dummy irq routing table is created.
+Creates an interrupt controller model in the kernel.
+On x86, creates a virtual ioapic, a virtual PIC (two PICs, nested), and sets up
+future vcpus to have a local APIC.  IRQ routing for GSIs 0-15 is set to both
+PIC and IOAPIC; GSI 16-23 only go to the IOAPIC.
+On ARM/arm64, a GICv2 is created. Any other GIC versions require the usage of
+KVM_CREATE_DEVICE, which also supports creating a GICv2.  Using
+KVM_CREATE_DEVICE is preferred over KVM_CREATE_IRQCHIP for GICv2.
+On s390, a dummy irq routing table is created.
 
 Note that on s390 the KVM_CAP_S390_IRQCHIP vm capability needs to be enabled
 before KVM_CREATE_IRQCHIP can be used.
diff --git a/Documentation/virtual/kvm/devices/arm-vgic.txt b/Documentation/virtual/kvm/devices/arm-vgic.txt
index 30f5427..5d4fd4b 100644
--- a/Documentation/virtual/kvm/devices/arm-vgic.txt
+++ b/Documentation/virtual/kvm/devices/arm-vgic.txt
@@ -3,22 +3,38 @@ ARM Virtual Generic Interrupt Controller (VGIC)
 
 Device types supported:
   KVM_DEV_TYPE_ARM_VGIC_V2     ARM Generic Interrupt Controller v2.0
+  KVM_DEV_TYPE_ARM_VGIC_V3     ARM Generic Interrupt Controller v3.0
 
 Only one VGIC instance may be instantiated through either this API or the
 legacy KVM_CREATE_IRQCHIP api.  The created VGIC will act as the VM interrupt
 controller, requiring emulated user-space devices to inject interrupts to the
 VGIC instead of directly to CPUs.
 
+Creating a guest GICv3 device requires a host GICv3 as well.
+GICv3 implementations with hardware compatibility support allow a guest GICv2
+as well.
+
 Groups:
   KVM_DEV_ARM_VGIC_GRP_ADDR
   Attributes:
     KVM_VGIC_V2_ADDR_TYPE_DIST (rw, 64-bit)
       Base address in the guest physical address space of the GIC distributor
-      register mappings.
+      register mappings. Only valid for KVM_DEV_TYPE_ARM_VGIC_V2.
 
     KVM_VGIC_V2_ADDR_TYPE_CPU (rw, 64-bit)
       Base address in the guest physical address space of the GIC virtual cpu
-      interface register mappings.
+      interface register mappings. Only valid for KVM_DEV_TYPE_ARM_VGIC_V2.
+
+    KVM_VGIC_V3_ADDR_TYPE_DIST (rw, 64-bit)
+      Base address in the guest physical address space of the GICv3 distributor
+      register mappings. Only valid for KVM_DEV_TYPE_ARM_VGIC_V3.
+
+    KVM_VGIC_V3_ADDR_TYPE_REDIST (rw, 64-bit)
+      Base address in the guest physical address space of the GICv3
+      redistributor register mappings. There are two 64K pages for each
+      VCPU and all of the redistributor pages are contiguous.
+      Only valid for KVM_DEV_TYPE_ARM_VGIC_V3.
+
 
   KVM_DEV_ARM_VGIC_GRP_DIST_REGS
   Attributes:
@@ -36,6 +52,7 @@ Groups:
     the register.
   Limitations:
     - Priorities are not implemented, and registers are RAZ/WI
+    - Currently only implemented for KVM_DEV_TYPE_ARM_VGIC_V2.
   Errors:
     -ENODEV: Getting or setting this register is not yet supported
     -EBUSY: One or more VCPUs are running
@@ -68,6 +85,7 @@ Groups:
 
   Limitations:
     - Priorities are not implemented, and registers are RAZ/WI
+    - Currently only implemented for KVM_DEV_TYPE_ARM_VGIC_V2.
   Errors:
     -ENODEV: Getting or setting this register is not yet supported
     -EBUSY: One or more VCPUs are running
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 480af34..3ef77a4 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -78,6 +78,13 @@ struct kvm_regs {
 #define KVM_VGIC_V2_DIST_SIZE		0x1000
 #define KVM_VGIC_V2_CPU_SIZE		0x2000
 
+/* Supported VGICv3 address types  */
+#define KVM_VGIC_V3_ADDR_TYPE_DIST	2
+#define KVM_VGIC_V3_ADDR_TYPE_REDIST	3
+
+#define KVM_VGIC_V3_DIST_SIZE		SZ_64K
+#define KVM_VGIC_V3_REDIST_SIZE		(2 * SZ_64K)
+
 #define KVM_ARM_VCPU_POWER_OFF		0 /* CPU is started in OFF state */
 #define KVM_ARM_VCPU_EL1_32BIT		1 /* CPU running a 32bit VM */
 #define KVM_ARM_VCPU_PSCI_0_2		2 /* CPU uses PSCI v0.2 */
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 39039d5..7c55dd5 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -36,8 +36,8 @@
 #define VGIC_V2_MAX_CPUS	8
 
 /* Sanity checks... */
-#if (KVM_MAX_VCPUS > 8)
-#error	Invalid number of CPU interfaces
+#if (KVM_MAX_VCPUS > 255)
+#error Too many KVM VCPUs, the VGIC only supports up to 255 VCPUs for now
 #endif
 
 #if (VGIC_NR_IRQS_LEGACY & 31)
diff --git a/virt/kvm/arm/vgic-v3-emul.c b/virt/kvm/arm/vgic-v3-emul.c
index 2d2199d..b3f1546 100644
--- a/virt/kvm/arm/vgic-v3-emul.c
+++ b/virt/kvm/arm/vgic-v3-emul.c
@@ -1007,6 +1007,9 @@ static int vgic_v3_has_attr(struct kvm_device *dev,
 		case KVM_VGIC_V2_ADDR_TYPE_DIST:
 		case KVM_VGIC_V2_ADDR_TYPE_CPU:
 			return -ENXIO;
+		case KVM_VGIC_V3_ADDR_TYPE_DIST:
+		case KVM_VGIC_V3_ADDR_TYPE_REDIST:
+			return 0;
 		}
 		break;
 	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 2efba82..184c6db 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1667,7 +1667,7 @@ static int vgic_ioaddr_assign(struct kvm *kvm, phys_addr_t *ioaddr,
 /**
  * kvm_vgic_addr - set or get vgic VM base addresses
  * @kvm:   pointer to the vm struct
- * @type:  the VGIC addr type, one of KVM_VGIC_V2_ADDR_TYPE_XXX
+ * @type:  the VGIC addr type, one of KVM_VGIC_V[23]_ADDR_TYPE_XXX
  * @addr:  pointer to address value
  * @write: if true set the address in the VM address space, if false read the
  *          address
@@ -1681,29 +1681,49 @@ int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write)
 {
 	int r = 0;
 	struct vgic_dist *vgic = &kvm->arch.vgic;
+	int type_needed;
+	phys_addr_t *addr_ptr, block_size;
 
 	mutex_lock(&kvm->lock);
 	switch (type) {
 	case KVM_VGIC_V2_ADDR_TYPE_DIST:
-		if (write) {
-			r = vgic_ioaddr_assign(kvm, &vgic->vgic_dist_base,
-					       *addr, KVM_VGIC_V2_DIST_SIZE);
-		} else {
-			*addr = vgic->vgic_dist_base;
-		}
+		type_needed = KVM_DEV_TYPE_ARM_VGIC_V2;
+		addr_ptr = &vgic->vgic_dist_base;
+		block_size = KVM_VGIC_V2_DIST_SIZE;
 		break;
 	case KVM_VGIC_V2_ADDR_TYPE_CPU:
-		if (write) {
-			r = vgic_ioaddr_assign(kvm, &vgic->vgic_cpu_base,
-					       *addr, KVM_VGIC_V2_CPU_SIZE);
-		} else {
-			*addr = vgic->vgic_cpu_base;
-		}
+		type_needed = KVM_DEV_TYPE_ARM_VGIC_V2;
+		addr_ptr = &vgic->vgic_cpu_base;
+		block_size = KVM_VGIC_V2_CPU_SIZE;
 		break;
+#ifdef CONFIG_ARM_GIC_V3
+	case KVM_VGIC_V3_ADDR_TYPE_DIST:
+		type_needed = KVM_DEV_TYPE_ARM_VGIC_V3;
+		addr_ptr = &vgic->vgic_dist_base;
+		block_size = KVM_VGIC_V3_DIST_SIZE;
+		break;
+	case KVM_VGIC_V3_ADDR_TYPE_REDIST:
+		type_needed = KVM_DEV_TYPE_ARM_VGIC_V3;
+		addr_ptr = &vgic->vgic_redist_base;
+		block_size = KVM_VGIC_V3_REDIST_SIZE;
+		break;
+#endif
 	default:
 		r = -ENODEV;
+		goto out;
+	}
+
+	if (vgic->vgic_model != type_needed) {
+		r = -ENODEV;
+		goto out;
 	}
 
+	if (write)
+		r = vgic_ioaddr_assign(kvm, addr_ptr, *addr, block_size);
+	else
+		*addr = *addr_ptr;
+
+out:
 	mutex_unlock(&kvm->lock);
 	return r;
 }
-- 
2.1.2.330.g565301e.dirty
