From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 9 May 2014 16:06:18 +0200
Subject: [PATCH v3 09/19] KVM: ARM: vgic: abstract MISR decoding
In-Reply-To: <1397655591-2761-10-git-send-email-marc.zyngier@arm.com>
References: <1397655591-2761-1-git-send-email-marc.zyngier@arm.com>
 <1397655591-2761-10-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140509140618.GJ3362@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 02:39:41PM +0100, Marc Zyngier wrote:
> Instead of directly dealing with the GICH_MISR bits, move the code to
> its own function and use a couple of public flags to represent the
> actual state.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  include/kvm/arm_vgic.h |  4 ++++
>  virt/kvm/arm/vgic.c    | 26 +++++++++++++++++++++++---
>  2 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> index 5dbc8ee..98208e0 100644
> --- a/include/kvm/arm_vgic.h
> +++ b/include/kvm/arm_vgic.h
> @@ -86,6 +86,7 @@ struct vgic_ops {
>  	void	(*set_lr)(struct kvm_vcpu *, int, struct vgic_lr);
>  	u64	(*get_elrsr)(const struct kvm_vcpu *vcpu);
>  	u64	(*get_eisr)(const struct kvm_vcpu *vcpu);
> +	u32	(*get_interrupt_status)(const struct kvm_vcpu *vcpu);
>  };
>  
>  struct vgic_dist {
> @@ -164,6 +165,9 @@ struct vgic_cpu {
>  
>  #define LR_EMPTY	0xff
>  
> +#define INT_STATUS_EOI		(1 << 0)
> +#define INT_STATUS_UNDERFLOW	(1 << 1)
> +
>  struct kvm;
>  struct kvm_vcpu;
>  struct kvm_run;
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index 896359f..9e100f6 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -1034,11 +1034,25 @@ static u64 vgic_v2_get_eisr(const struct kvm_vcpu *vcpu)
>  	return *(u64 *)eisr;
>  }
>  
> +static u32 vgic_v2_get_interrupt_status(const struct kvm_vcpu *vcpu)
> +{
> +	u32 misr = vcpu->arch.vgic_cpu.vgic_v2.vgic_misr;
> +	u32 ret = 0;
> +
> +	if (misr & GICH_MISR_EOI)
> +		ret |= INT_STATUS_EOI;
> +	if (misr & GICH_MISR_U)
> +		ret |= INT_STATUS_UNDERFLOW;
> +
> +	return ret;
> +}
> +
>  static const struct vgic_ops vgic_ops = {
>  	.get_lr			= vgic_v2_get_lr,
>  	.set_lr			= vgic_v2_set_lr,
>  	.get_elrsr		= vgic_v2_get_elrsr,
>  	.get_eisr		= vgic_v2_get_eisr,
> +	.get_interrupt_status	= vgic_v2_get_interrupt_status,
>  };
>  
>  static inline struct vgic_lr vgic_get_lr(const struct kvm_vcpu *vcpu, int lr)
> @@ -1062,6 +1076,11 @@ static inline u64 vgic_get_eisr(struct kvm_vcpu *vcpu)
>  	return vgic_ops.get_eisr(vcpu);
>  }
>  
> +static inline u32 vgic_get_interrupt_status(struct kvm_vcpu *vcpu)
> +{
> +	return vgic_ops.get_interrupt_status(vcpu);
> +}
> +
>  static void vgic_retire_lr(int lr_nr, int irq, struct kvm_vcpu *vcpu)
>  {
>  	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
> @@ -1259,11 +1278,12 @@ epilog:
>  static bool vgic_process_maintenance(struct kvm_vcpu *vcpu)
>  {
>  	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
> +	u32 status = vgic_get_interrupt_status(vcpu);
>  	bool level_pending = false;
>  
> -	kvm_debug("MISR = %08x\n", vgic_cpu->vgic_v2.vgic_misr);
> +	kvm_debug("STATUS = %08x\n", status);
>  
> -	if (vgic_cpu->vgic_v2.vgic_misr & GICH_MISR_EOI) {
> +	if (status & INT_STATUS_EOI) {
>  		/*
>  		 * Some level interrupts have been EOIed. Clear their
>  		 * active bit.
> @@ -1290,7 +1310,7 @@ static bool vgic_process_maintenance(struct kvm_vcpu *vcpu)
>  		}
>  	}
>  
> -	if (vgic_cpu->vgic_v2.vgic_misr & GICH_MISR_U)
> +	if (status & INT_STATUS_UNDERFLOW)
>  		vgic_cpu->vgic_v2.vgic_hcr &= ~GICH_HCR_UIE;
>  
>  	return level_pending;
> -- 
> 1.8.3.4
> 
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
