From: stigge@antcom.de (Roland Stigge)
Date: Tue, 03 Apr 2012 10:32:16 +0200
Subject: GPIO range check in drivers/of/gpio.c
Message-ID: <4F7AB590.2090505@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm wondering about a range check in drivers/of/gpio.c:144:

> int of_gpio_simple_xlate(struct gpio_chip *gc,
>			 const struct of_phandle_args *gpiospec, u32 *flags)
> {
>	/*
>	 * We're discouraging gpio_cells < 2, since that way you'll have to
>	 * write your own xlate function (that will have to retrive the GPIO
>	 * number and the flags from a single gpio cell -- this is possible,
>	 * but not recommended).
>	 */
>	if (gc->of_gpio_n_cells < 2) {
>		WARN_ON(1);
>		return -EINVAL;
>	}
>
>	if (WARN_ON(gpiospec->args_count < gc->of_gpio_n_cells))
>		return -EINVAL;
>
>	if (gpiospec->args[0] > gc->ngpio)
>		return -EINVAL;

Shouldn't this be rather:

	if (gpiospec->args[0] >= gc->ngpio)

?

Thanks in advance,

Roland
