From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Wed, 9 Nov 2011 13:48:12 +0000
Subject: [PATCH v3 1/3] ARM: mxs: add saif clkmux functions
In-Reply-To: <20111109113554.GK16886@pengutronix.de>
References: <1317052353-6029-1-git-send-email-b29396@freescale.com>
 <1317052353-6029-2-git-send-email-b29396@freescale.com>
 <20111109113554.GK16886@pengutronix.de>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7722BD332@039-SN1MPN1-003.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

First, thanks for the review.

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> Sent: Wednesday, November 09, 2011 7:36 PM
> To: Dong Aisheng-B29396
> Cc: alsa-devel at alsa-project.org; linux-arm-kernel at lists.infradead.org;
> broonie at opensource.wolfsonmicro.com; lrg at ti.com; w.sang at pengutronix.de;
> u.kleine-koenig at pengutronix.de
> Subject: Re: [PATCH v3 1/3] ARM: mxs: add saif clkmux functions
> 
> On Mon, Sep 26, 2011 at 11:52:31PM +0800, Dong Aisheng wrote:
> > Signed-off-by: Dong Aisheng <b29396@freescale.com>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Wolfram Sang <w.sang@pengutronix.de>
> > Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > Cc: Liam Girdwood <lrg@ti.com>
> >
> > ---
> > changes since v2:
> >  * This patch is separated from the following patch based on
> >    suggestions from Uwe.
> >   [PATCH 2/3] ARM: mx28evk: add platform data for saif
> >  * add lock suggested by Wolfram
> > ---
> >  arch/arm/mach-mxs/clock-mx28.c          |   58
> +++++++++++++++++++++++++++++++
> >  arch/arm/mach-mxs/include/mach/digctl.h |   21 +++++++++++
> >  2 files changed, 79 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-mxs/clock-mx28.c
> > b/arch/arm/mach-mxs/clock-mx28.c index 7954013..9497346 100644
> > --- a/arch/arm/mach-mxs/clock-mx28.c
> > +++ b/arch/arm/mach-mxs/clock-mx28.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/io.h>
> >  #include <linux/jiffies.h>
> >  #include <linux/clkdev.h>
> > +#include <linux/spinlock.h>
> >
> >  #include <asm/clkdev.h>
> >  #include <asm/div64.h>
> > @@ -29,6 +30,7 @@
> >  #include <mach/mx28.h>
> >  #include <mach/common.h>
> >  #include <mach/clock.h>
> > +#include <mach/digctl.h>
> >
> >  #include "regs-clkctrl-mx28.h"
> >
> > @@ -43,6 +45,62 @@ static struct clk emi_clk;  static struct clk
> > saif0_clk;  static struct clk saif1_clk;  static struct clk
> > clk32k_clk;
> > +static DEFINE_SPINLOCK(clkmux_lock);
> > +
> > +/*
> > + * HW_SAIF_CLKMUX_SEL:
> > + *  DIRECT(0x0): SAIF0 clock pins selected for SAIF0 input clocks, and
> SAIF1
> > + *		clock pins selected for SAIF1 input clocks.
> > + *  CROSSINPUT(0x1): SAIF1 clock inputs selected for SAIF0 input
> clocks, and
> > + *		SAIF0 clock inputs selected for SAIF1 input clocks.
> > + *  EXTMSTR0(0x2): SAIF0 clock pin selected for both SAIF0 and SAIF1
> input
> > + *		clocks.
> > + *  EXTMSTR1(0x3): SAIF1 clock pin selected for both SAIF0 and SAIF1
> input
> > + *		clocks.
> > + */
> > +int mxs_saif_clkmux_select(unsigned int clkmux)
> 
> Ahem, this seems to be a clk_set_parent function which is exported and
> bypasses the clk api. No.

I'm afraid this is a little different from clk_set_parent and may not be able
to be totally covered by clk api. 
For example, how do we treat its real parents pll or osc when we
want saif1 as saif0's parent? 
Additionally, if we want clk_set_parent(&saif0_clk, &saif1_clk),
It seems both CROSSINPUT and EXTMSTR1 can satisfy this requirement,
But clk api does not know how to make the decision.

> > +{
> > +	if (clkmux > 0x3)
> > +		return -EINVAL;
> > +
> > +	spin_lock(&clkmux_lock);
> > +	__raw_writel(BM_DIGCTL_CTRL_SAIF_CLKMUX,
> > +			DIGCTRL_BASE_ADDR + HW_DIGCTL_CTRL + MXS_CLR_ADDR);
> > +	__raw_writel(clkmux << BP_DIGCTL_CTRL_SAIF_CLKMUX,
> > +			DIGCTRL_BASE_ADDR + HW_DIGCTL_CTRL + MXS_SET_ADDR);
> > +	spin_unlock(&clkmux_lock);
> > +
> > +	return 0;
> > +}
> > +
> > +int mxs_get_saif_clk_master_id(unsigned int saif_id) {
> > +	unsigned int saif_clkmux;
> > +	unsigned int master_id;
> > +
> > +	spin_lock(&clkmux_lock);
> > +	saif_clkmux = (__raw_readl(DIGCTRL_BASE_ADDR + HW_DIGCTL_CTRL)
> > +			& BM_DIGCTL_CTRL_SAIF_CLKMUX) >>
> BP_DIGCTL_CTRL_SAIF_CLKMUX;
> > +	switch (saif_clkmux) {
> > +	case MXS_DIGCTL_SAIF_CLKMUX_DIRECT:
> > +		master_id = saif_id;
> > +		break;
> > +	case MXS_DIGCTL_SAIF_CLKMUX_CROSSINPUT:
> > +		master_id = saif_id ? 0 : 1;
> > +		break;
> > +	case MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0:
> > +		master_id = 0;
> > +		break;
> > +	case MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR1:
> > +		master_id = 1;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> 
> You return with a spinlock held here. You don't need the spinlock at all
> in this function as the only register access you have is atomic.
Sorry for the mistake.
I did not realize register access is atomic before.
I can remove it.

> > +	}
> > +	spin_unlock(&clkmux_lock);
> > +
> > +	return master_id;
> > +}
> >
> >  static int _raw_clk_enable(struct clk *clk)  { diff --git
> > a/arch/arm/mach-mxs/include/mach/digctl.h
> > b/arch/arm/mach-mxs/include/mach/digctl.h
> > new file mode 100644
> > index 0000000..9bd0496
> > --- /dev/null
> > +++ b/arch/arm/mach-mxs/include/mach/digctl.h
> > @@ -0,0 +1,21 @@
> > +/*
> > + * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > +modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#ifndef __MACH_DIGCTL_H__
> > +#define __MACH_DIGCTL_H__
> > +
> > +/* MXS DIGCTL SAIF CLKMUX */
> > +#define MXS_DIGCTL_SAIF_CLKMUX_DIRECT		0x0
> > +#define MXS_DIGCTL_SAIF_CLKMUX_CROSSINPUT	0x1
> > +#define MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0		0x2
> > +#define MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR1		0x3
> > +
> > +#define HW_DIGCTL_CTRL			0x0
> > +#define  BP_DIGCTL_CTRL_SAIF_CLKMUX	(10)
> > +#define  BM_DIGCTL_CTRL_SAIF_CLKMUX	(0x3 << 10)
> > +#endif
> > --
> > 1.7.0.4
> >
> >
> >
> 
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555
> |


Regards
Dong Aisheng
