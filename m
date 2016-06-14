From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 14 Jun 2016 14:18:08 +0300
Subject: [PATCH] gpio: omap: make gpio numbering deterministical by using
 of aliases
In-Reply-To: <1465898604-16294-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1465898604-16294-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <575FE7F0.6090200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On 06/14/2016 01:03 PM, Uwe Kleine-K?nig wrote:
> Traditionally the n-th gpio device probed by the omap gpio driver got
> the gpio number range [n*32 .. n*32+31].
> When order of the devices probed by the driver changes (which can happen
> already now when some devices have a pinctrl and so the first probe
> attempt returns -ENODEV) the numbering changes.
> 
> To ensure a deterministical numbering use of_alias_get_id to determine
> the number base for a given device. If no respective alias exists fall
> back to the traditional numbering.
> 
> For the unusual case where only a part of the gpio devices have a
> matching alias some of them might fail to probe. But if none of them has
> an alias or all, there is no conflict which should be good enough to
> maintain backward compatibility.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> if you're happy with this patch I can follow up and add the respective
> aliases to the device trees.
> 

Thanks for the patch.
I have no objection to the idea of the patch, but there are some comments.

> 
>   drivers/gpio/gpio-omap.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index b98ede78c9d8..6814245a54aa 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1034,6 +1034,7 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
>   	static int gpio;
>   	int irq_base = 0;
>   	int ret;
> +	int gpio_alias_id;
>   
>   	/*
>   	 * REVISIT eventually switch from OMAP-specific gpio structs
> @@ -1056,6 +1057,17 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
>   		bank->chip.label = "gpio";
>   		bank->chip.base = gpio;

I think, the gpio base correction should be done here

>   	}
> +
> +	/*
> +	 * Traditionally the base is given out in first-come-first-serve order.
> +	 * This might shuffle the numbering of gpios if the probe order changes.
> +	 * So make the base deterministical if the device tree specifies alias
> +	 * ids.
> +	 */
> +	gpio_alias_id = of_alias_get_id(bank->chip.of_node, "gpio");
> +	if (gpio_alias_id >= 0)
> +		bank->chip.base = bank->width * gpio_alias_id;
> +

Unfortunately, this driver is still used by non-DT platforms, so above code will
 break build if !OF && !OF_GPIO

I think, right way would be to get alias_id in .probe(), then calc base and save it
in struct gpio_bank. Then use it here to fixup GPIO base if positive.

>   	bank->chip.ngpio = bank->width;
>   
>   	ret = gpiochip_add_data(&bank->chip, bank);
> 


-- 
regards,
-grygorii
