From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Mar 2012 16:17:47 +0000
Subject: [PATCH 8/8] ARM i.MX27: implement clocks using common clock
 framework
In-Reply-To: <20120319143608.GZ3852@pengutronix.de>
References: <1332164166-6055-1-git-send-email-s.hauer@pengutronix.de>
 <20120319142325.GA32469@S2101-09.ap.freescale.net>
 <20120319143608.GZ3852@pengutronix.de>
Message-ID: <201203191617.47225.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 March 2012, Sascha Hauer wrote:
> > > +struct clkl {
> > > +   struct clk_lookup lookup;
> > > +   const char *clkname;
> > > +};
> > > +
> > > +#define clkdev(d, n, c) \
> > > +   { \
> > > +           .lookup.dev_id = d, \
> > > +           .lookup.con_id = n, \
> > > +           .clkname = c, \
> > > +   },
> > > +
> > 
> > They should at least be defined in arch/arm/mach-imx/clk.h to avoid
> > the duplication in every single imx clock driver.
> 
> Yes, right. See it as a quick-n-dirty solution...
> 

Or maybe just remove the macro. Open-coding seems to take little more space,
and I actually find it more readable:

static struct clkl lookups[] = {
	{ { .dev_id = "imx21-uart.0", .con_id = "ipg" }, "uart1_ipg_gate" },
	{ { .dev_id = "imx21-uart.0", .con_id = "per" }, "per1_gate" },
	{ { .dev_id = "imx21-uart.1", .con_id = "ipg" }, "uart2_ipg_gate" },
	{ ... },
};

	Arnd
