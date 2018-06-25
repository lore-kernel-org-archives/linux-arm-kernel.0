From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 25 Jun 2018 11:00:59 +0100
Subject: [PATCH 3/4] KVM: arm/arm64: Signal IRQs using their configured
 group
In-Reply-To: <20180624221103.15055-4-christoffer.dall@arm.com>
References: <20180624221103.15055-1-christoffer.dall@arm.com>
 <20180624221103.15055-4-christoffer.dall@arm.com>
Message-ID: <89debd42-643e-959d-09ab-929c13284802@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 24/06/18 23:11, Christoffer Dall wrote:
> Now when we have a group configuration on the struct IRQ, use this state
> when populating the LR and signaling interrupts as either group 0 or
> group 1 to the VM.  Depending on the model of the emulated GIC, and the
> guest's configuration of the VMCR, interrupts may be signaled as IRQs or
> FIQs to the VM.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  include/linux/irqchip/arm-gic.h | 1 +
>  virt/kvm/arm/vgic/vgic-v2.c     | 3 +++
>  virt/kvm/arm/vgic/vgic-v3.c     | 6 +-----
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
> index 68d8b1f73682..3fa74b917a82 100644
> --- a/include/linux/irqchip/arm-gic.h
> +++ b/include/linux/irqchip/arm-gic.h
> @@ -94,6 +94,7 @@
>  #define GICH_LR_PENDING_BIT		(1 << 28)
>  #define GICH_LR_ACTIVE_BIT		(1 << 29)
>  #define GICH_LR_EOI			(1 << 19)
> +#define GICH_LR_GROUP1			(1 << 30)
>  #define GICH_LR_HW			(1 << 31)
>  
>  #define GICH_VMCR_ENABLE_GRP0_SHIFT	0
> diff --git a/virt/kvm/arm/vgic/vgic-v2.c b/virt/kvm/arm/vgic/vgic-v2.c
> index a5f2e44f1c33..df5e6a6e3186 100644
> --- a/virt/kvm/arm/vgic/vgic-v2.c
> +++ b/virt/kvm/arm/vgic/vgic-v2.c
> @@ -159,6 +159,9 @@ void vgic_v2_populate_lr(struct kvm_vcpu *vcpu, struct vgic_irq *irq, int lr)
>  		}
>  	}
>  
> +	if (irq->group)
> +		val |= GICH_LR_GROUP1;
> +
>  	if (irq->hw) {
>  		val |= GICH_LR_HW;
>  		val |= irq->hwintid << GICH_LR_PHYSID_CPUID_SHIFT;
> diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
> index ff7dc890941a..4f64228e4b3d 100644
> --- a/virt/kvm/arm/vgic/vgic-v3.c
> +++ b/virt/kvm/arm/vgic/vgic-v3.c
> @@ -197,11 +197,7 @@ void vgic_v3_populate_lr(struct kvm_vcpu *vcpu, struct vgic_irq *irq, int lr)
>  	if (vgic_irq_is_mapped_level(irq) && (val & ICH_LR_PENDING_BIT))
>  		irq->line_level = false;
>  
> -	/*
> -	 * We currently only support Group1 interrupts, which is a
> -	 * known defect. This needs to be addressed at some point.
> -	 */
> -	if (model == KVM_DEV_TYPE_ARM_VGIC_V3)
> +	if (irq->group)
>  		val |= ICH_LR_GROUP;
>  
>  	val |= (u64)irq->priority << ICH_LR_PRIORITY_SHIFT;
> 
