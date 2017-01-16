From: mbrugger@suse.com (Matthias Brugger)
Date: Mon, 16 Jan 2017 20:27:38 +0100
Subject: [PATCH v7 06/15] irqchip: gicv3-its: platform-msi: refactor
 its_pmsi_init() to prepare for ACPI
In-Reply-To: <1484147199-4267-7-git-send-email-hanjun.guo@linaro.org>
References: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
 <1484147199-4267-7-git-send-email-hanjun.guo@linaro.org>
Message-ID: <d8474597-40e4-3cde-9326-ec8e6bf728ba@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/01/17 16:06, Hanjun Guo wrote:
> Introduce its_pmsi_init_one() to refactor the code to isolate
> ACPI&DT common code to prepare for ACPI later.
>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/irqchip/irq-gic-v3-its-platform-msi.c | 45 ++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 18 deletions(-)
>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
> index 3c94278..3d9efd1 100644
> --- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
> +++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
> @@ -82,34 +82,43 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
>  	{},
>  };
>
> -static int __init its_pmsi_init(void)
> +static int __init its_pmsi_init_one(struct fwnode_handle *fwnode,
> +				const char *name)
>  {
> -	struct device_node *np;
>  	struct irq_domain *parent;
>
> +	parent = irq_find_matching_fwnode(fwnode, DOMAIN_BUS_NEXUS);
> +	if (!parent || !msi_get_domain_info(parent)) {
> +		pr_err("%s: unable to locate ITS domain\n", name);
> +		return -ENXIO;
> +	}
> +
> +	if (!platform_msi_create_irq_domain(fwnode, &its_pmsi_domain_info,
> +					    parent)) {
> +		pr_err("%s: unable to create platform domain\n", name);
> +		return -ENXIO;
> +	}
> +
> +	pr_info("Platform MSI: %s domain created\n", name);
> +	return 0;
> +}
> +
> +static void __init its_pmsi_of_init(void)
> +{
> +	struct device_node *np;
> +
>  	for (np = of_find_matching_node(NULL, its_device_id); np;
>  	     np = of_find_matching_node(np, its_device_id)) {
>  		if (!of_property_read_bool(np, "msi-controller"))
>  			continue;
>
> -		parent = irq_find_matching_host(np, DOMAIN_BUS_NEXUS);
> -		if (!parent || !msi_get_domain_info(parent)) {
> -			pr_err("%s: unable to locate ITS domain\n",
> -			       np->full_name);
> -			continue;
> -		}
> -
> -		if (!platform_msi_create_irq_domain(of_node_to_fwnode(np),
> -						    &its_pmsi_domain_info,
> -						    parent)) {
> -			pr_err("%s: unable to create platform domain\n",
> -			       np->full_name);
> -			continue;
> -		}
> -
> -		pr_info("Platform MSI: %s domain created\n", np->full_name);
> +		its_pmsi_init_one(of_node_to_fwnode(np), np->full_name);
>  	}
> +}
>
> +static int __init its_pmsi_init(void)
> +{
> +	its_pmsi_of_init();
>  	return 0;
>  }
>  early_initcall(its_pmsi_init);
>
