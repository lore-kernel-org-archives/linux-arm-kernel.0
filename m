From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 15 May 2012 10:35:21 -0600
Subject: [PATCH 17/20] ARM: Exynos: Add device tree support for gpio
 wakeup interrupt controller
In-Reply-To: <1335813270-13083-18-git-send-email-thomas.abraham@linaro.org>
References: <1335813270-13083-1-git-send-email-thomas.abraham@linaro.org>
 <1335813270-13083-18-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20120515163521.144B13E07AF@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Apr 2012 12:14:27 -0700, Thomas Abraham <thomas.abraham@linaro.org> wrote:
> Add device tree support for gpio wakeup source interrupt controller
> for Exynos platforms.
> 
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  arch/arm/mach-exynos/common.c |   92 +++++++++++++++++++++++++++++++++++------
>  1 files changed, 79 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
> index 544f8b5..074508f 100644
> --- a/arch/arm/mach-exynos/common.c
> +++ b/arch/arm/mach-exynos/common.c
> @@ -64,7 +64,8 @@ static void exynos4_init_clocks(int xtal);
>  static void exynos5_init_clocks(int xtal);
>  static void exynos_init_uarts(struct s3c2410_uartcfg *cfg, int no);
>  static int exynos_init(void);
> -static int exynos_init_irq_eint(void);
> +static int exynos_init_irq_eint(struct device_node *np,
> +				struct device_node *parent);
>  
>  static struct cpu_table cpu_ids[] __initdata = {
>  	{
> @@ -589,6 +590,8 @@ static const struct of_device_id exynos4_dt_irq_match[] = {
>  	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
>  	{ .compatible = "samsung,exynos4210-combiner",
>  			.data = combiner_of_init, },
> +	{ .compatible = "samsung,exynos5210-wakeup-eint-map",
> +			.data = exynos_init_irq_eint, },
>  	{},
>  };
>  #endif
> @@ -606,8 +609,10 @@ void __init exynos4_init_irq(void)
>  		of_irq_init(exynos4_dt_irq_match);
>  #endif
>  
> -	if (!of_have_populated_dt())
> +	if (!of_have_populated_dt()) {
>  		combiner_init(S5P_VA_COMBINER_BASE, NULL);
> +		exynos_init_irq_eint(NULL, NULL);
> +	}
>  
>  	/*
>  	 * The parameters of s5p_init_irq() are for VIC init.
> @@ -615,7 +620,6 @@ void __init exynos4_init_irq(void)
>  	 * uses GIC instead of VIC.
>  	 */
>  	s5p_init_irq(NULL, 0);
> -	exynos_init_irq_eint();
>  }
>  
>  void __init exynos5_init_irq(void)
> @@ -629,7 +633,6 @@ void __init exynos5_init_irq(void)
>  	 * uses GIC instead of VIC.
>  	 */
>  	s5p_init_irq(NULL, 0);
> -	exynos_init_irq_eint();
>  }
>  
>  struct bus_type exynos_subsys = {
> @@ -1002,17 +1005,72 @@ static int exynos_eint_irq_domain_map(struct irq_domain *d, unsigned int irq,
>  	return 0;
>  }
>  
> +#ifdef CONFIG_OF
> +static int exynos_eint_irq_domain_xlate(struct irq_domain *d,
> +		struct device_node *controller, const u32 *intspec,
> +		unsigned int intsize, unsigned long *out_hwirq,
> +		unsigned int *out_type)
> +{
> +	if (d->of_node != controller)
> +		return -EINVAL;
> +	if (intsize < 2)
> +		return -EINVAL;
> +	*out_hwirq = intspec[0];
> +
> +	switch (intspec[1]) {
> +	case S5P_IRQ_TYPE_LEVEL_LOW:
> +		*out_type = IRQ_TYPE_LEVEL_LOW;
> +		break;
> +	case S5P_IRQ_TYPE_LEVEL_HIGH:
> +		*out_type = IRQ_TYPE_LEVEL_HIGH;
> +		break;
> +	case S5P_IRQ_TYPE_EDGE_FALLING:
> +		*out_type = IRQ_TYPE_EDGE_FALLING;
> +		break;
> +	case S5P_IRQ_TYPE_EDGE_RISING:
> +		*out_type = IRQ_TYPE_EDGE_RISING;
> +		break;
> +	case S5P_IRQ_TYPE_EDGE_BOTH:
> +		*out_type = IRQ_TYPE_EDGE_BOTH;
> +		break;
> +	};
> +
> +	return 0;

I'm recommending that new irq bindings use the Linux IRQ_TYPE_* values
just because it provides some commonality between irq controllers.
Using the S5P_IRQ_TYPE_ values doesn't make much sense when it only
gets immediately converted to another set of arbitrary values.

> +}
> +#else
> +static int exynos_eint_irq_domain_xlate(struct irq_domain *d,
> +		struct device_node *controller, const u32 *intspec,
> +		unsigned int intsize, unsigned long *out_hwirq,
> +		unsigned int *out_type)
> +{
> +	return -EINVAL;
> +}
> +#endif
> +
>  static struct irq_domain_ops exynos_eint_irq_domain_ops = {
> +	.xlate = exynos_eint_irq_domain_xlate,
>  	.map = exynos_eint_irq_domain_map,
>  };
>  
> -static int __init exynos_init_irq_eint(void)
> +static int __init exynos_init_irq_eint(struct device_node *eint_np,
> +					struct device_node *parent)
>  {
> -	int irq, *src_int, irq_base;
> +	int irq, *src_int, irq_base, irq_eint;
>  	unsigned int paddr;
> +	static unsigned int retry = 0;
> +	static struct device_node *np;
>  
> -	paddr = soc_is_exynos5250() ? EXYNOS5_PA_GPIO1 : EXYNOS4_PA_GPIO2;
> -	exynos_eint_base = ioremap(paddr, SZ_4K);
> +	if (retry)
> +		goto retry_init;
> +
> +	if (!eint_np) {
> +		paddr = soc_is_exynos5250() ? EXYNOS5_PA_GPIO1 :
> +						EXYNOS4_PA_GPIO2;
> +		exynos_eint_base = ioremap(paddr, SZ_4K);
> +	} else {
> +		np = of_get_parent(eint_np);
> +		exynos_eint_base = of_iomap(np, 0);
> +	}
>  	if (!exynos_eint_base) {
>  		pr_err("unable to ioremap for EINT base address\n");
>  		return -ENXIO;
> @@ -1025,21 +1083,29 @@ static int __init exynos_init_irq_eint(void)
>  				"linux irq base\n", __func__, irq_base);
>  	}
>  
> -	irq_domain = irq_domain_add_legacy(NULL, EXYNOS_EINT_NR, irq_base, 0,
> +	irq_domain = irq_domain_add_legacy(np, EXYNOS_EINT_NR, irq_base, 0,
>  					 &exynos_eint_irq_domain_ops, NULL);
>  	if (WARN_ON(!irq_domain)) {
>  		pr_warning("%s: irq domain init failed\n", __func__);
>  		return 0;
>  	}
>  
> -	irq_set_chained_handler(EXYNOS_IRQ_EINT16_31, exynos_irq_demux_eint16_31);
> +	irq_eint = eint_np ? irq_of_parse_and_map(np, 16) : EXYNOS_IRQ_EINT16_31;
> +	irq_set_chained_handler(irq_eint, exynos_irq_demux_eint16_31);
>  
> -	for (irq = 0 ; irq <= 15; irq++) {
> +retry_init:
> +	for (irq = 0; irq <= 15; irq++) {
>  		eint0_15_data[irq] = irq;
>  		src_int = soc_is_exynos5250() ? exynos5_eint0_15_src_int :
>  						exynos4_eint0_15_src_int;
> -		irq_set_handler_data(src_int[irq], &eint0_15_data[irq]);
> -		irq_set_chained_handler(src_int[irq], exynos_irq_eint0_15);
> +		irq_eint = eint_np ? irq_of_parse_and_map(np, irq) : src_int[irq];
> +		if (!irq_eint) {
> +			of_node_put(np);
> +			retry = 1;
> +			return -EAGAIN;
> +		}
> +		irq_set_handler_data(irq_eint, &eint0_15_data[irq]);
> +		irq_set_chained_handler(irq_eint, exynos_irq_eint0_15);

After switching to irq_domain, all of the contents of this loop should
be in the .map hook.

g.
