From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 20 Mar 2017 15:12:05 +0000
Subject: [PATCH 1/2] KVM: arm/arm64: vgic-v2: Expose the correct GICC_PMR
 values to userspace
In-Reply-To: <20170320142425.GB20711@cbox>
References: <20170316114535.25233-1-marc.zyngier@arm.com>
 <20170316114535.25233-2-marc.zyngier@arm.com> <20170320142425.GB20711@cbox>
Message-ID: <3fb0ff07-7191-b814-b7d6-5165de97a805@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/03/17 14:24, Christoffer Dall wrote:
> On Thu, Mar 16, 2017 at 11:45:34AM +0000, Marc Zyngier wrote:
>> We allow userspace to save/restore the GICC_PMR values in order
>> to allow migration. This value is extracted from GICH_PMCR, where
>> it occupies a 5 bit field. But the canonical PMR is an 8 bit
>> value and we fail to shift the virtual priority, resulting in
>> a non-sensical value being reported to userspace.
>>
>> Fixing it once and for all would be ideal, but that would break
>> migration of guest from old to new kernels. We thus introduce
>> a new GICv2 attribute (KVM_DEV_ARM_VGIC_CTRL_CANONICAL_PMR)
>> that allows userspace to register its interest for the one true
>> representation of PMR.
> 
> Thinking about this some more, I think we should just leave the ABI as
> is without introducing the flag, because we do not loose any information
> by doing so, and we can completely leave it up to userspace to work
> around our funny ABI.

Right. That's the other option. Do we have any use case where we'd like
to expose the real thing to userspace? This would impact migration from
KVM to "something else", but I'm not sure we ever want to consider this
seriously.

> In the end, considering my comments on the next patch, the result would
> be amusing, and look something like this patch instead:
> 
> 
> diff --git a/Documentation/virtual/kvm/devices/arm-vgic.txt b/Documentation/virtual/kvm/devices/arm-vgic.txt
> index 76e61c8..b2f60ca 100644
> --- a/Documentation/virtual/kvm/devices/arm-vgic.txt
> +++ b/Documentation/virtual/kvm/devices/arm-vgic.txt
> @@ -83,6 +83,12 @@ Groups:
>  
>      Bits for undefined preemption levels are RAZ/WI.
>  
> +    For historical reasons and to provide ABI compatibility with userspace we
> +    export the GICC_PMR register in the format of the GICH_VMCR.VMPriMask
> +    field in the lower 5 bits of a word, meaning that userspace must always
> +    use the lower 5 bits to communicate with the KVM device and must shift the
> +    value left by 3 places to obtain the actual priority mask level.
> +
>    Limitations:
>      - Priorities are not implemented, and registers are RAZ/WI
>      - Currently only implemented for KVM_DEV_TYPE_ARM_VGIC_V2.
> diff --git a/virt/kvm/arm/vgic/vgic-mmio-v2.c b/virt/kvm/arm/vgic/vgic-mmio-v2.c
> index a3ad7ff..7b7ecac 100644
> --- a/virt/kvm/arm/vgic/vgic-mmio-v2.c
> +++ b/virt/kvm/arm/vgic/vgic-mmio-v2.c
> @@ -229,7 +229,14 @@ static unsigned long vgic_mmio_read_vcpuif(struct kvm_vcpu *vcpu,
>  		val = vmcr.ctlr;
>  		break;
>  	case GIC_CPU_PRIMASK:
> -		val = vmcr.pmr;
> +		/*
> +		 * Our KVM_DEV_TYPE_ARM_VGIC_V2 device ABI exports the
> +		 * the PMR field as GICH_VMCR.VMPriMask rather than
> +		 * GICC_PMR.Priority, so we expose the upper five bits of
> +		 * priority mask to userspace using the lower bits in the
> +		 * unsigned long.
> +		 */
> +		val = vmcr.pmr >> 3;
>  		break;
>  	case GIC_CPU_BINPOINT:
>  		val = vmcr.bpr;
> @@ -262,7 +269,14 @@ static void vgic_mmio_write_vcpuif(struct kvm_vcpu *vcpu,
>  		vmcr.ctlr = val;
>  		break;
>  	case GIC_CPU_PRIMASK:
> -		vmcr.pmr = val;
> +		/*
> +		 * Our KVM_DEV_TYPE_ARM_VGIC_V2 device ABI exports the
> +		 * the PMR field as GICH_VMCR.VMPriMask rather than
> +		 * GICC_PMR.Priority, so we expose the upper five bits of
> +		 * priority mask to userspace using the lower bits in the
> +		 * unsigned long.
> +		 */
> +		vmcr.pmr = val << 3;

By just looking@the code, I understand that you have struct vmcr
carrying PMR using its architectural representation? That's cunning indeed.

>  		break;
>  	case GIC_CPU_BINPOINT:
>  		vmcr.bpr = val;
> diff --git a/virt/kvm/arm/vgic/vgic-v2.c b/virt/kvm/arm/vgic/vgic-v2.c
> index b834ecd..95739cc 100644
> --- a/virt/kvm/arm/vgic/vgic-v2.c
> +++ b/virt/kvm/arm/vgic/vgic-v2.c
> @@ -191,7 +191,7 @@ void vgic_v2_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcrp)
>  		GICH_VMCR_ALIAS_BINPOINT_MASK;
>  	vmcr |= (vmcrp->bpr << GICH_VMCR_BINPOINT_SHIFT) &
>  		GICH_VMCR_BINPOINT_MASK;
> -	vmcr |= (vmcrp->pmr << GICH_VMCR_PRIMASK_SHIFT) &
> +	vmcr |= ((vmcrp->pmr >> 3) << GICH_VMCR_PRIMASK_SHIFT) &
>  		GICH_VMCR_PRIMASK_MASK;
>  
>  	vcpu->arch.vgic_cpu.vgic_v2.vgic_vmcr = vmcr;
> @@ -207,8 +207,8 @@ void vgic_v2_get_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcrp)
>  			GICH_VMCR_ALIAS_BINPOINT_SHIFT;
>  	vmcrp->bpr  = (vmcr & GICH_VMCR_BINPOINT_MASK) >>
>  			GICH_VMCR_BINPOINT_SHIFT;
> -	vmcrp->pmr  = (vmcr & GICH_VMCR_PRIMASK_MASK) >>
> -			GICH_VMCR_PRIMASK_SHIFT;
> +	vmcrp->pmr  = ((vmcr & GICH_VMCR_PRIMASK_MASK) >>
> +			GICH_VMCR_PRIMASK_SHIFT) << 3;
>  }
>  
>  void vgic_v2_enable(struct kvm_vcpu *vcpu)
> diff --git a/virt/kvm/arm/vgic/vgic.h b/virt/kvm/arm/vgic/vgic.h
> index db28f7c..64b70b4 100644
> --- a/virt/kvm/arm/vgic/vgic.h
> +++ b/virt/kvm/arm/vgic/vgic.h
> @@ -85,7 +85,8 @@ struct vgic_vmcr {
>  	u32	ctlr;
>  	u32	abpr;
>  	u32	bpr;
> -	u32	pmr;
> +	u32	pmr;  /* Priority mask field in the GICC_PMR and
> +		       * ICC_PMR_EL1 priority field format */
>  	/* Below member variable are valid only for GICv3 */
>  	u32	grpen0;
>  	u32	grpen1;
> 
> 
> Let me know what you think.

If everybody is happy with it, then so am I.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
