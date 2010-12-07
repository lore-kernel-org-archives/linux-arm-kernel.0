From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 7 Dec 2010 21:27:50 +0100
Subject: [PATCH v3 03/15] ARM: mxs: Add reset routines
In-Reply-To: <1291739523-25077-2-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-2-git-send-email-shawn.guo@freescale.com>
Message-ID: <20101207202750.GB14775@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Wed, Dec 08, 2010 at 12:31:53AM +0800, Shawn Guo wrote:
>  - The mxs wdog is implemented in RTC block.
>  - There is a generic software reset routine for most modules on mxs.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
> Changes for v3:
>  - Change wdog timeout to 10ms for safety
>  - Simplify function mxs_reset_block() to get it look better
> 
> Changes for v2:
>  - Move rtc clock enabling from arch_reset() into mxs_arch_reset_init()
> 
>  arch/arm/mach-mxs/include/mach/system.h |   27 ++++++
>  arch/arm/mach-mxs/system.c              |  134 +++++++++++++++++++++++++++++++
>  2 files changed, 161 insertions(+), 0 deletions(-)
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
> index 0000000..58cb044
> --- /dev/null
> +++ b/arch/arm/mach-mxs/system.c
> @@ -0,0 +1,134 @@
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
> +	/* Set wdog timer 10 ms */
> +	__raw_writel(10, wdog_base + MXS_RTC_WATCHDOG);
> +
> +	/* Enable wdog reset */
> +	__raw_writel(MXS_WATCHDOG_EN, wdog_base + MXS_SET_ADDR);
> +
> +	/* Wait for reset to assert... */
> +	mdelay(10);
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
> +}
> +
> +/*
> + * Clear the bit and poll it cleared.  This is usually called with
> + * a reset address and mask being either SFTRST(bit 31) or CLKGATE
> + * (bit 30).
> + */
> +static int clear_poll_bit(void __iomem *addr, u32 mask)
> +{
> +	int timeout = 0x400;
> +
> +	/* clear the bit */
> +	__raw_writel(mask, addr + MXS_CLR_ADDR);
> +
> +	/*
> +	 * SFTRST needs 3 GPMI clocks to settle, the reference manual
> +	 * recommends to wait 1us.
> +	 */
> +	udelay(1);
> +
> +	/* poll the bit becoming clear */
> +	while ((__raw_readl(addr) & mask) && --timeout)
> +		/* nothing */;
> +
> +	return !timeout;
> +}
> +
> +int mxs_reset_block(void __iomem *reset_addr)
> +{
> +	int ret;
> +	int timeout = 0x400;
> +
> +	/* clear and poll SFTRST */
> +	ret = clear_poll_bit(reset_addr, MXS_MODULE_SFTRST);
> +	if (ret)
unlikely(ret)?

> +		goto error;
> +
> +	/* clear CLKGATE */
> +	__raw_writel(MXS_MODULE_CLKGATE, reset_addr + MXS_CLR_ADDR);

> +	/* set SFTRST to reset the block */
> +	__raw_writel(MXS_MODULE_SFTRST, reset_addr + MXS_SET_ADDR);
> +	udelay(1);

> +	/* poll CLKGATE becoming set */
Can you add empty lines above the comments, please.  This makes it much
easier to read.

> +	while ((!(__raw_readl(reset_addr) & MXS_MODULE_CLKGATE)) && --timeout)
> +		/* nothing */;
> +	if (unlikely(!timeout))
> +		goto error;
> +
> +	/* clear and poll SFTRST */
> +	ret = clear_poll_bit(reset_addr, MXS_MODULE_SFTRST);
> +	if (ret)
> +		goto error;
> +
> +	/* clear and poll CLKGATE */
> +	ret = clear_poll_bit(reset_addr, MXS_MODULE_CLKGATE);
> +	if (ret)
> +		goto error;
> +
> +	return 0;
> +
> +error:
> +	pr_err("%s(%p): module reset timeout\n", __func__, reset_addr);
> +	return -ETIMEDOUT;
> +}
> -- 
> 1.7.1

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
