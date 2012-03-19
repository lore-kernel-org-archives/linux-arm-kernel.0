From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 19 Mar 2012 15:36:08 +0100
Subject: [PATCH 8/8] ARM i.MX27: implement clocks using common clock
 framework
In-Reply-To: <20120319142325.GA32469@S2101-09.ap.freescale.net>
References: <1332164166-6055-1-git-send-email-s.hauer@pengutronix.de>
 <1332164166-6055-9-git-send-email-s.hauer@pengutronix.de>
 <20120319142325.GA32469@S2101-09.ap.freescale.net>
Message-ID: <20120319143608.GZ3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2012 at 10:23:29PM +0800, Shawn Guo wrote:
> > +
> > +struct clkl {
> > +	struct clk_lookup lookup;
> > +	const char *clkname;
> > +};
> > +
> > +#define clkdev(d, n, c) \
> > +	{ \
> > +		.lookup.dev_id = d, \
> > +		.lookup.con_id = n, \
> > +		.clkname = c, \
> > +	},
> > +
> 
> They should at least be defined in arch/arm/mach-imx/clk.h to avoid
> the duplication in every single imx clock driver.

Yes, right. See it as a quick-n-dirty solution...

> 
> If using registration function becomes the common way that clock
> driver registers clks, they will be needed by other platforms too.
> Then, we should probably do something like below instead?
> 
> diff --git a/include/linux/clkdev.h b/include/linux/clkdev.h
> index d9a4fd0..2cde34e 100644
> --- a/include/linux/clkdev.h
> +++ b/include/linux/clkdev.h
> @@ -21,6 +21,7 @@ struct clk_lookup {
>         struct list_head        node;
>         const char              *dev_id;
>         const char              *con_id;
> +       const char              *clk_name;
>         struct clk              *clk;
>  };
> 
> @@ -31,6 +32,13 @@ struct clk_lookup {
>                 .clk = c,       \
>         }
> 
> +#define CLKDEV_INIT_N(d, n, cn)        \
> +       {                       \
> +               .dev_id = d,    \
> +               .con_id = n,    \
> +               .clk_name = cn, \
> +       }
> +

...until something better is found. Adding the clock name to clk_lookup
seems like a good start.

> > +	imx_clk_gate("uart3_ipg_gate", "ipg", CCM_PCCR1, 29);
> > +	imx_clk_gate("uart2_ipg_gate", "ipg", CCM_PCCR1, 30);
> > +	imx_clk_gate("uart1_ipg_gate", "ipg", CCM_PCCR1, 31);
> > +
> > +	for (i = 0; i < ARRAY_SIZE(lookups); i++) {
> > +		struct clkl *l = &lookups[i];
> > +		l->lookup.clk = __clk_lookup(l->clkname);
> 
> That's somehow unfortunate this expensive function needs to be called
> to retrieve these clks, while those registration functions should ever
> have them returned.

I wanted to avoid having 'clkbla =' before every initializer. Maybe we
can skip struct clk from struct clk_lookup and only keep the name.
__clk_lookup could then be called in clk_get. This way looking up the
clock would be done when a clock is requested and we wouldn't do it
all at once and wouldn't add delays to the boot process.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
