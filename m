From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Mon, 13 Dec 2010 20:35:37 +0800
Subject: [PATCH 2/2] clk: Generic support for fixed-rate clocks
In-Reply-To: <20101213121413.GA29833@pengutronix.de>
References: <1291774094.269634.503532219345.0.gpush@pororo>
	<1291774094.270492.31002734529.2.gpush@pororo>
	<20101213121413.GA29833@pengutronix.de>
Message-ID: <201012132035.41371.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

> > +extern struct clk_ops clk_fixed_ops;
> > +
> > +#define INIT_CLK_FIXED(name, r) { \
> > +	.clk = INIT_CLK(name.clk, clk_fixed_ops), \
> > +	.rate = (r) \
> > +}
> 
> Is there any other valid usecase for this other than
> 
> struct clk_fixed bla = INIT_CLK_FIXED(bla, rate);
> 
> Otherwise I suggest to convert the macro to:
> 
> #define INIT_CLK_FIXED(name, r) \
> 	struct clk_fixed name = { \
> 		.clk = INIT_CLK(name.clk, clk_fixed_ops), \
> 		.rate = (r) \
> 	}
> 
> This way we do not have to specify the same name twice (and it has
> to be exactly the same name, otherwise it won't compile).

For the system-wide INIT_CLK* macros, I've intentionally made them initalisers 
rather than declarators, so that we can use them in other declarators (ie, the 
usage of INIT_CLK() above). This would be relevant if someone is using 
clk_fixed in their struct - probably not likely, but good to be consistent.

But yes, it would be good to avoid having to specify the name twice - how 
about adding a:

#define DEFINE_CLK_FIXED(name, r) \
	struct clk_fixed name = INIT_CLK_FIXED(name, r)

- just like DEFINE_MUTEX and MUTEX_INITIALIZER.

Cheers,


Jeremy
