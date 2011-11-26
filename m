From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 26 Nov 2011 03:53:35 +0000
Subject: [PATCH 6/7] ARM: pxa: enable pinmux mapping in zylonite
In-Reply-To: <1322262544-7854-7-git-send-email-haojian.zhuang@marvell.com>
References: <1322262544-7854-1-git-send-email-haojian.zhuang@marvell.com>
 <1322262544-7854-7-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <201111260353.36899.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 November 2011, Haojian Zhuang wrote:
> Remove MFP operation in zylonite. Use pinmux mapping instead.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  arch/arm/mach-pxa/Kconfig                 |    1 +
>  arch/arm/mach-pxa/devices.c               |   15 ++
>  arch/arm/mach-pxa/devices.h               |    1 +
>  arch/arm/mach-pxa/include/mach/zylonite.h |    2 +
>  arch/arm/mach-pxa/pxa3xx.c                |    1 +
>  arch/arm/mach-pxa/zylonite.c              |    6 +
>  arch/arm/mach-pxa/zylonite_pxa300.c       |  298 +++++++++++------------------
>  arch/arm/mach-pxa/zylonite_pxa320.c       |  211 +++++----------------
>  8 files changed, 183 insertions(+), 352 deletions(-)

This looks quite nice overall, but there is one thing that made me wonder if there
should be a better way to express it:

> +#define COMMON_PINMUX_MAP()					\
> +	{							\
> +		.name = "uart2",				\
> +		.ctrl_dev_name = "pinctrl.0",			\
> +		.function = "uart2",				\
> +		.dev_name = "pxa2xx-uart.2",			\
> +		.group = "stuart1",				\
> +		.hog_on_boot = true,				\
> +	}, {							\
> +		.name = "key",					\
> +		.ctrl_dev_name = "pinctrl.0",			\
> +		.function = "key",				\
> +		.dev_name = "pxa27x-keyboard",			\
> +		.group = "key0",				\
> +		.hog_on_boot = true,				\
> +	}, {							\
> +		.name = "mmc1",					\
> +		.ctrl_dev_name = "pinctrl.0",			\
> +		.function = "mmc1",				\
> +		.group = "mmc1_0",				\
> +		.hog_on_boot = true,				\
> +	},							\
> +	PINMUX_MAP_PRIMARY_SYS_HOG("mmc2", "mmc2"),		\
> +	PINMUX_MAP_PRIMARY_SYS_HOG("usbh", "usbh"),		\
> +	PINMUX_MAP_PRIMARY_SYS_HOG("ac97", "ac97"),		\
> +	PINMUX_MAP_PRIMARY_SYS_HOG("smc", "smc"),		\
> +	PINMUX_MAP_PRIMARY("pwm3", "pwm3", "pxa27x-pwm.1"),	\
> +	PINMUX_MAP_PRIMARY("uart1", "uart1", "pxa2xx-uart.1"),	\
> +	PINMUX_MAP_PRIMARY("ssp3", "ssp3", "pxa27x-ssp.2"),	\
> +	PINMUX_MAP_PRIMARY("lcd", "lcd", "pxa2xx-fb"),		\
> +	PINMUX_MAP_PRIMARY("i2c", "i2c", "pxa2xx-i2c.0")
> +
> +static struct pinmux_map pxa300_pmx_map[] = {
> +	COMMON_PINMUX_MAP(),
> +	{
> +		.name = "uart0",
> +		.ctrl_dev_name = "pinctrl.0",
> +		.function = "uart0",
> +		.dev_name = "pxa2xx-uart.0",
> +		.group = "ffuart0",
> +	},
>  };

I think we should not be forced to use macros like this in order to extend a common
pinmux mapping. Unfortunately, I can't see an easy way to do it differently
with the pinmux core, but it might not be too late to extend the interfaces now.

I also noticed that the pinmux_map arrays are not marked __initdata, because
it gets referenced later. This means that in a kernel that supports many machines,
we also have to keep all pinmux configurations around at runtime.

Linus, what do you think about changing the pinmux_register_mappings function
to make a copy of the data in order to let the platform code mark the data as
__initdata, and to allow appending the maps at boot time so that the above
can become two arrays that are registered individually?

>  		/* GPIO pin assignment */
> -		gpio_eth_irq	= mfp_to_gpio(MFP_PIN_GPIO9);
> +		gpio_eth_irq	= 90;
> +#if 0
> +		/* FIXME: can't support additional gpio pins */
>  		gpio_debug_led1	= mfp_to_gpio(MFP_PIN_GPIO1_2);
>  		gpio_debug_led2	= mfp_to_gpio(MFP_PIN_GPIO4_2);
> +#endif

If I read this correctly, your comment here refers to a different aspect of the
same problem, not being able to amend the mapping at a later point.

	Arnd
