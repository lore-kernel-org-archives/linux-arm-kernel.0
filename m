From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 2 Apr 2015 10:30:18 +0200
Subject: [PATCH 1/2] pinctrl: at91: Add set_multiple GPIO chip feature
In-Reply-To: <1426878721-2618-1-git-send-email-alexanders83@web.de>
References: <1426878721-2618-1-git-send-email-alexanders83@web.de>
Message-ID: <20150402083018.GC26864@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20:12 Fri 20 Mar     , Alexander Stein wrote:
> This adds the callback for set_multiple.
> As this controller has a separate set and clear register, we can't write
> directly to PIO_ODSR as this would required a cached variable and would
> race with at91_gpio_set.
> So build masks for the PIO_SODR and PIO_CODR registers and write them
> together.
> 
> Signed-off-by: Alexander Stein <alexanders83@web.de>
> ---
> This was tested by using an own test driver which uses
> gpiod_set_array_cansleep to set multiple GPIOs at once.
> 
>  drivers/pinctrl/pinctrl-at91.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> index f4cd0b9..a882523 100644
> --- a/drivers/pinctrl/pinctrl-at91.c
> +++ b/drivers/pinctrl/pinctrl-at91.c
> @@ -1330,6 +1330,33 @@ static void at91_gpio_set(struct gpio_chip *chip, unsigned offset,
>  	writel_relaxed(mask, pio + (val ? PIO_SODR : PIO_CODR));
>  }
>  
> +static void at91_gpio_set_multiple(struct gpio_chip *chip,
> +				      unsigned long *mask, unsigned long *bits)
> +{
> +	struct at91_gpio_chip *at91_gpio = to_at91_gpio_chip(chip);
> +	void __iomem *pio = at91_gpio->regbase;
> +	unsigned long set_mask;
> +	unsigned long clear_mask;
> +	size_t i;
> +
> +	set_mask = 0;
> +	clear_mask = 0;
> +
> +	for (i = 0; i < chip->ngpio; i++) {
> +		if (*mask == 0)
so why do you loop?
> +			break;
> +		if (__test_and_clear_bit(i, mask)) {
> +			if (test_bit(i, bits))
> +				set_mask |= BIT(i);
> +			else
> +				clear_mask |= BIT(i);
> +		}
> +	}

just use mask to invert the mask for the CODR

#define BITS_MASK(bits)	(((bits) == 32) ? ~0U : (BIT(bits) - 1))

	uint32_t set_mask = *mask & BITS_MASK(chip->ngpio);;
	uint32_t clear_mask = ~set_mask;

	writel_relaxed(set_mask, pio + PIO_SODR);
	writel_relaxed(clear_mask, pio + PIO_CODR);

Best Regards,
J.

> +
> +	writel_relaxed(set_mask, pio + PIO_SODR);
> +	writel_relaxed(clear_mask, pio + PIO_CODR);
> +}
> +
>  static int at91_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
>  				int val)
>  {
> @@ -1692,6 +1719,7 @@ static struct gpio_chip at91_gpio_template = {
>  	.get			= at91_gpio_get,
>  	.direction_output	= at91_gpio_direction_output,
>  	.set			= at91_gpio_set,
> +	.set_multiple		= at91_gpio_set_multiple,
>  	.dbg_show		= at91_gpio_dbg_show,
>  	.can_sleep		= false,
>  	.ngpio			= MAX_NB_GPIO_PER_BANK,
> -- 
> 2.3.3
> 
