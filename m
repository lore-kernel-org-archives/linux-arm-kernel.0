From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 22 Sep 2015 12:27:08 +0200 (CEST)
Subject: [PATCH 1/3] irqchip: atmel-aic5: fix bug with mask/unmask
In-Reply-To: <1442843173-2390-1-git-send-email-ludovic.desroches@atmel.com>
References: <1442843173-2390-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <alpine.DEB.2.11.1509221226090.5606@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Sep 2015, Ludovic Desroches wrote:
> diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
> index 9da9942..6c5fd25 100644
> --- a/drivers/irqchip/irq-atmel-aic5.c
> +++ b/drivers/irqchip/irq-atmel-aic5.c
> @@ -88,28 +88,30 @@ static void aic5_mask(struct irq_data *d)
>  {
>  	struct irq_domain *domain = d->domain;
>  	struct irq_domain_chip_generic *dgc = domain->gc;
> -	struct irq_chip_generic *gc = dgc->gc[0];
> +	struct irq_chip_generic *bgc = dgc->gc[0];
> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
>  
>  	/* Disable interrupt on AIC5 */
> -	irq_gc_lock(gc);
> +	irq_gc_lock(bgc);

Why is this locking dgc->gc[0] and fiddling with some other generic
chip?

>  	irq_reg_writel(gc, d->hwirq, AT91_AIC5_SSR);
>  	irq_reg_writel(gc, 1, AT91_AIC5_IDCR);

Thanks,

	tglx
