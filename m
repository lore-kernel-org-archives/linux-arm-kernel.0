From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 19 Jul 2017 11:42:31 +0200
Subject: [PATCH] irqchip: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-30-robh@kernel.org>
References: <20170718214339.7774-30-robh@kernel.org>
Message-ID: <d07ba1b0-054e-3c29-4502-f539f9903a5a@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/18/2017 11:43 PM, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list at broadcom.com
> Cc: Baruch Siach <baruch@tkos.co.il>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: "S?ren Brinkmann" <soren.brinkmann@xilinx.com>
> Cc: linux-rpi-kernel at lists.infradead.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-mediatek at lists.infradead.org
> Cc: linux-tegra at vger.kernel.org
> ---
>   drivers/irqchip/irq-bcm2835.c            |  9 ++++-----
>   drivers/irqchip/irq-bcm2836.c            |  5 ++---
>   drivers/irqchip/irq-crossbar.c           |  6 +++---
>   drivers/irqchip/irq-digicolor.c          |  8 ++++----
>   drivers/irqchip/irq-dw-apb-ictl.c        | 12 ++++++------
>   drivers/irqchip/irq-gic-v3-its-pci-msi.c |  2 +-
>   drivers/irqchip/irq-gic-v3-its.c         |  6 +++---
>   drivers/irqchip/irq-gic-v3.c             | 11 ++++-------
>   drivers/irqchip/irq-imx-gpcv2.c          |  4 ++--
>   drivers/irqchip/irq-lpc32xx.c            |  2 +-
>   drivers/irqchip/irq-mtk-sysirq.c         |  3 +--
>   drivers/irqchip/irq-mxs.c                |  4 ++--
>   drivers/irqchip/irq-stm32-exti.c         |  8 ++++----
>   drivers/irqchip/irq-sun4i.c              |  6 +++---
>   drivers/irqchip/irq-tegra.c              | 16 ++++++++--------
>   drivers/irqchip/irq-xilinx-intc.c        |  4 ++--
>   16 files changed, 50 insertions(+), 56 deletions(-)

For irq-stm32-exti.c:

Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>

Regards
Alex

> 
> diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
> index 44d7c38dde47..d2da8a1e6b1b 100644
> --- a/drivers/irqchip/irq-bcm2835.c
> +++ b/drivers/irqchip/irq-bcm2835.c
> @@ -147,13 +147,12 @@ static int __init armctrl_of_init(struct device_node *node,
> 
>   	base = of_iomap(node, 0);
>   	if (!base)
> -		panic("%s: unable to map IC registers\n",
> -			node->full_name);
> +		panic("%pOF: unable to map IC registers\n", node);
> 
>   	intc.domain = irq_domain_add_linear(node, MAKE_HWIRQ(NR_BANKS, 0),
>   			&armctrl_ops, NULL);
>   	if (!intc.domain)
> -		panic("%s: unable to create IRQ domain\n", node->full_name);
> +		panic("%pOF: unable to create IRQ domain\n", node);
> 
>   	for (b = 0; b < NR_BANKS; b++) {
>   		intc.pending[b] = base + reg_pending[b];
> @@ -173,8 +172,8 @@ static int __init armctrl_of_init(struct device_node *node,
>   		int parent_irq = irq_of_parse_and_map(node, 0);
> 
>   		if (!parent_irq) {
> -			panic("%s: unable to get parent interrupt.\n",
> -			      node->full_name);
> +			panic("%pOF: unable to get parent interrupt.\n",
> +			      node);
>   		}
>   		irq_set_chained_handler(parent_irq, bcm2836_chained_handle_irq);
>   	} else {
> diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
> index e7463e3c0814..dc8c1e3eafe7 100644
> --- a/drivers/irqchip/irq-bcm2836.c
> +++ b/drivers/irqchip/irq-bcm2836.c
> @@ -282,8 +282,7 @@ static int __init bcm2836_arm_irqchip_l1_intc_of_init(struct device_node *node,
>   {
>   	intc.base = of_iomap(node, 0);
>   	if (!intc.base) {
> -		panic("%s: unable to map local interrupt registers\n",
> -			node->full_name);
> +		panic("%pOF: unable to map local interrupt registers\n", node);
>   	}
> 
>   	bcm2835_init_local_timer_frequency();
> @@ -292,7 +291,7 @@ static int __init bcm2836_arm_irqchip_l1_intc_of_init(struct device_node *node,
>   					    &bcm2836_arm_irqchip_intc_ops,
>   					    NULL);
>   	if (!intc.domain)
> -		panic("%s: unable to create IRQ domain\n", node->full_name);
> +		panic("%pOF: unable to create IRQ domain\n", node);
> 
>   	bcm2836_arm_irqchip_register_irq(LOCAL_IRQ_CNTPSIRQ,
>   					 &bcm2836_arm_irqchip_timer);
> diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
> index f96601268f71..99d97d7e3fd7 100644
> --- a/drivers/irqchip/irq-crossbar.c
> +++ b/drivers/irqchip/irq-crossbar.c
> @@ -341,13 +341,13 @@ static int __init irqcrossbar_init(struct device_node *node,
>   	int err;
> 
>   	if (!parent) {
> -		pr_err("%s: no parent, giving up\n", node->full_name);
> +		pr_err("%pOF: no parent, giving up\n", node);
>   		return -ENODEV;
>   	}
> 
>   	parent_domain = irq_find_host(parent);
>   	if (!parent_domain) {
> -		pr_err("%s: unable to obtain parent domain\n", node->full_name);
> +		pr_err("%pOF: unable to obtain parent domain\n", node);
>   		return -ENXIO;
>   	}
> 
> @@ -360,7 +360,7 @@ static int __init irqcrossbar_init(struct device_node *node,
>   					  node, &crossbar_domain_ops,
>   					  NULL);
>   	if (!domain) {
> -		pr_err("%s: failed to allocated domain\n", node->full_name);
> +		pr_err("%pOF: failed to allocated domain\n", node);
>   		return -ENOMEM;
>   	}
> 
> diff --git a/drivers/irqchip/irq-digicolor.c b/drivers/irqchip/irq-digicolor.c
> index dad85e74c37c..df5752cfbc09 100644
> --- a/drivers/irqchip/irq-digicolor.c
> +++ b/drivers/irqchip/irq-digicolor.c
> @@ -78,7 +78,7 @@ static int __init digicolor_of_init(struct device_node *node,
> 
>   	reg_base = of_iomap(node, 0);
>   	if (!reg_base) {
> -		pr_err("%s: unable to map IC registers\n", node->full_name);
> +		pr_err("%pOF: unable to map IC registers\n", node);
>   		return -ENXIO;
>   	}
> 
> @@ -88,7 +88,7 @@ static int __init digicolor_of_init(struct device_node *node,
> 
>   	ucregs = syscon_regmap_lookup_by_phandle(node, "syscon");
>   	if (IS_ERR(ucregs)) {
> -		pr_err("%s: unable to map UC registers\n", node->full_name);
> +		pr_err("%pOF: unable to map UC registers\n", node);
>   		return PTR_ERR(ucregs);
>   	}
>   	/* channel 1, regular IRQs */
> @@ -97,7 +97,7 @@ static int __init digicolor_of_init(struct device_node *node,
>   	digicolor_irq_domain =
>   		irq_domain_add_linear(node, 64, &irq_generic_chip_ops, NULL);
>   	if (!digicolor_irq_domain) {
> -		pr_err("%s: unable to create IRQ domain\n", node->full_name);
> +		pr_err("%pOF: unable to create IRQ domain\n", node);
>   		return -ENOMEM;
>   	}
> 
> @@ -105,7 +105,7 @@ static int __init digicolor_of_init(struct device_node *node,
>   					     "digicolor_irq", handle_level_irq,
>   					     clr, 0, 0);
>   	if (ret) {
> -		pr_err("%s: unable to allocate IRQ gc\n", node->full_name);
> +		pr_err("%pOF: unable to allocate IRQ gc\n", node);
>   		return ret;
>   	}
> 
> diff --git a/drivers/irqchip/irq-dw-apb-ictl.c b/drivers/irqchip/irq-dw-apb-ictl.c
> index 052f266364c0..0a19618ce2c8 100644
> --- a/drivers/irqchip/irq-dw-apb-ictl.c
> +++ b/drivers/irqchip/irq-dw-apb-ictl.c
> @@ -79,24 +79,24 @@ static int __init dw_apb_ictl_init(struct device_node *np,
>   	/* Map the parent interrupt for the chained handler */
>   	irq = irq_of_parse_and_map(np, 0);
>   	if (irq <= 0) {
> -		pr_err("%s: unable to parse irq\n", np->full_name);
> +		pr_err("%pOF: unable to parse irq\n", np);
>   		return -EINVAL;
>   	}
> 
>   	ret = of_address_to_resource(np, 0, &r);
>   	if (ret) {
> -		pr_err("%s: unable to get resource\n", np->full_name);
> +		pr_err("%pOF: unable to get resource\n", np);
>   		return ret;
>   	}
> 
>   	if (!request_mem_region(r.start, resource_size(&r), np->full_name)) {
> -		pr_err("%s: unable to request mem region\n", np->full_name);
> +		pr_err("%pOF: unable to request mem region\n", np);
>   		return -ENOMEM;
>   	}
> 
>   	iobase = ioremap(r.start, resource_size(&r));
>   	if (!iobase) {
> -		pr_err("%s: unable to map resource\n", np->full_name);
> +		pr_err("%pOF: unable to map resource\n", np);
>   		ret = -ENOMEM;
>   		goto err_release;
>   	}
> @@ -123,7 +123,7 @@ static int __init dw_apb_ictl_init(struct device_node *np,
>   	domain = irq_domain_add_linear(np, nrirqs,
>   				       &irq_generic_chip_ops, NULL);
>   	if (!domain) {
> -		pr_err("%s: unable to add irq domain\n", np->full_name);
> +		pr_err("%pOF: unable to add irq domain\n", np);
>   		ret = -ENOMEM;
>   		goto err_unmap;
>   	}
> @@ -132,7 +132,7 @@ static int __init dw_apb_ictl_init(struct device_node *np,
>   					     handle_level_irq, clr, 0,
>   					     IRQ_GC_INIT_MASK_CACHE);
>   	if (ret) {
> -		pr_err("%s: unable to alloc irq domain gc\n", np->full_name);
> +		pr_err("%pOF: unable to alloc irq domain gc\n", np);
>   		goto err_unmap;
>   	}
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
> index 77931214d954..14a8c0a7e095 100644
> --- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
> +++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
> @@ -138,7 +138,7 @@ static int __init its_pci_of_msi_init(void)
>   		if (its_pci_msi_init_one(of_node_to_fwnode(np), np->full_name))
>   			continue;
> 
> -		pr_info("PCI/MSI: %s domain created\n", np->full_name);
> +		pr_info("PCI/MSI: %pOF domain created\n", np);
>   	}
> 
>   	return 0;
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 68932873eebc..62298ee360bc 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1816,13 +1816,13 @@ static int __init its_of_probe(struct device_node *node)
>   	for (np = of_find_matching_node(node, its_device_id); np;
>   	     np = of_find_matching_node(np, its_device_id)) {
>   		if (!of_property_read_bool(np, "msi-controller")) {
> -			pr_warn("%s: no msi-controller property, ITS ignored\n",
> -				np->full_name);
> +			pr_warn("%pOF: no msi-controller property, ITS ignored\n",
> +				np);
>   			continue;
>   		}
> 
>   		if (of_address_to_resource(np, 0, &res)) {
> -			pr_warn("%s: no regs?\n", np->full_name);
> +			pr_warn("%pOF: no regs?\n", np);
>   			continue;
>   		}
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index dbffb7ab6203..afae0a9d0df9 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -1057,7 +1057,7 @@ static void __init gic_populate_ppi_partitions(struct device_node *gic_node)
>   			if (WARN_ON(cpu == -1))
>   				continue;
> 
> -			pr_cont("%s[%d] ", cpu_node->full_name, cpu);
> +			pr_cont("%pOF[%d] ", cpu_node, cpu);
> 
>   			cpumask_set_cpu(cpu, &part->mask);
>   		}
> @@ -1125,15 +1125,13 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
> 
>   	dist_base = of_iomap(node, 0);
>   	if (!dist_base) {
> -		pr_err("%s: unable to map gic dist registers\n",
> -			node->full_name);
> +		pr_err("%pOF: unable to map gic dist registers\n", node);
>   		return -ENXIO;
>   	}
> 
>   	err = gic_validate_dist_version(dist_base);
>   	if (err) {
> -		pr_err("%s: no distributor detected, giving up\n",
> -			node->full_name);
> +		pr_err("%pOF: no distributor detected, giving up\n", node);
>   		goto out_unmap_dist;
>   	}
> 
> @@ -1153,8 +1151,7 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
>   		ret = of_address_to_resource(node, 1 + i, &res);
>   		rdist_regs[i].redist_base = of_iomap(node, 1 + i);
>   		if (ret || !rdist_regs[i].redist_base) {
> -			pr_err("%s: couldn't map region %d\n",
> -			       node->full_name, i);
> +			pr_err("%pOF: couldn't map region %d\n", node, i);
>   			err = -ENODEV;
>   			goto out_unmap_rdist;
>   		}
> diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
> index bb36f572e322..675eda5ff2b8 100644
> --- a/drivers/irqchip/irq-imx-gpcv2.c
> +++ b/drivers/irqchip/irq-imx-gpcv2.c
> @@ -214,13 +214,13 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
>   	int i;
> 
>   	if (!parent) {
> -		pr_err("%s: no parent, giving up\n", node->full_name);
> +		pr_err("%pOF: no parent, giving up\n", node);
>   		return -ENODEV;
>   	}
> 
>   	parent_domain = irq_find_host(parent);
>   	if (!parent_domain) {
> -		pr_err("%s: unable to get parent domain\n", node->full_name);
> +		pr_err("%pOF: unable to get parent domain\n", node);
>   		return -ENXIO;
>   	}
> 
> diff --git a/drivers/irqchip/irq-lpc32xx.c b/drivers/irqchip/irq-lpc32xx.c
> index 1034aeb2e98a..a48357d369b5 100644
> --- a/drivers/irqchip/irq-lpc32xx.c
> +++ b/drivers/irqchip/irq-lpc32xx.c
> @@ -191,7 +191,7 @@ static int __init lpc32xx_of_ic_init(struct device_node *node,
> 
>   	irqc->base = of_iomap(node, 0);
>   	if (!irqc->base) {
> -		pr_err("%s: unable to map registers\n", node->full_name);
> +		pr_err("%pOF: unable to map registers\n", node);
>   		kfree(irqc);
>   		return -EINVAL;
>   	}
> diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-sysirq.c
> index eeac512ec5a8..90aaf190157f 100644
> --- a/drivers/irqchip/irq-mtk-sysirq.c
> +++ b/drivers/irqchip/irq-mtk-sysirq.c
> @@ -178,8 +178,7 @@ static int __init mtk_sysirq_of_init(struct device_node *node,
>   		chip_data->intpol_words[i] = size / 4;
>   		chip_data->intpol_bases[i] = of_iomap(node, i);
>   		if (ret || !chip_data->intpol_bases[i]) {
> -			pr_err("%s: couldn't map region %d\n",
> -			       node->full_name, i);
> +			pr_err("%pOF: couldn't map region %d\n", node, i);
>   			ret = -ENODEV;
>   			goto out_free_intpol;
>   		}
> diff --git a/drivers/irqchip/irq-mxs.c b/drivers/irqchip/irq-mxs.c
> index 05fa9f7af53c..e8b31f52e071 100644
> --- a/drivers/irqchip/irq-mxs.c
> +++ b/drivers/irqchip/irq-mxs.c
> @@ -179,7 +179,7 @@ static void __init icoll_add_domain(struct device_node *np,
>   					     &icoll_irq_domain_ops, NULL);
> 
>   	if (!icoll_domain)
> -		panic("%s: unable to create irq domain", np->full_name);
> +		panic("%pOF: unable to create irq domain", np);
>   }
> 
>   static void __iomem * __init icoll_init_iobase(struct device_node *np)
> @@ -188,7 +188,7 @@ static void __iomem * __init icoll_init_iobase(struct device_node *np)
> 
>   	icoll_base = of_io_request_and_map(np, 0, np->name);
>   	if (IS_ERR(icoll_base))
> -		panic("%s: unable to map resource", np->full_name);
> +		panic("%pOF: unable to map resource", np);
>   	return icoll_base;
>   }
> 
> diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
> index 491568c95aa5..45363ff8d06f 100644
> --- a/drivers/irqchip/irq-stm32-exti.c
> +++ b/drivers/irqchip/irq-stm32-exti.c
> @@ -140,7 +140,7 @@ static int __init stm32_exti_init(struct device_node *node,
> 
>   	base = of_iomap(node, 0);
>   	if (!base) {
> -		pr_err("%s: Unable to map registers\n", node->full_name);
> +		pr_err("%pOF: Unable to map registers\n", node);
>   		return -ENOMEM;
>   	}
> 
> @@ -149,7 +149,7 @@ static int __init stm32_exti_init(struct device_node *node,
>   	nr_exti = fls(readl_relaxed(base + EXTI_RTSR));
>   	writel_relaxed(0, base + EXTI_RTSR);
> 
> -	pr_info("%s: %d External IRQs detected\n", node->full_name, nr_exti);
> +	pr_info("%pOF: %d External IRQs detected\n", node, nr_exti);
> 
>   	domain = irq_domain_add_linear(node, nr_exti,
>   				       &irq_exti_domain_ops, NULL);
> @@ -163,8 +163,8 @@ static int __init stm32_exti_init(struct device_node *node,
>   	ret = irq_alloc_domain_generic_chips(domain, nr_exti, 1, "exti",
>   					     handle_edge_irq, clr, 0, 0);
>   	if (ret) {
> -		pr_err("%s: Could not allocate generic interrupt chip.\n",
> -			node->full_name);
> +		pr_err("%pOF: Could not allocate generic interrupt chip.\n",
> +			node);
>   		goto out_free_domain;
>   	}
> 
> diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
> index 376b28074e0d..e3e5b9132b75 100644
> --- a/drivers/irqchip/irq-sun4i.c
> +++ b/drivers/irqchip/irq-sun4i.c
> @@ -97,8 +97,8 @@ static int __init sun4i_of_init(struct device_node *node,
>   {
>   	sun4i_irq_base = of_iomap(node, 0);
>   	if (!sun4i_irq_base)
> -		panic("%s: unable to map IC registers\n",
> -			node->full_name);
> +		panic("%pOF: unable to map IC registers\n",
> +			node);
> 
>   	/* Disable all interrupts */
>   	writel(0, sun4i_irq_base + SUN4I_IRQ_ENABLE_REG(0));
> @@ -124,7 +124,7 @@ static int __init sun4i_of_init(struct device_node *node,
>   	sun4i_irq_domain = irq_domain_add_linear(node, 3 * 32,
>   						 &sun4i_irq_ops, NULL);
>   	if (!sun4i_irq_domain)
> -		panic("%s: unable to create IRQ domain\n", node->full_name);
> +		panic("%pOF: unable to create IRQ domain\n", node);
> 
>   	set_handle_irq(sun4i_handle_irq);
> 
> diff --git a/drivers/irqchip/irq-tegra.c b/drivers/irqchip/irq-tegra.c
> index 3973a14bb15b..0abc0cd1c32e 100644
> --- a/drivers/irqchip/irq-tegra.c
> +++ b/drivers/irqchip/irq-tegra.c
> @@ -291,13 +291,13 @@ static int __init tegra_ictlr_init(struct device_node *node,
>   	int err;
> 
>   	if (!parent) {
> -		pr_err("%s: no parent, giving up\n", node->full_name);
> +		pr_err("%pOF: no parent, giving up\n", node);
>   		return -ENODEV;
>   	}
> 
>   	parent_domain = irq_find_host(parent);
>   	if (!parent_domain) {
> -		pr_err("%s: unable to obtain parent domain\n", node->full_name);
> +		pr_err("%pOF: unable to obtain parent domain\n", node);
>   		return -ENXIO;
>   	}
> 
> @@ -329,29 +329,29 @@ static int __init tegra_ictlr_init(struct device_node *node,
>   	}
> 
>   	if (!num_ictlrs) {
> -		pr_err("%s: no valid regions, giving up\n", node->full_name);
> +		pr_err("%pOF: no valid regions, giving up\n", node);
>   		err = -ENOMEM;
>   		goto out_free;
>   	}
> 
>   	WARN(num_ictlrs != soc->num_ictlrs,
> -	     "%s: Found %u interrupt controllers in DT; expected %u.\n",
> -	     node->full_name, num_ictlrs, soc->num_ictlrs);
> +	     "%pOF: Found %u interrupt controllers in DT; expected %u.\n",
> +	     node, num_ictlrs, soc->num_ictlrs);
> 
> 
>   	domain = irq_domain_add_hierarchy(parent_domain, 0, num_ictlrs * 32,
>   					  node, &tegra_ictlr_domain_ops,
>   					  lic);
>   	if (!domain) {
> -		pr_err("%s: failed to allocated domain\n", node->full_name);
> +		pr_err("%pOF: failed to allocated domain\n", node);
>   		err = -ENOMEM;
>   		goto out_unmap;
>   	}
> 
>   	tegra_ictlr_syscore_init();
> 
> -	pr_info("%s: %d interrupts forwarded to %s\n",
> -		node->full_name, num_ictlrs * 32, parent->full_name);
> +	pr_info("%pOF: %d interrupts forwarded to %pOF\n",
> +		node, num_ictlrs * 32, parent);
> 
>   	return 0;
> 
> diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
> index 3db7ab1c9741..e3043ded8973 100644
> --- a/drivers/irqchip/irq-xilinx-intc.c
> +++ b/drivers/irqchip/irq-xilinx-intc.c
> @@ -186,8 +186,8 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
>   	if (irqc->intr_mask >> nr_irq)
>   		pr_warn("irq-xilinx: mismatch in kind-of-intr param\n");
> 
> -	pr_info("irq-xilinx: %s: num_irq=%d, edge=0x%x\n",
> -		intc->full_name, nr_irq, irqc->intr_mask);
> +	pr_info("irq-xilinx: %pOF: num_irq=%d, edge=0x%x\n",
> +		intc, nr_irq, irqc->intr_mask);
> 
> 
>   	/*
> --
> 2.11.0
> 
