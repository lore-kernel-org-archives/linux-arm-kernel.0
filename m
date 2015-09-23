From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 23 Sep 2015 18:01:00 +0100
Subject: [PATCH v2 3/3] irqchip/gicv3-its:  Handle OF device tree
 "msi-map" properties.
In-Reply-To: <1442966406-13198-4-git-send-email-ddaney.cavm@gmail.com>
References: <1442966406-13198-1-git-send-email-ddaney.cavm@gmail.com>
 <1442966406-13198-4-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20150923180100.03844936@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Sep 2015 17:00:06 -0700
David Daney <ddaney.cavm@gmail.com> wrote:

> From: David Daney <david.daney@cavium.com>
> 
> Call of_msi_map_rid() to handle mapping of the requester id.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  drivers/irqchip/irq-gic-v3-its-pci-msi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
> index cf351c6..8b1c938 100644
> --- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
> +++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
> @@ -86,7 +86,8 @@ static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
>  	pci_for_each_dma_alias(pdev, its_get_pci_alias, &dev_alias);
>  
>  	/* ITS specific DeviceID, as the core ITS ignores dev. */
> -	info->scratchpad[0].ul = dev_alias.dev_id;
> +	info->scratchpad[0].ul = of_msi_map_rid(dev, domain->of_node,
> +						dev_alias.dev_id);
>  
>  	return msi_info->ops->msi_prepare(domain->parent,
>  					  dev, dev_alias.count, info);

I really wonder if that shouldn't be part of the pci_for_each_dma_alias
call. It would make a lot more sense for this functionality to be an
integral part of the core code, and would probably make the integration
of _IORT (which has the exact same requirements) a bit easier.

Thoughts?

	M.
-- 
Jazz is not dead. It just smells funny.
