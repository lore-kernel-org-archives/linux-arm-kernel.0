From: cdall@linaro.org (Christoffer Dall)
Date: Mon, 20 Mar 2017 15:24:35 +0100
Subject: [PATCH 2/2] KVM: arm/arm64: vgic-v3: Format PMR to mimic the
 GICv2 behaviour
In-Reply-To: <20170316114535.25233-3-marc.zyngier@arm.com>
References: <20170316114535.25233-1-marc.zyngier@arm.com>
 <20170316114535.25233-3-marc.zyngier@arm.com>
Message-ID: <20170320142435.GC20711@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 16, 2017 at 11:45:35AM +0000, Marc Zyngier wrote:
> Similarily to the GICv2 case, we need to expose a PMR value that
> is either the 8bit value (KVM_DEV_ARM_VGIC_CTRL_CANONICAL_PMR
> being set) or the 5bit, truncated value otherwise.

I'm a bit puzzled by this patch as well.  The struct vmcr is an internal
representation of the VMCR register fields without well-defined
semantics of how the fields should be laid out.

I think I would prefer it if we document on the vmcr struct which format
the pmr field is in, and choose the actual ICC_PMR_EL1 or GICC_PMR
format for this field, and then we leave the get/set_vmcr functions
untouched.

> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  virt/kvm/arm/vgic/vgic-v3.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
> index be0f4c3e0142..d260214a5bdb 100644
> --- a/virt/kvm/arm/vgic/vgic-v3.c
> +++ b/virt/kvm/arm/vgic/vgic-v3.c
> @@ -184,6 +184,17 @@ void vgic_v3_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcrp)
>  	vmcr |= (vmcrp->ctlr << ICH_VMCR_CBPR_SHIFT) & ICH_VMCR_CBPR_MASK;
>  	vmcr |= (vmcrp->abpr << ICH_VMCR_BPR1_SHIFT) & ICH_VMCR_BPR1_MASK;
>  	vmcr |= (vmcrp->bpr << ICH_VMCR_BPR0_SHIFT) & ICH_VMCR_BPR0_MASK;
> +
> +	/*
> +	 * If we're emulating GICv2 and that userspace can't deal with

My comments above notwithstanding:

s/that//

> +	 * the normal PMR range (8 bits), we need to make it GICv3
> +	 * compatible by shifting the value by 3 bits in order to deal
> +	 * with the full 8bit range.
> +	 */
> +	if (vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V2 &&
> +	    !test_bit(VGIC_QUIRK_CANONICAL_PMR, &vcpu->kvm->arch.vgic.quirks))
> +		vmcrp->pmr <<= 3;
> +
>  	vmcr |= (vmcrp->pmr << ICH_VMCR_PMR_SHIFT) & ICH_VMCR_PMR_MASK;
>  	vmcr |= (vmcrp->grpen0 << ICH_VMCR_ENG0_SHIFT) & ICH_VMCR_ENG0_MASK;
>  	vmcr |= (vmcrp->grpen1 << ICH_VMCR_ENG1_SHIFT) & ICH_VMCR_ENG1_MASK;
> @@ -205,6 +216,16 @@ void vgic_v3_get_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcrp)
>  	vmcrp->abpr = (vmcr & ICH_VMCR_BPR1_MASK) >> ICH_VMCR_BPR1_SHIFT;
>  	vmcrp->bpr  = (vmcr & ICH_VMCR_BPR0_MASK) >> ICH_VMCR_BPR0_SHIFT;
>  	vmcrp->pmr  = (vmcr & ICH_VMCR_PMR_MASK) >> ICH_VMCR_PMR_SHIFT;
> +
> +	/*
> +	 * If we're emulating GICv2 and that userspace DOES NOT deal

s/that//

nit: why do we write DOES NOT here i upper case (feels a bit aggressive)?

> +	 * with the normal PMR range (8 bits), we need to reduce it to
> +	 * the GICv2 range (5 bits).
> +	 */
> +	if (vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V2 &&
> +	    !test_bit(VGIC_QUIRK_CANONICAL_PMR, &vcpu->kvm->arch.vgic.quirks))
> +		vmcrp->pmr >>= 3;
> +
>  	vmcrp->grpen0 = (vmcr & ICH_VMCR_ENG0_MASK) >> ICH_VMCR_ENG0_SHIFT;
>  	vmcrp->grpen1 = (vmcr & ICH_VMCR_ENG1_MASK) >> ICH_VMCR_ENG1_SHIFT;
>  }
> -- 
> 2.11.0
> 

Thanks,
-Christoffer
