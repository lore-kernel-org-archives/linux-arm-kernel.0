From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 9 May 2014 16:06:25 +0200
Subject: [PATCH v3 10/19] KVM: ARM: vgic: move underflow handling to
 vgic_ops
In-Reply-To: <1397655591-2761-11-git-send-email-marc.zyngier@arm.com>
References: <1397655591-2761-1-git-send-email-marc.zyngier@arm.com>
 <1397655591-2761-11-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140509140625.GK3362@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 02:39:42PM +0100, Marc Zyngier wrote:
> Move the code dealing with LR underflow handling to its own functions,
> and make them accessible through vgic_ops.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  include/kvm/arm_vgic.h |  2 ++
>  virt/kvm/arm/vgic.c    | 28 +++++++++++++++++++++++++---
>  2 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> index 98208e0..831b9f5 100644
> --- a/include/kvm/arm_vgic.h
> +++ b/include/kvm/arm_vgic.h
> @@ -87,6 +87,8 @@ struct vgic_ops {
>  	u64	(*get_elrsr)(const struct kvm_vcpu *vcpu);
>  	u64	(*get_eisr)(const struct kvm_vcpu *vcpu);
>  	u32	(*get_interrupt_status)(const struct kvm_vcpu *vcpu);
> +	void	(*set_underflow)(struct kvm_vcpu *vcpu);
> +	void	(*clear_underflow)(struct kvm_vcpu *vcpu);
>  };
>  
>  struct vgic_dist {
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index 9e100f6..13dad1f 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -1047,12 +1047,24 @@ static u32 vgic_v2_get_interrupt_status(const struct kvm_vcpu *vcpu)
>  	return ret;
>  }
>  
> +static void vgic_v2_set_underflow(struct kvm_vcpu *vcpu)
> +{
> +	vcpu->arch.vgic_cpu.vgic_v2.vgic_hcr |= GICH_HCR_UIE;
> +}
> +
> +static void vgic_v2_clear_underflow(struct kvm_vcpu *vcpu)
> +{
> +	vcpu->arch.vgic_cpu.vgic_v2.vgic_hcr &= ~GICH_HCR_UIE;
> +}
> +
>  static const struct vgic_ops vgic_ops = {
>  	.get_lr			= vgic_v2_get_lr,
>  	.set_lr			= vgic_v2_set_lr,
>  	.get_elrsr		= vgic_v2_get_elrsr,
>  	.get_eisr		= vgic_v2_get_eisr,
>  	.get_interrupt_status	= vgic_v2_get_interrupt_status,
> +	.set_underflow		= vgic_v2_set_underflow,
> +	.clear_underflow	= vgic_v2_clear_underflow,

hmm, not crazy about the naming, we're not setting/clearing underflow
status but enabling/disabling underflow interrupts...

Perhaps vgic_v2_enable_underflow_int ?  Too long?

>  };
>  
>  static inline struct vgic_lr vgic_get_lr(const struct kvm_vcpu *vcpu, int lr)
> @@ -1081,6 +1093,16 @@ static inline u32 vgic_get_interrupt_status(struct kvm_vcpu *vcpu)
>  	return vgic_ops.get_interrupt_status(vcpu);
>  }
>  
> +static inline void vgic_set_underflow(struct kvm_vcpu *vcpu)
> +{
> +	vgic_ops.set_underflow(vcpu);
> +}
> +
> +static inline void vgic_clear_underflow(struct kvm_vcpu *vcpu)
> +{
> +	vgic_ops.clear_underflow(vcpu);
> +}
> +
>  static void vgic_retire_lr(int lr_nr, int irq, struct kvm_vcpu *vcpu)
>  {
>  	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
> @@ -1262,9 +1284,9 @@ static void __kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu)
>  
>  epilog:
>  	if (overflow) {
> -		vgic_cpu->vgic_v2.vgic_hcr |= GICH_HCR_UIE;
> +		vgic_set_underflow(vcpu);
>  	} else {
> -		vgic_cpu->vgic_v2.vgic_hcr &= ~GICH_HCR_UIE;
> +		vgic_clear_underflow(vcpu);
>  		/*
>  		 * We're about to run this VCPU, and we've consumed
>  		 * everything the distributor had in store for
> @@ -1311,7 +1333,7 @@ static bool vgic_process_maintenance(struct kvm_vcpu *vcpu)
>  	}
>  
>  	if (status & INT_STATUS_UNDERFLOW)
> -		vgic_cpu->vgic_v2.vgic_hcr &= ~GICH_HCR_UIE;
> +		vgic_clear_underflow(vcpu);
>  
>  	return level_pending;
>  }
> -- 
> 1.8.3.4
> 

Otherwise,

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
