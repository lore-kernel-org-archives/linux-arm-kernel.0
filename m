From: eric.auger@redhat.com (Auger Eric)
Date: Wed, 22 Feb 2017 17:52:03 +0100
Subject: [PATCH] KVM: arm/arm64: vgic-v3: Don't pretend to support IRQ/FIQ
 bypass
In-Reply-To: <20170222121348.3138-1-marc.zyngier@arm.com>
References: <20170222121348.3138-1-marc.zyngier@arm.com>
Message-ID: <0aaafedb-2f0c-c99c-3c7d-8c6e540df93d@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 22/02/2017 13:13, Marc Zyngier wrote:
> Our GICv3 emulation always presents ICC_SRE_EL1 with DIB/DFB set to
> zero, which implies that there is a way to bypass the GIC and
> inject raw IRQ/FIQ by driving the CPU pins.
> 
> Of course, we don't allow that when the GIC is configured, but
> we fail to indicate that to the guest. The obvious fix is to
> set these bits (and never let them being changed again).
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

> ---
>  include/linux/irqchip/arm-gic-v3.h | 2 ++
>  virt/kvm/arm/vgic/vgic-v3.c        | 5 ++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
> index e808f8ae6f14..0a8bad331341 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -354,6 +354,8 @@
>   */
>  #define ICC_CTLR_EL1_EOImode_drop_dir	(0U << 1)
>  #define ICC_CTLR_EL1_EOImode_drop	(1U << 1)
> +#define ICC_SRE_EL1_DIB			(1U << 2)
> +#define ICC_SRE_EL1_DFB			(1U << 1)
>  #define ICC_SRE_EL1_SRE			(1U << 0)
>  
>  /*
> diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
> index e6b03fd8c374..d062256131fc 100644
> --- a/virt/kvm/arm/vgic/vgic-v3.c
> +++ b/virt/kvm/arm/vgic/vgic-v3.c
> @@ -215,10 +215,13 @@ void vgic_v3_enable(struct kvm_vcpu *vcpu)
>  	/*
>  	 * If we are emulating a GICv3, we do it in an non-GICv2-compatible
>  	 * way, so we force SRE to 1 to demonstrate this to the guest.
> +	 * Also, we don't support any form of IRQ/FIQ bypass.
>  	 * This goes with the spec allowing the value to be RAO/WI.
>  	 */
>  	if (vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3) {
> -		vgic_v3->vgic_sre = ICC_SRE_EL1_SRE;
> +		vgic_v3->vgic_sre = (ICC_SRE_EL1_DIB |
> +				     ICC_SRE_EL1_DFB |
> +				     ICC_SRE_EL1_SRE);
>  		vcpu->arch.vgic_cpu.pendbaser = INITIAL_PENDBASER_VALUE;
>  	} else {
>  		vgic_v3->vgic_sre = 0;
> 
