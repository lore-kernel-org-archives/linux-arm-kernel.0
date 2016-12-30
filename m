From: kong.kongxinwei@hisilicon.com (Xinwei Kong)
Date: Fri, 30 Dec 2016 16:57:37 +0800
Subject: [PATCH v5 06/14] irqchip: gicv3-its: platform-msi: refactor
 its_pmsi_init() to prepare for ACPI
In-Reply-To: <1482384922-21507-7-git-send-email-guohanjun@huawei.com>
References: <1482384922-21507-1-git-send-email-guohanjun@huawei.com>
 <1482384922-21507-7-git-send-email-guohanjun@huawei.com>
Message-ID: <58662181.2010409@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/12/22 13:35, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
>
> Introduce its_pmsi_init_one() to refactor the code to isolate
> ACPI&DT common code to prepare for ACPI later.
>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Sinan Kaya <okaya@codeaurora.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>   drivers/irqchip/irq-gic-v3-its-platform-msi.c | 45 ++++++++++++++++-----------
>   1 file changed, 27 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
> index 16587a9..ff72704 100644
> --- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
> +++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
> @@ -84,34 +84,43 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
>   	{},
>   };
>   
> -static int __init its_pmsi_init(void)
> +static int __init its_pmsi_init_one(struct fwnode_handle *fwnode,
> +				const char *name)
>   {
> -	struct device_node *np;
>   	struct irq_domain *parent;
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
>   	for (np = of_find_matching_node(NULL, its_device_id); np;
>   	     np = of_find_matching_node(np, its_device_id)) {
>   		if (!of_property_read_bool(np, "msi-controller"))
>   			continue;
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
>   	}
> +}
>   
> +static int __init its_pmsi_init(void)
> +{
> +	its_pmsi_of_init();
>   	return 0;
>   }
>   early_initcall(its_pmsi_init);
Tested-by:  Xinwei Kong <kong.kongxinwei@hisilicon.com>
