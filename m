From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 31 May 2013 13:21:00 +0100
Subject: [PATCH 2/2] ARM: shmobile: irqpin: map spurious interrupts in DT
 case
In-Reply-To: <Pine.LNX.4.64.1305241112210.1090@axis700.grange>
References: <Pine.LNX.4.64.1305241109530.1090@axis700.grange>
 <Pine.LNX.4.64.1305241112210.1090@axis700.grange>
Message-ID: <20130531122100.BEC173E0901@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 24 May 2013 11:13:07 +0200 (CEST), Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> In the non-DT case all interrupts get mapped statically during probing,
> therefore, if a spurious interrupt arrives, it can easily be mapped back
> to hardware registers and bits and handled. In the DT case interrupts are
> mapped only when a device, using that interrupt is instantiated from DT.
> So, spurious interrupts occur unmapped and thus cannot be handled properly.
> This patch fixes this by mapping such interrupts as they occur.

That sounds like a bad approach. If the driver really requires the irqs
to be mapped, then it should do all of them when the controller is set
up. Mapping at interrupt handling time is absolutely the wrong time to
do it.

Also, why is mapping the irq necessary to handle it? You don't want to
call generic_handle_irq() on a bad interrupt because there won't be
anything listening for it. First of all, that particular irq should be
entirely disabled if at all possible. Second, if it isn't possible to
disable it, then the handler function should clear the state and get out
of the handler as quickly as possible.

g.

> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>  drivers/irqchip/irq-renesas-intc-irqpin.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
> index 82cec63..e62d76d 100644
> --- a/drivers/irqchip/irq-renesas-intc-irqpin.c
> +++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
> @@ -71,6 +71,7 @@ struct intc_irqpin_priv {
>  	struct intc_irqpin_iomem iomem[INTC_IRQPIN_REG_NR];
>  	struct intc_irqpin_irq irq[INTC_IRQPIN_MAX];
>  	struct renesas_intc_irqpin_config config;
> +	unsigned int min_irq;
>  	unsigned int number_of_irqs;
>  	struct platform_device *pdev;
>  	struct irq_chip irq_chip;
> @@ -274,6 +275,10 @@ static irqreturn_t intc_irqpin_irq_handler(int irq, void *dev_id)
>  	struct intc_irqpin_priv *p = i->p;
>  	unsigned long bit;
>  
> +	if (!i->domain_irq)
> +		/* unmapped: spurious IRQ, map it now */
> +		irq_create_mapping(p->irq_domain, irq - p->min_irq);
> +
>  	intc_irqpin_dbg(i, "demux1");
>  	bit = intc_irqpin_hwirq_mask(p, INTC_IRQPIN_REG_SOURCE, i->hw_irq);
>  
> @@ -372,6 +377,7 @@ static int intc_irqpin_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	p->min_irq = INT_MAX;
>  	/* allow any number of IRQs between 1 and INTC_IRQPIN_MAX */
>  	for (k = 0; k < INTC_IRQPIN_MAX; k++) {
>  		irq = platform_get_resource(pdev, IORESOURCE_IRQ, k);
> @@ -380,6 +386,8 @@ static int intc_irqpin_probe(struct platform_device *pdev)
>  
>  		p->irq[k].p = p;
>  		p->irq[k].requested_irq = irq->start;
> +		if (p->min_irq > irq->start)
> +			p->min_irq = irq->start;
>  	}
>  
>  	p->number_of_irqs = k;
> -- 
> 1.7.2.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
