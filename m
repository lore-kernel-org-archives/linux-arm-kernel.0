From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 11 Jan 2015 16:35:58 +0100
Subject: [PATCH v6 20/20] arm/arm64: KVM: allow userland to request a
 virtual GICv3
In-Reply-To: <1420804478-17354-21-git-send-email-andre.przywara@arm.com>
References: <1420804478-17354-1-git-send-email-andre.przywara@arm.com>
 <1420804478-17354-21-git-send-email-andre.przywara@arm.com>
Message-ID: <20150111153558.GF21444@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 09, 2015 at 11:54:38AM +0000, Andre Przywara wrote:
> With all of the GICv3 code in place now we allow userland to ask the
> kernel for using a virtual GICv3 in the guest.
> Also we provide the necessary support for guests setting the memory
> addresses for the virtual distributor and redistributors.
> This requires some userland code to make use of that feature and
> explicitly ask for a virtual GICv3.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Changelog v5...v6:
>  (none)
> 
> Changelog v4...v5:
> - improving documentation text
> 
> Changelog v3...v4:
> - refine commit message
> - add documentation of new GICv3 KVM device
> 
>  Documentation/virtual/kvm/devices/arm-vgic.txt |   22 ++++++++++--
>  arch/arm64/include/uapi/asm/kvm.h              |    7 ++++
>  include/kvm/arm_vgic.h                         |    4 +--
>  virt/kvm/arm/vgic-v3-emul.c                    |    3 ++
>  virt/kvm/arm/vgic.c                            |   46 +++++++++++++++++-------
>  5 files changed, 65 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/virtual/kvm/devices/arm-vgic.txt b/Documentation/virtual/kvm/devices/arm-vgic.txt
> index 30f5427..5d4fd4b 100644
> --- a/Documentation/virtual/kvm/devices/arm-vgic.txt
> +++ b/Documentation/virtual/kvm/devices/arm-vgic.txt
> @@ -3,22 +3,38 @@ ARM Virtual Generic Interrupt Controller (VGIC)
>  
>  Device types supported:
>    KVM_DEV_TYPE_ARM_VGIC_V2     ARM Generic Interrupt Controller v2.0
> +  KVM_DEV_TYPE_ARM_VGIC_V3     ARM Generic Interrupt Controller v3.0
>  
>  Only one VGIC instance may be instantiated through either this API or the
>  legacy KVM_CREATE_IRQCHIP api.  The created VGIC will act as the VM interrupt
>  controller, requiring emulated user-space devices to inject interrupts to the
>  VGIC instead of directly to CPUs.
>  
> +Creating a guest GICv3 device requires a host GICv3 as well.
> +GICv3 implementations with hardware compatibility support allow a guest GICv2
> +as well.
> +
>  Groups:
>    KVM_DEV_ARM_VGIC_GRP_ADDR
>    Attributes:
>      KVM_VGIC_V2_ADDR_TYPE_DIST (rw, 64-bit)
>        Base address in the guest physical address space of the GIC distributor
> -      register mappings.
> +      register mappings. Only valid for KVM_DEV_TYPE_ARM_VGIC_V2.
>  
>      KVM_VGIC_V2_ADDR_TYPE_CPU (rw, 64-bit)
>        Base address in the guest physical address space of the GIC virtual cpu
> -      interface register mappings.
> +      interface register mappings. Only valid for KVM_DEV_TYPE_ARM_VGIC_V2.
> +
> +    KVM_VGIC_V3_ADDR_TYPE_DIST (rw, 64-bit)
> +      Base address in the guest physical address space of the GICv3 distributor
> +      register mappings. Only valid for KVM_DEV_TYPE_ARM_VGIC_V3.
> +
> +    KVM_VGIC_V3_ADDR_TYPE_REDIST (rw, 64-bit)
> +      Base address in the guest physical address space of the GICv3
> +      redistributor register mappings. There are two 64K pages for each
> +      VCPU and all of the redistributor pages are contiguous.
> +      Only valid for KVM_DEV_TYPE_ARM_VGIC_V3.
> +

so did you decide on not specifying the alignment restrictions here?

>  
>    KVM_DEV_ARM_VGIC_GRP_DIST_REGS
>    Attributes:
> @@ -36,6 +52,7 @@ Groups:
>      the register.
>    Limitations:
>      - Priorities are not implemented, and registers are RAZ/WI
> +    - Currently only implemented for KVM_DEV_TYPE_ARM_VGIC_V2.
>    Errors:
>      -ENODEV: Getting or setting this register is not yet supported
>      -EBUSY: One or more VCPUs are running
> @@ -68,6 +85,7 @@ Groups:
>  
>    Limitations:
>      - Priorities are not implemented, and registers are RAZ/WI
> +    - Currently only implemented for KVM_DEV_TYPE_ARM_VGIC_V2.
>    Errors:
>      -ENODEV: Getting or setting this register is not yet supported
>      -EBUSY: One or more VCPUs are running
> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> index 480af34..3ef77a4 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
> @@ -78,6 +78,13 @@ struct kvm_regs {
>  #define KVM_VGIC_V2_DIST_SIZE		0x1000
>  #define KVM_VGIC_V2_CPU_SIZE		0x2000
>  
> +/* Supported VGICv3 address types  */
> +#define KVM_VGIC_V3_ADDR_TYPE_DIST	2
> +#define KVM_VGIC_V3_ADDR_TYPE_REDIST	3
> +
> +#define KVM_VGIC_V3_DIST_SIZE		SZ_64K
> +#define KVM_VGIC_V3_REDIST_SIZE		(2 * SZ_64K)
> +
>  #define KVM_ARM_VCPU_POWER_OFF		0 /* CPU is started in OFF state */
>  #define KVM_ARM_VCPU_EL1_32BIT		1 /* CPU running a 32bit VM */
>  #define KVM_ARM_VCPU_PSCI_0_2		2 /* CPU uses PSCI v0.2 */
> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> index b9b2e05..1bc0ca8 100644
> --- a/include/kvm/arm_vgic.h
> +++ b/include/kvm/arm_vgic.h
> @@ -36,8 +36,8 @@
>  #define VGIC_V2_MAX_CPUS	8
>  
>  /* Sanity checks... */
> -#if (KVM_MAX_VCPUS > 8)
> -#error	Invalid number of CPU interfaces
> +#if (KVM_MAX_VCPUS > 255)
> +#error Too many KVM VCPUs, the VGIC only supports up to 255 VCPUs for now
>  #endif
>  
>  #if (VGIC_NR_IRQS_LEGACY & 31)
> diff --git a/virt/kvm/arm/vgic-v3-emul.c b/virt/kvm/arm/vgic-v3-emul.c
> index 2d49058..a6d2bdb 100644
> --- a/virt/kvm/arm/vgic-v3-emul.c
> +++ b/virt/kvm/arm/vgic-v3-emul.c
> @@ -1009,6 +1009,9 @@ static int vgic_v3_has_attr(struct kvm_device *dev,
>  		case KVM_VGIC_V2_ADDR_TYPE_DIST:
>  		case KVM_VGIC_V2_ADDR_TYPE_CPU:
>  			return -ENXIO;
> +		case KVM_VGIC_V3_ADDR_TYPE_DIST:
> +		case KVM_VGIC_V3_ADDR_TYPE_REDIST:
> +			return 0;
>  		}
>  		break;
>  	case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index e474bd2..186cf30 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -1663,7 +1663,7 @@ static int vgic_ioaddr_assign(struct kvm *kvm, phys_addr_t *ioaddr,
>  /**
>   * kvm_vgic_addr - set or get vgic VM base addresses
>   * @kvm:   pointer to the vm struct
> - * @type:  the VGIC addr type, one of KVM_VGIC_V2_ADDR_TYPE_XXX
> + * @type:  the VGIC addr type, one of KVM_VGIC_V[23]_ADDR_TYPE_XXX
>   * @addr:  pointer to address value
>   * @write: if true set the address in the VM address space, if false read the
>   *          address
> @@ -1677,29 +1677,49 @@ int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write)
>  {
>  	int r = 0;
>  	struct vgic_dist *vgic = &kvm->arch.vgic;
> +	int type_needed;
> +	phys_addr_t *addr_ptr, block_size;
>  
>  	mutex_lock(&kvm->lock);
>  	switch (type) {
>  	case KVM_VGIC_V2_ADDR_TYPE_DIST:
> -		if (write) {
> -			r = vgic_ioaddr_assign(kvm, &vgic->vgic_dist_base,
> -					       *addr, KVM_VGIC_V2_DIST_SIZE);
> -		} else {
> -			*addr = vgic->vgic_dist_base;
> -		}
> +		type_needed = KVM_DEV_TYPE_ARM_VGIC_V2;
> +		addr_ptr = &vgic->vgic_dist_base;
> +		block_size = KVM_VGIC_V2_DIST_SIZE;
>  		break;
>  	case KVM_VGIC_V2_ADDR_TYPE_CPU:
> -		if (write) {
> -			r = vgic_ioaddr_assign(kvm, &vgic->vgic_cpu_base,
> -					       *addr, KVM_VGIC_V2_CPU_SIZE);
> -		} else {
> -			*addr = vgic->vgic_cpu_base;
> -		}
> +		type_needed = KVM_DEV_TYPE_ARM_VGIC_V2;
> +		addr_ptr = &vgic->vgic_cpu_base;
> +		block_size = KVM_VGIC_V2_CPU_SIZE;
>  		break;
> +#ifdef CONFIG_ARM_GIC_V3
> +	case KVM_VGIC_V3_ADDR_TYPE_DIST:
> +		type_needed = KVM_DEV_TYPE_ARM_VGIC_V3;
> +		addr_ptr = &vgic->vgic_dist_base;
> +		block_size = KVM_VGIC_V3_DIST_SIZE;
> +		break;
> +	case KVM_VGIC_V3_ADDR_TYPE_REDIST:
> +		type_needed = KVM_DEV_TYPE_ARM_VGIC_V3;
> +		addr_ptr = &vgic->vgic_redist_base;
> +		block_size = KVM_VGIC_V3_REDIST_SIZE;
> +		break;
> +#endif
>  	default:
>  		r = -ENODEV;
> +		goto out;
> +	}
> +
> +	if (vgic->vgic_model != type_needed) {
> +		r = -ENODEV;
> +		goto out;
>  	}
>  
> +	if (write)
> +		r = vgic_ioaddr_assign(kvm, addr_ptr, *addr, block_size);

you mentioned something about checking that the address for gicv3 is 64K
aligned, which we're not doing at the moment.  What are the potential
consequences?  Should we not just fix this?

> +	else
> +		*addr = *addr_ptr;
> +
> +out:
>  	mutex_unlock(&kvm->lock);
>  	return r;
>  }
> -- 
> 1.7.9.5
> 

Thanks,
-Christoffer
