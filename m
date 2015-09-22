From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 22 Sep 2015 10:27:34 +0200
Subject: [PATCH 2/3] irqchip: atmel-aic5: fix variable naming
In-Reply-To: <1442843173-2390-2-git-send-email-ludovic.desroches@atmel.com>
References: <1442843173-2390-1-git-send-email-ludovic.desroches@atmel.com>
 <1442843173-2390-2-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <560110F6.5070006@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 21/09/2015 15:46, Ludovic Desroches a ?crit :
> To avoid errors, use an explicit variable name when accessing the 'base'
> generic chip.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  drivers/irqchip/irq-atmel-aic5.c | 44 ++++++++++++++++++++--------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
> index 6c5fd25..abff79e 100644
> --- a/drivers/irqchip/irq-atmel-aic5.c
> +++ b/drivers/irqchip/irq-atmel-aic5.c
> @@ -71,15 +71,15 @@ static asmlinkage void __exception_irq_entry
>  aic5_handle(struct pt_regs *regs)
>  {
>  	struct irq_domain_chip_generic *dgc = aic5_domain->gc;
> -	struct irq_chip_generic *gc = dgc->gc[0];
> +	struct irq_chip_generic *bgc = dgc->gc[0];
>  	u32 irqnr;
>  	u32 irqstat;
>  
> -	irqnr = irq_reg_readl(gc, AT91_AIC5_IVR);
> -	irqstat = irq_reg_readl(gc, AT91_AIC5_ISR);
> +	irqnr = irq_reg_readl(bgc, AT91_AIC5_IVR);
> +	irqstat = irq_reg_readl(bgc, AT91_AIC5_ISR);
>  
>  	if (!irqstat)
> -		irq_reg_writel(gc, 0, AT91_AIC5_EOICR);
> +		irq_reg_writel(bgc, 0, AT91_AIC5_EOICR);
>  	else
>  		handle_domain_irq(aic5_domain, irqnr, regs);
>  }
> @@ -118,13 +118,13 @@ static int aic5_retrigger(struct irq_data *d)
>  {
>  	struct irq_domain *domain = d->domain;
>  	struct irq_domain_chip_generic *dgc = domain->gc;
> -	struct irq_chip_generic *gc = dgc->gc[0];
> +	struct irq_chip_generic *bgc = dgc->gc[0];
>  
>  	/* Enable interrupt on AIC5 */
> -	irq_gc_lock(gc);
> -	irq_reg_writel(gc, d->hwirq, AT91_AIC5_SSR);
> -	irq_reg_writel(gc, 1, AT91_AIC5_ISCR);
> -	irq_gc_unlock(gc);
> +	irq_gc_lock(bgc);
> +	irq_reg_writel(bgc, d->hwirq, AT91_AIC5_SSR);
> +	irq_reg_writel(bgc, 1, AT91_AIC5_ISCR);
> +	irq_gc_unlock(bgc);
>  
>  	return 0;
>  }
> @@ -133,17 +133,17 @@ static int aic5_set_type(struct irq_data *d, unsigned type)
>  {
>  	struct irq_domain *domain = d->domain;
>  	struct irq_domain_chip_generic *dgc = domain->gc;
> -	struct irq_chip_generic *gc = dgc->gc[0];
> +	struct irq_chip_generic *bgc = dgc->gc[0];
>  	unsigned int smr;
>  	int ret;
>  
> -	irq_gc_lock(gc);
> -	irq_reg_writel(gc, d->hwirq, AT91_AIC5_SSR);
> -	smr = irq_reg_readl(gc, AT91_AIC5_SMR);
> +	irq_gc_lock(bgc);
> +	irq_reg_writel(bgc, d->hwirq, AT91_AIC5_SSR);
> +	smr = irq_reg_readl(bgc, AT91_AIC5_SMR);
>  	ret = aic_common_set_type(d, type, &smr);
>  	if (!ret)
> -		irq_reg_writel(gc, smr, AT91_AIC5_SMR);
> -	irq_gc_unlock(gc);
> +		irq_reg_writel(bgc, smr, AT91_AIC5_SMR);
> +	irq_gc_unlock(bgc);
>  
>  	return ret;
>  }
> @@ -257,7 +257,7 @@ static int aic5_irq_domain_xlate(struct irq_domain *d,
>  				 unsigned int *out_type)
>  {
>  	struct irq_domain_chip_generic *dgc = d->gc;
> -	struct irq_chip_generic *gc;
> +	struct irq_chip_generic *bgc;
>  	unsigned smr;
>  	int ret;
>  
> @@ -269,15 +269,15 @@ static int aic5_irq_domain_xlate(struct irq_domain *d,
>  	if (ret)
>  		return ret;
>  
> -	gc = dgc->gc[0];
> +	bgc = dgc->gc[0];
>  
> -	irq_gc_lock(gc);
> -	irq_reg_writel(gc, *out_hwirq, AT91_AIC5_SSR);
> -	smr = irq_reg_readl(gc, AT91_AIC5_SMR);
> +	irq_gc_lock(bgc);
> +	irq_reg_writel(bgc, *out_hwirq, AT91_AIC5_SSR);
> +	smr = irq_reg_readl(bgc, AT91_AIC5_SMR);
>  	ret = aic_common_set_priority(intspec[2], &smr);
>  	if (!ret)
> -		irq_reg_writel(gc, intspec[2] | smr, AT91_AIC5_SMR);
> -	irq_gc_unlock(gc);
> +		irq_reg_writel(bgc, intspec[2] | smr, AT91_AIC5_SMR);
> +	irq_gc_unlock(bgc);
>  
>  	return ret;
>  }
> 


-- 
Nicolas Ferre
