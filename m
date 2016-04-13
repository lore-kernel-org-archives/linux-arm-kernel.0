From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 13 Apr 2016 16:09:06 +0100
Subject: [PATCH V4 3/7] irqchip, GICv3, ITS: Refator ITS DT init code to
 prepare for ACPI.
In-Reply-To: <1459759975-24097-4-git-send-email-tn@semihalf.com>
References: <1459759975-24097-1-git-send-email-tn@semihalf.com>
 <1459759975-24097-4-git-send-email-tn@semihalf.com>
Message-ID: <570E6112.3040503@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/16 09:52, Tomasz Nowicki wrote:
> No functional changes.
> 
> In order to add ACPI support we need to isolate ACPI&DT common code and
> move DT logic to corresponding functions. To achieve this we are using
> firmware agnostic handle which can be unpacked to either DT or ACPI node.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c   | 76 ++++++++++++++++++++++----------------
>  drivers/irqchip/irq-gic-v3.c       |  6 +--
>  include/linux/irqchip/arm-gic-v3.h |  2 +-
>  3 files changed, 48 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 065eac5..2dcc7b4 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -815,7 +815,7 @@ static void its_free_tables(struct its_node *its)
>  	}
>  }
>  
> -static int its_alloc_tables(const char *node_name, struct its_node *its)
> +static int its_alloc_tables(struct its_node *its)
>  {
>  	int err;
>  	int i;
> @@ -869,8 +869,8 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
>  				    order);
>  			if (order >= MAX_ORDER) {
>  				order = MAX_ORDER - 1;
> -				pr_warn("%s: Device Table too large, reduce its page order to %u\n",
> -					node_name, order);
> +				pr_warn("ITS at 0x%lx: Device Table too large, reduce its page order to %u\n",
> +					its->phys_base, order);

Start by making the phys_base field in struct its_node a phys_addr_t (as
it should have been from day-1), and use %pa in the format strings.

>  			}
>  		}
>  
> @@ -879,8 +879,8 @@ retry_alloc_baser:
>  		if (alloc_pages > GITS_BASER_PAGES_MAX) {
>  			alloc_pages = GITS_BASER_PAGES_MAX;
>  			order = get_order(GITS_BASER_PAGES_MAX * psz);
> -			pr_warn("%s: Device Table too large, reduce its page order to %u (%u pages)\n",
> -				node_name, order, alloc_pages);
> +			pr_warn("ITS at 0x%lx: Device Table too large, reduce its page order to %u (%u pages)\n",
> +				its->phys_base, order, alloc_pages);
>  		}
>  
>  		base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> @@ -953,8 +953,8 @@ retry_baser:
>  		}
>  
>  		if (val != tmp) {
> -			pr_err("ITS: %s: GITS_BASER%d doesn't stick: %lx %lx\n",
> -			       node_name, i,
> +			pr_err("ITS at 0x%lx: GITS_BASER%d doesn't stick: %lx %lx\n",
> +			       its->phys_base, i,
>  			       (unsigned long) val, (unsigned long) tmp);
>  			err = -ENXIO;
>  			goto out_free;
> @@ -1429,7 +1429,7 @@ static void its_enable_quirks(struct its_node *its)
>  	gic_enable_quirks(iidr, its_quirks, its);
>  }
>  
> -static int its_init_domain(struct device_node *node, struct its_node *its,
> +static int its_init_domain(struct fwnode_handle *handler, struct its_node *its,
>  			   struct irq_domain *parent)

nit: s/handler/handle/g

>  {
>  	struct irq_domain *inner_domain;
> @@ -1439,7 +1439,7 @@ static int its_init_domain(struct device_node *node, struct its_node *its,
>  	if (!info)
>  		return -ENOMEM;
>  
> -	inner_domain = irq_domain_add_tree(node, &its_domain_ops, its);
> +	inner_domain = irq_domain_create_tree(handler, &its_domain_ops, its);
>  	if (!inner_domain) {
>  		kfree(info);
>  		return -ENOMEM;
> @@ -1454,43 +1454,39 @@ static int its_init_domain(struct device_node *node, struct its_node *its,
>  	return 0;
>  }
>  
> -static int __init its_probe(struct device_node *node,
> -			    struct irq_domain *parent)
> +static int __init its_probe_one(phys_addr_t phys_base, unsigned long size,

Why don't you pass a resource here? That's the right abstraction to
describe an IO range. Surely you can allocate a resource on the stack in
your ACPI code and pass that around, just like we do here.

> +				struct irq_domain *parent,
> +				struct fwnode_handle *handler)
>  {
> -	struct resource res;
>  	struct its_node *its;
>  	void __iomem *its_base;
>  	u32 val;
>  	u64 baser, tmp;
>  	int err;
>  
> -	err = of_address_to_resource(node, 0, &res);
> -	if (err) {
> -		pr_warn("%s: no regs?\n", node->full_name);
> -		return -ENXIO;
> -	}
> -
> -	its_base = ioremap(res.start, resource_size(&res));
> +	its_base = ioremap(phys_base, size);
>  	if (!its_base) {
> -		pr_warn("%s: unable to map registers\n", node->full_name);
> +		pr_warn("ITS at 0x%lx: Unable to map ITS registers\n",
> +			(long)phys_base);

Same here. Use the right format, and lose the case everywhere.

>  		return -ENOMEM;
>  	}
>  
>  	val = readl_relaxed(its_base + GITS_PIDR2) & GIC_PIDR2_ARCH_MASK;
>  	if (val != 0x30 && val != 0x40) {
> -		pr_warn("%s: no ITS detected, giving up\n", node->full_name);
> +		pr_warn("ITS at 0x%lx: No ITS detected, giving up\n",
> +			(long)phys_base);
>  		err = -ENODEV;
>  		goto out_unmap;
>  	}
>  
>  	err = its_force_quiescent(its_base);
>  	if (err) {
> -		pr_warn("%s: failed to quiesce, giving up\n",
> -			node->full_name);
> +		pr_warn("ITS at 0x%lx: Failed to quiesce, giving up\n",
> +			(long)phys_base);
>  		goto out_unmap;
>  	}
>  
> -	pr_info("ITS: %s\n", node->full_name);
> +	pr_info("ITS at 0x%lx\n", (long)phys_base);
>  
>  	its = kzalloc(sizeof(*its), GFP_KERNEL);
>  	if (!its) {
> @@ -1502,7 +1498,7 @@ static int __init its_probe(struct device_node *node,
>  	INIT_LIST_HEAD(&its->entry);
>  	INIT_LIST_HEAD(&its->its_device_list);
>  	its->base = its_base;
> -	its->phys_base = res.start;
> +	its->phys_base = phys_base;
>  	its->ite_size = ((readl_relaxed(its_base + GITS_TYPER) >> 4) & 0xf) + 1;
>  
>  	its->cmd_base = kzalloc(ITS_CMD_QUEUE_SZ, GFP_KERNEL);
> @@ -1514,7 +1510,7 @@ static int __init its_probe(struct device_node *node,
>  
>  	its_enable_quirks(its);
>  
> -	err = its_alloc_tables(node->full_name, its);
> +	err = its_alloc_tables(its);
>  	if (err)
>  		goto out_free_cmd;
>  
> @@ -1550,7 +1546,7 @@ static int __init its_probe(struct device_node *node,
>  	writeq_relaxed(0, its->base + GITS_CWRITER);
>  	writel_relaxed(GITS_CTLR_ENABLE, its->base + GITS_CTLR);
>  
> -	err = its_init_domain(node, its, parent);
> +	err = its_init_domain(handler, its, parent);
>  	if (err)
>  		goto out_free_tables;
>  
> @@ -1568,7 +1564,7 @@ out_free_its:
>  	kfree(its);
>  out_unmap:
>  	iounmap(its_base);
> -	pr_err("ITS: failed probing %s (%d)\n", node->full_name, err);
> +	pr_err("ITS at 0x%lx: failed probing (%d)\n", (long)phys_base, err);
>  	return err;
>  }
>  
> @@ -1596,10 +1592,11 @@ static struct of_device_id its_device_id[] = {
>  	{},
>  };
>  
> -int __init its_init(struct device_node *node, struct rdists *rdists,
> -	     struct irq_domain *parent_domain)
> +static int __init
> +its_of_probe(struct device_node *node, struct irq_domain *parent)
>  {
>  	struct device_node *np;
> +	struct resource res;
>  
>  	for (np = of_find_matching_node(node, its_device_id); np;
>  	     np = of_find_matching_node(np, its_device_id)) {
> @@ -1609,8 +1606,25 @@ int __init its_init(struct device_node *node, struct rdists *rdists,
>  			continue;
>  		}
>  
> -		its_probe(np, parent_domain);
> +		if (of_address_to_resource(np, 0, &res)) {
> +			pr_warn("%s: no regs?\n", np->full_name);
> +			continue;
> +		}
> +
> +		its_probe_one(res.start, resource_size(&res), parent,
> +			      &np->fwnode);
>  	}
> +	return 0;
> +}
> +
> +int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
> +		    struct irq_domain *parent_domain)
> +{
> +	struct device_node *of_node;
> +
> +	of_node = to_of_node(handle);
> +	if (of_node)
> +		its_of_probe(of_node, parent_domain);
>  
>  	if (list_empty(&its_nodes)) {
>  		pr_warn("ITS: No ITS available, not enabling LPIs\n");
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index dd16a60..995b7251 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -832,7 +832,6 @@ static int __init gic_init_bases(void __iomem *dist_base,
>  				 u64 redist_stride,
>  				 struct fwnode_handle *handle)
>  {
> -	struct device_node *node;
>  	u32 typer;
>  	int gic_irqs;
>  	int err;
> @@ -872,10 +871,9 @@ static int __init gic_init_bases(void __iomem *dist_base,
>  
>  	set_handle_irq(gic_handle_irq);
>  
> -	node = to_of_node(handle);
>  	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis() &&
> -	    node) /* Temp hack to prevent ITS init for ACPI */
> -		its_init(node, &gic_data.rdists, gic_data.domain);
> +	    to_of_node(handle)) /* Temp hack to prevent ITS init for ACPI */
> +		its_init(handle, &gic_data.rdists, gic_data.domain);
>  
>  	gic_smp_init();
>  	gic_dist_init();
> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
> index d5d798b..a40ed7d 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -332,7 +332,7 @@ struct rdists {
>  struct irq_domain;
>  struct device_node;
>  int its_cpu_init(void);
> -int its_init(struct device_node *node, struct rdists *rdists,
> +int its_init(struct fwnode_handle *handle, struct rdists *rdists,
>  	     struct irq_domain *domain);
>  
>  static inline bool gic_enable_sre(void)
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
