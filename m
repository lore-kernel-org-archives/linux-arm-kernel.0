From: mturquette@baylibre.com (Michael Turquette)
Date: Tue, 20 Oct 2015 05:40:00 -0700
Subject: [PATCH RFC RFT 2/3] clk: clk_put WARNs if user has not disabled
 clk
In-Reply-To: <CAMuHMdX8Fq3AfxuZMLe4-CYFzrDiQcwnREQhX5fSGXzYNSkKsA@mail.gmail.com>
References: <1438974570-20812-1-git-send-email-mturquette@baylibre.com>
 <1438974570-20812-3-git-send-email-mturquette@baylibre.com>
 <CAMuHMdX8Fq3AfxuZMLe4-CYFzrDiQcwnREQhX5fSGXzYNSkKsA@mail.gmail.com>
Message-ID: <20151020124000.20687.60752@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

Quoting Geert Uytterhoeven (2015-09-30 08:38:46)
> Hi Mike,
> 
> On Fri, Aug 7, 2015 at 9:09 PM, Michael Turquette
> <mturquette@baylibre.com> wrote:
> > From the clk_put kerneldoc in include/linux/clk.h:
> >
> > """
> > Note: drivers must ensure that all clk_enable calls made on this clock
> > source are balanced by clk_disable calls prior to calling this function.
> > """
> >
> > The common clock framework implementation of the clk.h api has per-user
> > reference counts for calls to clk_prepare and clk_disable. As such it
> > can enforce the requirement to properly call clk_disable and
> > clk_unprepare before calling clk_put.
> >
> > Because this requirement is probably violated in many places, this patch
> > starts with a simple warning. Once offending code has been fixed this
> > check could additionally release the reference counts automatically.
> >
> > Signed-off-by: Michael Turquette <mturquette@baylibre.com>
> > ---
> >  drivers/clk/clk.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index 72feee9..6ec0f77 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -2764,6 +2764,14 @@ void __clk_put(struct clk *clk)
> >             clk->max_rate < clk->core->req_rate)
> >                 clk_core_set_rate_nolock(clk->core, clk->core->req_rate);
> >
> > +       /*
> > +        * before calling clk_put, all calls to clk_prepare and clk_enable from
> > +        * a given user must be balanced with calls to clk_disable and
> > +        * clk_unprepare by that same user
> > +        */
> > +       WARN_ON(clk->prepare_count);
> > +       WARN_ON(clk->enable_count);
> 
> These two WARN_ON()s are triggered a lot when using a legacy clock domain,
> and CONFIG_PM=n. Indeed, without Runtime PM, the idea is that the module clocks
> get enabled unconditionally, which violates the assumptions above.
> 
> Cfr. the CONFIG_PM=n version of pm_clk_notify() in
> drivers/base/power/clock_ops.c, which calls enable_clock():
> 
>     /**
>      * enable_clock - Enable a device clock.
>      * @dev: Device whose clock is to be enabled.
>      * @con_id: Connection ID of the clock.
>      */
>     static void enable_clock(struct device *dev, const char *con_id)
>     {
>             struct clk *clk;
> 
>             clk = clk_get(dev, con_id);
>             if (!IS_ERR(clk)) {
>                     clk_prepare_enable(clk);
>                     clk_put(clk);

This is a violation of the clkdev api as defined in include/linux/clk.h:

	/**
	 * clk_put|------ "free" the clock source
	 * @clk: clock source
	 *
	 * Note: drivers must ensure that all clk_enable calls made on this
	 * clock source are balanced by clk_disable calls prior to calling
	 * this function.

So the WARN is doing its job and letting us know about incorrect use of
the API.

>                     dev_info(dev, "Runtime PM disabled, clock forced on.\n");
>             }
>     }
> 
> I think this affects shmobile, keystone, davinci, omap1, and legacy sh.

Why not keep the reference to the struct clk after get'ing it the first
time?

> 
> Sorry for not noticing before, we usually build with CONFIG_PM=y.
> One more reason for making CONFIG_PM=y mandatory on SoCs with clock domains?

I don't know about that, but it seems like a reason to fix the clkdev
usage in the clock domain code.

What do you think?

Regards,
Mike

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
