From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 29 Dec 2010 20:08:23 +0800
Subject: [PATCH 08/10] ARM: mxs: add ocotp read function
In-Reply-To: <20101229104745.GV14221@pengutronix.de>
References: <1293548155-16328-1-git-send-email-shawn.guo@freescale.com>
	<1293548155-16328-9-git-send-email-shawn.guo@freescale.com>
	<20101229104745.GV14221@pengutronix.de>
Message-ID: <20101229120822.GI19347@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 29, 2010 at 11:47:45AM +0100, Uwe Kleine-K?nig wrote:
> Hello Shawn,
> 
> On Tue, Dec 28, 2010 at 10:55:53PM +0800, Shawn Guo wrote:
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > ---
> >  arch/arm/mach-mxs/Makefile              |    2 +-
> >  arch/arm/mach-mxs/include/mach/common.h |    1 +
> >  arch/arm/mach-mxs/ocotp.c               |   52 +++++++++++++++++++++++++++++++
> >  3 files changed, 54 insertions(+), 1 deletions(-)
> >  create mode 100644 arch/arm/mach-mxs/ocotp.c
> > 
> > diff --git a/arch/arm/mach-mxs/Makefile b/arch/arm/mach-mxs/Makefile
> > index 39d3f9c..f23ebbd 100644
> > --- a/arch/arm/mach-mxs/Makefile
> > +++ b/arch/arm/mach-mxs/Makefile
> > @@ -1,5 +1,5 @@
> >  # Common support
> > -obj-y := clock.o devices.o gpio.o icoll.o iomux.o system.o timer.o
> > +obj-y := clock.o devices.o gpio.o icoll.o iomux.o ocotp.o system.o timer.o
> >  
> >  obj-$(CONFIG_SOC_IMX23) += clock-mx23.o mm-mx23.o
> >  obj-$(CONFIG_SOC_IMX28) += clock-mx28.o mm-mx28.o
> > diff --git a/arch/arm/mach-mxs/include/mach/common.h b/arch/arm/mach-mxs/include/mach/common.h
> > index 59133eb..cf02552 100644
> > --- a/arch/arm/mach-mxs/include/mach/common.h
> > +++ b/arch/arm/mach-mxs/include/mach/common.h
> > @@ -13,6 +13,7 @@
> >  
> >  struct clk;
> >  
> > +extern int mxs_read_ocotp(int offset, int count, u32 *values);
> >  extern int mxs_reset_block(void __iomem *);
> >  extern void mxs_timer_init(struct clk *, int);
> >  
> > diff --git a/arch/arm/mach-mxs/ocotp.c b/arch/arm/mach-mxs/ocotp.c
> > new file mode 100644
> > index 0000000..24457d7
> > --- /dev/null
> > +++ b/arch/arm/mach-mxs/ocotp.c
> > @@ -0,0 +1,52 @@
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
> > +
> > +#include <mach/mxs.h>
> > +
> > +#define BM_OCOTP_CTRL_RD_BANK_OPEN	(1 << 12)
> > +#define BM_OCOTP_CTRL_BUSY		(1 << 8)
> > +
> > +int mxs_read_ocotp(int offset, int count, u32 *values)
> Maybe use size_t as type for count?  unsigned for offset?
> 
OK.

> > +{
> > +	void __iomem *ocotp_base = MXS_IO_ADDRESS(MXS_OCOTP_BASE_ADDR);
> > +	int i, timeout = 0x400;
> > +
> > +	/* open OCOTP banks for read */
> > +	__mxs_setl(BM_OCOTP_CTRL_RD_BANK_OPEN, ocotp_base);
> > +
> > +	/* approximately wait 32 hclk cycles */
> > +	udelay(1);
> > +
> > +	/* poll BUSY bit becoming cleared */
> > +	while ((__raw_readl(ocotp_base) & BM_OCOTP_CTRL_BUSY) && --timeout)
> > +		/* nothing */;
> > +
> > +	if (unlikely(!timeout))
> > +		goto error;
> > +
> > +	for (i = 0; i < count; i++, offset += 4)
> > +		*values++ = __raw_readl(ocotp_base + offset);
> > +
> > +	/* close banks for power saving */
> > +	__mxs_clrl(BM_OCOTP_CTRL_RD_BANK_OPEN, ocotp_base);
> > +
> > +	return 0;
> > +
> > +error:
> > +	pr_err("%s: timeout in reading OCOTP\n", __func__);
> > +	return -ETIMEDOUT;
> > +}
> does this need locking?
> 
You are suggesting mutex or spinlock?

-- 
Regards,
Shawn
