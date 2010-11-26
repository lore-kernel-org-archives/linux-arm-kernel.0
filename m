From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 26 Nov 2010 10:57:33 +0100
Subject: [PATCH 03/15] ARM: mxs: Add reset routines
In-Reply-To: <19695.32386.279224.624305@ipc1.ka-ro>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1290754154-9428-4-git-send-email-shawn.guo@freescale.com>
	<19695.32386.279224.624305@ipc1.ka-ro>
Message-ID: <20101126095733.GA27637@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lothar,

On Fri, Nov 26, 2010 at 10:31:46AM +0100, Lothar Wa?mann wrote:
> Shawn Guo writes:
> [...]
> > diff --git a/arch/arm/mach-mxs/system.c b/arch/arm/mach-mxs/system.c
> > new file mode 100644
> > index 0000000..de33c66
> > --- /dev/null
> > +++ b/arch/arm/mach-mxs/system.c
> > @@ -0,0 +1,152 @@
> > +/*
> > + * Copyright (C) 1999 ARM Limited
> > + * Copyright (C) 2000 Deep Blue Solutions Ltd
> > + * Copyright 2006-2007,2010 Freescale Semiconductor, Inc. All Rights Reserved.
> > + * Copyright 2008 Juergen Beisert, kernel at pengutronix.de
> > + * Copyright 2009 Ilya Yanok, Emcraft Systems Ltd, yanok at emcraft.com
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/err.h>
> > +#include <linux/delay.h>
> > +
> > +#include <asm/proc-fns.h>
> > +#include <asm/system.h>
> > +
> > +#include <mach/hardware.h>
> > +#include <mach/common.h>
> > +
> > +#define MXS_RTC_WATCHDOG	0x50
> > +#define MXS_WATCHDOG_EN		(1 << 4)
> > +
> > +#define MXS_MODULE_CLKGATE	(1 << 30)
> > +#define MXS_MODULE_SFTRST	(1 << 31)
> > +
> > +static void __iomem *wdog_base;
> > +
> > +/*
> > + * Reset the system. It is called by machine_restart().
> > + */
> > +void arch_reset(char mode, const char *cmd)
> > +{
> > +	struct clk *clk;
> > +
> > +	clk = clk_get_sys("rtc", NULL);
> > +	if (!IS_ERR(clk))
> > +		clk_enable(clk);
> > +
> >
> Since arch_reset() may be called from interrupt context (e.g. due to
> SYSRQ-B) it must not call any functions that may sleep like clk_get*()
> or clk_enable(). The clock should be acquired and enabled in the init
> routine.
This is a problem that also exist in arch/arm/plat-mxc/system.c's
arch_reset.

Did you already verify that this is indeed a problem?  I guess there are
more architectures that use clk_get in arch_reset, aren't there?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
