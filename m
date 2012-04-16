From: s.hauer@pengutronix.de (s.hauer at pengutronix.de)
Date: Mon, 16 Apr 2012 22:51:33 +0200
Subject: [PATCH] CLKDEV: Add helper routines to allocate and add clkdevs
 for given struct clk *
In-Reply-To: <20120416204609.GA8548@glitch>
References: <cfe2a4ef4a7903696200ca3880b96b4aa98c4820.1334553491.git.viresh.kumar@st.com>
 <20120416102503.GA32687@glitch> <4F8BF4DD.2080501@st.com>
 <20120416103822.GU24211@n2100.arm.linux.org.uk>
 <CAOh2x=kXeDOeZbAACOjKiwfdEniXkvAuFbrJ+rmgw=rq_gHQAg@mail.gmail.com>
 <20120416204609.GA8548@glitch>
Message-ID: <20120416205133.GW3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2012 at 10:46:09PM +0200, Domenico Andreoli wrote:
> On Mon, Apr 16, 2012 at 07:09:32PM +0530, viresh kumar wrote:
> > V2:
> > 
> > From: Russell King <rmk+kernel@arm.linux.org.uk>
> > CLKDEV: Add helper routines to allocate and add clkdevs for given struct clk *
> > 
> > With common clock framework, clks are allocated at runtime. Some of them require
> > clkdevs to be allocated and added in global clkdev list.
> > 
> > This patch introduces helper routines to:
> > 
> >  - allocate and add single clkdev for a single clk structure.
> >  - add multiple clkdevs for a single clk structure.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> > ---
> > +struct clk_lookup * __init_refok
> > +clkdev_alloc(struct clk *clk, const char *con_id, const char *dev_fmt, ...)
> > +{
> > +	struct clk_lookup * cl;
> > +	va_list ap = NULL;
> 
> gcc complains because of this initialization:
> 
> drivers/clk/clkdev.c: In function 'clkdev_alloc':
> drivers/clk/clkdev.c:149:2: error: invalid initializer
> drivers/clk/clkdev.c: In function 'clk_register_single_clkdev':
> drivers/clk/clkdev.c:197:2: error: invalid initializer
> make[2]: *** [drivers/clk/clkdev.o] Error 1
> make[1]: *** [drivers/clk] Error 2
> 
> 
> so I finally tested it with this modification:
> 
> 	if (dev_fmt) {
> 		va_start(ap, dev_fmt);
> 		cl = clkdev_alloc_valist(clk, con_id, dev_fmt, ap);
> 		va_end(ap);
> 	} else
> 		cl = clkdev_alloc(clk, con_id, NULL);

Same here. The correct fix is simply not to initialize ap.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
