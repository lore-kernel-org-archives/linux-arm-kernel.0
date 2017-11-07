From: eric.auger@redhat.com (Auger Eric)
Date: Tue, 7 Nov 2017 21:28:55 +0100
Subject: [PATCH v5 12/26] KVM: arm/arm64: GICv4: Unmap VLPI when freeing
 an LPI
In-Reply-To: <20171027142855.21584-13-marc.zyngier@arm.com>
References: <20171027142855.21584-1-marc.zyngier@arm.com>
 <20171027142855.21584-13-marc.zyngier@arm.com>
Message-ID: <052a6676-c15a-6d91-da1e-660312c29f1b@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 27/10/2017 16:28, Marc Zyngier wrote:
> When freeing an LPI (on a DISCARD command, for example), we need
> to unmap the VLPI down to the physical ITS level.
> 
> Acked-by: Christoffer Dall <cdall@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  virt/kvm/arm/vgic/vgic-its.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
> index b2a678d131d0..c9b1c0967426 100644
> --- a/virt/kvm/arm/vgic/vgic-its.c
> +++ b/virt/kvm/arm/vgic/vgic-its.c
> @@ -628,8 +628,12 @@ static void its_free_ite(struct kvm *kvm, struct its_ite *ite)
>  	list_del(&ite->ite_list);
>  
>  	/* This put matches the get in vgic_add_lpi. */
> -	if (ite->irq)
> +	if (ite->irq) {
> +		if (ite->irq->hw)
> +			WARN_ON(its_unmap_vlpi(ite->irq->host_irq));
> +
>  		vgic_put_irq(kvm, ite->irq);
You could have put the its_unmap_vlpi() directly in vgic_put_irq which
is meant to decr the ref/release the LPI irq.

Thanks

Eric
> +	}
>  
>  	kfree(ite);
>  }
> 
