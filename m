From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 24 Nov 2014 10:09:27 +0100
Subject: [PATCH v4 18/19] arm/arm64: KVM: enable kernel side of GICv3
 emulation
In-Reply-To: <1415959683-26027-19-git-send-email-andre.przywara@arm.com>
References: <1415959683-26027-1-git-send-email-andre.przywara@arm.com>
 <1415959683-26027-19-git-send-email-andre.przywara@arm.com>
Message-ID: <20141124090927.GE3401@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 10:08:02AM +0000, Andre Przywara wrote:
> With all the necessary GICv3 emulation code in place, we can now
> connect the code to the GICv3 backend in the kernel.
> The LR register handling is different depending on the emulated GIC
> model, so provide different implementations for each.
> Also allow non-v2-compatible GICv3 implementations (which don't
> provide MMIO regions for the virtual CPU interface in the DT), but
> restrict those hosts to support GICv3 guests only.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Changelog v3...v4:
> - handle differences between GICv2-on-v3 and GICv3-on-v3 in existing functions
> - remove init_*_emul() functions
> - remove max_vcpus setting (done in earlier patches now)
> - adapt to new vgic_v<n>_init_emulation behaviour
> 
>  virt/kvm/arm/vgic-v3.c |   83 ++++++++++++++++++++++++++++++++----------------
>  virt/kvm/arm/vgic.c    |    5 +++
>  2 files changed, 60 insertions(+), 28 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic-v3.c b/virt/kvm/arm/vgic-v3.c
> index a04d208..4894c59 100644
> --- a/virt/kvm/arm/vgic-v3.c
> +++ b/virt/kvm/arm/vgic-v3.c
> @@ -34,6 +34,7 @@
>  #define GICH_LR_VIRTUALID		(0x3ffUL << 0)
>  #define GICH_LR_PHYSID_CPUID_SHIFT	(10)
>  #define GICH_LR_PHYSID_CPUID		(7UL << GICH_LR_PHYSID_CPUID_SHIFT)
> +#define ICH_LR_VIRTUALID_MASK		(BIT_ULL(32) - 1)
>  
>  /*
>   * LRs are stored in reverse order in memory. make sure we index them
> @@ -48,12 +49,17 @@ static struct vgic_lr vgic_v3_get_lr(const struct kvm_vcpu *vcpu, int lr)
>  	struct vgic_lr lr_desc;
>  	u64 val = vcpu->arch.vgic_cpu.vgic_v3.vgic_lr[LR_INDEX(lr)];
>  
> -	lr_desc.irq	= val & GICH_LR_VIRTUALID;
> -	if (lr_desc.irq <= 15)
> -		lr_desc.source	= (val >> GICH_LR_PHYSID_CPUID_SHIFT) & 0x7;
> +	if (vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3)
> +		lr_desc.irq = val & ICH_LR_VIRTUALID_MASK;
>  	else
> -		lr_desc.source = 0;
> -	lr_desc.state	= 0;
> +		lr_desc.irq = val & GICH_LR_VIRTUALID;
> +
> +	lr_desc.source = 0;
> +	if (lr_desc.irq <= 15 &&
> +	    vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V2)
> +		lr_desc.source	= (val >> GICH_LR_PHYSID_CPUID_SHIFT) & 0x7;
> +
> +	lr_desc.state   = 0;

super-nit-only-if-you-respin: you have a couple of tabs and extra spaces
in the two lines above that need to just be a single space before the
assignment operator on each line.

>  
>  	if (val & ICH_LR_PENDING_BIT)
>  		lr_desc.state |= LR_STATE_PENDING;
> @@ -68,8 +74,20 @@ static struct vgic_lr vgic_v3_get_lr(const struct kvm_vcpu *vcpu, int lr)
>  static void vgic_v3_set_lr(struct kvm_vcpu *vcpu, int lr,
>  			   struct vgic_lr lr_desc)
>  {
> -	u64 lr_val = (((u32)lr_desc.source << GICH_LR_PHYSID_CPUID_SHIFT) |
> -		      lr_desc.irq);
> +	u64 lr_val;
> +
> +	lr_val = lr_desc.irq;
> +
> +	/*
> +	 * currently all guest IRQs are Group1, as Group0 would result

I guess you couldn't guess my comment, from last time, can you please
begin sentences with upper-case?  (only if you re-spin).

> +	 * in a FIQ in the guest, which it wouldn't expect.
> +	 * Eventually we want to make this configurable, so we may revisit
> +	 * this in the future.
> +	 */
> +	if (vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3)
> +		lr_val |= ICH_LR_GROUP;
> +	else
> +		lr_val |= (u32)lr_desc.source << GICH_LR_PHYSID_CPUID_SHIFT;
>  
>  	if (lr_desc.state & LR_STATE_PENDING)
>  		lr_val |= ICH_LR_PENDING_BIT;
> @@ -154,7 +172,14 @@ static void vgic_v3_enable(struct kvm_vcpu *vcpu)
>  	 */
>  	vgic_v3->vgic_vmcr = 0;
>  
> -	vgic_v3->vgic_sre = 0;
> +	/*
> +	 * Set the SRE_EL1 value depending on the configured
> +	 * emulated vGIC model.
> +	 */
> +	if (vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3)
> +		vgic_v3->vgic_sre = ICC_SRE_EL1_SRE;

I think we left some of my questions from last round unanswered here
(you said you needed to go and think about it).  If the guest sets SRE=0
we will not currently preserve this value I think.

The comment should clearly indicate that we're choosing a reset value
of the register for our implementation of the gic.

I'm fine with this change, but would like to know what the rationale
behind it is; wouldn't guests always initialize this value?

> +	else
> +		vgic_v3->vgic_sre = 0;
>  
>  	/* Get the show on the road... */
>  	vgic_v3->vgic_hcr = ICH_HCR_EN;
> @@ -215,28 +240,30 @@ int vgic_v3_probe(struct device_node *vgic_node,
>  
>  	gicv_idx += 3; /* Also skip GICD, GICC, GICH */
>  	if (of_address_to_resource(vgic_node, gicv_idx, &vcpu_res)) {
> -		kvm_err("Cannot obtain GICV region\n");
> -		ret = -ENXIO;
> -		goto out;
> -	}
> -
> -	if (!PAGE_ALIGNED(vcpu_res.start)) {
> -		kvm_err("GICV physical address 0x%llx not page aligned\n",
> -			(unsigned long long)vcpu_res.start);
> -		ret = -ENXIO;
> -		goto out;
> -	}
> -
> -	if (!PAGE_ALIGNED(resource_size(&vcpu_res))) {
> -		kvm_err("GICV size 0x%llx not a multiple of page size 0x%lx\n",
> -			(unsigned long long)resource_size(&vcpu_res),
> -			PAGE_SIZE);
> -		ret = -ENXIO;
> -		goto out;
> +		kvm_info("GICv3: GICv2 emulation not available\n");
> +		vgic->vcpu_base = 0;
> +	} else {
> +		if (!PAGE_ALIGNED(vcpu_res.start)) {
> +			kvm_err("GICV physical address 0x%llx not page aligned\n",
> +				(unsigned long long)vcpu_res.start);
> +			ret = -ENXIO;
> +			goto out;

shouldn't we be allowing an emulated gicv3 using the system registers in
this case then?

> +		}
> +
> +		if (!PAGE_ALIGNED(resource_size(&vcpu_res))) {
> +			kvm_err("GICV size 0x%llx not a multiple of page size 0x%lx\n",
> +				(unsigned long long)resource_size(&vcpu_res),
> +				PAGE_SIZE);
> +			ret = -ENXIO;
> +			goto out;

ditto?

> +		}
> +
> +		vgic->vcpu_base = vcpu_res.start;
> +		kvm_register_device_ops(&kvm_arm_vgic_v2_ops,
> +					KVM_DEV_TYPE_ARM_VGIC_V2);
>  	}
> -	kvm_register_device_ops(&kvm_arm_vgic_v2_ops, KVM_DEV_TYPE_ARM_VGIC_V2);
> +	kvm_register_device_ops(&kvm_arm_vgic_v3_ops, KVM_DEV_TYPE_ARM_VGIC_V3);
>  
> -	vgic->vcpu_base = vcpu_res.start;
>  	vgic->vctrl_base = NULL;
>  	vgic->type = VGIC_V3;
>  	vgic->max_hw_vcpus = KVM_MAX_VCPUS;
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index b7de0f8..1dbaeb5 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -1577,6 +1577,11 @@ static int init_vgic_model(struct kvm *kvm, int type)
>  	case KVM_DEV_TYPE_ARM_VGIC_V2:
>  		ret = vgic_v2_init_emulation(kvm);
>  		break;
> +#ifdef CONFIG_ARM_GIC_V3
> +	case KVM_DEV_TYPE_ARM_VGIC_V3:
> +		ret = vgic_v3_init_emulation(kvm);
> +		break;
> +#endif
>  	default:
>  		ret = -ENODEV;
>  		break;
> -- 
> 1.7.9.5
> 

Thanks,
-Christoffer
