From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 23 May 2016 16:19:37 +0200
Subject: [PATCH 3/7] KVM: arm/arm64: vgic-v2: Always resample level
 interrupts
In-Reply-To: <1464007023-11736-4-git-send-email-marc.zyngier@arm.com>
References: <1464007023-11736-1-git-send-email-marc.zyngier@arm.com>
 <1464007023-11736-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160523141937.GA9625@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 23, 2016 at 01:36:59PM +0100, Marc Zyngier wrote:
> When reading back from the list registers, we need to perform
> two actions for level interrupts:
> 1) clear the soft-pending bit if the interrupt is not pending
>    anymore *in the list register*
> 2) resample the line level and propagate it to the pending state
> 
> But these two actions linked, and we should *always* resample

were linked?

> the line level, no matter what state is in the list register.
> Otherwise, we may end-up injecting spurious interrupts that
> have been already retired.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  virt/kvm/arm/vgic/vgic-v2.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-v2.c b/virt/kvm/arm/vgic/vgic-v2.c
> index 8ad42c2..f659af0 100644
> --- a/virt/kvm/arm/vgic/vgic-v2.c
> +++ b/virt/kvm/arm/vgic/vgic-v2.c
> @@ -112,10 +112,13 @@ void vgic_v2_fold_lr_state(struct kvm_vcpu *vcpu)
>  			}
>  		}
>  
> -		/* Clear soft pending state when level IRQs have been acked */
> -		if (irq->config == VGIC_CONFIG_LEVEL &&
> -		    !(val & GICH_LR_PENDING_BIT)) {
> -			irq->soft_pending = false;
> +		/*
> +		 * Clear soft pending state when level irqs have been acked.
> +		 * Always resample the line level.
> +		 */
> +		if (irq->config == VGIC_CONFIG_LEVEL) {
> +			if (!(val & GICH_LR_PENDING_BIT))
> +				irq->soft_pending = false;
>  			irq->pending = irq->line_level;

shouldn't this context line then be:
	irq->pending = irq->line_level || irq->soft_pending;  ??

Thanks,
-Christoffer
