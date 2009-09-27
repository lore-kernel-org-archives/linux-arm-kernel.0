From: ben-linux@fluff.org (Ben Dooks)
Date: Sun, 27 Sep 2009 07:18:02 +0100
Subject: [PATCH v2 2/5] Add basic HP iPAQ rx1950 support
In-Reply-To: <4abe82e2.0405560a.5ebe.428d@mx.google.com>
References: <4abe82e2.0405560a.5ebe.428d@mx.google.com>
Message-ID: <20090927061802.GL31920@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 27, 2009 at 12:03:40AM +0300, Vasily Khoruzhick wrote:
> 

> From 1490cd5bd21d387b122332edfb2537437d3cb1f3 Mon Sep 17 00:00:00 2001
> From: Vasily Khoruzhick <anarsoul@gmail.com>
> Date: Thu, 24 Sep 2009 21:58:36 +0300
> Subject: [PATCH v2 2/5] Add basic HP iPAQ rx1950 support
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  arch/arm/mach-s3c2442/Kconfig       |   10 +
>  arch/arm/mach-s3c2442/Makefile      |    2 +-
>  arch/arm/mach-s3c2442/mach-rx1950.c |  368 +++++++++++++++++++++++++++++++++++
>  3 files changed, 379 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-s3c2442/mach-rx1950.c
> 
> diff --git a/arch/arm/mach-s3c2442/Kconfig b/arch/arm/mach-s3c2442/Kconfig
> index 103e913..e12faf4 100644
> --- a/arch/arm/mach-s3c2442/Kconfig
> +++ b/arch/arm/mach-s3c2442/Kconfig
> @@ -36,6 +36,16 @@ config MACH_NEO1973_GTA02
>  	help
>  	   Say Y here if you are using the Openmoko GTA02 / Freerunner GSM Phone
>  
> +config MACH_RX1950
> +	bool "HP iPAQ rx1950"
> +	select CPU_S3C2442
> +	select PM_H1940 if PM
> +	select I2C
> +	select S3C2410_PWM
> +	select S3C2410_IOTIMING if S3C2440_CPUFREQ
> +	select S3C2440_XTAL_16934400
> +	help
> +	   Say Y here if you're using HP iPAQ rx1950
>  
>  endmenu
>  
> diff --git a/arch/arm/mach-s3c2442/Makefile b/arch/arm/mach-s3c2442/Makefile
> index 2a19113..e40caa8 100644
> --- a/arch/arm/mach-s3c2442/Makefile
> +++ b/arch/arm/mach-s3c2442/Makefile
> @@ -13,6 +13,6 @@ obj-$(CONFIG_CPU_S3C2442)	+= s3c2442.o
>  obj-$(CONFIG_CPU_S3C2442)	+= clock.o
>  
>  obj-$(CONFIG_MACH_NEO1973_GTA02) += mach-gta02.o
> -
> +obj-$(CONFIG_MACH_RX1950)   += mach-rx1950.o
>  # Machine support

you managed to take out a blank line, please don't do that.
  
> diff --git a/arch/arm/mach-s3c2442/mach-rx1950.c b/arch/arm/mach-s3c2442/mach-rx1950.c
> new file mode 100644
> index 0000000..c1390ba
> --- /dev/null
> +++ b/arch/arm/mach-s3c2442/mach-rx1950.c
> @@ -0,0 +1,368 @@
> +/* linux/arch/arm/mach-s3c2440/mach-rx1950.c
> + *
> + * Copyright (c) 2006-2009 Victor Chukhantsev, Denis Grigoriev,
> + * Copyright (c) 2007-2009 Vasily Khoruzhick

would be good to get the acked-by for the other two authours on this.

> + * based on smdk2440 written by Ben Dooks
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> +*/
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/interrupt.h>
> +#include <linux/list.h>
> +#include <linux/delay.h>
> +#include <linux/timer.h>
> +#include <linux/init.h>
> +#include <linux/gpio.h>
> +#include <linux/platform_device.h>
> +#include <linux/serial_core.h>
> +#include <linux/input.h>
> +#include <linux/gpio_keys.h>
> +#include <linux/sysdev.h>
> +#include <linux/pwm_backlight.h>
> +#include <linux/pwm.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/mmc/host.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +#include <asm/mach-types.h>
> +#include <mach/regs-gpio.h>
> +#include <mach/regs-gpioj.h>
> +#include <mach/h1940.h>
> +#include <mach/fb.h>
> +#include <plat/regs-serial.h>
> +#include <plat/regs-iic.h>
> +#include <plat/mci.h>
> +#include <plat/udc.h>
> +#include <plat/nand.h>
> +#include <plat/iic.h>
> +#include <plat/devs.h>
> +#include <plat/cpu.h>
> +#include <plat/pm.h>
> +#include <plat/irq.h>

hmm, blank lines between the groups on includes?

> +static struct map_desc rx1950_iodesc[] __initdata = {
> +	/* ISA IO Space map (memory space selected by A24) */
> +	{
> +	 .virtual = (u32) S3C24XX_VA_ISA_WORD,
> +	 .pfn = __phys_to_pfn(S3C2410_CS2),
> +	 .length = 0x10000,
> +	 .type = MT_DEVICE,
> +	 },
> +	{
> +	 .virtual = (u32) S3C24XX_VA_ISA_WORD + 0x10000,
> +	 .pfn = __phys_to_pfn(S3C2410_CS2 + (1 << 24)),
> +	 .length = SZ_4M,
> +	 .type = MT_DEVICE,
> +	 },
> +};
> +
> +static struct s3c24xx_uart_clksrc rx1950_serial_clocks[] = {
> +	[0] = {
> +	       .name = "fclk",
> +	       .divisor = 0x0a,
> +	       .min_baud = 0,
> +	       .max_baud = 0,
> +	       }
> +};

the closing bracket should be as thus:


	[0] = {
		...stuff...
	},

note, level and addition of ,
lots of these that need to be fixed.

> +static int rx1950_backlight_notify(int brightness)
> +{
> +	static int disabled = 1;
> +	if (!brightness) {
> +		if (!disabled) {
> +			s3c2410_gpio_setpin(S3C2410_GPB(0), 0);
> +			s3c2410_gpio_pullup(S3C2410_GPB(0), 0);
> +			s3c2410_gpio_cfgpin(S3C2410_GPB(0),
> +				S3C2410_GPIO_OUTPUT);
> +		}
> +		disabled = 1;
> +	} else {
> +		if (disabled) {
> +			/* LED driver need a "push" to power on */
> +			s3c2410_gpio_setpin(S3C2410_GPB(0), 1);
> +			s3c2410_gpio_pullup(S3C2410_GPB(0), 1);
> +			/* Warm up backlight for one period of PWM.
> +			 * Without this trick its almost impossible to
> +			 * enable backlight
> +			 */
> +			ndelay(48000);
> +			s3c2410_gpio_cfgpin(S3C2410_GPB(0),
> +				S3C2410_GPB0_TOUT0);
> +		}
> +		disabled = 0;
> +	}
> +	return brightness;
> +}

Maybe this is something that should be done in the pwm-bl driver?

> +	{KEY_POWER, S3C2410_GPF(0), 1, "Power button"},

some spacing... named initialisers would have been nice too

> +static struct platform_device rx1950_device_gpiokeys = {
> +	.name = "gpio-keys",
> +	.dev = {.platform_data = &rx1950_gpio_keys_data,}
> +};

how about .dev.platform_data =  instead of brackets?

> +	/* Configuring udc pullup */
> +	s3c2410_gpio_cfgpin(S3C2440_GPJ5, S3C2410_GPIO_OUTPUT);

please use gpiolib interface, we're moving away from specific gpio set
interface.

> +	/* Configuring mmc ro sense pin */
> +	s3c2410_gpio_cfgpin(S3C2410_GPH(8), S3C2410_GPIO_INPUT);

The MMC driver should be setting this as an input.

> +	/* Configuring mmc power pin */
> +	s3c2410_gpio_setpin(S3C2440_GPJ1, S3C2410_GPIO_OUTPUT);
> +	/* mmc power is disabled by default */
> +	s3c2410_gpio_setpin(S3C2440_GPJ1, 0);
> +
> +	/* Configuring udc vbus pin */
> +	s3c2410_gpio_setpin(S3C2410_GPG(5), S3C2410_GPG5_EINT13);

no need to, the request_irq() calls the right set_type function which
implicitly sets the IRQ.

> +	/* Some udc magic */
> +	s3c2410_modify_misccr(S3C2410_MISCCR_USBHOST |
> +			      S3C2410_MISCCR_USBSUSPND0 |
> +			      S3C2410_MISCCR_USBSUSPND1, 0x0);
> +
> +	s3c24xx_udc_set_platdata(&rx1950_udc_cfg);
> +
> +	platform_add_devices(rx1950_devices, ARRAY_SIZE(rx1950_devices));
> +
> +	s3c_pm_init();
> +	s3c_irq_wake(IRQ_EINT0, 1);
> +}

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
