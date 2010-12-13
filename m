From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 13 Dec 2010 13:42:54 +0100
Subject: [PATCH 2/2] clk: Generic support for fixed-rate clocks
In-Reply-To: <201012132035.41371.jeremy.kerr@canonical.com>
References: <1291774094.269634.503532219345.0.gpush@pororo>
	<1291774094.270492.31002734529.2.gpush@pororo>
	<20101213121413.GA29833@pengutronix.de>
	<201012132035.41371.jeremy.kerr@canonical.com>
Message-ID: <20101213124254.GI6017@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 13, 2010 at 08:35:37PM +0800, Jeremy Kerr wrote:
> Hi Sascha,
> 
> > > +extern struct clk_ops clk_fixed_ops;
> > > +
> > > +#define INIT_CLK_FIXED(name, r) { \
> > > +	.clk = INIT_CLK(name.clk, clk_fixed_ops), \
> > > +	.rate = (r) \
> > > +}
> > 
> > Is there any other valid usecase for this other than
> > 
> > struct clk_fixed bla = INIT_CLK_FIXED(bla, rate);
> > 
> > Otherwise I suggest to convert the macro to:
> > 
> > #define INIT_CLK_FIXED(name, r) \
> > 	struct clk_fixed name = { \
> > 		.clk = INIT_CLK(name.clk, clk_fixed_ops), \
> > 		.rate = (r) \
> > 	}
> > 
> > This way we do not have to specify the same name twice (and it has
> > to be exactly the same name, otherwise it won't compile).
> 
> For the system-wide INIT_CLK* macros, I've intentionally made them initalisers 
> rather than declarators, so that we can use them in other declarators (ie, the 
> usage of INIT_CLK() above). This would be relevant if someone is using 
> clk_fixed in their struct - probably not likely, but good to be consistent.
> 
> But yes, it would be good to avoid having to specify the name twice - how 
> about adding a:
> 
> #define DEFINE_CLK_FIXED(name, r) \
> 	struct clk_fixed name = INIT_CLK_FIXED(name, r)
> 
> - just like DEFINE_MUTEX and MUTEX_INITIALIZER.

Jup, sounds good.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
