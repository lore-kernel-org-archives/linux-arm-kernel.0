From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Dec 2010 17:23:08 +0000
Subject: [PATCH 02/54] ARM: ecard: irq_data conversion.
In-Reply-To: <20101130132534.GC15575@mail.wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
	<20101130132534.GC15575@mail.wantstofly.org>
Message-ID: <20101203172308.GF30898@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 30, 2010 at 02:25:34PM +0100, Lennert Buytenhek wrote:
> Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

> ---
>  arch/arm/kernel/ecard.c |   28 ++++++++++++++--------------
>  1 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/kernel/ecard.c b/arch/arm/kernel/ecard.c
> index eed2f79..2ad62df 100644
> --- a/arch/arm/kernel/ecard.c
> +++ b/arch/arm/kernel/ecard.c
> @@ -443,40 +443,40 @@ static expansioncard_ops_t ecard_default_ops = {
>   *
>   * They are not meant to be called directly, but via enable/disable_irq.
>   */
> -static void ecard_irq_unmask(unsigned int irqnr)
> +static void ecard_irq_unmask(struct irq_data *d)
>  {
> -	ecard_t *ec = slot_to_ecard(irqnr - 32);
> +	ecard_t *ec = slot_to_ecard(d->irq - 32);
>  
>  	if (ec) {
>  		if (!ec->ops)
>  			ec->ops = &ecard_default_ops;
>  
>  		if (ec->claimed && ec->ops->irqenable)
> -			ec->ops->irqenable(ec, irqnr);
> +			ec->ops->irqenable(ec, d->irq);
>  		else
>  			printk(KERN_ERR "ecard: rejecting request to "
> -				"enable IRQs for %d\n", irqnr);
> +				"enable IRQs for %d\n", d->irq);
>  	}
>  }
>  
> -static void ecard_irq_mask(unsigned int irqnr)
> +static void ecard_irq_mask(struct irq_data *d)
>  {
> -	ecard_t *ec = slot_to_ecard(irqnr - 32);
> +	ecard_t *ec = slot_to_ecard(d->irq - 32);
>  
>  	if (ec) {
>  		if (!ec->ops)
>  			ec->ops = &ecard_default_ops;
>  
>  		if (ec->ops && ec->ops->irqdisable)
> -			ec->ops->irqdisable(ec, irqnr);
> +			ec->ops->irqdisable(ec, d->irq);
>  	}
>  }
>  
>  static struct irq_chip ecard_chip = {
> -	.name	= "ECARD",
> -	.ack	= ecard_irq_mask,
> -	.mask	= ecard_irq_mask,
> -	.unmask = ecard_irq_unmask,
> +	.name		= "ECARD",
> +	.irq_ack	= ecard_irq_mask,
> +	.irq_mask	= ecard_irq_mask,
> +	.irq_unmask	= ecard_irq_unmask,
>  };
>  
>  void ecard_enablefiq(unsigned int fiqnr)
> @@ -551,7 +551,7 @@ static void ecard_check_lockup(struct irq_desc *desc)
>  			printk(KERN_ERR "\nInterrupt lockup detected - "
>  			       "disabling all expansion card interrupts\n");
>  
> -			desc->chip->mask(IRQ_EXPANSIONCARD);
> +			desc->irq_data.chip->irq_mask(&desc->irq_data);
>  			ecard_dump_irq_state();
>  		}
>  	} else
> @@ -574,7 +574,7 @@ ecard_irq_handler(unsigned int irq, struct irq_desc *desc)
>  	ecard_t *ec;
>  	int called = 0;
>  
> -	desc->chip->mask(irq);
> +	desc->irq_data.chip->irq_mask(&desc->irq_data);
>  	for (ec = cards; ec; ec = ec->next) {
>  		int pending;
>  
> @@ -591,7 +591,7 @@ ecard_irq_handler(unsigned int irq, struct irq_desc *desc)
>  			called ++;
>  		}
>  	}
> -	desc->chip->unmask(irq);
> +	desc->irq_data.chip->irq_unmask(&desc->irq_data);
>  
>  	if (called == 0)
>  		ecard_check_lockup(desc);
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
