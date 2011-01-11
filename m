From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 11 Jan 2011 15:05:30 +0100
Subject: [PATCH v4 08/10] ARM: mxs: add ocotp read function
In-Reply-To: <20110111133137.GS12078@pengutronix.de>
References: <1294297998-26930-1-git-send-email-shawn.guo@freescale.com>
	<1294297998-26930-9-git-send-email-shawn.guo@freescale.com>
	<20110111133137.GS12078@pengutronix.de>
Message-ID: <20110111140530.GS24920@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sascha,

On Tue, Jan 11, 2011 at 02:31:37PM +0100, Sascha Hauer wrote:
> On Thu, Jan 06, 2011 at 03:13:16PM +0800, Shawn Guo wrote:
> > diff --git a/arch/arm/mach-mxs/ocotp.c b/arch/arm/mach-mxs/ocotp.c
> > new file mode 100644
> > index 0000000..e2d39aa
> > --- /dev/null
> > +++ b/arch/arm/mach-mxs/ocotp.c
> > @@ -0,0 +1,79 @@
> > +/*
> > + * Copyright 2010 Freescale Semiconductor, Inc. All Rights Reserved.
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
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/mutex.h>
> > +
> > +#include <mach/mxs.h>
> > +
> > +#define BM_OCOTP_CTRL_BUSY		(1 << 8)
> > +#define BM_OCOTP_CTRL_ERROR		(1 << 9)
> > +#define BM_OCOTP_CTRL_RD_BANK_OPEN	(1 << 12)
> > +
> > +static DEFINE_MUTEX(ocotp_mutex);
> > +
> > +int mxs_read_ocotp(unsigned offset, size_t count, u32 *values)
> > +{
> > +	void __iomem *ocotp_base = MXS_IO_ADDRESS(MXS_OCOTP_BASE_ADDR);
> > +	int timeout = 0x400;
> > +	size_t i;
> > +
> > +	mutex_lock(&ocotp_mutex);
> > +
> > +	/*
> > +	 * clk_enable(hbus_clk) for ocotp can be skipped
> > +	 * as it must be on when system is running.
> > +	 */
> > +
> > +	/* try to clear ERROR bit */
> > +	__mxs_clrl(BM_OCOTP_CTRL_ERROR, ocotp_base);
> 
> This operation does not try to clear the error bit but actually clears
> it...
> 
> > +
> > +	/* check both BUSY and ERROR cleared */
> > +	while ((__raw_readl(ocotp_base) &
> > +		(BM_OCOTP_CTRL_BUSY | BM_OCOTP_CTRL_ERROR)) && --timeout)
> > +		cpu_relax();
> 
> ...which means you do not have to poll the error bit here...
well, I don't know how the hardware works here, but in general the
argument is broken.  Registers are not memory, so just because you set a
bit in register space it doesn't mean it is really set when you read
from the same address.

If there is something wrong with the ocotp I'd even expect that clearing
the error bit doesn't work because it doesn't change the general
condition.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
