From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Fri, 26 Nov 2010 10:31:46 +0100
Subject: [PATCH 03/15] ARM: mxs: Add reset routines
In-Reply-To: <1290754154-9428-4-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1290754154-9428-4-git-send-email-shawn.guo@freescale.com>
Message-ID: <19695.32386.279224.624305@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo writes:
[...]
> diff --git a/arch/arm/mach-mxs/system.c b/arch/arm/mach-mxs/system.c
> new file mode 100644
> index 0000000..de33c66
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
> +	struct clk *clk;
> +
> +	clk = clk_get_sys("rtc", NULL);
> +	if (!IS_ERR(clk))
> +		clk_enable(clk);
> +
>
Since arch_reset() may be called from interrupt context (e.g. due to
SYSRQ-B) it must not call any functions that may sleep like clk_get*()
or clk_enable(). The clock should be acquired and enabled in the init
routine.

> +void mxs_arch_reset_init(void __iomem *base)
> +{
> +	wdog_base = base;
> +}
> +

Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
