From: torbenh@gmx.de (torbenh)
Date: Thu, 21 Apr 2011 21:22:58 +0200
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <alpine.LFD.2.02.1104211147300.3323@ionos>
References: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
	<1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.02.1104201704350.3323@ionos>
	<20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
	<4DAFD5AA.9020404@codeaurora.org>
	<alpine.LFD.2.02.1104211147300.3323@ionos>
Message-ID: <20110421192258.GD13755@siel.b>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2011 at 12:33:49PM +0200, Thomas Gleixner wrote:
> On Wed, 20 Apr 2011, Saravana Kannan wrote:
> > On 04/20/2011 12:52 PM, Thomas Gleixner wrote:
> > > 2) The "framework" API is just a set of low level primitive helper
> > >     functions
> > > 
> > >     It lacks:
> > > 
> > >     - proper refcounting. clk_get() / clk_put() should do that at the
> > >       framework level.
> > 
> > This has nothing to do with the patches Jeremy made. clk_get()/_put() is in
> > clkdev. Also, I'm not sure if clk_get()/put() needs refcounting. That's like
> > asking kalloc/kfree to have refcounting.
> 
> Ok. I missed the clkdev part.

well... just look at this:

-> git grep __clk_get
arch/arm/mach-bcmring/include/mach/clkdev.h:#define __clk_get(clk) ({ 1; })
arch/arm/mach-davinci/include/mach/clkdev.h:static inline int __clk_get(struct clk *clk)
arch/arm/mach-ep93xx/include/mach/clkdev.h:#define __clk_get(clk) ({ 1; })
arch/arm/mach-integrator/include/mach/clkdev.h:static inline int __clk_get(struct clk *clk)
arch/arm/mach-lpc32xx/include/mach/clkdev.h:#define __clk_get(clk) ({ 1; })
arch/arm/mach-mmp/include/mach/clkdev.h:#define __clk_get(clk) ({ 1; })
arch/arm/mach-msm/include/mach/clkdev.h:static inline int __clk_get(struct clk *clk) { return 1; }
arch/arm/mach-mxs/include/mach/clkdev.h:#define __clk_get(clk) ({ 1; })
arch/arm/mach-nomadik/include/mach/clkdev.h:#define __clk_get(clk) ({ 1; })
arch/arm/mach-nuc93x/include/mach/clkdev.h:#define __clk_get(clk) ({ 1; })
arch/arm/mach-pnx4008/include/mach/clkdev.h:#define __clk_get(clk) ({ 1; })
arch/arm/mach-pxa/include/mach/clkdev.h:#define __clk_get(clk) ({ 1; })
arch/arm/mach-realview/include/mach/clkdev.h:#define __clk_get(clk) ({ 1; })
arch/arm/mach-shmobile/clock.c:int __clk_get(struct clk *clk)
arch/arm/mach-shmobile/clock.c:EXPORT_SYMBOL(__clk_get);
arch/arm/mach-shmobile/include/mach/clkdev.h:int __clk_get(struct clk *clk);
arch/arm/mach-tegra/include/mach/clkdev.h:static inline int __clk_get(struct clk *clk)
arch/arm/mach-u300/clock.c:int __clk_get(struct clk *clk)
arch/arm/mach-u300/clock.c:EXPORT_SYMBOL(__clk_get);
arch/arm/mach-u300/include/mach/clkdev.h:int __clk_get(struct clk *clk);
arch/arm/mach-ux500/include/mach/clkdev.h:#define __clk_get(clk) ({ 1; })
arch/arm/mach-versatile/include/mach/clkdev.h:#define __clk_get(clk) ({ 1; })
arch/arm/mach-vexpress/include/mach/clkdev.h:#define __clk_get(clk) ({ 1; })
arch/arm/mach-w90x900/include/mach/clkdev.h:#define __clk_get(clk) ({ 1; })
arch/arm/plat-mxc/include/mach/clkdev.h:#define __clk_get(clk) ({ 1; })
arch/arm/plat-omap/include/plat/clkdev.h:static inline int __clk_get(struct clk *clk)
arch/arm/plat-spear/include/plat/clkdev.h:#define __clk_get(clk) ({ 1; })
arch/arm/plat-stmp3xxx/include/mach/clkdev.h:#define __clk_get(clk) ({ 1; })
arch/arm/plat-tcc/include/mach/clkdev.h:#define __clk_get(clk) ({ 1; })
arch/sh/include/asm/clkdev.h:#define __clk_get(clk) ({ 1; })
drivers/clk/clkdev.c:   if (clk && !__clk_get(clk))




-- 
torben Hohn
