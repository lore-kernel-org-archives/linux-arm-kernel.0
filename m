From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 14 Nov 2014 10:08:03 +0000
Subject: [PATCH v4 19/19] arm/arm64: KVM: allow userland to request a virtual
 GICv3
In-Reply-To: <1415959683-26027-1-git-send-email-andre.przywara@arm.com>
References: <1415959683-26027-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1415959683-26027-20-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With all of the GICv3 code in place now we allow userland to ask the
kernel for using a virtual GICv3 in the guest.
Also we provide the necessary support for guests setting the memory
addresses for the virtual distributor and redistributors.
This requires some userland code to make use of that feature and
explicitly ask for a virtual GICv3.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
Changelog v3...v4:
- refine commit message
- add documentation of new GICv3 KVM device

 Documentation/virtual/kvm/devices/arm-vgic.txt |   21 +++++++++--
 arch/arm64/include/uapi/asm/kvm.h              |    7 ++++
 include/kvm/arm_vgic.h                         |    4 +--
 virt/kvm/arm/vgic-v3-emul.c                    |    3 ++
 virt/kvm/arm/vgic.c                            |   46 +++++++++++++++++-------
 5 files changed, 64 insertions(+), 17 deletions(-)

diff --git a/Documentation/virtual/kvm/devices/arm-vgic.txt b/Documentation/virtual/kvm/devices/arm-vgic.txt
index df8b0c7..67e4c3e 100644
--- a/Documentation/virtual/kvm/devices/arm-vgic.txt
+++ b/Documentation/virtual/kvm/devices/arm-vgic.txt
@@ -3,22 +3,37 @@ ARM Virtual Generic Interrupt Controller (VGIC)
 
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
 
 Groups:
   KVM_DEV_ARM_VGIC_GRP_ADDR
   Attributes:
     KVM_VGIC_V2_ADDR_TYPE_DIST (rw, 64-bit)
       Base address in the guest physical address space of the GIC distributor
-      register mappings.
+      register mappings. Only valid if a guest GICv2 has been instantiated.
 
     KVM_VGIC_V2_ADDR_TYPE_CPU (rw, 64-bit)
       Base address in the guest physical address space of the GIC virtual cpu
-      interface register mappings.
+      interface register mappings. Only valid if a guest GICv2 has been
+      instantiated.
+
+    KVM_VGIC_V3_ADDR_TYPE_DIST (rw, 64-bit)
+      Base address in the guest physical address space of the GICv3 distributor
+      register mappings. Only valid if a guest GICv3 has been instantiated.
+
+    KVM_VGIC_V3_ADDR_TYPE_REDIST (rw, 64-bit)
+      Base address in the guest physical address space of the GICv3
+      redistributor register mappings. Only valid if a guest GICv3 has been
+      instantiated.
+
 
   KVM_DEV_ARM_VGIC_GRP_DIST_REGS
   Attributes:
@@ -36,6 +51,7 @@ Groups:
     the register.
   Limitations:
     - Priorities are not implemented, and registers are RAZ/WI
+    - Currently only implemented for GICv2.
   Errors:
     -ENODEV: Getting or setting this register is not yet supported
     -EBUSY: One or more VCPUs are running
@@ -68,6 +84,7 @@ Groups:
 
   Limitations:
     - Priorities are not implemented, and registers are RAZ/WI
+    - Currently only implemented for GICv2.
   Errors:
     -ENODEV: Getting or setting this register is not yet supported
     -EBUSY: One or more VCPUs are running
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 8e38878..2ed873a 100644
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
index 357a935..e452ef7 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -35,8 +35,8 @@
 #define VGIC_MAX_IRQS		1024
 
 /* Sanity checks... */
-#if (KVM_MAX_VCPUS > 8)
-#error	Invalid number of CPU interfaces
+#if (KVM_MAX_VCPUS > 255)
+#error Too many KVM VCPUs, the VGIC only supports up to 255 VCPUs for now
 #endif
 
 #if (VGIC_NR_IRQS_LEGACY & 31)
diff --git a/virt/kvm/arm/vgic-v3-emul.c b/virt/kvm/arm/vgic-v3-emul.c
index 58d7457..85e1bd6 100644
--- a/virt/kvm/arm/vgic-v3-emul.c
+++ b/virt/kvm/arm/vgic-v3-emul.c
@@ -996,6 +996,9 @@ static int vgic_v3_has_attr(struct kvm_device *dev,
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
index 1dbaeb5..1213da5 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1692,7 +1692,7 @@ static int vgic_ioaddr_assign(struct kvm *kvm, phys_addr_t *ioaddr,
 /**
  * kvm_vgic_addr - set or get vgic VM base addresses
  * @kvm:   pointer to the vm struct
- * @type:  the VGIC addr type, one of KVM_VGIC_V2_ADDR_TYPE_XXX
+ * @type:  the VGIC addr type, one of KVM_VGIC_V[23]_ADDR_TYPE_XXX
  * @addr:  pointer to address value
  * @write: if true set the address in the VM address space, if false read the
  *          address
@@ -1706,29 +1706,49 @@ int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write)
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
1.7.9.5
