From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 1 Sep 2010 17:40:07 +0200
Subject: [RFC] [PATCH] arm & sh: factorised duplicated clkdev.c
In-Reply-To: <20100901152719.GG22790@game.jcrosoft.org>
References: <1283253402-3139-1-git-send-email-plagnioj@jcrosoft.com>
	<20100901095121.GA11107@pengutronix.de>
	<20100901111846.GF22790@game.jcrosoft.org>
	<20100901150112.GF11107@pengutronix.de>
	<20100901152719.GG22790@game.jcrosoft.org>
Message-ID: <20100901154007.GA32131@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 01, 2010 at 05:27:19PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 17:01 Wed 01 Sep     , Uwe Kleine-K?nig wrote:
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
> Take a look in this commit 312b1485fb509c9bc32eda28ad29537896658cb8
> 
> it will be more clear
Assume I understand in which cases you need to use __ref.  Which of
these cases is valid for clkdev_alloc?

And further, which function calls (or which structure references)
clkdev_alloc that makes it impossible to mark it using __init?

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
