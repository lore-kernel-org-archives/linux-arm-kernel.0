From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 27 Oct 2013 17:19:54 +0000
Subject: [PATCH RESEND v2 6/8] KVM: arm-vgic: Add vgic reg access from
 dev attr
In-Reply-To: <40baa441edd0d109e145b2f08612a2fe@www.loen.fr>
References: <1382432923-61267-1-git-send-email-christoffer.dall@linaro.org>
 <1382432923-61267-7-git-send-email-christoffer.dall@linaro.org>
 <40baa441edd0d109e145b2f08612a2fe@www.loen.fr>
Message-ID: <20131027171954.GC21180@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 04:46:56PM +0100, Marc Zyngier wrote:
> On 2013-10-22 10:08, Christoffer Dall wrote:
> >Add infrastructure to handle distributor and cpu interface register
> >accesses through the KVM_{GET/SET}_DEVICE_ATTR interface by adding
> >the
> >KVM_DEV_ARM_VGIC_GRP_DIST_REGS and KVM_DEV_ARM_VGIC_GRP_CPU_REGS
> >groups
> >and defining the semantics of the attr field to be the MMIO offset as
> >specified in the GICv2 specs.
> >
> >Missing register accesses or other changes in individual register
> >access
> >functions to support save/restore of the VGIC state is added in
> >subsequent patches.
> >
> >Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> >Reviewed-by: Alexander Graf <agraf@suse.de>
> >
> >---
> >Changelog[v2]:
> > - Added implementation specific format for the GICC_APRn registers.
> >---
> > Documentation/virtual/kvm/devices/arm-vgic.txt |   50 +++++++++
> > virt/kvm/arm/vgic.c                            |  143
> >++++++++++++++++++++++++
> > 2 files changed, 193 insertions(+)
> >
> >diff --git a/Documentation/virtual/kvm/devices/arm-vgic.txt
> >b/Documentation/virtual/kvm/devices/arm-vgic.txt
> >index c9febb2..e6416f8e 100644
> >--- a/Documentation/virtual/kvm/devices/arm-vgic.txt
> >+++ b/Documentation/virtual/kvm/devices/arm-vgic.txt
> >@@ -19,3 +19,53 @@ Groups:
> >     KVM_VGIC_V2_ADDR_TYPE_CPU (rw, 64-bit)
> >       Base address in the guest physical address space of the GIC
> >virtual cpu
> >       interface register mappings.
> >+
> >+  KVM_DEV_ARM_VGIC_GRP_DIST_REGS
> >+  Attributes:
> >+    The attr field of kvm_device_attr encodes two values:
> >+    bits:     | 63   ....  40 | 39 ..  32  |  31   ....    0 |
> >+    values:   |    reserved   |   cpu id   |      offset     |
> >+
> >+    All distributor regs are (rw, 32-bit)
> >+
> >+    The offset is relative to the "Distributor base address" as
> >defined in the
> >+    GICv2 specs.  Getting or setting such a register has the same
> >effect as
> >+    reading or writing the register on the actual hardware from
> >the cpu
> >+    specified with cpu id field.  Note that most distributor
> >fields are not
> >+    banked, but return the same value regardless of the cpu id used
> >to access
> >+    the register.
> >+  Limitations:
> >+    - Priorities are not implemented, and registers are RAZ/WI
> >+  Errors:
> >+    - ENODEV: Getting or setting this register is not yet supported
> 
> -ENODEV?
> 

indeed

> >+  KVM_DEV_ARM_VGIC_GRP_CPU_REGS
> >+  Attributes:
> >+    The attr field of kvm_device_attr encodes two values:
> >+    bits:     | 63   ....  40 | 39 ..  32  |  31   ....    0 |
> >+    values:   |    reserved   |   cpu id   |      offset     |
> >+
> >+    All CPU regs are (rw, 32-bit)
> 
> Nit: CPU interface registers
> 
> >+    The offset specifies the offset from the "CPU interface base
> >address" as
> >+    defined in the GICv2 specs.  Getting or setting such a
> >register has the
> >+    same effect as reading or writing the register on the actual
> >hardware.
> >+
> >+    The Active Priorities Registers APRn are implementation defined,
> >so we set a
> >+    fixed format for our implementation that fits with the model
> >of a "GICv2
> >+    impementation without the security extensions" which we
> >present to the
> 
> implementation
> 
> >+    guest.  This interface always exposes four register APR[0-3]
> >describing the
> >+    maximum possible 128 preemption levels.  The semantics of the
> >register
> >+    indicate if any interrupts in a given preemption level are in
> >the active
> >+    state by setting the corresponding bit.
> >+
> >+    Thus, preemption level X has one or more active interrupts if
> >and only if:
> >+
> >+      APRn[X mod 32] == 0b1,  where n = X / 32
> >+
> >+    Bits for undefined preemption levels are RAZ/WI.
> >+
> >+  Limitations:
> >+    - Priorities are not implemented, and registers are RAZ/WI
> >+  Errors:
> >+    - ENODEV: Getting or setting this register is not yet supported
> >diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> >index 1148a2e..f2dc72a 100644
> >--- a/virt/kvm/arm/vgic.c
> >+++ b/virt/kvm/arm/vgic.c
> >@@ -589,11 +589,29 @@ static bool handle_mmio_sgi_reg(struct
> >kvm_vcpu *vcpu,
> > 	return false;
> > }
> >
> >+static bool handle_mmio_sgi_clear(struct kvm_vcpu *vcpu,
> >+				  struct kvm_exit_mmio *mmio,
> >+				  phys_addr_t offset)
> >+{
> >+	return false;
> >+}
> >+
> >+static bool handle_mmio_sgi_set(struct kvm_vcpu *vcpu,
> >+				struct kvm_exit_mmio *mmio,
> >+				phys_addr_t offset)
> >+{
> >+	return false;
> >+}
> >+
> > /*
> >  * I would have liked to use the kvm_bus_io_*() API instead, but it
> >  * cannot cope with banked registers (only the VM pointer is passed
> >  * around, and we need the vcpu). One of these days, someone please
> >  * fix it!
> >+ *
> >+ * Note that the handle_mmio implementations should not use the
> >phys_addr
> >+ * field from the kvm_exit_mmio struct as this will not have any
> >sane values
> >+ * when used to save/restore state from user space.
> 
> This is quite ugly... I don't think we'd ever use that field
> directly, but reusing a well known structure for that purpose is
> very messy. I believe we'd be better off creating our own structure
> instead of re-purposing am existing one.

Hmmm, I don't think this is about re-purposing an existing structure, it
is about generally using a structure in a file which happens to contain
a superflous field, which should never have to be used in this file anyway.
Now we will actually use this structure where this unnecessary field (in
this context) does not contain a sane value and we clearly document that
in the comment.  Further, introducing another type adds another memcpy
or makes the whole io_mem_abort() - vgic_handle_mmio() messy.  I
actually had a go at it that I can pass your way if you are set on this
approach...

> 
> The other possibility would be to properly fill-in the phys_addr
> field. How difficult would that be?
> 

Not really difficult at all, let me do that for a v3.

> >  */
> > struct mmio_range {
> > 	phys_addr_t base;
> >@@ -663,6 +681,16 @@ static const struct mmio_range
> >vgic_dist_ranges[] = {
> > 		.len		= 4,
> > 		.handle_mmio	= handle_mmio_sgi_reg,
> > 	},
> >+	{
> >+		.base		= GIC_DIST_SGI_CLEAR,
> >+		.len		= VGIC_NR_SGIS,
> >+		.handle_mmio	= handle_mmio_sgi_clear,
> >+	},
> >+	{
> >+		.base		= GIC_DIST_SGI_SET,
> >+		.len		= VGIC_NR_SGIS,
> >+		.handle_mmio	= handle_mmio_sgi_set,
> >+	},
> > 	{}
> > };
> >
> >@@ -1541,6 +1569,80 @@ int kvm_vgic_addr(struct kvm *kvm, unsigned
> >long type, u64 *addr, bool write)
> > 	return r;
> > }
> >
> >+static bool handle_cpu_mmio_misc(struct kvm_vcpu *vcpu,
> >+				 struct kvm_exit_mmio *mmio, phys_addr_t offset)
> >+{
> >+	return true;
> >+}
> >+
> >+static const struct mmio_range vgic_cpu_ranges[] = {
> >+	{
> >+		.base		= GIC_CPU_CTRL,
> >+		.len		= 12,
> >+		.handle_mmio	= handle_cpu_mmio_misc,
> >+	},
> >+	{
> >+		.base		= GIC_CPU_ALIAS_BINPOINT,
> >+		.len		= 4,
> >+		.handle_mmio	= handle_cpu_mmio_misc,
> >+	},
> >+	{
> >+		.base		= GIC_CPU_ACTIVEPRIO,
> >+		.len		= 16,
> >+		.handle_mmio	= handle_cpu_mmio_misc,
> >+	},
> >+	{
> >+		.base		= GIC_CPU_IDENT,
> >+		.len		= 4,
> >+		.handle_mmio	= handle_cpu_mmio_misc,
> >+	},
> >+};
> >+
> >+static struct kvm_exit_mmio dev_attr_mmio = { .len = 4 };
> 
> I'm not very fond of a half-initialized structure here. How about
> moving this "4" to the location where it is used?
> Actually, what if we have several users of this through
> vgic_has_attr_regs at the same time? It feels incredibly racy. I
> suggest you nuke it and move it to live on the stack in
> vgic_has_attr_regs.
> 

fair enough, since this is just another way of passing the constant four
to a match function and that constant is only ever read, I don't think
there's any race here, but ok, it's completely fine to just allocate it on
the stack.

> >+static int vgic_attr_regs_access(struct kvm_device *dev,
> >+				 struct kvm_device_attr *attr,
> >+				 u32 *reg, bool is_write)
> >+{
> >+	const struct mmio_range *r = NULL;
> >+	phys_addr_t offset;
> >+	int cpuid;
> >+	struct kvm_vcpu *vcpu;
> >+	struct kvm_exit_mmio mmio;
> >+
> >+	offset = attr->attr & KVM_DEV_ARM_VGIC_OFFSET_MASK;
> >+	cpuid = (attr->attr & KVM_DEV_ARM_VGIC_CPUID_MASK) >>
> >+		KVM_DEV_ARM_VGIC_CPUID_SHIFT;
> >+
> >+	if (cpuid >= atomic_read(&dev->kvm->online_vcpus))
> >+		return -EINVAL;
> >+
> >+	vcpu = kvm_get_vcpu(dev->kvm, cpuid);
> >+
> >+	mmio.len = 4;
> >+	mmio.is_write = is_write;
> >+	if (is_write)
> >+		mmio_data_write(&mmio, ~0, *reg);
> >+
> >+	if (attr->group == KVM_DEV_ARM_VGIC_GRP_DIST_REGS)
> >+		r = find_matching_range(vgic_dist_ranges, &mmio, offset);
> >+	else if (attr->group == KVM_DEV_ARM_VGIC_GRP_CPU_REGS)
> >+		r = find_matching_range(vgic_cpu_ranges, &mmio, offset);
> 
> How about having a switch statement instead?
> 

sure.

> >+	if (unlikely(!r || !r->handle_mmio))
> >+		return -ENXIO;
> >+
> >+	spin_lock(&vcpu->kvm->arch.vgic.lock);
> >+	offset -= r->base;
> >+	r->handle_mmio(vcpu, &mmio, offset);
> >+	spin_unlock(&vcpu->kvm->arch.vgic.lock);
> >+
> >+	if (!is_write)
> >+		*reg = mmio_data_read(&mmio, ~0);
> >+
> >+	return 0;
> >+}
> >+
> > static int vgic_set_attr(struct kvm_device *dev, struct
> >kvm_device_attr *attr)
> > {
> > 	int r;
> >@@ -1557,6 +1659,18 @@ static int vgic_set_attr(struct kvm_device
> >*dev, struct kvm_device_attr *attr)
> > 		r = kvm_vgic_addr(dev->kvm, type, &addr, true);
> > 		return (r == -ENODEV) ? -ENXIO : r;
> > 	}
> >+
> >+	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
> >+	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS: {
> >+		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
> >+		u32 reg;
> >+
> >+		if (get_user(reg, uaddr))
> >+			return -EFAULT;
> >+
> >+		return vgic_attr_regs_access(dev, attr, &reg, true);
> >+	}
> >+
> > 	}
> >
> > 	return -ENXIO;
> >@@ -1579,12 +1693,35 @@ static int vgic_get_attr(struct kvm_device
> >*dev, struct kvm_device_attr *attr)
> > 		r = 0;
> > 		if (copy_to_user(uaddr, &addr, sizeof(addr)))
> > 			return -EFAULT;
> >+		break;
> > 	}
> >+
> >+	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
> >+	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS: {
> >+		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
> >+		u32 reg = 0;
> >+
> >+		r = vgic_attr_regs_access(dev, attr, &reg, false);
> >+		if (r)
> >+			return r;
> >+		r = put_user(reg, uaddr);
> >+		break;
> >+	}
> >+
> > 	}
> >
> > 	return r;
> > }
> >
> >+static int vgic_has_attr_regs(const struct mmio_range *ranges,
> >+			      phys_addr_t offset)
> >+{
> >+	if (find_matching_range(ranges, &dev_attr_mmio, offset))
> >+		return 0;
> >+	else
> >+		return -ENXIO;
> >+}
> >+
> > static int vgic_has_attr(struct kvm_device *dev, struct
> >kvm_device_attr *attr)
> > {
> > 	phys_addr_t offset;
> >@@ -1597,6 +1734,12 @@ static int vgic_has_attr(struct kvm_device
> >*dev, struct kvm_device_attr *attr)
> > 			return 0;
> > 		}
> > 		break;
> >+	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
> >+		offset = attr->attr & KVM_DEV_ARM_VGIC_OFFSET_MASK;
> >+		return vgic_has_attr_regs(vgic_dist_ranges, offset);
> >+	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS:
> >+		offset = attr->attr & KVM_DEV_ARM_VGIC_OFFSET_MASK;
> >+		return vgic_has_attr_regs(vgic_cpu_ranges, offset);
> > 	}
> > 	return -ENXIO;
> > }
> 

Thanks!
-- 
Christoffer
