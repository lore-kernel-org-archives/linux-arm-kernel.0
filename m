From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 25 Mar 2016 02:04:57 +0000
Subject: [RFC PATCH 34/45] KVM: arm/arm64: vgic-new: vgic_kvm_device:
 implement kvm_vgic_addr
In-Reply-To: <1458871508-17279-1-git-send-email-andre.przywara@arm.com>
References: <1458871508-17279-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1458871508-17279-35-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Auger <eric.auger@linaro.org>

kvm_vgic_addr is used by the userspace to set the base address of
the following register regions, as seen by the guest:
- distributor(v2 and v3),
- re-distributors (v3),
- CPU interface (v2).

Signed-off-by: Eric Auger <eric.auger@linaro.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 include/kvm/vgic/vgic.h             |   2 +
 virt/kvm/arm/vgic/vgic.h            |   3 +
 virt/kvm/arm/vgic/vgic_kvm_device.c | 112 ++++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+)

diff --git a/include/kvm/vgic/vgic.h b/include/kvm/vgic/vgic.h
index ab5fcc7..43b4537 100644
--- a/include/kvm/vgic/vgic.h
+++ b/include/kvm/vgic/vgic.h
@@ -187,6 +187,8 @@ struct vgic_cpu {
 	struct list_head ap_list_head;
 };
 
+int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write);
+
 int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int intid,
 			bool level);
 
diff --git a/virt/kvm/arm/vgic/vgic.h b/virt/kvm/arm/vgic/vgic.h
index ff7ac9a..c8fd30c 100644
--- a/virt/kvm/arm/vgic/vgic.h
+++ b/virt/kvm/arm/vgic/vgic.h
@@ -19,6 +19,9 @@
 #define PRODUCT_ID_KVM		0x4b	/* ASCII code K */
 #define IMPLEMENTER_ARM		0x43b
 
+#define VGIC_ADDR_UNDEF		(-1)
+#define IS_VGIC_ADDR_UNDEF(_x)  ((_x) == VGIC_ADDR_UNDEF)
+
 #define INTERRUPT_ID_BITS_SPIS	10
 
 struct vgic_irq *vgic_get_irq(struct kvm *kvm, struct kvm_vcpu *vcpu,
diff --git a/virt/kvm/arm/vgic/vgic_kvm_device.c b/virt/kvm/arm/vgic/vgic_kvm_device.c
index dfe40a0..d9f2383 100644
--- a/virt/kvm/arm/vgic/vgic_kvm_device.c
+++ b/virt/kvm/arm/vgic/vgic_kvm_device.c
@@ -16,10 +16,122 @@
 #include <linux/kvm_host.h>
 #include <kvm/vgic/vgic.h>
 #include <linux/uaccess.h>
+#include <asm/kvm_mmu.h>
 #include "vgic.h"
 
 /* common helpers */
 
+static int vgic_ioaddr_overlap(struct kvm *kvm)
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
+	if (addr & ~KVM_PHYS_MASK)
+		return -E2BIG;
+
+	if (addr & (SZ_4K - 1))
+		return -EINVAL;
+
+	if (!IS_VGIC_ADDR_UNDEF(*ioaddr))
+		return -EEXIST;
+	if (addr + size < addr)
+		return -EINVAL;
+
+	*ioaddr = addr;
+	ret = vgic_ioaddr_overlap(kvm);
+	if (ret)
+		*ioaddr = VGIC_ADDR_UNDEF;
+
+	return ret;
+}
+
+/**
+ * kvm_vgic_addr - set or get vgic VM base addresses
+ * @kvm:   pointer to the vm struct
+ * @type:  the VGIC addr type, one of KVM_VGIC_V[23]_ADDR_TYPE_XXX
+ * @addr:  pointer to address value
+ * @write: if true set the address in the VM address space, if false read the
+ *          address
+ *
+ * Set or get the vgic base addresses for the distributor and the virtual CPU
+ * interface in the VM physical address space.  These addresses are properties
+ * of the emulated core/SoC and therefore user space initially knows this
+ * information.
+ */
+int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write)
+{
+	int r = 0;
+	struct vgic_dist *vgic = &kvm->arch.vgic;
+	int type_needed;
+	phys_addr_t *addr_ptr, block_size;
+	phys_addr_t alignment;
+
+	mutex_lock(&kvm->lock);
+	switch (type) {
+	case KVM_VGIC_V2_ADDR_TYPE_DIST:
+		type_needed = KVM_DEV_TYPE_ARM_VGIC_V2;
+		addr_ptr = &vgic->vgic_dist_base;
+		block_size = KVM_VGIC_V2_DIST_SIZE;
+		alignment = SZ_4K;
+		break;
+	case KVM_VGIC_V2_ADDR_TYPE_CPU:
+		type_needed = KVM_DEV_TYPE_ARM_VGIC_V2;
+		addr_ptr = &vgic->vgic_cpu_base;
+		block_size = KVM_VGIC_V2_CPU_SIZE;
+		alignment = SZ_4K;
+		break;
+#ifdef CONFIG_KVM_ARM_VGIC_V3
+	case KVM_VGIC_V3_ADDR_TYPE_DIST:
+		type_needed = KVM_DEV_TYPE_ARM_VGIC_V3;
+		addr_ptr = &vgic->vgic_dist_base;
+		block_size = KVM_VGIC_V3_DIST_SIZE;
+		alignment = SZ_64K;
+		break;
+	case KVM_VGIC_V3_ADDR_TYPE_REDIST:
+		type_needed = KVM_DEV_TYPE_ARM_VGIC_V3;
+		addr_ptr = &vgic->vgic_redist_base;
+		block_size = KVM_VGIC_V3_REDIST_SIZE;
+		alignment = SZ_64K;
+		break;
+#endif
+	default:
+		r = -ENODEV;
+		goto out;
+	}
+
+	if (vgic->vgic_model != type_needed) {
+		r = -ENODEV;
+		goto out;
+	}
+
+	if (write) {
+		if (!IS_ALIGNED(*addr, alignment))
+			r = -EINVAL;
+		else
+			r = vgic_ioaddr_assign(kvm, addr_ptr,
+					       *addr, block_size);
+	} else {
+		*addr = *addr_ptr;
+	}
+
+out:
+	mutex_unlock(&kvm->lock);
+	return r;
+}
+
 static int vgic_set_common_attr(struct kvm_device *dev,
 				struct kvm_device_attr *attr)
 {
-- 
2.7.3
