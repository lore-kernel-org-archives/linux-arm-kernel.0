From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Dec 2010 09:05:05 +0000
Subject: [PATCH] S5PC210: universal: update support pmic for c210
	universal board
In-Reply-To: <1293094587-12502-1-git-send-email-dh09.lee@samsung.com>
References: <1293094587-12502-1-git-send-email-dh09.lee@samsung.com>
Message-ID: <20101223090504.GA3636@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 23, 2010 at 05:56:27PM +0900, Donghwa Lee wrote:
> @@ -11,10 +11,14 @@
>  #include <linux/serial_core.h>
>  #include <linux/input.h>
>  #include <linux/i2c.h>
> +#include <linux/i2c-gpio.h>
>  #include <linux/gpio_keys.h>
>  #include <linux/gpio.h>

linux/gpio.h included here.

> +#include <linux/fb.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/regulator/fixed.h>
> +#include <linux/regulator/max8952.h>
> +#include <linux/mfd/max8998.h>
>  #include <linux/mmc/host.h>
>  
>  #include <asm/mach/arch.h>
> @@ -25,8 +29,15 @@
>  #include <plat/cpu.h>
>  #include <plat/devs.h>
>  #include <plat/sdhci.h>
> +#include <plat/gpio-cfg.h>
> +#include <plat/gpio-core.h>
> +#include <plat/regs-fb.h>
> +#include <plat/clock.h>
> +#include <plat/iic.h>
>  
> +#include <mach/gpio.h>

So you don't need mach/gpio.h, because:

=== linux/gpio.h ===
#ifndef __LINUX_GPIO_H
#define __LINUX_GPIO_H

/* see Documentation/gpio.txt */

#ifdef CONFIG_GENERIC_GPIO
#include <asm/gpio.h>

#else
...

=== asm/gpio.h ===
#ifndef _ARCH_ARM_GPIO_H
#define _ARCH_ARM_GPIO_H

/* not all ARM platforms necessarily support this API ... */
#include <mach/gpio.h>

#endif /* _ARCH_ARM_GPIO_H */

It gets included via linux/gpio.h.

Don't add asm/gpio.h OR mach/gpio.h includes.  Use linux/gpio.h instead.
