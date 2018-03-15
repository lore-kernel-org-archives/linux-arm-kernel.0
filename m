From: eric.auger@redhat.com (Auger Eric)
Date: Thu, 15 Mar 2018 10:31:32 +0100
Subject: [PATCH] KVM: arm/arm64: vgic: Disallow Active+Pending for level
 interrupts
In-Reply-To: <20180314183744.30889-1-marc.zyngier@arm.com>
References: <20180314183744.30889-1-marc.zyngier@arm.com>
Message-ID: <c0ac2636-4143-98d3-5eb3-1e9098d0e056@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,
On 14/03/18 19:37, Marc Zyngier wrote:
> It was recently reported that VFIO mediated devices, and anything
> that VFIO exposes as level interrupts, do no strictly follow the
> expected logic of such interrupts as it only lowers the input
> line when the guest has EOId the interrupt at the GIC level, rather
> than when it Acked the interrupt at the device level.
> 
> THe GIC's Active+Pending state is fundamentally incompatible with
> this behaviour, as it prevents KVM from observing the EOI, and in
> turn results in VFIO never dropping the line. This results in an
> interrupt storm in the guest, which it really never expected.
> 
> As we cannot really change VFIO to follow the strict rules of level
> signalling, let's forbid the A+P state altogether, as it is in the
> end only an optimization. It ensures that we will transition via
> an invalid state, which we can use to notify VFIO of the EOI.
> 
> Reported-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
> Tested-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  virt/kvm/arm/vgic/vgic-v2.c | 47 +++++++++++++++++++++++++++------------------
>  virt/kvm/arm/vgic/vgic-v3.c | 47 +++++++++++++++++++++++++++------------------
>  2 files changed, 56 insertions(+), 38 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-v2.c b/virt/kvm/arm/vgic/vgic-v2.c
> index 29556f71b691..9356d749da1d 100644
> --- a/virt/kvm/arm/vgic/vgic-v2.c
> +++ b/virt/kvm/arm/vgic/vgic-v2.c
> @@ -153,8 +153,35 @@ void vgic_v2_fold_lr_state(struct kvm_vcpu *vcpu)
>  void vgic_v2_populate_lr(struct kvm_vcpu *vcpu, struct vgic_irq *irq, int lr)
>  {
>  	u32 val = irq->intid;
> +	bool allow_pending = true;
>  
> -	if (irq_is_pending(irq)) {
> +	if (irq->active)
> +		val |= GICH_LR_ACTIVE_BIT;
> +
> +	if (irq->hw) {
> +		val |= GICH_LR_HW;
> +		val |= irq->hwintid << GICH_LR_PHYSID_CPUID_SHIFT;
> +		/*
> +		 * Never set pending+active on a HW interrupt, as the
> +		 * pending state is kept at the physical distributor
> +		 * level.
> +		 */
> +		if (irq->active)
> +			allow_pending = false;
> +	} else {
> +		if (irq->config == VGIC_CONFIG_LEVEL) {
> +			val |= GICH_LR_EOI;
> +
> +			/*
> +			 * Software resampling doesn't work very well
> +			 * if we allow P+A, so let's not do that.
> +			 */
> +			if (irq->active)
> +				allow_pending = false;
> +		}
> +	}
> +
> +	if (allow_pending && irq_is_pending(irq)) {
>  		val |= GICH_LR_PENDING_BIT;
Can't we have this no luck unlikely scenario where soft_pending and LR
state A on flush? In such case, on fold we are going to reset the
pending_latch as we considered disappearance of LR P meant the
soft_pending was acked. But P now is no more logged in LR concurrently
with A.

Thanks

Eric
>  
>  		if (irq->config == VGIC_CONFIG_EDGE)
> @@ -171,24 +198,6 @@ void vgic_v2_populate_lr(struct kvm_vcpu *vcpu, struct vgic_irq *irq, int lr)
>  		}
>  	}
>  
> -	if (irq->active)
> -		val |= GICH_LR_ACTIVE_BIT;
> -
> -	if (irq->hw) {
> -		val |= GICH_LR_HW;
> -		val |= irq->hwintid << GICH_LR_PHYSID_CPUID_SHIFT;
> -		/*
> -		 * Never set pending+active on a HW interrupt, as the
> -		 * pending state is kept at the physical distributor
> -		 * level.
> -		 */
> -		if (irq->active && irq_is_pending(irq))
> -			val &= ~GICH_LR_PENDING_BIT;
> -	} else {
> -		if (irq->config == VGIC_CONFIG_LEVEL)
> -			val |= GICH_LR_EOI;
> -	}
> -
>  	/*
>  	 * Level-triggered mapped IRQs are special because we only observe
>  	 * rising edges as input to the VGIC.  We therefore lower the line
> diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
> index 0ff2006f3781..6b484575cafb 100644
> --- a/virt/kvm/arm/vgic/vgic-v3.c
> +++ b/virt/kvm/arm/vgic/vgic-v3.c
> @@ -135,8 +135,35 @@ void vgic_v3_populate_lr(struct kvm_vcpu *vcpu, struct vgic_irq *irq, int lr)
>  {
>  	u32 model = vcpu->kvm->arch.vgic.vgic_model;
>  	u64 val = irq->intid;
> +	bool allow_pending = true;
>  
> -	if (irq_is_pending(irq)) {
> +	if (irq->active)
> +		val |= ICH_LR_ACTIVE_BIT;
> +
> +	if (irq->hw) {
> +		val |= ICH_LR_HW;
> +		val |= ((u64)irq->hwintid) << ICH_LR_PHYS_ID_SHIFT;
> +		/*
> +		 * Never set pending+active on a HW interrupt, as the
> +		 * pending state is kept at the physical distributor
> +		 * level.
> +		 */
> +		if (irq->active)
> +			allow_pending = false;
> +	} else {
> +		if (irq->config == VGIC_CONFIG_LEVEL) {
> +			val |= ICH_LR_EOI;
> +
> +			/*
> +			 * Software resampling doesn't work very well
> +			 * if we allow P+A, so let's not do that.
> +			 */
> +			if (irq->active)
> +				allow_pending = false;
> +		}
> +	}
> +
> +	if (allow_pending && irq_is_pending(irq)) {
>  		val |= ICH_LR_PENDING_BIT;
>  
>  		if (irq->config == VGIC_CONFIG_EDGE)
> @@ -154,24 +181,6 @@ void vgic_v3_populate_lr(struct kvm_vcpu *vcpu, struct vgic_irq *irq, int lr)
>  		}
>  	}
>  
> -	if (irq->active)
> -		val |= ICH_LR_ACTIVE_BIT;
> -
> -	if (irq->hw) {
> -		val |= ICH_LR_HW;
> -		val |= ((u64)irq->hwintid) << ICH_LR_PHYS_ID_SHIFT;
> -		/*
> -		 * Never set pending+active on a HW interrupt, as the
> -		 * pending state is kept at the physical distributor
> -		 * level.
> -		 */
> -		if (irq->active && irq_is_pending(irq))
> -			val &= ~ICH_LR_PENDING_BIT;
> -	} else {
> -		if (irq->config == VGIC_CONFIG_LEVEL)
> -			val |= ICH_LR_EOI;
> -	}
> -
>  	/*
>  	 * Level-triggered mapped IRQs are special because we only observe
>  	 * rising edges as input to the VGIC.  We therefore lower the line
> 
