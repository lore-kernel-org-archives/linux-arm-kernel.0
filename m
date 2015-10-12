From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 12 Oct 2015 14:44:24 +0800
Subject: [PATCH 05/16] irqchip: Convert all alloc/xlate users from of_node
 to fwnode
In-Reply-To: <1444152989-31726-6-git-send-email-marc.zyngier@arm.com>
References: <1444152989-31726-1-git-send-email-marc.zyngier@arm.com>
 <1444152989-31726-6-git-send-email-marc.zyngier@arm.com>
Message-ID: <561B56C8.7090403@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2015 01:36 AM, Marc Zyngier wrote:
> Since we now have a generic data structure to express an
> interrupt specifier, convert all hierarchical irqchips that
> are OF based to use a fwnode_handle as part of their alloc
> and xlate (which becomes translate) callbacks.
>
> As most of these drivers have dependencies (they exchange IRQ
> specifiers), change them all in a single, massive patch...
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   arch/arm/mach-exynos/suspend.c       | 55 ++++++++++++++++---------------
>   arch/arm/mach-imx/gpc.c              | 55 ++++++++++++++++---------------
>   arch/arm/mach-omap2/omap-wakeupgen.c | 55 ++++++++++++++++---------------
>   drivers/irqchip/irq-crossbar.c       | 62 ++++++++++++++++++----------------
>   drivers/irqchip/irq-gic-v2m.c        | 18 ++++++----
>   drivers/irqchip/irq-gic-v3-its.c     | 20 ++++++-----
>   drivers/irqchip/irq-gic-v3.c         | 49 +++++++++++++--------------
>   drivers/irqchip/irq-gic.c            | 33 ++++++++++++++++---
>   drivers/irqchip/irq-imx-gpcv2.c      | 64 ++++++++++++++++--------------------
>   drivers/irqchip/irq-mtk-sysirq.c     | 49 ++++++++++++++-------------
>   drivers/irqchip/irq-nvic.c           | 18 +++++++---
>   drivers/irqchip/irq-tegra.c          | 55 ++++++++++++++++---------------
>   drivers/irqchip/irq-vf610-mscm-ir.c  | 42 +++++++++++++++--------
>   13 files changed, 323 insertions(+), 252 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
> index e00eb39..5a7e47c 100644
> --- a/arch/arm/mach-exynos/suspend.c
> +++ b/arch/arm/mach-exynos/suspend.c
> @@ -177,54 +177,57 @@ static struct irq_chip exynos_pmu_chip = {
>   #endif
>   };
>
> -static int exynos_pmu_domain_xlate(struct irq_domain *domain,
> -				   struct device_node *controller,
> -				   const u32 *intspec,
> -				   unsigned int intsize,
> -				   unsigned long *out_hwirq,
> -				   unsigned int *out_type)
> +static int exynos_pmu_domain_translate(struct irq_domain *d,
> +				       struct irq_fwspec *fwspec,
> +				       unsigned long *hwirq,
> +				       unsigned int *type)
>   {
> -	if (domain->of_node != controller)
> -		return -EINVAL;	/* Shouldn't happen, really... */
> -	if (intsize != 3)
> -		return -EINVAL;	/* Not GIC compliant */
> -	if (intspec[0] != 0)
> -		return -EINVAL;	/* No PPI should point to this domain */
> +	if (is_of_node(fwspec->fwnode)) {
> +		if (fwspec->param_count != 3)
> +			return -EINVAL;
>
> -	*out_hwirq = intspec[1];
> -	*out_type = intspec[2];
> -	return 0;
> +		/* No PPI should point to this domain */
> +		if (fwspec->param[0] != 0)
> +			return -EINVAL;
> +
> +		*hwirq = fwspec->param[1];
> +		*type = fwspec->param[2];
> +		return 0;
> +	}
> +
> +	return -EINVAL;
>   }
>
>   static int exynos_pmu_domain_alloc(struct irq_domain *domain,
>   				   unsigned int virq,
>   				   unsigned int nr_irqs, void *data)
>   {
> -	struct of_phandle_args *args = data;
> -	struct of_phandle_args parent_args;
> +	struct irq_fwspec *fwspec = data;
> +	struct irq_fwspec parent_fwspec;
>   	irq_hw_number_t hwirq;
>   	int i;
>
> -	if (args->args_count != 3)
> +	if (fwspec->param_count != 3)
>   		return -EINVAL;	/* Not GIC compliant */
> -	if (args->args[0] != 0)
> +	if (fwspec->param[0] != 0)
>   		return -EINVAL;	/* No PPI should point to this domain */
>
> -	hwirq = args->args[1];
> +	hwirq = fwspec->param[1];
>
>   	for (i = 0; i < nr_irqs; i++)
>   		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
>   					      &exynos_pmu_chip, NULL);
>
> -	parent_args = *args;
> -	parent_args.np = domain->parent->of_node;

Hmm, here removes the of_node, but I think we still
need to convert it in the first patch, or will break
the git bisect.

Thanks
Hanjun
