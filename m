From: stigge@antcom.de (Roland Stigge)
Date: Sat, 15 Dec 2012 00:49:57 +0100
Subject: [PATCH RESEND 0/6 v10] gpio: Add block GPIO
In-Reply-To: <50CB68AB.5070806@grandegger.com>
References: <1355495185-24220-1-git-send-email-stigge@antcom.de>
 <50CB68AB.5070806@grandegger.com>
Message-ID: <50CBBB25.20002@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfgang,

thank you for the patch!

On 14/12/12 18:58, Wolfgang Grandegger wrote:
> +static void at91_gpiolib_set_block(struct gpio_chip *chip, unsigned long mask, unsigned long val)
> +{
> +	struct at91_gpio_chip *at91_gpio = to_at91_gpio_chip(chip);
> +	void __iomem *pio = at91_gpio->regbase;
> +
> +	__raw_writel(mask, pio + (val ? PIO_SODR : PIO_CODR));
> +}
> +

Without having an AT91 available right now, I guess the hardware
interface of this GPIO chip is different from the GPIO block API. While
the hardware has clear and set registers, the val parameter of
at91_gpiolib_set_block() should be interpreted as the actual output
values. See lpc32xx_gpo_set_block() for an example for handling set and
clear registers like this: First, set_bits and clear_bits words are
calculated from mask and val parameters, and finally written to the
respective hardware registers.

Note that one .set_block() can result in writing both the set and clear
registers of the hardware when val contains both 0s and 1s in
respectively masked positions.

Roland
