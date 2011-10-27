From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Oct 2011 14:11:24 +0100
Subject: [PATCH] asm-generic/gpio.h: merge basic gpiolib wrappers
In-Reply-To: <1319720503-3183-1-git-send-email-vapier@gentoo.org>
References: <1319528012-19006-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1319720503-3183-1-git-send-email-vapier@gentoo.org>
Message-ID: <20111027131124.GK19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2011 at 09:01:43AM -0400, Mike Frysinger wrote:
> diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
> index d494001..622851c 100644
> --- a/include/asm-generic/gpio.h
> +++ b/include/asm-generic/gpio.h
> @@ -170,6 +170,29 @@ extern int __gpio_cansleep(unsigned gpio);
>  
>  extern int __gpio_to_irq(unsigned gpio);
>  
> +#ifndef gpio_get_value
> +#define gpio_get_value(gpio) __gpio_get_value(gpio)
> +#endif
> +
> +#ifndef gpio_set_value
> +#define gpio_set_value(gpio, value) __gpio_set_value(gpio, value)
> +#endif
> +
> +#ifndef gpio_cansleep
> +#define gpio_cansleep(gpio) __gpio_cansleep(gpio)
> +#endif
> +
> +#ifndef gpio_to_irq
> +#define gpio_to_irq(gpio) __gpio_to_irq(gpio)
> +#endif
> +
> +#ifndef irq_to_gpio
> +static inline int irq_to_gpio(unsigned int irq)
> +{
> +	return -EINVAL;
> +}
> +#endif
> +

This is extremely dangerous.  Consider for example this code
(see ARM mach-davinci's gpio.h):

#include <asm-generic/gpio.h>

static inline int gpio_get_value(unsigned gpio)
{
        struct davinci_gpio_controller *ctlr;

        if (!__builtin_constant_p(gpio) || gpio >= davinci_soc_info.gpio_num)
                return __gpio_get_value(gpio);

        ctlr = __gpio_to_controller(gpio);
        return __gpio_mask(gpio) & __raw_readl(ctlr->in_data);
}

The result with your changes above will be:

static inline int __gpio_get_value(unsigned gpio)
{
        struct davinci_gpio_controller *ctlr;

        if (!__builtin_constant_p(gpio) || gpio >= davinci_soc_info.gpio_num)
                return __gpio_get_value(gpio);

        ctlr = __gpio_to_controller(gpio);
        return __gpio_mask(gpio) & __raw_readl(ctlr->in_data);
}

and notice the recursive call there.

This is why I didn't solve this using the preprocessor method in ARM, but
instead used __ARM_GPIOLIB_COMPLEX to control whether these definitions
are required.
