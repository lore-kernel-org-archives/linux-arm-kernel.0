From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 16 Dec 2011 10:11:47 +0000
Subject: [PATCH 3/6] ARM: at91/gpio: add DT support
In-Reply-To: <876f676ec80d2db927e379654be76171ca496422.1323975517.git.nicolas.ferre@atmel.com>
References: <85d531b5686e5eff623bed9618f802198409905f.1323975517.git.nicolas.ferre@atmel.com>
 <876f676ec80d2db927e379654be76171ca496422.1323975517.git.nicolas.ferre@atmel.com>
Message-ID: <20111216101147.GA3230@totoro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas, Jean-Christophe,

This looks pretty good to me, but a couple of minor comments inline.

Jamie

On Thu, Dec 15, 2011 at 08:16:05PM +0100, Nicolas Ferre wrote:
> From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
[...]
> diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
> index 7ffb893..edb453a 100644
> --- a/arch/arm/mach-at91/gpio.c
> +++ b/arch/arm/mach-at91/gpio.c
> @@ -21,6 +21,7 @@
>  #include <linux/module.h>
>  #include <linux/io.h>
>  #include <linux/irqdomain.h>
> +#include <linux/of_address.h>
>  
>  #include <mach/hardware.h>
>  #include <mach/at91_pio.h>
> @@ -624,40 +625,122 @@ static void at91_gpiolib_dbg_show(struct seq_file *s, struct gpio_chip *chip)
>  	}
>  }
>  
> +#ifdef CONFIG_OF_GPIO
> +static void __init of_at91_gpio_init_one(struct device_node *np)
> +{
> +	int alias_id;
> +	struct at91_gpio_chip *at91_gpio;
> +	const unsigned int *intspec;
> +
> +	if (!np)
> +		return;
> +
> +	alias_id = of_alias_get_id(np, "gpio");
> +	if (alias_id >= MAX_GPIO_BANKS) {
> +		pr_err("at91_gpio, failed alias id(%d) > MAX_GPIO_BANKS(%d), ignoring.\n",
> +								alias_id, MAX_GPIO_BANKS);
> +		return;
> +	}
> +
> +	at91_gpio = &gpio_chip[alias_id];
> +	at91_gpio->chip.base = alias_id * at91_gpio->chip.ngpio;
> +
> +	at91_gpio->regbase = of_iomap(np, 0);
> +	if (!at91_gpio->regbase) {
> +		pr_err("at91_gpio.%d, failed to map registers, ignoring.\n",
> +								alias_id);
> +		return;
> +	}
> +
> +	/* Get the interrupts property */
> +	intspec = of_get_property(np, "interrupts", NULL);
> +	BUG_ON(!intspec);
> +	at91_gpio->id = be32_to_cpup(intspec);

Use of_property_read_u32()?  Also, BUG_ON() seems a bit harsh, better to 
print a warning and return an error.

> +
> +	at91_gpio->clock = clk_get_sys(NULL, at91_gpio->chip.label);
> +	if (!at91_gpio->clock) {
> +		pr_err("at91_gpio.%d, failed to get clock, ignoring.\n",
> +								alias_id);
> +		return;

Perhaps	unmap the regs here?

> +	}
> +
> +	/* enable PIO controller's clock */
> +	clk_enable(at91_gpio->clock);

Missing return value check.

> +
> +	at91_gpio->chip.of_node = np;
> +	gpio_banks = max(gpio_banks, alias_id + 1);
> +}
> +
> +static int __init of_at91_gpio_init(void)
> +{
> +	struct device_node *np = NULL;
> +
> +	/*
> +	 * This isn't ideal, but it gets things hooked up until this
> +	 * driver is converted into a platform_device
> +	 */
> +	do {
> +		np = of_find_compatible_node(np, NULL, "atmel,at91rm9200-gpio");
> +
> +		of_at91_gpio_init_one(np);
> +	} while (np);

for_each_compatible_node9)?

> +
> +	return gpio_banks > 0 ? 0 : -EINVAL;
> +}
> +#else
> +static int __init of_at91_gpio_init(void)
> +{
> +	return -EINVAL;
> +}
> +#endif
> +
> +static void __init at91_gpio_init_one(int i, u32 regbase, int id)
> +{
> +	struct at91_gpio_chip *at91_gpio = &gpio_chip[i];
> +
> +	at91_gpio->chip.base = i * at91_gpio->chip.ngpio;
> +	at91_gpio->id = id;
> +
> +	at91_gpio->regbase = ioremap(regbase, 512);
> +	if (!at91_gpio->regbase) {
> +		pr_err("at91_gpio.%d, failed to map registers, ignoring.\n", i);
> +		return;
> +	}
> +
> +	at91_gpio->clock = clk_get_sys(NULL, at91_gpio->chip.label);
> +	if (!at91_gpio->clock) {
> +		pr_err("at91_gpio.%d, failed to get clock, ignoring.\n", i);
> +		return;
> +	}
> +
> +	/* enable PIO controller's clock */
> +	clk_enable(at91_gpio->clock);

Missing return value check?

> +	gpio_banks = max(gpio_banks, i + 1);
> +}
> +
>  /*
>   * Called from the processor-specific init to enable GPIO pin support.
>   */
>  void __init at91_gpio_init(struct at91_gpio_bank *data, int nr_banks)
>  {
> -	unsigned		i;
> +	unsigned i;
>  	struct at91_gpio_chip *at91_gpio, *last = NULL;
>  
>  	BUG_ON(nr_banks > MAX_GPIO_BANKS);
>  
> -	gpio_banks = nr_banks;
> +	if (of_at91_gpio_init() < 0) {
> +		/* no GPIO controller found in device tree */
> +		for (i = 0; i < nr_banks; i++)
> +			at91_gpio_init_one(i, data[i].regbase, data[i].id);
> +	}
>  
> -	for (i = 0; i < nr_banks; i++) {
> +	for (i = 0; i < gpio_banks; i++) {
>  		at91_gpio = &gpio_chip[i];
>  
> -		at91_gpio->id = data[i].id;
> -		at91_gpio->chip.base = i * 32;
> -
> -		at91_gpio->regbase = ioremap(data[i].regbase, 512);
> -		if (!at91_gpio->regbase) {
> -			pr_err("at91_gpio.%d, failed to map registers, ignoring.\n", i);
> -			continue;
> -		}
> -
> -		at91_gpio->clock = clk_get_sys(NULL, at91_gpio->chip.label);
> -		if (!at91_gpio->clock) {
> -			pr_err("at91_gpio.%d, failed to get clock, ignoring.\n", i);
> -			continue;
> -		}
> -
> -		/* enable PIO controller's clock */
> -		clk_enable(at91_gpio->clock);
> -
> -		/* AT91SAM9263_ID_PIOCDE groups PIOC, PIOD, PIOE */
> +		/*
> +		 * GPIO controller are grouped on some SoC:
> +		 * PIOC, PIOD and PIOE can share the same IRQ line
> +		 */
>  		if (last && last->id == at91_gpio->id)
>  			last->next = at91_gpio;
>  		last = at91_gpio;
> -- 
> 1.7.5.4
> 
