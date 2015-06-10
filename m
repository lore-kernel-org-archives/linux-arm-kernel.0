From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 10 Jun 2015 18:23:47 +0100
Subject: [PATCH 03/10] KVM: arm/arm64: vgic: Convert struct vgic_lr to
 use bitfields
In-Reply-To: <1433783045-8002-4-git-send-email-marc.zyngier@arm.com>
References: <1433783045-8002-1-git-send-email-marc.zyngier@arm.com>
 <1433783045-8002-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <557872A3.8070302@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 06/08/2015 06:03 PM, Marc Zyngier wrote:
> As we're about to cram more information in the vgic_lr structure
> (HW interrupt number and additional state information), we switch
> to a layout similar to the HW's:
> 
> - use bitfields to save space (we don't need more than 10 bits
>   to represent the irq numbers)

But that will not be true for LPIs later, right? Before that I was lucky
with the irq field being 16 bits wide ;-)
So can we increase that to be at least 14 bits (8192 LPI offset + 8192
LPIs) here? The structure would still fit in 32 bits, then.
I guess guests should get away with only supporting 8K of LPIs, but if
we map hardware LPIs to guest IRQs I guess we may exceed 14 bits here.
Not sure if we could extend this further for ARM64 only, as we have more
room there and also need it only here.

Cheers,
Andre.

> - source CPU and HW interrupt can share the same field, as
>   a SGI doesn't have a physical line.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  include/kvm/arm_vgic.h | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> index 133ea00..4f9fa1d 100644
> --- a/include/kvm/arm_vgic.h
> +++ b/include/kvm/arm_vgic.h
> @@ -95,11 +95,15 @@ enum vgic_type {
>  #define LR_STATE_ACTIVE		(1 << 1)
>  #define LR_STATE_MASK		(3 << 0)
>  #define LR_EOI_INT		(1 << 2)
> +#define LR_HW			(1 << 3)
>  
>  struct vgic_lr {
> -	u16	irq;
> -	u8	source;
> -	u8	state;
> +	unsigned irq:10;
> +	union {
> +		unsigned hwirq:10;
> +		unsigned source:8;
> +	};
> +	unsigned state:4;
>  };
>  
>  struct vgic_vmcr {
> 
