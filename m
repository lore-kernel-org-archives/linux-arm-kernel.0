From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 18 Jun 2013 08:44:28 -0700
Subject: [PATCH 1/7] KVM: arm-vgic: Support KVM_CREATE_DEVICE for VGIC
In-Reply-To: <CC247907-70DF-4981-9CF8-58719A410B61@suse.de>
References: <1370926279-32532-1-git-send-email-christoffer.dall@linaro.org>
 <1370926279-32532-2-git-send-email-christoffer.dall@linaro.org>
 <CC247907-70DF-4981-9CF8-58719A410B61@suse.de>
Message-ID: <20130618154428.GC3332@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 03:21:38PM +0200, Alexander Graf wrote:
> 
> 
> Am 11.06.2013 um 06:51 schrieb Christoffer Dall <christoffer.dall@linaro.org>:
> 
> > Support creating the ARM VGIC device through the KVM_CREATE_DEVICE
> > ioctl, which can then later be leveraged to use the
> > KVM_{GET/SET}_DEVICE_ATTR, which is useful both for setting addresses in
> > a more generic API than the ARM-specific one and is useful for
> > save/restore of VGIC state.
> > 
> > Adds KVM_CAP_DEVICE_CTRL to ARM capabilities.
> > 
> > Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> > ---
> > Documentation/virtual/kvm/devices/arm-vgic.txt |   10 +++++++
> > arch/arm/include/uapi/asm/kvm.h                |    8 ++++++
> > arch/arm/kvm/arm.c                             |    1 +
> > include/linux/kvm_host.h                       |    1 +
> > include/uapi/linux/kvm.h                       |    1 +
> > virt/kvm/arm/vgic.c                            |   34 ++++++++++++++++++++++++
> > virt/kvm/kvm_main.c                            |    4 +++
> > 7 files changed, 59 insertions(+)
> > create mode 100644 Documentation/virtual/kvm/devices/arm-vgic.txt
> > 
> > diff --git a/Documentation/virtual/kvm/devices/arm-vgic.txt b/Documentation/virtual/kvm/devices/arm-vgic.txt
> > new file mode 100644
> > index 0000000..25fd2d9
> > --- /dev/null
> > +++ b/Documentation/virtual/kvm/devices/arm-vgic.txt
> > @@ -0,0 +1,10 @@
> > +MPIC interrupt controller
> 
> MPIC?
> 

yes, ARM MPIC, haven't heard of it?

> > +=========================
> > +
> > +Device types supported:
> > +  KVM_DEV_TYPE_ARM_VGIC        ARM Generic Interrupt Controller v2.0
> > +
> > +Only one VGIC instance may be instantiated through either this API or the
> > +legacy KVM_CREATE_IRQCHIP api.  The created VGIC will act as the VM interrupt
> > +controller, requiring emulated user-space devices to inject interrupts to the
> > +VGIC instead of directly to CPUs.
> > diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
> > index c1ee007..587f1ae 100644
> > --- a/arch/arm/include/uapi/asm/kvm.h
> > +++ b/arch/arm/include/uapi/asm/kvm.h
> > @@ -142,6 +142,14 @@ struct kvm_arch_memory_slot {
> > #define KVM_REG_ARM_VFP_FPINST        0x1009
> > #define KVM_REG_ARM_VFP_FPINST2        0x100A
> > 
> > +/* Device Control API: ARM VGIC */
> > +#define KVM_DEV_ARM_VGIC_GRP_ADDR    0
> > +#define KVM_DEV_ARM_VGIC_GRP_DIST_REGS    1
> > +#define KVM_DEV_ARM_VGIC_GRP_CPU_REGS    2
> > +#define   KVM_DEV_ARM_VGIC_CPUID_SHIFT    32
> > +#define   KVM_DEV_ARM_VGIC_CPUID_MASK    (0xffULL << KVM_DEV_ARM_VGIC_CPUID_SHIFT)
> > +#define   KVM_DEV_ARM_VGIC_OFFSET_SHIFT    0
> > +#define   KVM_DEV_ARM_VGIC_OFFSET_MASK    (0xffffffffULL << KVM_DEV_ARM_VGIC_OFFSET_SHIFT)
> 
> Could you please describe the groups in the documentation too?
> 

these defines can go in the other patch

> > 
> > /* KVM_IRQ_LINE irq field index values */
> > #define KVM_ARM_IRQ_TYPE_SHIFT        24
> > diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> > index 741f66a..b8e3b6e 100644
> > --- a/arch/arm/kvm/arm.c
> > +++ b/arch/arm/kvm/arm.c
> > @@ -187,6 +187,7 @@ int kvm_dev_ioctl_check_extension(long ext)
> >    case KVM_CAP_IRQCHIP:
> >        r = vgic_present;
> >        break;
> > +    case KVM_CAP_DEVICE_CTRL:
> >    case KVM_CAP_USER_MEMORY:
> >    case KVM_CAP_SYNC_MMU:
> >    case KVM_CAP_DESTROY_MEMORY_REGION_WORKS:
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index d9a3c30..e2d6556 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -1086,6 +1086,7 @@ struct kvm_device *kvm_device_from_filp(struct file *filp);
> > 
> > extern struct kvm_device_ops kvm_mpic_ops;
> > extern struct kvm_device_ops kvm_xics_ops;
> > +extern struct kvm_device_ops kvm_arm_vgic_ops;
> > 
> > #ifdef CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT
> > 
> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > index a5c86fc..4f2a4ab 100644
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -839,6 +839,7 @@ struct kvm_device_attr {
> > #define KVM_DEV_TYPE_FSL_MPIC_20    1
> > #define KVM_DEV_TYPE_FSL_MPIC_42    2
> > #define KVM_DEV_TYPE_XICS        3
> > +#define KVM_DEV_TYPE_ARM_VGIC        4
> 
> Should this be versioned? Gicv2 is different from v3, no?
> 

yes, we can call it all XXX_VGIC_V2. It just becomes so verbose, but
it's really the right thing to do.

> Alex
> 
> > 
> > /*
> >  * ioctls for VM fds
> > diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> > index 17c5ac7..b3dcd66 100644
> > --- a/virt/kvm/arm/vgic.c
> > +++ b/virt/kvm/arm/vgic.c
> > @@ -1497,3 +1497,37 @@ int kvm_vgic_set_addr(struct kvm *kvm, unsigned long type, u64 addr)
> >    mutex_unlock(&kvm->lock);
> >    return r;
> > }
> > +
> > +static int vgic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
> > +{
> > +    return -ENXIO;
> > +}
> > +
> > +static int vgic_get_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
> > +{
> > +    return -ENXIO;
> > +}
> > +
> > +static int vgic_has_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
> > +{
> > +    return -ENXIO;
> > +}
> > +
> > +static void vgic_destroy(struct kvm_device *dev)
> > +{
> > +    kfree(dev);
> > +}
> > +
> > +static int vgic_create(struct kvm_device *dev, u32 type)
> > +{
> > +    return kvm_vgic_create(dev->kvm);
> > +}
> > +
> > +struct kvm_device_ops kvm_arm_vgic_ops = {
> > +    .name = "kvm-arm-vgic",
> > +    .create = vgic_create,
> > +    .destroy = vgic_destroy,
> > +    .set_attr = vgic_set_attr,
> > +    .get_attr = vgic_get_attr,
> > +    .has_attr = vgic_has_attr,
> > +};
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index b547a1c..774e77c 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -2282,6 +2282,10 @@ static int kvm_ioctl_create_device(struct kvm *kvm,
> >        ops = &kvm_xics_ops;
> >        break;
> > #endif
> > +#ifdef CONFIG_KVM_ARM_VGIC
> > +    case KVM_DEV_TYPE_ARM_VGIC:
> > +        ops = &kvm_arm_vgic_ops;
> > +#endif
> >    default:
> >        return -ENODEV;
> >    }
> > -- 
> > 1.7.9.5
> > 
> > _______________________________________________
> > kvmarm mailing list
> > kvmarm at lists.cs.columbia.edu
> > https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm
