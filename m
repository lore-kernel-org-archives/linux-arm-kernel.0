From: cdall@linaro.org (Christoffer Dall)
Date: Mon, 28 Aug 2017 20:18:08 +0200
Subject: [PATCH v3 43/59] KVM: arm/arm64: GICv4: Unmap VLPI when freeing
 an LPI
In-Reply-To: <20170731172637.29355-44-marc.zyngier@arm.com>
References: <20170731172637.29355-1-marc.zyngier@arm.com>
 <20170731172637.29355-44-marc.zyngier@arm.com>
Message-ID: <20170828181808.GC24649@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 06:26:21PM +0100, Marc Zyngier wrote:
> When freeing an LPI (on a DISCARD command, for example), we need
> to unmap the VLPI down to the physical ITS level.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  virt/kvm/arm/vgic/vgic-its.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
> index 40aeadef33fe..79bac93d3e7d 100644
> --- a/virt/kvm/arm/vgic/vgic-its.c
> +++ b/virt/kvm/arm/vgic/vgic-its.c
> @@ -623,8 +623,12 @@ static void its_free_ite(struct kvm *kvm, struct its_ite *ite)
>  	list_del(&ite->ite_list);
>  
>  	/* This put matches the get in vgic_add_lpi. */
> -	if (ite->irq)
> +	if (ite->irq) {
> +		if (ite->irq->hw)
> +			its_unmap_vlpi(ite->irq->host_irq);

nit: should we raise a warning on a bad return value?

Otherwise:

Acked-by: Christoffer Dall <cdall@linaro.org>

> +
>  		vgic_put_irq(kvm, ite->irq);
> +	}
>  
>  	kfree(ite);
>  }
> -- 
> 2.11.0
> 
