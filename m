From: balbi@ti.com (Felipe Balbi)
Date: Fri, 5 Apr 2013 12:19:02 +0300
Subject: [PATCH 3/5] gpio/omap: optimise interrupt service routine
In-Reply-To: <1365106576-31816-4-git-send-email-jon-hunter@ti.com>
References: <1365106576-31816-1-git-send-email-jon-hunter@ti.com>
 <1365106576-31816-4-git-send-email-jon-hunter@ti.com>
Message-ID: <20130405091902.GA9626@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 04, 2013 at 03:16:14PM -0500, Jon Hunter wrote:
> The OMAP GPIO interrupt service routine is checking each bit in the
> GPIO interrupt status register to see which bits are set. It is not
> efficient to check every bit especially if only a few bits are set.
> Therefore, instead of checking every bit use the __ffs() function,
> which returns the location of the first set bit, to find all the set
> bits.
> 
> This optimisation was suggested-by and developed in collaboration
> with Felipe Balbi.
> 
> Cc: Felipe Balbi <balbi@ti.com>
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

looks alright:

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/gpio/gpio-omap.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 5af7acd..685e850 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -689,7 +689,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>  {
>  	void __iomem *isr_reg = NULL;
>  	u32 isr;
> -	unsigned int i;
> +	unsigned int bit;
>  	struct gpio_bank *bank;
>  	int unmasked = 0;
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
> @@ -730,9 +730,9 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>  		if (!isr)
>  			break;
>  
> -		for (i = 0; isr != 0; isr >>= 1, i++) {
> -			if (!(isr & 1))
> -				continue;
> +		while (isr) {
> +			bit = __ffs(isr);
> +			isr &= ~(1 << bit);
>  
>  			/*
>  			 * Some chips can't respond to both rising and falling
> @@ -741,10 +741,10 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>  			 * to respond to the IRQ for the opposite direction.
>  			 * This will be indicated in the bank toggle_mask.
>  			 */
> -			if (bank->toggle_mask & (1 << i))
> -				_toggle_gpio_edge_triggering(bank, i);
> +			if (bank->toggle_mask & (1 << bit))
> +				_toggle_gpio_edge_triggering(bank, bit);
>  
> -			generic_handle_irq(irq_find_mapping(bank->domain, i));
> +			generic_handle_irq(irq_find_mapping(bank->domain, bit));
>  		}
>  	}
>  	/* if bank has any level sensitive GPIO pin interrupt
> -- 
> 1.7.10.4
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130405/1674148b/attachment.sig>
