From: balbi@ti.com (Felipe Balbi)
Date: Sat, 2 Mar 2013 13:48:11 +0200
Subject: [PATCH 1/2] gpio/omap: convert gpio irq domain to linear mapping
In-Reply-To: <1362158568-1624-2-git-send-email-jon-hunter@ti.com>
References: <1362158568-1624-1-git-send-email-jon-hunter@ti.com>
 <1362158568-1624-2-git-send-email-jon-hunter@ti.com>
Message-ID: <20130302114742.GA9965@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 01, 2013 at 11:22:47AM -0600, Jon Hunter wrote:
> Currently the OMAP GPIO driver uses a legacy mapping for the GPIO IRQ
> domain. This is not necessary because we do not need to assign a
> specific interrupt number to the GPIO IRQ domain. Therefore, convert
> the OMAP GPIO driver to use a linear mapping instead.
> 
> Please note that this also allows to simplify the logic in the OMAP
> gpio_irq_handler() routine, by using irq_find_mapping() to obtain the
> virtual irq number from the GPIO bank and bank index.
> 
> Reported-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

Just one suggestion below for a later patch.

> @@ -680,7 +686,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>  {
>  	void __iomem *isr_reg = NULL;
>  	u32 isr;
> -	unsigned int gpio_irq, gpio_index;
> +	unsigned int i;
>  	struct gpio_bank *bank;
>  	int unmasked = 0;
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
> @@ -721,15 +727,10 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>  		if (!isr)
>  			break;
>  
> -		gpio_irq = bank->irq_base;
> -		for (; isr != 0; isr >>= 1, gpio_irq++) {
> -			int gpio = irq_to_gpio(bank, gpio_irq);
> -
> +		for (i = 0; isr != 0; isr >>= 1, i++) {
>  			if (!(isr & 1))
>  				continue;

this will iterate over all 32 GPIOs, a better way to handle this would
be to have something like:

while (isr) {
	unsigned long bit = __ffs(isr);

	/* clear this bit */
	isr &= ~bit;

	generic_handle_irq(irq_find_mapping(bank->domain, bit);
}

this way you will only iterate the amount of bits enabled in the isr
register.

ps: completely untested ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130302/0330d140/attachment.sig>
