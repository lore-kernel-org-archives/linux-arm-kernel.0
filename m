From: agraf@suse.de (Alexander Graf)
Date: Tue, 18 Jun 2013 15:25:04 +0200
Subject: [PATCH 2/7] KVM: arm-vgic: Set base addr through device API
In-Reply-To: <1370926279-32532-3-git-send-email-christoffer.dall@linaro.org>
References: <1370926279-32532-1-git-send-email-christoffer.dall@linaro.org>
 <1370926279-32532-3-git-send-email-christoffer.dall@linaro.org>
Message-ID: <C2CF6B47-18E3-456B-9BE4-0682A7DD0DE9@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Am 11.06.2013 um 06:51 schrieb Christoffer Dall <christoffer.dall@linaro.org>:

> Support setting the distributor and cpu interface base addresses in the
> VM physical address space through the KVM_{SET,GET}_DEVICE_ATTR API
> in addition the ARM specific API.
> 
> This has the added benefit of being able to share more code in user
> space and do things in a uniform maner.
> 
> Also deprecate the older API at the same time, but backwards
> compatibility will be maintained.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
> Documentation/virtual/kvm/api.txt              |    5 +-
> Documentation/virtual/kvm/devices/arm-vgic.txt |   11 +++
> arch/arm/kvm/arm.c                             |    2 +-
> include/kvm/arm_vgic.h                         |    2 +-
> virt/kvm/arm/vgic.c                            |   90 ++++++++++++++++++++----
> 5 files changed, 95 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index 5f91eda..ea5ec4a 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -2305,7 +2305,7 @@ This ioctl returns the guest registers that are supported for the
> KVM_GET_ONE_REG/KVM_SET_ONE_REG calls.
> 
> 
> -4.80 KVM_ARM_SET_DEVICE_ADDR
> +4.80 KVM_ARM_SET_DEVICE_ADDR (deprecated)
> 
> Capability: KVM_CAP_ARM_SET_DEVICE_ADDR
> Architectures: arm
> @@ -2342,6 +2342,9 @@ and distributor interface, the ioctl must be called after calling
> KVM_CREATE_IRQCHIP, but before calling KVM_RUN on any of the VCPUs.  Calling
> this ioctl twice for any of the base addresses will return -EEXIST.
> 
> +Note, this IOCTL is deprecated and the more flexible SET/GET_DEVICE_ATTR API
> +should be used instead.
> +
> 4.82 KVM_PPC_RTAS_DEFINE_TOKEN
> 
> Capability: KVM_CAP_PPC_RTAS
> diff --git a/Documentation/virtual/kvm/devices/arm-vgic.txt b/Documentation/virtual/kvm/devices/arm-vgic.txt
> index 25fd2d9..ca83ad8 100644
> --- a/Documentation/virtual/kvm/devices/arm-vgic.txt
> +++ b/Documentation/virtual/kvm/devices/arm-vgic.txt
> @@ -8,3 +8,14 @@ Only one VGIC instance may be instantiated through either this API or the
> legacy KVM_CREATE_IRQCHIP api.  The created VGIC will act as the VM interrupt
> controller, requiring emulated user-space devices to inject interrupts to the
> VGIC instead of directly to CPUs.
> +
> +Groups:

Ah, here they are :)

> +  KVM_DEV_ARM_VGIC_GRP_ADDR
> +  Attributes:
> +    KVM_VGIC_V2_ADDR_TYPE_DIST (rw, 64-bit)
> +      Base address in the guest physical address space of the GIC distributor
> +      register mappings.
> +
> +    KVM_VGIC_V2_ADDR_TYPE_CPU (rw, 64-bit)
> +      Base address in the guest physical address space of the GIC virtual cpu
> +      interface register mappings.

Is this per-cpu or per-vgic? Can different CPUs have their gic interface maps mapped at different offsets?

Alex

> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index b8e3b6e..63ddccb 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -768,7 +768,7 @@ static int kvm_vm_ioctl_set_device_addr(struct kvm *kvm,
>    case KVM_ARM_DEVICE_VGIC_V2:
>        if (!vgic_present)
>            return -ENXIO;
> -        return kvm_vgic_set_addr(kvm, type, dev_addr->addr);
> +        return kvm_vgic_addr(kvm, type, &dev_addr->addr, true);
>    default:
>        return -ENODEV;
>    }
> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> index 343744e..5631cfa 100644
> --- a/include/kvm/arm_vgic.h
> +++ b/include/kvm/arm_vgic.h
> @@ -144,7 +144,7 @@ struct kvm_run;
> struct kvm_exit_mmio;
> 
> #ifdef CONFIG_KVM_ARM_VGIC
> -int kvm_vgic_set_addr(struct kvm *kvm, unsigned long type, u64 addr);
> +int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write);
> int kvm_vgic_hyp_init(void);
> int kvm_vgic_init(struct kvm *kvm);
> int kvm_vgic_create(struct kvm *kvm);
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index b3dcd66..8e915b7 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -1457,6 +1457,12 @@ static int vgic_ioaddr_assign(struct kvm *kvm, phys_addr_t *ioaddr,
> {
>    int ret;
> 
> +    if (addr & ~KVM_PHYS_MASK)
> +        return -E2BIG;
> +
> +    if (addr & (SZ_4K - 1))
> +        return -EINVAL;
> +
>    if (!IS_VGIC_ADDR_UNDEF(*ioaddr))
>        return -EEXIST;
>    if (addr + size < addr)
> @@ -1469,26 +1475,41 @@ static int vgic_ioaddr_assign(struct kvm *kvm, phys_addr_t *ioaddr,
>    return ret;
> }
> 
> -int kvm_vgic_set_addr(struct kvm *kvm, unsigned long type, u64 addr)
> +/**
> + * kvm_vgic_addr - set or get vgic VM base addresses
> + * @kvm:   pointer to the vm struct
> + * @type:  the VGIC addr type, one of KVM_VGIC_V2_ADDR_TYPE_XXX
> + * @addr:  pointer to address value
> + * @write: if true set the address in the VM address space, if false read the
> + *          address
> + *
> + * Set or get the vgic base addresses for the distributor and the virtual CPU
> + * interface in the VM physical address space.  These addresses are properties
> + * of the emulated core/SoC and therefore user space initially knows this
> + * information.
> + */
> +int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write)
> {
>    int r = 0;
>    struct vgic_dist *vgic = &kvm->arch.vgic;
> 
> -    if (addr & ~KVM_PHYS_MASK)
> -        return -E2BIG;
> -
> -    if (addr & (SZ_4K - 1))
> -        return -EINVAL;
> -
>    mutex_lock(&kvm->lock);
>    switch (type) {
>    case KVM_VGIC_V2_ADDR_TYPE_DIST:
> -        r = vgic_ioaddr_assign(kvm, &vgic->vgic_dist_base,
> -                       addr, KVM_VGIC_V2_DIST_SIZE);
> +        if (write) {
> +            r = vgic_ioaddr_assign(kvm, &vgic->vgic_dist_base,
> +                           *addr, KVM_VGIC_V2_DIST_SIZE);
> +        } else {
> +            *addr = vgic->vgic_dist_base;
> +        }
>        break;
>    case KVM_VGIC_V2_ADDR_TYPE_CPU:
> -        r = vgic_ioaddr_assign(kvm, &vgic->vgic_cpu_base,
> -                       addr, KVM_VGIC_V2_CPU_SIZE);
> +        if (write) {
> +            r = vgic_ioaddr_assign(kvm, &vgic->vgic_cpu_base,
> +                           *addr, KVM_VGIC_V2_CPU_SIZE);
> +        } else {
> +            *addr = vgic->vgic_cpu_base;
> +        }
>        break;
>    default:
>        r = -ENODEV;
> @@ -1500,16 +1521,61 @@ int kvm_vgic_set_addr(struct kvm *kvm, unsigned long type, u64 addr)
> 
> static int vgic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
> {
> +    int r;
> +
> +    switch (attr->group) {
> +    case KVM_DEV_ARM_VGIC_GRP_ADDR: {
> +        u64 __user *uaddr = (u64 __user *)(long)attr->addr;
> +        u64 addr;
> +        unsigned long type = (unsigned long)attr->attr;
> +
> +        if (copy_from_user(&addr, uaddr, sizeof(addr)))
> +            return -EFAULT;
> +
> +        r = kvm_vgic_addr(dev->kvm, type, &addr, true);
> +        return (r == -ENODEV) ? -ENXIO : r;
> +    }
> +    }
> +
>    return -ENXIO;
> }
> 
> static int vgic_get_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
> {
> -    return -ENXIO;
> +    int r = ENXIO;
> +
> +    switch (attr->group) {
> +    case KVM_DEV_ARM_VGIC_GRP_ADDR: {
> +        u64 __user *uaddr = (u64 __user *)(long)attr->addr;
> +        u64 addr;
> +        unsigned long type = (unsigned long)attr->attr;
> +
> +        r = kvm_vgic_addr(dev->kvm, type, &addr, false);
> +        if (r)
> +            return (r == -ENODEV) ? -ENXIO : r;
> +
> +        r = 0;
> +        if (copy_to_user(uaddr, &addr, sizeof(addr)))
> +            return -EFAULT;
> +    }
> +    }
> +
> +    return r;
> }
> 
> static int vgic_has_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
> {
> +    phys_addr_t offset;
> +
> +    switch (attr->group) {
> +    case KVM_DEV_ARM_VGIC_GRP_ADDR:
> +        switch (attr->attr) {
> +        case KVM_VGIC_V2_ADDR_TYPE_DIST:
> +        case KVM_VGIC_V2_ADDR_TYPE_CPU:
> +            return 0;
> +        }
> +        break;
> +    }
>    return -ENXIO;
> }
> 
> -- 
> 1.7.9.5
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm
