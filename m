From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 31 Dec 2010 09:46:20 +0800
Subject: [PATCH 08/10] ARM: mxs: add ocotp read function
In-Reply-To: <20101230090224.GM14221@pengutronix.de>
References: <1293548155-16328-1-git-send-email-shawn.guo@freescale.com>
	<1293548155-16328-9-git-send-email-shawn.guo@freescale.com>
	<20101229112208.GB14221@pengutronix.de>
	<20101230084139.GC28246@freescale.com>
	<20101230090224.GM14221@pengutronix.de>
Message-ID: <20101231014619.GF28246@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Thu, Dec 30, 2010 at 10:02:24AM +0100, Uwe Kleine-K?nig wrote:
> Hello Shawn,
> 
> On Thu, Dec 30, 2010 at 04:41:40PM +0800, Shawn Guo wrote:
> > On Wed, Dec 29, 2010 at 12:22:08PM +0100, Uwe Kleine-K?nig wrote:
> > > On Tue, Dec 28, 2010 at 10:55:53PM +0800, Shawn Guo wrote:
> > > > diff --git a/arch/arm/mach-mxs/ocotp.c b/arch/arm/mach-mxs/ocotp.c
> > > > new file mode 100644
> > > > index 0000000..24457d7
> > > > --- /dev/null
> > > > +++ b/arch/arm/mach-mxs/ocotp.c
> > > > @@ -0,0 +1,52 @@
> > > > +/*
> > > > + * Copyright 2010 Freescale Semiconductor, Inc. All Rights Reserved.
> > > > + *
> > > > + * This program is free software; you can redistribute it and/or modify
> > > > + * it under the terms of the GNU General Public License as published by
> > > > + * the Free Software Foundation; either version 2 of the License, or
> > > > + * (at your option) any later version.
> > > > + *
> > > > + * This program is distributed in the hope that it will be useful,
> > > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > > + * GNU General Public License for more details.
> > > > + */
> > > > +
> > > > +#include <linux/delay.h>
> > > > +#include <linux/err.h>
> > > > +
> > > > +#include <mach/mxs.h>
> > > > +
> > > > +#define BM_OCOTP_CTRL_RD_BANK_OPEN	(1 << 12)
> > > > +#define BM_OCOTP_CTRL_BUSY		(1 << 8)
> > > > +
> > > > +int mxs_read_ocotp(int offset, int count, u32 *values)
> > > > +{
> > > > +	void __iomem *ocotp_base = MXS_IO_ADDRESS(MXS_OCOTP_BASE_ADDR);
> > > > +	int i, timeout = 0x400;
> > > > +
> > > > +	/* open OCOTP banks for read */
> > > > +	__mxs_setl(BM_OCOTP_CTRL_RD_BANK_OPEN, ocotp_base);
> > > The reference manual specifies:
> > > 	1. Program the HCLK to a frequency up to the maximum allowable HCLK
> > > 	   frequency. [...]
> > > 	2. Check that HW_OCOTP_CTRL_BUSY and HW_OCOTP_CTRL_ERROR are clear.
> > > 	3. Set HW_OCOTP_CTRL_RD_BANK_OPEN. [...]
> > > 
> > > 1. isn't done (which is probably OK, or should it aquire a clk?)
> > ocotp needs clk_h, which must be on when system is running.
> maybe add a comment?  "clk_enable(clk_h) can be skipped as it must be on
> anyhow because ..." or similar?  It's always good to document implicit
> assumptions.
> 
OK.

> > > For 2. there is no check for HW_OCOTP_CTRL_ERROR which is not OK i
> > > guess?!
> > > 
> > How does the new code look to you?
> > 
> > static DEFINE_MUTEX(ocotp_mutex);
> > 
> > int mxs_read_ocotp(unsigned offset, size_t count, u32 *values)
> > {
> > 	void __iomem *ocotp_base = MXS_IO_ADDRESS(MXS_OCOTP_BASE_ADDR);
> > 	int i, timeout = 0x400;
> i should be size_t, too
> 
OK.

> > 
> > 	mutex_lock(&ocotp_mutex);
> > 
> > 	/* clear ERROR bit anyway */
> anyway?  Better?: "try to clear ERROR bit"
> 
> > 	__mxs_clrl(BM_OCOTP_CTRL_ERROR, ocotp_base);
> > 
> > 	/* check both BUSY and ERROR cleared */
> > 	while ((__raw_readl(ocotp_base) &
> > 		(BM_OCOTP_CTRL_BUSY | BM_OCOTP_CTRL_ERROR)) && --timeout)
> > 		/* nothing */;
> > 
> > 	if (unlikely(!timeout))
> > 		goto error;
> This goto and some more leave the critical section without unlocking the
> mutex.
> 
My bad. Thanks.

> > 
> > 	/* open OCOTP banks for read */
> > 	__mxs_setl(BM_OCOTP_CTRL_RD_BANK_OPEN, ocotp_base);
> > 
> > 	/* approximately wait 32 hclk cycles */
> > 	udelay(1);
> > 
> > 	/* poll BUSY bit becoming cleared */
> > 	timeout = 0x400;
> > 	while ((__raw_readl(ocotp_base) & BM_OCOTP_CTRL_BUSY) && --timeout)
> > 		/* nothing */;
> > 
> > 	if (unlikely(!timeout))
> > 		goto error;
> > 
> > 	for (i = 0; i < count; i++, offset += 4)
> > 		*values++ = __raw_readl(ocotp_base + offset);
> > 
> > 	/* close banks for power saving */
> > 	__mxs_clrl(BM_OCOTP_CTRL_RD_BANK_OPEN, ocotp_base);
> > 
> > 	mutex_unlock(&ocotp_mutex);
> > 
> > 	return 0;
> > 
> > error:
> > 	pr_err("%s: timeout in reading OCOTP\n", __func__);
> > 	return -ETIMEDOUT;
> > }
> I think it's OK then.  One optimisation that comes to my mind is to make
> BM_OCOTP_CTRL_RD_BANK_OPEN a clk (that can depend on clk_h).  This would
> allow for multiple readers, but I think it's not worth the effort.
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> 

-- 
Regards,
Shawn
