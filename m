From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 00:18:49 +0100
Subject: [RFC] [PATCH] arm & sh: factorised duplicated clkdev.c
In-Reply-To: <20100901150112.GF11107@pengutronix.de>
References: <1283253402-3139-1-git-send-email-plagnioj@jcrosoft.com>
	<20100901095121.GA11107@pengutronix.de>
	<20100901111846.GF22790@game.jcrosoft.org>
	<20100901150112.GF11107@pengutronix.de>
Message-ID: <20100901231849.GB25860@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 01, 2010 at 05:01:12PM +0200, Uwe Kleine-K?nig wrote:
> On Wed, Sep 01, 2010 at 01:18:46PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > >  
> > > > -struct clk_lookup *clkdev_alloc(struct clk *clk, const char *con_id,
> > > > -	const char *dev_fmt, ...)
> > > > +struct clk_lookup * __init_refok
> > > Why do you need __init_refok?  __init_refok is defined as follows in
> > > include/linux/init.h:
> > > 
> > > 	/* compatibility defines */
> > > 	#define __init_refok     __ref
> > > 
> > > So if really needed better use __ref.  Couldn't this be __init?  
> > ok for __ref but __init_refok is more clear IMHO
> For me it was not, because before your mail I didn't know __init_refok
> so I had to look it up.
> 
> > and yes we need it as for early device we may use bootmem as slab allocators
> > may no be availlable in some case
> Yes I got that, but it doesn't explain why you need to mark your
> function as __ref or why you cannot use __init.

You can't use __init for this because this function may be used for
non-init code.
