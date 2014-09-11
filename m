From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 11 Sep 2014 15:38:51 -0700
Subject: [PATCH v4 8/8] arm/arm64: KVM: vgic: make number of irqs a
 configurable attribute
In-Reply-To: <1410433755-3612-9-git-send-email-marc.zyngier@arm.com>
References: <1410433755-3612-1-git-send-email-marc.zyngier@arm.com>
 <1410433755-3612-9-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140911223851.GS5535@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 12:09:15PM +0100, Marc Zyngier wrote:
> In order to make the number of interrupts configurable, use the new
> fancy device management API to add KVM_DEV_ARM_VGIC_GRP_NR_IRQS as
> a VGIC configurable attribute.
> 
> Userspace can now specify the exact size of the GIC (by increments
> of 32 interrupts).
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  Documentation/virtual/kvm/devices/arm-vgic.txt | 10 +++++++
>  arch/arm/include/uapi/asm/kvm.h                |  1 +
>  arch/arm64/include/uapi/asm/kvm.h              |  1 +
>  virt/kvm/arm/vgic.c                            | 37 ++++++++++++++++++++++++++
>  4 files changed, 49 insertions(+)
> 
> diff --git a/Documentation/virtual/kvm/devices/arm-vgic.txt b/Documentation/virtual/kvm/devices/arm-vgic.txt
> index 7f4e91b..df8b0c7 100644
> --- a/Documentation/virtual/kvm/devices/arm-vgic.txt
> +++ b/Documentation/virtual/kvm/devices/arm-vgic.txt
> @@ -71,3 +71,13 @@ Groups:
>    Errors:
>      -ENODEV: Getting or setting this register is not yet supported
>      -EBUSY: One or more VCPUs are running
> +
> +  KVM_DEV_ARM_VGIC_GRP_NR_IRQS
> +  Attributes:
> +    A value describing the number of interrupts (SGI, PPI and SPI) for
> +    this GIC instance, ranging from 64 to 1024, in increments of 32.
> +
> +  Errors:
> +    -EINVAL: Value set is out of the expected range
> +    -EBUSY: Value has already be set, or GIC has already been initialized
> +            with default values.
> diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
> index e6ebdd3..8b51c1a 100644
> --- a/arch/arm/include/uapi/asm/kvm.h
> +++ b/arch/arm/include/uapi/asm/kvm.h
> @@ -173,6 +173,7 @@ struct kvm_arch_memory_slot {
>  #define   KVM_DEV_ARM_VGIC_CPUID_MASK	(0xffULL << KVM_DEV_ARM_VGIC_CPUID_SHIFT)
>  #define   KVM_DEV_ARM_VGIC_OFFSET_SHIFT	0
>  #define   KVM_DEV_ARM_VGIC_OFFSET_MASK	(0xffffffffULL << KVM_DEV_ARM_VGIC_OFFSET_SHIFT)
> +#define KVM_DEV_ARM_VGIC_GRP_NR_IRQS	3
>  
>  /* KVM_IRQ_LINE irq field index values */
>  #define KVM_ARM_IRQ_TYPE_SHIFT		24
> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> index e633ff8..b5cd6ed 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
> @@ -159,6 +159,7 @@ struct kvm_arch_memory_slot {
>  #define   KVM_DEV_ARM_VGIC_CPUID_MASK	(0xffULL << KVM_DEV_ARM_VGIC_CPUID_SHIFT)
>  #define   KVM_DEV_ARM_VGIC_OFFSET_SHIFT	0
>  #define   KVM_DEV_ARM_VGIC_OFFSET_MASK	(0xffffffffULL << KVM_DEV_ARM_VGIC_OFFSET_SHIFT)
> +#define KVM_DEV_ARM_VGIC_GRP_NR_IRQS	3
>  
>  /* KVM_IRQ_LINE irq field index values */
>  #define KVM_ARM_IRQ_TYPE_SHIFT		24
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index 9180823..744388d 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -2331,6 +2331,36 @@ static int vgic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
>  
>  		return vgic_attr_regs_access(dev, attr, &reg, true);
>  	}
> +	case KVM_DEV_ARM_VGIC_GRP_NR_IRQS: {
> +		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
> +		u32 val;
> +		int ret = 0;
> +
> +		if (get_user(val, uaddr))
> +			return -EFAULT;
> +
> +		/*
> +		 * We require:
> +		 * - at least 32 SPIs on top of the 16 SGIs and 16 PPIs
> +		 * - at most 1024 interrupts
> +		 * - a multiple of 32 interrupts
> +		 */
> +		if (val < (VGIC_NR_PRIVATE_IRQS + 32) ||
> +		    val > VGIC_MAX_IRQS ||
> +		    (val & 31))
> +			return -EINVAL;
> +
> +		mutex_lock(&dev->kvm->lock);
> +
> +		if (vgic_initialized(dev->kvm) || dev->kvm->arch.vgic.nr_irqs)
> +			ret = -EBUSY;
> +		else
> +			dev->kvm->arch.vgic.nr_irqs = val;
> +
> +		mutex_unlock(&dev->kvm->lock);
> +
> +		return ret;
> +	}
>  
>  	}
>  
> @@ -2367,6 +2397,11 @@ static int vgic_get_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
>  		r = put_user(reg, uaddr);
>  		break;
>  	}
> +	case KVM_DEV_ARM_VGIC_GRP_NR_IRQS: {
> +		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
> +		r = put_user(dev->kvm->arch.vgic.nr_irqs, uaddr);
> +		break;
> +	}
>  
>  	}
>  
> @@ -2403,6 +2438,8 @@ static int vgic_has_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
>  	case KVM_DEV_ARM_VGIC_GRP_CPU_REGS:
>  		offset = attr->attr & KVM_DEV_ARM_VGIC_OFFSET_MASK;
>  		return vgic_has_attr_regs(vgic_cpu_ranges, offset);
> +	case KVM_DEV_ARM_VGIC_GRP_NR_IRQS:
> +		return 0;
>  	}
>  	return -ENXIO;
>  }
> -- 
> 2.0.4
> 

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
