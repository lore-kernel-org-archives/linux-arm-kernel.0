From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 07 Sep 2015 17:44:41 +0100
Subject: [PATCH v2] irqchip, gicv3-its,
 numa: Workaround for Cavium ThunderX erratum 23144
In-Reply-To: <1440497885-24584-1-git-send-email-gkulkarni@caviumnetworks.com>
References: <1440497885-24584-1-git-send-email-gkulkarni@caviumnetworks.com>
Message-ID: <55EDBEF9.4050007@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/08/15 11:18, Ganapatrao Kulkarni wrote:
> The patch below adds a workaround for gicv3 in a numa environment. It
> is on top of Robert's recent gicv3 errata patch submission v4 and my
> arm64 numa patches v5.
> 
> This implements a workaround for gicv3-its erratum 23144 on Cavium's
> ThunderX dual-socket platforms, where LPI cannot be routed to a
> redistributors present on a foreign node.
> 
> v2:
> updatated as per Marc Zyngier's review comments.
> 
> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 53 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 44 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 614a367..d3fe0a4 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -40,7 +40,8 @@
>  #include "irqchip.h"
>  
>  #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING          (1ULL << 0)
> -#define ITS_FLAGS_CAVIUM_THUNDERX              (1ULL << 1)
> +#define ITS_WORKAROUND_CAVIUM_22375            (1ULL << 1)
> +#define ITS_WORKAROUND_CAVIUM_23144            (1ULL << 2)

Please move this to Robert's series, as it doesn't make much sense to
add a quirk flag just to modify it in the next patch. This will help
declutter this patch.

>  
>  #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
>  
> @@ -73,6 +74,7 @@ struct its_node {
>  	struct list_head	its_device_list;
>  	u64			flags;
>  	u32			ite_size;
> +	int			numa_node;
>  };
>  
>  #define ITS_ITT_ALIGN		SZ_256
> @@ -607,11 +609,20 @@ static void its_eoi_irq(struct irq_data *d)
>  static int its_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
>  			    bool force)
>  {
> -	unsigned int cpu = cpumask_any_and(mask_val, cpu_online_mask);
> +	unsigned int cpu;
> +	const struct cpumask *cpu_mask = cpu_online_mask;
>  	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
>  	struct its_collection *target_col;
>  	u32 id = its_get_event_id(d);
>  
> +	/* lpi cannot be routed to a redistributor that is on a foreign node */
> +	if (its_dev->its->flags & ITS_WORKAROUND_CAVIUM_23144) {
> +		cpu_mask = cpumask_of_node(its_dev->its->numa_node);
> +		if (!cpumask_intersects(mask_val, cpu_mask))
> +			return -EINVAL;
> +	}
> +
> +	cpu = cpumask_any_and(mask_val, cpu_mask);
>  	if (cpu >= nr_cpu_ids)
>  		return -EINVAL;
>  
> @@ -1338,9 +1349,14 @@ static void its_irq_domain_activate(struct irq_domain *domain,
>  {
>  	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
>  	u32 event = its_get_event_id(d);
> +	const struct cpumask *cpu_mask = cpu_online_mask;
> +
> +	/* get the cpu_mask of local node */
> +	if (IS_ENABLED(CONFIG_NUMA))
> +		cpu_mask = cpumask_of_node(its_dev->its->numa_node);
>  
>  	/* Bind the LPI to the first possible CPU */
> -	its_dev->event_map.col_map[event] = cpumask_first(cpu_online_mask);
> +	its_dev->event_map.col_map[event] = cpumask_first(cpu_mask);
>  
>  	/* Map the GIC IRQ and event to the device */
>  	its_send_mapvi(its_dev, d->hwirq, event);
> @@ -1423,11 +1439,19 @@ static int its_force_quiescent(void __iomem *base)
>  	}
>  }
>  
> -static void its_enable_cavium_thunderx(void *data)
> +static void its_enable_cavium_thunderx_22375(void *data)
>  {
>         struct its_node *its = data;
>  
> -       its->flags |= ITS_FLAGS_CAVIUM_THUNDERX;
> +	its->flags |= ITS_WORKAROUND_CAVIUM_22375;
> +}
> +
> +static void its_enable_cavium_thunderx_23144(void *data)
> +{
> +	struct its_node *its = data;
> +
> +	if (num_possible_nodes() > 1)
> +		its->flags |= ITS_WORKAROUND_CAVIUM_23144;
>  }
>  
>  static const struct gic_capabilities its_errata[] = {
> @@ -1435,10 +1459,16 @@ static const struct gic_capabilities its_errata[] = {
>                 .desc   = "ITS: Cavium errata 22375, 24313",
>                 .iidr   = 0xa100034c,   /* ThunderX pass 1.x */
>                 .mask   = 0xffff0fff,
> -               .init   = its_enable_cavium_thunderx,
> -       },
> -       {
> -       }
> +		.init	= its_enable_cavium_thunderx_22375,
> +	},
> +	{
> +		.desc	= "ITS: Cavium errata 23144",
> +		.iidr	= 0xa100034c,	/* ThunderX pass 1.x */
> +		.mask	= 0xffff0fff,
> +		.init	= its_enable_cavium_thunderx_23144,
> +	},
> +	{
> +	}
>  };
>  
>  static void its_enable_quirks(struct its_node *its)
> @@ -1456,6 +1486,7 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
>  	u32 val;
>  	u64 baser, tmp;
>  	int err;
> +	int numa_node;
>  
>  	err = of_address_to_resource(node, 0, &res);
>  	if (err) {
> @@ -1463,6 +1494,9 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
>  		return -ENXIO;
>  	}
>  
> +	/* get numa affinity of its node*/
> +	numa_node = of_node_to_nid(node);
> +
>  	its_base = ioremap(res.start, resource_size(&res));
>  	if (!its_base) {
>  		pr_warn("%s: unable to map registers\n", node->full_name);
> @@ -1498,6 +1532,7 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
>  	its->phys_base = res.start;
>  	its->msi_chip.of_node = node;
>  	its->ite_size = ((readl_relaxed(its_base + GITS_TYPER) >> 4) & 0xf) + 1;
> +	its->numa_node = numa_node;
>  
>  	its->cmd_base = kzalloc(ITS_CMD_QUEUE_SZ, GFP_KERNEL);
>  	if (!its->cmd_base) {
> 

The patch (minus the above comment about splitting it) looks sane, but
obviously depends on the whole of_node_to_nid() discussion to happen,
and I haven't followed that.

Please CC me for further discussions on this matter.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
