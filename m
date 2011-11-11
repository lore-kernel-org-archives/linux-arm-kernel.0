From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 11 Nov 2011 15:41:20 +0800
Subject: [PATCH v4 1/3] ARM: mxs: add saif clkmux functions
In-Reply-To: <65EE16ACC360FA4D99C96DC085B3F7722CD6FB@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1320907333-12696-1-git-send-email-b29396@freescale.com>
 <1320907333-12696-2-git-send-email-b29396@freescale.com>
 <20111111071401.GC8732@S2100-06.ap.freescale.net>
 <65EE16ACC360FA4D99C96DC085B3F7722CD6FB@039-SN1MPN1-002.039d.mgd.msft.net>
Message-ID: <20111111074119.GE8732@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2011 at 03:19:49PM +0800, Dong Aisheng-B29396 wrote:
> > -----Original Message-----
> > From: Guo Shawn-R65073
> > Sent: Friday, November 11, 2011 3:14 PM
> > To: Dong Aisheng-B29396
> > Cc: linux-arm-kernel at lists.infradead.org; alsa-devel at alsa-project.org;
> > broonie at opensource.wolfsonmicro.com; lrg at ti.com; s.hauer at pengutronix.de;
> > w.sang at pengutronix.de; u.kleine-koenig at pengutronix.de
> > Subject: Re: [PATCH v4 1/3] ARM: mxs: add saif clkmux functions
> > 
> > On Thu, Nov 10, 2011 at 02:42:11PM +0800, Dong Aisheng wrote:
> > > Signed-off-by: Dong Aisheng <b29396@freescale.com>
> > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > Cc: Wolfram Sang <w.sang@pengutronix.de>
> > > Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > > Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > > Cc: Liam Girdwood <lrg@ti.com>
> > >
> > > ---
> > > changes since v3:
> > >  * remove the unneeded locking according to Sascha changes since v2:
> > >  * This patch is separated from the following patch based on
> > >    suggestions from Uwe.
> > >    [PATCH 2/3] ARM: mx28evk: add platform data for saif
> > > ---
> > >  arch/arm/mach-mxs/clock-mx28.c          |   56
> > +++++++++++++++++++++++++++++++
> > >  arch/arm/mach-mxs/include/mach/digctl.h |   21 +++++++++++
> > >  2 files changed, 77 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-mxs/clock-mx28.c
> > > b/arch/arm/mach-mxs/clock-mx28.c index 7954013..6522d5f 100644
> > > --- a/arch/arm/mach-mxs/clock-mx28.c
> > > +++ b/arch/arm/mach-mxs/clock-mx28.c
> > > @@ -22,6 +22,7 @@
> > >  #include <linux/io.h>
> > >  #include <linux/jiffies.h>
> > >  #include <linux/clkdev.h>
> > > +#include <linux/spinlock.h>
> > >
> > >  #include <asm/clkdev.h>
> > >  #include <asm/div64.h>
> > > @@ -29,6 +30,7 @@
> > >  #include <mach/mx28.h>
> > >  #include <mach/common.h>
> > >  #include <mach/clock.h>
> > > +#include <mach/digctl.h>
> > >
> > >  #include "regs-clkctrl-mx28.h"
> > >
> > > @@ -43,6 +45,60 @@ static struct clk emi_clk;  static struct clk
> > > saif0_clk;  static struct clk saif1_clk;  static struct clk
> > > clk32k_clk;
> > > +static DEFINE_SPINLOCK(clkmux_lock);
> > > +
> > > +/*
> > > + * HW_SAIF_CLKMUX_SEL:
> > > + *  DIRECT(0x0): SAIF0 clock pins selected for SAIF0 input clocks, and
> > SAIF1
> > > + *		clock pins selected for SAIF1 input clocks.
> > > + *  CROSSINPUT(0x1): SAIF1 clock inputs selected for SAIF0 input
> > clocks, and
> > > + *		SAIF0 clock inputs selected for SAIF1 input clocks.
> > > + *  EXTMSTR0(0x2): SAIF0 clock pin selected for both SAIF0 and SAIF1
> > input
> > > + *		clocks.
> > > + *  EXTMSTR1(0x3): SAIF1 clock pin selected for both SAIF0 and SAIF1
> > input
> > > + *		clocks.
> > > + */
> > > +int mxs_saif_clkmux_select(unsigned int clkmux) {
> > > +	if (clkmux > 0x3)
> > > +		return -EINVAL;
> > > +
> > > +	spin_lock(&clkmux_lock);
> > > +	__raw_writel(BM_DIGCTL_CTRL_SAIF_CLKMUX,
> > > +			DIGCTRL_BASE_ADDR + HW_DIGCTL_CTRL + MXS_CLR_ADDR);
> > > +	__raw_writel(clkmux << BP_DIGCTL_CTRL_SAIF_CLKMUX,
> > > +			DIGCTRL_BASE_ADDR + HW_DIGCTL_CTRL + MXS_SET_ADDR);
> > > +	spin_unlock(&clkmux_lock);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +int mxs_get_saif_clk_master_id(unsigned int saif_id) {
> > > +	unsigned int saif_clkmux;
> > > +	unsigned int master_id;
> > > +
> > > +	saif_clkmux = (__raw_readl(DIGCTRL_BASE_ADDR + HW_DIGCTL_CTRL)
> > > +			&& BM_DIGCTL_CTRL_SAIF_CLKMUX) >>
> > BP_DIGCTL_CTRL_SAIF_CLKMUX;
> > > +	switch (saif_clkmux) {
> > > +	case MXS_DIGCTL_SAIF_CLKMUX_DIRECT:
> > > +		master_id = saif_id;
> > > +		break;
> > > +	case MXS_DIGCTL_SAIF_CLKMUX_CROSSINPUT:
> > > +		master_id = saif_id ? 0 : 1;
> > > +		break;
> > > +	case MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0:
> > > +		master_id = 0;
> > > +		break;
> > > +	case MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR1:
> > > +		master_id = 1;
> > > +		break;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	return master_id;
> > > +}
> > >
> > 
> > I'm not completely comfortable to have these DIGCTL setup in clock code.
> > What about creating a digctl.c for all DIGCTL stuff?
> >
> Originally I did as you said.
> But as suggested by Wolfram a long time ago, the question is that there're
> already some DIGCTL reference codes in clock-mx28.c, so we thought it may be
> better to keep this stuff in one place.
> Also these code looks clock related.
> Do you think it's suitable?
> 
Fair enough.  I forgot that we already have usb_clk set up by DIGCTL
in there.

Regards,
Shawn

> > >  static int _raw_clk_enable(struct clk *clk)  { diff --git
> > > a/arch/arm/mach-mxs/include/mach/digctl.h
> > > b/arch/arm/mach-mxs/include/mach/digctl.h
> > > new file mode 100644
> > > index 0000000..9bd0496
> > > --- /dev/null
> > > +++ b/arch/arm/mach-mxs/include/mach/digctl.h
> > > @@ -0,0 +1,21 @@
> > > +/*
> > > + * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
> > > + *
> > > + * This program is free software; you can redistribute it and/or
> > > +modify
> > > + * it under the terms of the GNU General Public License version 2 as
> > > + * published by the Free Software Foundation.
> > > + */
> > > +
> > > +#ifndef __MACH_DIGCTL_H__
> > > +#define __MACH_DIGCTL_H__
> > > +
> > > +/* MXS DIGCTL SAIF CLKMUX */
> > > +#define MXS_DIGCTL_SAIF_CLKMUX_DIRECT		0x0
> > > +#define MXS_DIGCTL_SAIF_CLKMUX_CROSSINPUT	0x1
> > > +#define MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0		0x2
> > > +#define MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR1		0x3
> > > +
> > > +#define HW_DIGCTL_CTRL			0x0
> > > +#define  BP_DIGCTL_CTRL_SAIF_CLKMUX	(10)
> > > +#define  BM_DIGCTL_CTRL_SAIF_CLKMUX	(0x3 << 10)
> > > +#endif
> > >
> > 
> > And if possible, we should try to make these definitions local to that
> > digctl.c.
> > 
> We can do that if nobody else needs it.
> 
> Regards
> Dong Aisheng
