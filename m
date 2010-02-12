From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 12 Feb 2010 21:06:09 +0100
Subject: [PATCH 07/14] ARM: LPC32XX: Misc support functions
In-Reply-To: <1265674295-23996-8-git-send-email-wellsk40@gmail.com>
References: <1265674295-23996-1-git-send-email-wellsk40@gmail.com>
	<1265674295-23996-8-git-send-email-wellsk40@gmail.com>
Message-ID: <20100212200609.GA947@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

> +/*
> + * Detects and returns IRAM size for the device variation
> + */
> +#define LPC32XX_IRAM_BANK_SIZE (128 * SZ_1K)
SZ_128K ?

> +static u32 iram_size;
> +u32 lpc32xx_return_iram_size(void)
> +{
> +	if (iram_size == 0) {
> +		u32 savedval;
> +		void __iomem *iramptr1, *iramptr2;
> +
> +		iramptr1 = io_p2v(LPC32XX_IRAM_BASE);
> +		iramptr2 = io_p2v(LPC32XX_IRAM_BASE + LPC32XX_IRAM_BANK_SIZE);
> +		savedval = __raw_readl(iramptr2);
> +
> +		__raw_writel(savedval + 1, iramptr2);
> +
> +		/*
> +		 * If IRAM size is 128K, the value at iramptr2 will wrap back
> +		 * into iramptr1
> +		 */
> +		if (__raw_readl(iramptr1) == __raw_readl(iramptr2))
> +			iram_size = LPC32XX_IRAM_BANK_SIZE;
> +		else
> +			iram_size = LPC32XX_IRAM_BANK_SIZE * 2;
> +
> +		__raw_writel(savedval, iramptr2);
> +	}
> +
> +	return iram_size;
> +}
I didn't understand this.  The size of IRAM is either 128KiB or 256KiB,
right.  And if it's 128KiB it's mirrored.

So if the content of a 256KiB IRAM happens to be

	00000:  00000001 ....
	...
	20000:  00000000 ....

the above code does

	savedval = 8
	IRAM[20000] = 1
	iram_size = LPC32XX_IRAM_BANK_SIZE;

IMHO you should do:

	savedval1 = __raw_readl(iramptr1);
	savedval2 = __raw_readl(iramptr2);

	if (savedval1 == savedval2) {
		__raw_writel(savedval2 + 1, iramptr2);
		if (__raw_readl(iramptr1) == savedval2 + 1)
			iram_size = LPC32XX_IRAM_BANK_SIZE;
		else
			iram_size = 2 * LPC32XX_IRAM_BANK_SIZE;
		__raw_writel(savedval2, iramptr2);
	} else
		iram_size = 2 * LPC32XX_IRAM_BANK_SIZE;

> diff --git a/arch/arm/mach-lpc32xx/common.h b/arch/arm/mach-lpc32xx/common.h
> new file mode 100644
> index 0000000..8161efe
> --- /dev/null
> +++ b/arch/arm/mach-lpc32xx/common.h
> @@ -0,0 +1,75 @@
> +/*
> + * arch/arm/mach-lpc32xx/common.h
> + *
> + * Author: Kevin Wells <kevin.wells@nxp.com>
> + *
> + * Copyright (C) 2009-2010 NXP Semiconductors
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __LPC32XX_COMMON_H
> +#define __LPC32XX_COMMON_H
> +
> +#include <linux/platform_device.h>
> +
> +/*
> + * Arch specific platform device structures
> + */
> +extern struct platform_device watchdog_device;
lpc32xx_watchdoc_device?

> +extern struct platform_device i2c0_device;
> +extern struct platform_device i2c1_device;
> +extern struct platform_device i2c2_device;
I prefer using functions to add these devices because then it's easier
to add support for now SoCs that happen to have the watchdog at a
different address.  Then you can just do:

	static struct resource watchdog_resources[] __initdata = {
		{
			.flags = ...;
		},
	};
	int __init lpc32xx_add_watchdog(void)
	{
		if (cpu_is_lpc3212()) {
			watchdog_resources[0].start = LPC3212_WATCHDOG_BASE;
		} else if (cpu_is_lpc3214()) {
			watchdog_resources[0].start = LPC3214_WATCHDOG_BASE;
		} else
			return -ENODEV;

		watchdog_resources[0].end = watchdog_resources[0].start + SZ_4K;

		....

	}

or something similar.  Another variation is:

	static struct resource watchdog_resources[] __initdata = {
		...
	}

	int __init lpc32xx_add_watchdog(sometype baseaddr)
	{
		watchdog_resources[0].start = base;
		...
	}

and then in a header do:

	#define lpc3212_add_watchdog() lpc32xx_add_watchdog(LPC3212_WATCHDOG_BASE)
	#define lpc3214_add_watchdog() lpc32xx_add_watchdog(LPC3214_WATCHDOG_BASE)

or provide an inline function.

When providing platform_devices as in your patch you have to do:

	extern struct platform_device lpc3212_watchdog_device;
	extern struct platform_device lpc3214_watchdog_device;

and at least in a kernel that supports both SoCs one or the other only
sits in RAM doing nothing.

But YMMV.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
