From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 7 Sep 2011 11:02:07 -0700
Subject: [PATCH v2] gpio: rewrite U300 GPIO to use gpiolib
In-Reply-To: <1315383085-26352-1-git-send-email-linus.walleij@stericsson.com>
References: <1315383085-26352-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110907180207.GC9937@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2011 at 10:11:25AM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This rewrites the U300 GPIO so as to use gpiolib and
> struct gpio_chip instead of just generic GPIO, hiding
> all the platform specifics and passing in GPIO chip
> variant as platform data at runtime instead of the
> compiletime kludges.
> 
> As a result <mach/gpio.h> is now empty for U300 and
> using just defaults.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Debian kernel maintainers <debian-kernel@lists.debian.org>
> Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
> Reported-by: Ben Hutchings <ben@decadent.org.uk>
> Signed-off-nu: Linus Walleij <linus.walleij@linaro.org>
             ^^
Your keyboard needs to be shifted 1cm to the right. :-)

I'll pick it up, but there are some things that I've commented on
below that needs to be addressed in follow up patches.

> ---
>  arch/arm/Kconfig                            |    1 +
>  arch/arm/mach-u300/Kconfig                  |    1 +
>  arch/arm/mach-u300/core.c                   |   31 +-
>  arch/arm/mach-u300/include/mach/gpio-u300.h |  149 +---
>  arch/arm/mach-u300/include/mach/gpio.h      |   47 --
>  arch/arm/mach-u300/include/mach/irqs.h      |   25 +-
>  drivers/gpio/Kconfig                        |    9 +
>  drivers/gpio/gpio-u300.c                    | 1189 ++++++++++++++++-----------
>  8 files changed, 783 insertions(+), 669 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index f23712d..3f38a7f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -831,6 +831,7 @@ config ARCH_U300
>  	select CLKDEV_LOOKUP
>  	select HAVE_MACH_CLKDEV
>  	select GENERIC_GPIO
> +	select ARCH_REQUIRE_GPIOLIB
>  	help
>  	  Support for ST-Ericsson U300 series mobile platforms.
>  
> diff --git a/arch/arm/mach-u300/Kconfig b/arch/arm/mach-u300/Kconfig
> index 966a5a0..39e077e 100644
> --- a/arch/arm/mach-u300/Kconfig
> +++ b/arch/arm/mach-u300/Kconfig
> @@ -6,6 +6,7 @@ comment "ST-Ericsson Mobile Platform Products"
>  
>  config MACH_U300
>  	bool "U300"
> +	select GPIO_U300
>  
>  comment "ST-Ericsson U300/U330/U335/U365 Feature Selections"
>  
> diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
> index 724037e..2f1d758 100644
> --- a/arch/arm/mach-u300/core.c
> +++ b/arch/arm/mach-u300/core.c
> @@ -38,6 +38,7 @@
>  #include <mach/hardware.h>
>  #include <mach/syscon.h>
>  #include <mach/dma_channels.h>
> +#include <mach/gpio-u300.h>
>  
>  #include "clock.h"
>  #include "mmc.h"
> @@ -223,7 +224,7 @@ static struct resource gpio_resources[] = {
>  		.end   = IRQ_U300_GPIO_PORT2,
>  		.flags = IORESOURCE_IRQ,
>  	},
> -#ifdef U300_COH901571_3
> +#if defined(CONFIG_MACH_U300_BS365) || defined(CONFIG_MACH_U300_BS335)
>  	{
>  		.name  = "gpio3",
>  		.start = IRQ_U300_GPIO_PORT3,
> @@ -236,6 +237,7 @@ static struct resource gpio_resources[] = {
>  		.end   = IRQ_U300_GPIO_PORT4,
>  		.flags = IORESOURCE_IRQ,
>  	},
> +#endif
>  #ifdef CONFIG_MACH_U300_BS335
>  	{
>  		.name  = "gpio5",
> @@ -250,7 +252,6 @@ static struct resource gpio_resources[] = {
>  		.flags = IORESOURCE_IRQ,
>  	},
>  #endif /* CONFIG_MACH_U300_BS335 */
> -#endif /* U300_COH901571_3 */

This looks suspect because it doesn't look mulitplatform friendly, but
I understand if it is a stop-gap until U300 is made multiplatform
friendly.

>  };
>  
>  static struct resource keypad_resources[] = {
> @@ -1495,11 +1496,35 @@ static struct platform_device i2c1_device = {
>  	.resource = i2c1_resources,
>  };
>  
> +/*
> + * The different variants have a few different versions of the
> + * GPIO block, with different number of ports.
> + */
> +static struct u300_gpio_platform u300_gpio_plat = {
> +#if defined(CONFIG_MACH_U300_BS2X) || defined(CONFIG_MACH_U300_BS330)
> +	.variant = U300_GPIO_COH901335,
> +	.ports = 3,
> +#endif
> +#ifdef CONFIG_MACH_U300_BS335
> +	.variant = U300_GPIO_COH901571_3_BS335,
> +	.ports = 7,
> +#endif
> +#ifdef CONFIG_MACH_U300_BS365
> +	.variant = U300_GPIO_COH901571_3_BS365,
> +	.ports = 5,
> +#endif
> +	.gpio_base = 0,
> +	.gpio_irq_base = IRQ_U300_GPIO_BASE,
> +};

Ditto here.  The goal is to allow supporting all variants from the
same kernel.  I won't outright nack the patch over this, but I'm not
happy and I expect a commitment to fix it.

>  	/* Port 6, pind 0-7 */
>  	{
> -		{GPIO_IN,  DEFAULT_OUTPUT_LOW,   DISABLE_PULL_UP},
> -		{GPIO_IN,  DEFAULT_OUTPUT_LOW,   DISABLE_PULL_UP},
> -		{GPIO_IN,  DEFAULT_OUTPUT_LOW,   DISABLE_PULL_UP},
> -		{GPIO_IN,  DEFAULT_OUTPUT_LOW,   DISABLE_PULL_UP},
> -		{GPIO_IN,  DEFAULT_OUTPUT_LOW,   DISABLE_PULL_UP},
> -		{GPIO_IN,  DEFAULT_OUTPUT_LOW,   DISABLE_PULL_UP},
> -		{GPIO_IN,  DEFAULT_OUTPUT_LOW,   DISABLE_PULL_UP},
> -		{GPIO_IN,  DEFAULT_OUTPUT_LOW,   DISABLE_PULL_UP}
> +		U300_FLOATING_INPUT,
> +		U300_FLOATING_INPUT,
> +		U300_FLOATING_INPUT,
> +		U300_FLOATING_INPUT,
> +		U300_FLOATING_INPUT,
> +		U300_FLOATING_INPUT,
> +		U300_FLOATING_INPUT,
> +		U300_FLOATING_INPUT,

This syntax should work, be a lot less verbose, and I do like seeing
explicit array indexes:

	[ 0 ... 7 ] = U300_FLOATING_INPUT,

> +	/* Add each port with its IRQ separately */
> +	INIT_LIST_HEAD(&gpio->port_list);
> +	for (portno = 0 ; portno < plat->ports; portno++) {
> +		struct u300_gpio_port *port =
> +			kmalloc(sizeof(struct u300_gpio_port), GFP_KERNEL);

devm_kzalloc(), although I understand that you're refactoring existing
code, so that change would be best in a separate patch.

>  
> -static int __exit gpio_remove(struct platform_device *pdev)
> +static int __exit u300_gpio_remove(struct platform_device *pdev)

Just noticed an existing bug; should be __devexit

> -static struct platform_driver gpio_driver = {
> +static struct platform_driver u300_gpio_driver = {
>  	.driver		= {
>  		.name	= "u300-gpio",
>  	},
> -	.remove		= __exit_p(gpio_remove),
> +	.remove		= __exit_p(u300_gpio_remove),

__devexit_p
