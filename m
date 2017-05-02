From: cdall@linaro.org (Christoffer Dall)
Date: Tue, 2 May 2017 22:56:45 +0200
Subject: [PATCH 4/5] KVM: arm/arm64: vgic-v3: Do not use Active+Pending
 state for a HW interrupt
In-Reply-To: <20170502133041.10980-5-marc.zyngier@arm.com>
References: <20170502133041.10980-1-marc.zyngier@arm.com>
 <20170502133041.10980-5-marc.zyngier@arm.com>
Message-ID: <20170502205645.GB4421@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 02, 2017 at 02:30:40PM +0100, Marc Zyngier wrote:
> When an interrupt is injected with the HW bit set (indicating that
> deactivation should be propagated to the physical distributor),
> special care must be taken so that we never mark the corresponding
> LR with the Active+Pending state (as the pending state is kept in
> the physycal distributor).
> 
> Cc: stable at vger.kernel.org
> Fixes: 59529f69f504 ("KVM: arm/arm64: vgic-new: Add GICv3 world switch backend")
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <cdall@linaro.org>

> ---
>  virt/kvm/arm/vgic/vgic-v3.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
> index df1503650300..393779ebe87c 100644
> --- a/virt/kvm/arm/vgic/vgic-v3.c
> +++ b/virt/kvm/arm/vgic/vgic-v3.c
> @@ -127,6 +127,13 @@ void vgic_v3_populate_lr(struct kvm_vcpu *vcpu, struct vgic_irq *irq, int lr)
>  	if (irq->hw) {
>  		val |= ICH_LR_HW;
>  		val |= ((u64)irq->hwintid) << ICH_LR_PHYS_ID_SHIFT;
> +		/*
> +		 * Never set pending+active on a HW interrupt, as the
> +		 * pending state is kept at the physical distributor
> +		 * level.
> +		 */
> +		if (irq->active && irq_is_pending(irq))
> +			val &= ~ICH_LR_PENDING_BIT;
>  	} else {
>  		if (irq->config == VGIC_CONFIG_LEVEL)
>  			val |= ICH_LR_EOI;
> -- 
> 2.11.0
> 
