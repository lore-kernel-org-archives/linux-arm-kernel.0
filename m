From: aisheng.dong@nxp.com (A.s. Dong)
Date: Fri, 25 May 2018 09:48:48 +0000
Subject: [PATCH V2 1/4] clk: bulk: add of_clk_bulk_get()
In-Reply-To: <152182399342.178046.13139513462419815903@swboyd.mtv.corp.google.com>
References: <1521602391-30356-1-git-send-email-aisheng.dong@nxp.com>
 <1521602391-30356-2-git-send-email-aisheng.dong@nxp.com>
 <152182399342.178046.13139513462419815903@swboyd.mtv.corp.google.com>
Message-ID: <AM0PR04MB421192DFF5F41078B54FCC1A80690@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd at kernel.org]
> Sent: Saturday, March 24, 2018 12:53 AM
> To: A.s. Dong <aisheng.dong@nxp.com>; linux-clk at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> mturquette at baylibre.com; hdegoede at redhat.com;
> b.zolnierkie at samsung.com; linux at armlinux.org.uk; linux-
> fbdev at vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; A.s. Dong
> <aisheng.dong@nxp.com>; Stephen Boyd <sboyd@codeaurora.org>; Russell
> King <linux@arm.linux.org.uk>
> Subject: Re: [PATCH V2 1/4] clk: bulk: add of_clk_bulk_get()
> 
> Quoting Dong Aisheng (2018-03-20 20:19:48)
> > diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c index
> > 4c10456..4b357b2 100644
> > --- a/drivers/clk/clk-bulk.c
> > +++ b/drivers/clk/clk-bulk.c
> > @@ -19,6 +19,38 @@
> >  #include <linux/clk.h>
> >  #include <linux/device.h>
> >  #include <linux/export.h>
> > +#include <linux/of.h>
> > +
> > +#if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
> 
> Do we need these defines? of_clk_get() is a stub function when these
> configs are false.
> 

You're right. Will drop it.

> > +static int __must_check of_clk_bulk_get(struct device_node *np, int
> num_clks,
> > +                                       struct clk_bulk_data *clks) {
> > +       int ret;
> > +       int i;
> > +
> > +       for (i = 0; i < num_clks; i++)
> > +               clks[i].clk = NULL;
> > +
> > +       for (i = 0; i < num_clks; i++) {
> > +               clks[i].clk = of_clk_get(np, i);
> > +               if (IS_ERR(clks[i].clk)) {
> > +                       ret = PTR_ERR(clks[i].clk);
> > +                       pr_err("%pOF: Failed to get clk index: %d ret: %d\n",
> > +                              np, i, ret);
> > +                       clks[i].clk = NULL;
> > +                       goto err;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +
> > +err:
> > +       clk_bulk_put(i, clks);
> > +
> > +       return ret;
> > +}
> > +EXPORT_SYMBOL(of_clk_bulk_get);
> 
> It's static, so don't export it.

Got it.
Sorry for such mistake.

Will fix and sent V3.

Regards
Dong Aisheng
