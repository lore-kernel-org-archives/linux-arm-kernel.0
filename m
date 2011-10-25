From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 24 Oct 2011 21:39:05 -0700
Subject: [RFC] ARM: at91: gpio add mux check
In-Reply-To: <1319462000-32642-1-git-send-email-plagnioj@jcrosoft.com>
References: <1319462000-32642-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173E1B417B@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean-Christophe PLAGNIOL-VILLARD wrote at Monday, October 24, 2011 7:13 AM:
> this will check if the pio is not configured as mux first
...
> 	one of the the issue is what happened it the bootloader miss
> 	configured a pin a periph A or B?
> 
> 	do we need to keep the tracking of it in the pinmux?
...
> +static int at91_gpiolib_request(struct gpio_chip *chip, unsigned offset)
> +{
> +	struct at91_gpio_chip *at91_gpio = to_at91_gpio_chip(chip);
> +	void __iomem *pio = at91_gpio->regbase;
> +	unsigned mask = 1 << offset;
> +
> +	if (__raw_readl(pio + PIO_PSR) & mask)
> +		return 0;
> +
> +	return -EBUSY;
> +}

Yes, this will break if the boot-loader configured some pin as a special
function instead of as a GPIO. I suggest this check be implemented using
SW state instead; pinctrl's gpio_request_enable op should set this SW
state. On Tegra at least (and I think looking at your registers, on this
Atmel part too), the pinctrl's gpio_request_enable ends up calling a
function in the GPIO driver to toggle between GPIO vs. special function
mode for the pin, so both maintenance and usage of this SW state could
be completely isolated within the GPIO driver; no data explicit sharing
of the variable is required between pinmux and GPIO.

-- 
nvpublic
