From: eric.auger@redhat.com (Auger Eric)
Date: Thu, 16 Mar 2017 10:18:38 +0100
Subject: [RFC PATCH 20/33] irqchip/gic-v3-its: Add VPE domain
 infrastructure
In-Reply-To: <1484648454-21216-21-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-21-git-send-email-marc.zyngier@arm.com>
Message-ID: <ce962630-8c60-abd8-dfc8-6ad4186523ab@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 17/01/2017 11:20, Marc Zyngier wrote:
> Add the basic GICv4 VPE (vcpu in GICv4 parlance) infrastructure
> (irqchip, irq domain) that is going to be populated in the following
> patches.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

> ---
>  drivers/irqchip/irq-gic-v3-its.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 6931018..ddd8096 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1918,6 +1918,13 @@ static const struct irq_domain_ops its_domain_ops = {
>  	.deactivate		= its_irq_domain_deactivate,
>  };
>  
> +static struct irq_chip its_vpe_irq_chip = {
> +	.name			= "GICv4-vpe",
> +};
> +
> +static const struct irq_domain_ops its_vpe_domain_ops = {
> +};
> +
>  static int its_force_quiescent(void __iomem *base)
>  {
>  	u32 count = 1000000;	/* 1s */
> @@ -2017,6 +2024,27 @@ static int its_init_domain(struct fwnode_handle *handle, struct its_node *its)
>  	return 0;
>  }
>  
> +static struct irq_domain *its_init_vpe_domain(void)
> +{
> +	struct fwnode_handle *handle;
> +	struct irq_domain *domain;
> +
> +	handle = irq_domain_alloc_fwnode("VPE domain");
> +	if (!handle)
> +		return NULL;
> +
> +	domain = irq_domain_create_tree(handle, &its_vpe_domain_ops, NULL);
> +	if (!domain) {
> +		kfree(handle);
> +		return NULL;
> +	}
> +
> +	domain->parent = its_parent;
> +	domain->bus_token = DOMAIN_BUS_NEXUS;
> +
> +	return domain;
> +}
> +
>  static int __init its_probe_one(struct resource *res,
>  				struct fwnode_handle *handle, int numa_node)
>  {
> @@ -2266,6 +2294,8 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
>  		    struct irq_domain *parent_domain)
>  {
>  	struct device_node *of_node;
> +	struct its_node *its;
> +	bool has_v4 = false;
>  
>  	its_parent = parent_domain;
>  	of_node = to_of_node(handle);
> @@ -2283,5 +2313,11 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
>  	its_alloc_lpi_tables();
>  	its_lpi_init(rdists->id_bits);
>  
> +	list_for_each_entry(its, &its_nodes, entry)
> +		has_v4 |= its->is_v4;
> +
> +	if (has_v4 & rdists->has_vlpis)
> +		its_init_vpe_domain();
> +
>  	return 0;
>  }
> 
