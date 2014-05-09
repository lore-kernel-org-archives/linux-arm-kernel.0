From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 9 May 2014 16:06:11 +0200
Subject: [PATCH v3 08/19] KVM: ARM: vgic: abstract EISR bitmap access
In-Reply-To: <1397655591-2761-9-git-send-email-marc.zyngier@arm.com>
References: <1397655591-2761-1-git-send-email-marc.zyngier@arm.com>
 <1397655591-2761-9-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140509140611.GI3362@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 02:39:40PM +0100, Marc Zyngier wrote:
> Move the GICH_EISR access to its own function.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  include/kvm/arm_vgic.h |  1 +
>  virt/kvm/arm/vgic.c    | 16 +++++++++++++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> index 01013ec..5dbc8ee 100644
> --- a/include/kvm/arm_vgic.h
> +++ b/include/kvm/arm_vgic.h
> @@ -85,6 +85,7 @@ struct vgic_ops {
>  	struct vgic_lr	(*get_lr)(const struct kvm_vcpu *, int);
>  	void	(*set_lr)(struct kvm_vcpu *, int, struct vgic_lr);
>  	u64	(*get_elrsr)(const struct kvm_vcpu *vcpu);
> +	u64	(*get_eisr)(const struct kvm_vcpu *vcpu);
>  };
>  
>  struct vgic_dist {
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index 04206a8..896359f 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -1028,10 +1028,17 @@ static u64 vgic_v2_get_elrsr(const struct kvm_vcpu *vcpu)
>  	return *(u64 *)elrsr;
>  }
>  
> +static u64 vgic_v2_get_eisr(const struct kvm_vcpu *vcpu)
> +{
> +	const u32 *eisr = vcpu->arch.vgic_cpu.vgic_v2.vgic_eisr;
> +	return *(u64 *)eisr;
> +}
> +
>  static const struct vgic_ops vgic_ops = {
>  	.get_lr			= vgic_v2_get_lr,
>  	.set_lr			= vgic_v2_set_lr,
>  	.get_elrsr		= vgic_v2_get_elrsr,
> +	.get_eisr		= vgic_v2_get_eisr,
>  };
>  
>  static inline struct vgic_lr vgic_get_lr(const struct kvm_vcpu *vcpu, int lr)
> @@ -1050,6 +1057,11 @@ static inline u64 vgic_get_elrsr(struct kvm_vcpu *vcpu)
>  	return vgic_ops.get_elrsr(vcpu);
>  }
>  
> +static inline u64 vgic_get_eisr(struct kvm_vcpu *vcpu)
> +{
> +	return vgic_ops.get_eisr(vcpu);
> +}
> +
>  static void vgic_retire_lr(int lr_nr, int irq, struct kvm_vcpu *vcpu)
>  {
>  	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
> @@ -1256,9 +1268,11 @@ static bool vgic_process_maintenance(struct kvm_vcpu *vcpu)
>  		 * Some level interrupts have been EOIed. Clear their
>  		 * active bit.
>  		 */
> +		u64 eisr = vgic_get_eisr(vcpu);
> +		unsigned long *eisr_ptr = (unsigned long *)&eisr;
>  		int lr;
>  
> -		for_each_set_bit(lr, (unsigned long *)vgic_cpu->vgic_v2.vgic_eisr,
> +		for_each_set_bit(lr, eisr_ptr, vgic_cpu->nr_lr) {
>  				 vgic_cpu->nr_lr) {

looks like you missed a line here.

>  			struct vgic_lr vlr = vgic_get_lr(vcpu, lr);
>  
> -- 
> 1.8.3.4
> 

Otherwise,

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
