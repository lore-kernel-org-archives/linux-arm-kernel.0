From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Aug 2013 12:20:04 -0700
Subject: [PATCH 6/8] KVM: arm-vgic: Add vgic reg access from dev attr
In-Reply-To: <1377285606-15692-1-git-send-email-christoffer.dall@linaro.org>
References: <1377285606-15692-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1377285606-15692-7-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add infrastructure to handle distributor and cpu interface register
accesses through the KVM_{GET/SET}_DEVICE_ATTR interface by adding the
KVM_DEV_ARM_VGIC_GRP_DIST_REGS and KVM_DEV_ARM_VGIC_GRP_CPU_REGS groups
and defining the semantics of the attr field to be the MMIO offset as
specified in the GICv2 specs.

Missing register accesses or other changes in individual register access
functions to support save/restore of the VGIC state is added in
subsequent patches.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 Documentation/virtual/kvm/devices/arm-vgic.txt |   35 ++++++
 virt/kvm/arm/vgic.c                            |  143 ++++++++++++++++++++++++
 2 files changed, 178 insertions(+)

diff --git a/Documentation/virtual/kvm/devices/arm-vgic.txt b/Documentation/virtual/kvm/devices/arm-vgic.txt
index c9febb2..1b68475 100644
--- a/Documentation/virtual/kvm/devices/arm-vgic.txt
+++ b/Documentation/virtual/kvm/devices/arm-vgic.txt
@@ -19,3 +19,38 @@ Groups:
     KVM_VGIC_V2_ADDR_TYPE_CPU (rw, 64-bit)
       Base address in the guest physical address space of the GIC virtual cpu
       interface register mappings.
+
+  KVM_DEV_ARM_VGIC_GRP_DIST_REGS
+  Attributes:
+    The attr field of kvm_device_attr encodes two values:
+    bits:     | 63   ....  40 | 39 ..  32  |  31   ....    0 |
+    values:   |    reserved   |   cpu id   |      offset     |
+
+    All distributor regs are (rw, 32-bit)
+
+    The offset is relative to the "Distributor base address" as defined in the
+    GICv2 specs.  Getting or setting such a register has the same effect as
+    reading or writing the register on the actual hardware from the cpu
+    specified with cpu id field.  Note that most distributor fields are not
+    banked, but return the same value regardless of the cpu id used to access
+    the register.
+  Limitations:
+    - Priorities are not implemented, and registers are RAZ/WI
+  Errors:
+    - ENODEV: Getting or setting this register is not yet supported
+
+  KVM_DEV_ARM_VGIC_GRP_CPU_REGS
+  Attributes:
+    The attr field of kvm_device_attr encodes two values:
+    bits:     | 63   ....  40 | 39 ..  32  |  31   ....    0 |
+    values:   |    reserved   |   cpu id   |      offset     |
+
+    All CPU regs are (rw, 32-bit)
+
+    The offsetspecifies the offset from the "CPU interface base address" as
+    defined in the GICv2 specs.  Getting or setting such a register has the
+    same effect as reading or writing the register on the actual hardware.
+  Limitations:
+    - Priorities are not implemented, and registers are RAZ/WI
+  Errors:
+    - ENODEV: Getting or setting this register is not yet supported
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 629caeb..e31625c 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -591,11 +591,29 @@ static bool handle_mmio_sgi_reg(struct kvm_vcpu *vcpu,
 	return false;
 }
 
+static bool handle_mmio_sgi_clear(struct kvm_vcpu *vcpu,
+				  struct kvm_exit_mmio *mmio,
+				  phys_addr_t offset)
+{
+	return false;
+}
+
+static bool handle_mmio_sgi_set(struct kvm_vcpu *vcpu,
+				struct kvm_exit_mmio *mmio,
+				phys_addr_t offset)
+{
+	return false;
+}
+
 /*
  * I would have liked to use the kvm_bus_io_*() API instead, but it
  * cannot cope with banked registers (only the VM pointer is passed
  * around, and we need the vcpu). One of these days, someone please
  * fix it!
+ *
+ * Note that the handle_mmio implementations should not use the phys_addr
+ * field from the kvm_exit_mmio struct as this will not have any sane values
+ * when used to save/restore state from user space.
  */
 struct mmio_range {
 	phys_addr_t base;
@@ -665,6 +683,16 @@ static const struct mmio_range vgic_dist_ranges[] = {
 		.len		= 4,
 		.handle_mmio	= handle_mmio_sgi_reg,
 	},
+	{
+		.base		= GIC_DIST_SGI_CLEAR,
+		.len		= VGIC_NR_SGIS,
+		.handle_mmio	= handle_mmio_sgi_clear,
+	},
+	{
+		.base		= GIC_DIST_SGI_SET,
+		.len		= VGIC_NR_SGIS,
+		.handle_mmio	= handle_mmio_sgi_set,
+	},
 	{}
 };
 
@@ -1543,6 +1571,80 @@ int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write)
 	return r;
 }
 
+static bool handle_cpu_mmio_misc(struct kvm_vcpu *vcpu,
+				 struct kvm_exit_mmio *mmio, phys_addr_t offset)
+{
+	return true;
+}
+
+static const struct mmio_range vgic_cpu_ranges[] = {
+	{
+		.base		= GIC_CPU_CTRL,
+		.len		= 12,
+		.handle_mmio	= handle_cpu_mmio_misc,
+	},
+	{
+		.base		= GIC_CPU_ALIAS_BINPOINT,
+		.len		= 4,
+		.handle_mmio	= handle_cpu_mmio_misc,
+	},
+	{
+		.base		= GIC_CPU_ACTIVEPRIO,
+		.len		= 16,
+		.handle_mmio	= handle_cpu_mmio_misc,
+	},
+	{
+		.base		= GIC_CPU_IDENT,
+		.len		= 4,
+		.handle_mmio	= handle_cpu_mmio_misc,
+	},
+};
+
+static struct kvm_exit_mmio dev_attr_mmio = { .len = 4 };
+
+static int vgic_attr_regs_access(struct kvm_device *dev,
+				 struct kvm_device_attr *attr,
+				 u32 *reg, bool is_write)
+{
+	const struct mmio_range *r = NULL;
+	phys_addr_t offset;
+	int cpuid;
+	struct kvm_vcpu *vcpu;
+	struct kvm_exit_mmio mmio;
+
+	offset = attr->attr & KVM_DEV_ARM_VGIC_OFFSET_MASK;
+	cpuid = (attr->attr & KVM_DEV_ARM_VGIC_CPUID_MASK) >>
+		KVM_DEV_ARM_VGIC_CPUID_SHIFT;
+
+	if (cpuid >= atomic_read(&dev->kvm->online_vcpus))
+		return -EINVAL;
+
+	vcpu = kvm_get_vcpu(dev->kvm, cpuid);
+
+	mmio.len = 4;
+	mmio.is_write = is_write;
+	if (is_write)
+		memcpy(mmio.data, reg, sizeof(*reg));
+
+	if (attr->group == KVM_DEV_ARM_VGIC_GRP_DIST_REGS)
+		r = find_matching_range(vgic_dist_ranges, &mmio, offset);
+	else if (attr->group == KVM_DEV_ARM_VGIC_GRP_CPU_REGS)
+		r = find_matching_range(vgic_cpu_ranges, &mmio, offset);
+
+	if (unlikely(!r || !r->handle_mmio))
+		return -ENXIO;
+
+	spin_lock(&vcpu->kvm->arch.vgic.lock);
+	offset -= r->base;
+	r->handle_mmio(vcpu, &mmio, offset);
+	spin_unlock(&vcpu->kvm->arch.vgic.lock);
+
+	if (!is_write)
+		memcpy(reg, mmio.data, sizeof(*reg));
+
+	return 0;
+}
+
 static int vgic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 {
 	int r;
@@ -1559,6 +1661,18 @@ static int vgic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 		r = kvm_vgic_addr(dev->kvm, type, &addr, true);
 		return (r == -ENODEV) ? -ENXIO : r;
 	}
+
+	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
+	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS: {
+		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
+		u32 reg;
+
+		if (get_user(reg, uaddr))
+			return -EFAULT;
+
+		return vgic_attr_regs_access(dev, attr, &reg, true);
+	}
+
 	}
 
 	return -ENXIO;
@@ -1581,12 +1695,35 @@ static int vgic_get_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 		r = 0;
 		if (copy_to_user(uaddr, &addr, sizeof(addr)))
 			return -EFAULT;
+		break;
 	}
+
+	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
+	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS: {
+		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
+		u32 reg = 0;
+
+		r = vgic_attr_regs_access(dev, attr, &reg, false);
+		if (r)
+			return r;
+		r = put_user(reg, uaddr);
+		break;
+	}
+
 	}
 
 	return r;
 }
 
+static int vgic_has_attr_regs(const struct mmio_range *ranges,
+			      phys_addr_t offset)
+{
+	if (find_matching_range(ranges, &dev_attr_mmio, offset))
+		return 0;
+	else
+		return -ENXIO;
+}
+
 static int vgic_has_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 {
 	phys_addr_t offset;
@@ -1599,6 +1736,12 @@ static int vgic_has_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 			return 0;
 		}
 		break;
+	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
+		offset = attr->attr & KVM_DEV_ARM_VGIC_OFFSET_MASK;
+		return vgic_has_attr_regs(vgic_dist_ranges, offset);
+	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS:
+		offset = attr->attr & KVM_DEV_ARM_VGIC_OFFSET_MASK;
+		return vgic_has_attr_regs(vgic_cpu_ranges, offset);
 	}
 	return -ENXIO;
 }
-- 
1.7.10.4
