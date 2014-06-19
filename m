From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 19 Jun 2014 10:45:52 +0100
Subject: [PATCH 14/14] arm/arm64: KVM: allow userland to request a virtual
 GICv3
In-Reply-To: <1403171152-24067-1-git-send-email-andre.przywara@arm.com>
References: <1403171152-24067-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1403171152-24067-15-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With everything in place we allow userland to request the kernel
using a virtual GICv3 in the guest, which finally lifts the 8 vCPU
limit for a guest.
Also we provide the necessary support for guests setting the memory
addresses for the virtual distributor and redistributors.
This requires some userland code to make use of that feature and
explicitly ask for a virtual GICv3.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/include/uapi/asm/kvm.h |    7 ++++++
 include/kvm/arm_vgic.h            |    4 ++--
 virt/kvm/arm/vgic-v3-emul.c       |    3 +++
 virt/kvm/arm/vgic.c               |   46 ++++++++++++++++++++++++++-----------
 4 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 5513de4..9a62081 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -77,6 +77,13 @@ struct kvm_regs {
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
index 3b164ee..82e00a5 100644
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
index 68821fd..88c2cca 100644
--- a/virt/kvm/arm/vgic-v3-emul.c
+++ b/virt/kvm/arm/vgic-v3-emul.c
@@ -873,6 +873,9 @@ static int vgic_v3_has_attr(struct kvm_device *dev,
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
index 8a584e0..e3c7189 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1526,7 +1526,7 @@ static int vgic_ioaddr_assign(struct kvm *kvm, phys_addr_t *ioaddr,
 /**
  * kvm_vgic_addr - set or get vgic VM base addresses
  * @kvm:   pointer to the vm struct
- * @type:  the VGIC addr type, one of KVM_VGIC_V2_ADDR_TYPE_XXX
+ * @type:  the VGIC addr type, one of KVM_VGIC_V[23]_ADDR_TYPE_XXX
  * @addr:  pointer to address value
  * @write: if true set the address in the VM address space, if false read the
  *          address
@@ -1540,29 +1540,49 @@ int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write)
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
