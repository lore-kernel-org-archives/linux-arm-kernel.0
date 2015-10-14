From: tomasz.nowicki@linaro.org (Tomasz Nowicki)
Date: Wed, 14 Oct 2015 17:26:00 +0200
Subject: [PATCH v2 05/17] irqchip: Convert all alloc/xlate users from
 of_node to fwnode
In-Reply-To: <1444737105-31573-6-git-send-email-marc.zyngier@arm.com>
References: <1444737105-31573-1-git-send-email-marc.zyngier@arm.com>
 <1444737105-31573-6-git-send-email-marc.zyngier@arm.com>
Message-ID: <561E7408.3050106@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 13.10.2015 13:51, Marc Zyngier wrote:
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

[...]

>
>   static int its_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 5793880..05d010b 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -737,32 +737,30 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
>   	return 0;
>   }
>
> -static int gic_irq_domain_xlate(struct irq_domain *d,
> -				struct device_node *controller,
> -				const u32 *intspec, unsigned int intsize,
> -				unsigned long *out_hwirq, unsigned int *out_type)
> +static int gic_irq_domain_translate(struct irq_domain *d,
> +				    struct irq_fwspec *fwspec,
> +				    unsigned long *hwirq,
> +				    unsigned int *type)
>   {
> -	if (irq_domain_get_of_node(d) != controller)
> -		return -EINVAL;
> -	if (intsize < 3)
> -		return -EINVAL;
> +	if (is_of_node(fwspec->fwnode)) {
> +		if (fwspec->param_count < 3)
> +			return -EINVAL;
>
> -	switch(intspec[0]) {
> -	case 0:			/* SPI */
> -		*out_hwirq = intspec[1] + 32;
> -		break;
> -	case 1:			/* PPI */
> -		*out_hwirq = intspec[1] + 16;
> -		break;
> -	case GIC_IRQ_TYPE_LPI:	/* LPI */
> -		*out_hwirq = intspec[1];
> -		break;
> -	default:
> -		return -EINVAL;
> +		/* Get the interrupt number and add 16 to skip over SGIs */
> +		*hwirq = fwspec->param[1] + 16;
> +
> +		/*
> +		 * For SPIs, we need to add 16 more to get the GIC irq
> +		 * ID number
> +		 */
> +		if (!fwspec->param[0])
> +			*hwirq += 16;
> +
> +		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
> +		return 0;
>   	}
>
> -	*out_type = intspec[2] & IRQ_TYPE_SENSE_MASK;
> -	return 0;
> +	return -EINVAL;
>   }

What about GIC_IRQ_TYPE_LPI type? Previously we leaved interrupt line nr 
and now +32.

Regards,
Tomasz
