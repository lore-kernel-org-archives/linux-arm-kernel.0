From: joel.schopp@amd.com (Joel Schopp)
Date: Tue, 24 Jun 2014 14:28:13 -0500
Subject: [PATCH v2 9/9] arm64: KVM: vgic: deal with GIC sub-page alignment
In-Reply-To: <1403169693-13982-10-git-send-email-marc.zyngier@arm.com>
References: <1403169693-13982-1-git-send-email-marc.zyngier@arm.com>
 <1403169693-13982-10-git-send-email-marc.zyngier@arm.com>
Message-ID: <53A9D14D.2020802@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 06/19/2014 04:21 AM, Marc Zyngier wrote:
> The GIC CPU interface is always 4k aligned. If the host is using
> 64k pages, it is critical to place the guest's GICC interface at the
> same relative alignment as the host's GICV. Failure to do so results
> in an impossibility for the guest to deal with interrupts.
>
> Add a KVM_DEV_ARM_VGIC_GRP_ADDR_OFFSET attribute for the VGIC, allowing
> userspace to retrieve the GICV offset in a page. It becomes then trivial
> to adjust the GICC base address for the guest.

Does this mean there is a corresponding patch for qemu?

>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   arch/arm/include/uapi/asm/kvm.h   | 1 +
>   arch/arm64/include/uapi/asm/kvm.h | 1 +
>   virt/kvm/arm/vgic.c               | 7 +++++++
>   3 files changed, 9 insertions(+)
>
> diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
> index 8b51c1a..056b782 100644
> --- a/arch/arm/include/uapi/asm/kvm.h
> +++ b/arch/arm/include/uapi/asm/kvm.h
> @@ -174,6 +174,7 @@ struct kvm_arch_memory_slot {
>   #define   KVM_DEV_ARM_VGIC_OFFSET_SHIFT	0
>   #define   KVM_DEV_ARM_VGIC_OFFSET_MASK	(0xffffffffULL << KVM_DEV_ARM_VGIC_OFFSET_SHIFT)
>   #define KVM_DEV_ARM_VGIC_GRP_NR_IRQS	3
> +#define KVM_DEV_ARM_VGIC_GRP_ADDR_OFFSET 4
>   
>   /* KVM_IRQ_LINE irq field index values */
>   #define KVM_ARM_IRQ_TYPE_SHIFT		24
> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> index b5cd6ed..5513de4 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
> @@ -160,6 +160,7 @@ struct kvm_arch_memory_slot {
>   #define   KVM_DEV_ARM_VGIC_OFFSET_SHIFT	0
>   #define   KVM_DEV_ARM_VGIC_OFFSET_MASK	(0xffffffffULL << KVM_DEV_ARM_VGIC_OFFSET_SHIFT)
>   #define KVM_DEV_ARM_VGIC_GRP_NR_IRQS	3
> +#define KVM_DEV_ARM_VGIC_GRP_ADDR_OFFSET 4
>   
>   /* KVM_IRQ_LINE irq field index values */
>   #define KVM_ARM_IRQ_TYPE_SHIFT		24
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index b0cd417..68ac9c6 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -2228,6 +2228,12 @@ static int vgic_get_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
>   		r = put_user(dev->kvm->arch.vgic.nr_irqs, uaddr);
>   		break;
>   	}
> +	case KVM_DEV_ARM_VGIC_GRP_ADDR_OFFSET: {
> +		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
> +		u32 val = vgic->vcpu_base & ~PAGE_MASK;
> +		r = put_user(val, uaddr);
> +		break;
> +	}
>   
>   	}
>   
> @@ -2265,6 +2271,7 @@ static int vgic_has_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
>   		offset = attr->attr & KVM_DEV_ARM_VGIC_OFFSET_MASK;
>   		return vgic_has_attr_regs(vgic_cpu_ranges, offset);
>   	case KVM_DEV_ARM_VGIC_GRP_NR_IRQS:
> +	case KVM_DEV_ARM_VGIC_GRP_ADDR_OFFSET:
>   		return 0;
>   	}
>   	return -ENXIO;
