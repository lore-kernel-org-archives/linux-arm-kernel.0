From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 2 Sep 2010 07:46:30 +0200
Subject: [RFC] [PATCH] arm & sh: factorised duplicated clkdev.c
In-Reply-To: <20100901231849.GB25860@n2100.arm.linux.org.uk>
References: <1283253402-3139-1-git-send-email-plagnioj@jcrosoft.com>
	<20100901095121.GA11107@pengutronix.de>
	<20100901111846.GF22790@game.jcrosoft.org>
	<20100901150112.GF11107@pengutronix.de>
	<20100901231849.GB25860@n2100.arm.linux.org.uk>
Message-ID: <20100902054630.GB14214@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 02, 2010 at 12:18:49AM +0100, Russell King - ARM Linux wrote:
> On Wed, Sep 01, 2010 at 05:01:12PM +0200, Uwe Kleine-K?nig wrote:
> > On Wed, Sep 01, 2010 at 01:18:46PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > > >  
> > > > > -struct clk_lookup *clkdev_alloc(struct clk *clk, const char *con_id,
> > > > > -	const char *dev_fmt, ...)
> > > > > +struct clk_lookup * __init_refok
> > > > Why do you need __init_refok?  __init_refok is defined as follows in
> > > > include/linux/init.h:
> > > > 
> > > > 	/* compatibility defines */
> > > > 	#define __init_refok     __ref
> > > > 
> > > > So if really needed better use __ref.  Couldn't this be __init?  
> > > ok for __ref but __init_refok is more clear IMHO
> > For me it was not, because before your mail I didn't know __init_refok
> > so I had to look it up.
> > 
> > > and yes we need it as for early device we may use bootmem as slab allocators
> > > may no be availlable in some case
> > Yes I got that, but it doesn't explain why you need to mark your
> > function as __ref or why you cannot use __init.
> 
> You can't use __init for this because this function may be used for
> non-init code.
Hmmm, as I don't seem to be able to persude someone else to do the hard
work, I did it.  Here are the hard facts:

	- clkdev_alloc is exported
	- clkdev is called by clk_add_alias
	- clk_add_alias is exported
	- clkdev_alloc is called by impd1_probe
	  (arch/arm/mach-integrator/impd1.c)
	  Can be compiled as a module.
	- clk_add_alias is called from __init functions only in
		arch/arm/mach-davinci/dm355.c
		arch/arm/mach-davinci/dm365.c
		arch/arm/mach-davinci/dm644x.c
		arch/arm/mach-pxa/eseries.c
		arch/arm/mach-pxa/lubbock.c
		arch/arm/mach-pxa/tosa.c
		arch/sh/kernel/cpu/clock-cpg.c
	  All these cannot be compiled as a module.
	- clk_add_alias is called from non-__init functions that could
	  be __init:
		arch/arm/mach-omap1/board-nokia770.c
	  This cannot be compiled as a module.

So the actions needed before make clkdev_alloc and clk_add_alias __init are:

	- register the clocks for impd1 in machine code, not the driver
	- move hwa742_dev_init to .init.text
	- don't export clkdev_alloc and clk_add_alias

I guess the first is simple, the rest trivial, no?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
