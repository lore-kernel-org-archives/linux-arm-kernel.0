From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 30 Nov 2010 11:25:05 +0100
Subject: [PATCH v2 03/15] ARM: mxs: Add reset routines
In-Reply-To: <1291031956-30314-3-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291031956-30314-3-git-send-email-shawn.guo@freescale.com>
Message-ID: <20101130102505.GG20449@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Nov 29, 2010 at 07:59:13PM +0800, Shawn Guo wrote:
>  - The mxs wdog is implemented in RTC block.
>  - There is a generic software reset routine for most modules on mxs.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
> Changes for v2:
>  - Move rtc clock enabling from arch_reset() into mxs_arch_reset_init()
> 
>  arch/arm/mach-mxs/include/mach/system.h |   27 ++++++
>  arch/arm/mach-mxs/system.c              |  152 +++++++++++++++++++++++++++++++
>  2 files changed, 179 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/include/mach/system.h
>  create mode 100644 arch/arm/mach-mxs/system.c
> 
> diff --git a/arch/arm/mach-mxs/include/mach/system.h b/arch/arm/mach-mxs/include/mach/system.h
> new file mode 100644
> index 0000000..0e42823
> --- /dev/null
> +++ b/arch/arm/mach-mxs/include/mach/system.h
> @@ -0,0 +1,27 @@
> +/*
> + *  Copyright (C) 1999 ARM Limited
> + *  Copyright (C) 2000 Deep Blue Solutions Ltd
> + *  Copyright 2004-2008 Freescale Semiconductor, Inc. All Rights Reserved.
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
> +#ifndef __MACH_MXS_SYSTEM_H__
> +#define __MACH_MXS_SYSTEM_H__
> +
> +static inline void arch_idle(void)
> +{
> +	cpu_do_idle();
> +}
> +
> +void arch_reset(char mode, const char *cmd);
> +
> +#endif /* __MACH_MXS_SYSTEM_H__ */
> diff --git a/arch/arm/mach-mxs/system.c b/arch/arm/mach-mxs/system.c
> new file mode 100644
> index 0000000..7ad73bf
> --- /dev/null
> +++ b/arch/arm/mach-mxs/system.c
> @@ -0,0 +1,152 @@
> +/*
> + * Copyright (C) 1999 ARM Limited
> + * Copyright (C) 2000 Deep Blue Solutions Ltd
> + * Copyright 2006-2007,2010 Freescale Semiconductor, Inc. All Rights Reserved.
> + * Copyright 2008 Juergen Beisert, kernel at pengutronix.de
> + * Copyright 2009 Ilya Yanok, Emcraft Systems Ltd, yanok at emcraft.com
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
> +#include <linux/kernel.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/delay.h>
> +
> +#include <asm/proc-fns.h>
> +#include <asm/system.h>
> +
> +#include <mach/hardware.h>
> +#include <mach/common.h>
> +
> +#define MXS_RTC_WATCHDOG	0x50
> +#define MXS_WATCHDOG_EN		(1 << 4)
> +
> +#define MXS_MODULE_CLKGATE	(1 << 30)
> +#define MXS_MODULE_SFTRST	(1 << 31)
> +
> +static void __iomem *wdog_base;
> +
> +/*
> + * Reset the system. It is called by machine_restart().
> + */
> +void arch_reset(char mode, const char *cmd)
> +{
> +	/* Set wdog count */
> +	__raw_writel(1, wdog_base + MXS_RTC_WATCHDOG);
Which unit is used here?  Does the timer only start running when it's
enabled below?  Does this apply when the watchdog is already in use,
too?

> +
> +	/* Assert SRS signal */
> +	__raw_writel(MXS_WATCHDOG_EN, wdog_base + MXS_SET_ADDR);
> +
> +	/* Wait for reset to assert... */
> +	mdelay(500);
> +
> +	pr_err("Watchdog reset failed to assert reset\n");
> +
> +	/* Delay to allow the serial port to show the message */
> +	mdelay(50);
> +
> +	/* We'll take a jump through zero as a poor second */
> +	cpu_reset(0);
> +}
> +
> +void mxs_arch_reset_init(void __iomem *base)
> +{
> +	struct clk *clk;
> +
> +	wdog_base = base;
> +
> +	clk = clk_get_sys("rtc", NULL);
> +	if (!IS_ERR(clk))
> +		clk_enable(clk);
Actually I'm not sure if it's worth to do this.  It might hurt if you
want to save power.

I'll try to find a time slot to look into that.

> +}
> +
> +int mxs_reset_block(void __iomem *reset_addr)
> +{
> +	u32 val;
> +	int timeout;
> +
> +	/*
> +	 * The process of software reset of IP block is done
> +	 * in several steps:
> +	 *
> +	 * 1) clear SFTRST and wait it cleared;
> +	 * 2) clear CLKGATE, set SFTRST, wait CLKGATE set;
> +	 * 3) clear SFTRST and wait it cleared;
> +	 * 4) clear CLKGATE and wait it cleared.
> +	 */
> +
> +	/* Clear SFTRST */
> +	val = __raw_readl(reset_addr);
> +	val &= ~MXS_MODULE_SFTRST;
> +	__raw_writel(val, reset_addr);

__raw_writel(MXS_MODULE_SFTRST, reset_addr + MXS_CLEAR_ADDR);

instead of read-modify-write here doesn't work here?

> +	/*
> +	 * SFTRST needs 3 GPMI clocks to settle, the reference manual
> +	 * recommends to wait 1us.
> +	 */
> +	udelay(1);
> +	/* Poll SFTRST cleared */
> +	timeout = 0x400;
> +	while ((__raw_readl(reset_addr) & MXS_MODULE_SFTRST) && --timeout)
> +		/* nothing */;
> +	if (!timeout)
Maybe add an unlikely here?  (i.e.

	if (unlikely(!timeout))
		...
)

> +		goto error;
> +
> +	/* Clear CLKGATE */
> +	val = __raw_readl(reset_addr);
Not sure it's worth to optimize here, but you read reset_addr above.

> +	val &= ~MXS_MODULE_CLKGATE;
> +	__raw_writel(val, reset_addr);
> +	/* Set SFTRST to reset the block */
> +	val = __raw_readl(reset_addr);
> +	val |= MXS_MODULE_SFTRST;
> +	__raw_writel(val, reset_addr);
> +	/* Wait 1us */
> +	udelay(1);
The comment doesn't help much.

> +	/* Poll CLKGATE set */
> +	timeout = 0x400;
> +	while ((!(__raw_readl(reset_addr) & MXS_MODULE_CLKGATE)) && --timeout)
> +		/* nothing */;
> +	if (!timeout)
> +		goto error;
> +
> +	/* Clear SFTRST */
> +	val = __raw_readl(reset_addr);
> +	val &= ~MXS_MODULE_SFTRST;
> +	__raw_writel(val, reset_addr);
> +	/* Wait 1us */
> +	udelay(1);
> +	/* Poll SFTRST cleared */
> +	timeout = 0x400;
> +	while ((__raw_readl(reset_addr) & MXS_MODULE_SFTRST) && --timeout)
> +		/* nothing */;
> +	if (!timeout)
> +		goto error;
> +
> +	/* Clear CLKGATE */
> +	val = __raw_readl(reset_addr);
> +	val &= ~MXS_MODULE_CLKGATE;
> +	__raw_writel(val, reset_addr);
> +	/* Wait 1us */
> +	udelay(1);
> +	/* Poll CLKGATE cleared */
> +	timeout = 0x400;
> +	while ((__raw_readl(reset_addr) & MXS_MODULE_CLKGATE) && --timeout)
> +		/* nothing */;
> +	if (!timeout)
> +		goto error;

There are quite some repetitions in this function.  If you could get it
down to something that looks like

	clear SFTRST
	udelay
	poll SFTRST cleared

	clear CLKGATE
	set SFTRST
	udelay
	poll CLKGATE set

	clear SFTRST
	udelay
	poll SFTRST cleared

	clear CLKGATE
	udelay
	poll CLKGATE cleared

it's IMHO better than the comment above.  If "clear CLKGATE" and "set
SFTRST" can be done in a single step this might be done like that:

	/* comment describing setmask_poll */
	static int setmask_poll(void __iomem *addr, u32 set, u32 mask,
		u32 pollval, u32 pollmask, u32 *curval)
	{
		int timeout = 0x400;

		*curval &= ~mask;
		*curval |= set;
		__raw_writel(*curval, addr)

		/*
		 * some nice comment about 1us being a good idea
		 */
		udelay(1);

		do {
			*curval = __raw_readl(addr);
			if ((*curval & pollmask) == pollval)
				return 0;

		} while(--timeout);

		return 1;
	}

	int mxs_reset_block(void __iomem *reset_addr)
	{
		u32 val = __raw_readl(reset_addr);
		int ret;

		/* clear SFTRST and poll SFTRST becoming clear */
		ret = setmask_poll(reset_addr,
			0, MXS_MODULE_SFTRST,
			0, MXS_MODULE_SFTRST, &val);
		if (ret)
			goto error;

		/* clear CLKGATE, set SFTRST and poll CLKGATE becoming set */
		ret = setmask_poll(reset_addr,
			MXS_MODULE_SFTRST, MXS_MODULE_SFTRST | MXS_MODULE_CLKGATE,
			0, MXS_MODULE_CLKGATE, &val);
		if (ret)
			goto error;

		...
	}

Well, not very nice, but IMHO better that your code.  Maybe
mxs_reset_block fits in a Terminal that way without decreasing the font
size :-)

> +
> +	return 0;
> +
> +error:
> +	pr_err("%s(%p): module reset timeout\n", __func__, reset_addr);
> +	return -ETIMEDOUT;
> +}
> -- 
> 1.7.1
> 
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
