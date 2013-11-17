From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 16 Nov 2013 20:30:17 -0800
Subject: [PATCH v3 6/9] KVM: arm-vgic: Add vgic reg access from dev attr
In-Reply-To: <1384662620-13795-1-git-send-email-christoffer.dall@linaro.org>
References: <1384662620-13795-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1384662620-13795-7-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add infrastructure to handle distributor and cpu interface register
accesses through the KVM_{GET/SET}_DEVICE_ATTR interface by adding the
KVM_DEV_ARM_VGIC_GRP_DIST_REGS and KVM_DEV_ARM_VGIC_GRP_CPU_REGS groups
and defining the semantics of the attr field to be the MMIO offset as
specified in the GICv2 specs.

Set the cpu field (physical CPU index) on the vcpu struct to -1 in
kvm_arch_vcpu_put so we have a method to check if the vcpu is running or
not without having to grab the VCPU mutexes.

Missing register accesses or other changes in individual register access
functions to support save/restore of the VGIC state is added in
subsequent patches.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Changelog[v3]:
 - Spelling and formatting nits
 - Fill in the phys_addr in kvm_exit_mmio
 - Put kvm_exit_mmio matching struct on stack
 - Change if-else-if to switch statement in vgic_attr_regs_access
 - Properly synchronize access to the VGIC with all VCPUs and the VM
   structure, ensuring no VCPUs are running while user space is
   accessing VGIC registers.

Changelog[v2]:
 - Added implementation specific format for the GICC_APRn registers.
---
 Documentation/virtual/kvm/devices/arm-vgic.txt |   52 ++++++++
 arch/arm/kvm/arm.c                             |    1 +
 virt/kvm/arm/vgic.c                            |  169 ++++++++++++++++++++++++
 3 files changed, 222 insertions(+)

diff --git a/Documentation/virtual/kvm/devices/arm-vgic.txt b/Documentation/virtual/kvm/devices/arm-vgic.txt
index c9febb2..7f4e91b 100644
--- a/Documentation/virtual/kvm/devices/arm-vgic.txt
+++ b/Documentation/virtual/kvm/devices/arm-vgic.txt
@@ -19,3 +19,55 @@ Groups:
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
+    -ENODEV: Getting or setting this register is not yet supported
+    -EBUSY: One or more VCPUs are running
+
+  KVM_DEV_ARM_VGIC_GRP_CPU_REGS
+  Attributes:
+    The attr field of kvm_device_attr encodes two values:
+    bits:     | 63   ....  40 | 39 ..  32  |  31   ....    0 |
+    values:   |    reserved   |   cpu id   |      offset     |
+
+    All CPU interface regs are (rw, 32-bit)
+
+    The offset specifies the offset from the "CPU interface base address" as
+    defined in the GICv2 specs.  Getting or setting such a register has the
+    same effect as reading or writing the register on the actual hardware.
+
+    The Active Priorities Registers APRn are implementation defined, so we set a
+    fixed format for our implementation that fits with the model of a "GICv2
+    implementation without the security extensions" which we present to the
+    guest.  This interface always exposes four register APR[0-3] describing the
+    maximum possible 128 preemption levels.  The semantics of the register
+    indicate if any interrupts in a given preemption level are in the active
+    state by setting the corresponding bit.
+
+    Thus, preemption level X has one or more active interrupts if and only if:
+
+      APRn[X mod 32] == 0b1,  where n = X / 32
+
+    Bits for undefined preemption levels are RAZ/WI.
+
+  Limitations:
+    - Priorities are not implemented, and registers are RAZ/WI
+  Errors:
+    -ENODEV: Getting or setting this register is not yet supported
+    -EBUSY: One or more VCPUs are running
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index a0bf0d8..35acac8 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -342,6 +342,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 {
+	vcpu->cpu = -1;
 	kvm_arm_set_running_vcpu(NULL);
 }
 
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 9b9fa20..ecf6dcf 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -589,6 +589,20 @@ static bool handle_mmio_sgi_reg(struct kvm_vcpu *vcpu,
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
@@ -663,6 +677,16 @@ static const struct mmio_range vgic_dist_ranges[] = {
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
 
@@ -1552,6 +1576,107 @@ int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write)
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
+static int vgic_attr_regs_access(struct kvm_device *dev,
+				 struct kvm_device_attr *attr,
+				 u32 *reg, bool is_write)
+{
+	const struct mmio_range *r = NULL, *ranges;
+	phys_addr_t offset;
+	int ret, cpuid, c;
+	struct kvm_vcpu *vcpu, *tmp_vcpu;
+	struct vgic_dist *vgic;
+	struct kvm_exit_mmio mmio;
+
+	offset = attr->attr & KVM_DEV_ARM_VGIC_OFFSET_MASK;
+	cpuid = (attr->attr & KVM_DEV_ARM_VGIC_CPUID_MASK) >>
+		KVM_DEV_ARM_VGIC_CPUID_SHIFT;
+
+	mutex_lock(&dev->kvm->lock);
+
+	if (cpuid >= atomic_read(&dev->kvm->online_vcpus)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	vcpu = kvm_get_vcpu(dev->kvm, cpuid);
+	vgic = &dev->kvm->arch.vgic;
+
+	mmio.len = 4;
+	mmio.is_write = is_write;
+	if (is_write)
+		mmio_data_write(&mmio, ~0, *reg);
+	switch (attr->group) {
+	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
+		mmio.phys_addr = vgic->vgic_dist_base + offset;
+		ranges = vgic_dist_ranges;
+		break;
+	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS:
+		mmio.phys_addr = vgic->vgic_cpu_base + offset;
+		ranges = vgic_cpu_ranges;
+		break;
+	default:
+		BUG();
+	}
+	r = find_matching_range(ranges, &mmio, offset);
+
+	if (unlikely(!r || !r->handle_mmio)) {
+		ret = -ENXIO;
+		goto out;
+	}
+
+
+	spin_lock(&vgic->lock);
+
+	kvm_for_each_vcpu(c, tmp_vcpu, dev->kvm) {
+		if (unlikely(tmp_vcpu->cpu != -1)) {
+			spin_unlock(&vgic->lock);
+			ret = -EBUSY;
+			goto out;
+		}
+	}
+
+	offset -= r->base;
+	r->handle_mmio(vcpu, &mmio, offset);
+	spin_unlock(&vgic->lock);
+
+	if (!is_write)
+		*reg = mmio_data_read(&mmio, ~0);
+
+	ret = 0;
+out:
+	mutex_unlock(&dev->kvm->lock);
+	return ret;
+}
+
 static int vgic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 {
 	int r;
@@ -1568,6 +1693,18 @@ static int vgic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
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
@@ -1589,12 +1726,38 @@ static int vgic_get_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 
 		if (copy_to_user(uaddr, &addr, sizeof(addr)))
 			return -EFAULT;
+		break;
+	}
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
 	}
+
 	}
 
 	return r;
 }
 
+static int vgic_has_attr_regs(const struct mmio_range *ranges,
+			      phys_addr_t offset)
+{
+	struct kvm_exit_mmio dev_attr_mmio;
+
+	dev_attr_mmio.len = 4;
+	if (find_matching_range(ranges, &dev_attr_mmio, offset))
+		return 0;
+	else
+		return -ENXIO;
+}
+
 static int vgic_has_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 {
 	phys_addr_t offset;
@@ -1607,6 +1770,12 @@ static int vgic_has_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
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
