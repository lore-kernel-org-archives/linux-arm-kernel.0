From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Sep 2011 09:49:38 +0100
Subject: [PATCH] gpio: rewrite U300 GPIO to use gpiolib
In-Reply-To: <1315297950-12720-1-git-send-email-linus.walleij@stericsson.com>
References: <1315297950-12720-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110906084938.GI6619@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2011 at 10:32:30AM +0200, Linus Walleij wrote:
> This is based on top of the pending GPIO cleanups in Russells
> tree, if I can get some ACK on this I presume Russell can
> apply it to his branch.

> diff --git a/arch/arm/mach-u300/include/mach/gpio.h b/arch/arm/mach-u300/include/mach/gpio.h
> index 430a054..ba224b5 100644
> --- a/arch/arm/mach-u300/include/mach/gpio.h
> +++ b/arch/arm/mach-u300/include/mach/gpio.h
> @@ -13,35 +13,15 @@
>  #ifndef __MACH_U300_GPIO_H
>  #define __MACH_U300_GPIO_H
>  
> +#include <linux/io.h>
> +#include <mach/hardware.h>
> +#include <asm/irq.h>
> +#include <asm-generic/gpio.h>
>  
> +/* Map these overrides to gpiolib functions, simply */
> +#define gpio_get_value  __gpio_get_value
> +#define gpio_set_value  __gpio_set_value
> +#define gpio_cansleep   __gpio_cansleep
> +#define gpio_to_irq     __gpio_to_irq
>  
> +#endif

This is how mach/gpio.h ends up looking - two things:

1. is there any reason for asm/irq.h and linux/io.h in there?
2. asm/gpio.h already includes asm-generic/gpio.h and defines
   the dispatchers for the trivial case.

So, I think this is how it should look:

#ifndef __MACH_U300_GPIO_H
#define __MACH_U300_GPIO_H
#include <mach/hardware.h>
#endif

Or even just:

/* empty */

if mach/hardware.h include is not required for ARCH_NR_GPIOS.
