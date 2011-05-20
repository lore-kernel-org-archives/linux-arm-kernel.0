From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 20 May 2011 17:07:12 -0500
Subject: [PATCH 02/10] mach-u300: rewrite gpio driver, move to drivers/gpio
In-Reply-To: <20110520015022.GA3095@pulham.picochip.com>
References: <1303910002-3333-1-git-send-email-linus.walleij@stericsson.com>
	<20110519085638.GA26816@S2100-06.ap.freescale.net>
	<BANLkTinD9rAipfwNnh6QpgbcogckdtQ=OQ@mail.gmail.com>
	<20110519135631.GB26816@S2100-06.ap.freescale.net>
	<20110519191156.GE2429@pengutronix.de>
	<0D753D10438DA54287A00B027084269764D3045B3B@AUSP01VMBX24.collaborationhost.net>
	<20110520015022.GA3095@pulham.picochip.com>
Message-ID: <0D753D10438DA54287A00B027084269764D30C10DC@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, May 19, 2011 6:50 PM, Jamie Iles wrote:
>> Jamie Iles (cc'ed) posted some patches that extended the basic_mmio_gpio
>> driver so that it could be used as a library by other gpio drivers.
>> 
>> Jamie, could you re-post that series to the linux-arm-kernel list for
>> review?
>
> Grant has applied these patches but I've put them in a public branch if 
> that's OK rather than reposting:
>
>	git://github.com/jamieiles/linux-2.6-ji.git gpio

Thanks for the link.

I just noticed something in commit fdcd80cb991dac7a70433be1e336726415762b6a
"basic_mmio_gpio: split into a gpio library and platform device".

> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index d3b2953..2186d22 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -70,8 +70,14 @@ config GPIO_MAX730X
>  
>  comment "Memory mapped GPIO expanders:"
>  
> +config GPIO_BASIC_MMIO_CORE
> +       tristate
> +       help
> +         Provides core functionality for basic memory-mapped GPIO controllers.
> +
>  config GPIO_BASIC_MMIO
>         tristate "Basic memory-mapped GPIO controllers support"
> +       select GPIO_BASIC_MMIO_CORE
>         help
>           Say yes here to support basic memory-mapped GPIO controllers.
>  
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index becef59..aa9e97f 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_GPIOLIB)         += gpiolib.o
>  
>  obj-$(CONFIG_GPIO_ADP5520)     += adp5520-gpio.o
>  obj-$(CONFIG_GPIO_ADP5588)     += adp5588-gpio.o
> +obj-$(CONFIG_GPIO_BASIC_MMIO_CORE)     += basic_mmio_gpio.o
>  obj-$(CONFIG_GPIO_BASIC_MMIO)  += basic_mmio_gpio.o

I think the line above should be removed.  GPIO_BASIC_MMIO selects
GPIO_BASIC_MMIO_CORE so the line you added previous to it will cause
basic_mmio_gpio to be compiled.

GPIO_BASIC_MMIO is really just used in the driver to enable the code
at the end which creates the generic gbpio_driver.

>  obj-$(CONFIG_GPIO_LANGWELL)    += langwell_gpio.o
>  obj-$(CONFIG_GPIO_MAX730X)     += max730x.o

Regards,
Hartley
