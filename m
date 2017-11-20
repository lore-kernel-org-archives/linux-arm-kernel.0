From: cdall@linaro.org (Christoffer Dall)
Date: Mon, 20 Nov 2017 15:49:57 +0100
Subject: [PATCH 1/7] KVM: arm/arm64: vgic-irqfd: Fix MSI entry allocation
In-Reply-To: <20171116175821.26544-2-marc.zyngier@arm.com>
References: <20171116175821.26544-1-marc.zyngier@arm.com>
 <20171116175821.26544-2-marc.zyngier@arm.com>
Message-ID: <20171120144957.GJ28855@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 16, 2017 at 05:58:15PM +0000, Marc Zyngier wrote:
> Using the size of the structure we're allocating is a good idea
> and avoids any surprise... In this case, we're happilly confusing
> kvm_kernel_irq_routing_entry and kvm_irq_routing_entry...

Yikes.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

> 
> Fixes: 95b110ab9a09 ("KVM: arm/arm64: Enable irqchip routing")
> Cc: stable at vger.kernel.org # 4.8
> Reported-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  virt/kvm/arm/vgic/vgic-irqfd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-irqfd.c b/virt/kvm/arm/vgic/vgic-irqfd.c
> index b7baf581611a..99e026d2dade 100644
> --- a/virt/kvm/arm/vgic/vgic-irqfd.c
> +++ b/virt/kvm/arm/vgic/vgic-irqfd.c
> @@ -112,8 +112,7 @@ int kvm_vgic_setup_default_irq_routing(struct kvm *kvm)
>  	u32 nr = dist->nr_spis;
>  	int i, ret;
>  
> -	entries = kcalloc(nr, sizeof(struct kvm_kernel_irq_routing_entry),
> -			  GFP_KERNEL);
> +	entries = kcalloc(nr, sizeof(*entries), GFP_KERNEL);
>  	if (!entries)
>  		return -ENOMEM;
>  
> -- 
> 2.14.2
> 
