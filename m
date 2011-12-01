From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 1 Dec 2011 15:24:14 +0100
Subject: [RFC V1 3/8] clk: Add support for simple dividers
In-Reply-To: <20111201074253.GD8684@b20223-02.ap.freescale.net>
References: <1322046755-13511-1-git-send-email-richard.zhao@linaro.org>
 <1322046755-13511-4-git-send-email-richard.zhao@linaro.org>
 <CAPtuhThdt3Q63r_mP7aanXdgLH1si2pHfRr_Yg1GRhREqdDmfg@mail.gmail.com>
 <20111201074253.GD8684@b20223-02.ap.freescale.net>
Message-ID: <20111201142414.GO27267@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2011 at 03:42:59PM +0800, Richard Zhao wrote:
> On Wed, Nov 30, 2011 at 12:43:10PM -0800, Mike Turquette wrote:
> > On Wed, Nov 23, 2011 at 3:12 AM, Richard Zhao <richard.zhao@linaro.org> wrote:
> > > +#define account_for_rounding_errors ? ?1
> > > +
> > > +static int clk_divider_bestdiv(struct clk *clk, unsigned long rate,
> > > + ? ? ? ? ? ? ? unsigned long *best_parent_rate)
> > > +{
> > > + ? ? ? struct clk_divider *divider = to_clk_divider(clk);
> > > + ? ? ? int i, bestdiv = 0;
> > > + ? ? ? unsigned long parent_rate, best = 0, now, maxdiv;
> > > +
> > > + ? ? ? maxdiv = (1 << divider->width);
> > > +
> > > + ? ? ? if (divider->flags & CLK_DIVIDER_FLAG_ONE_BASED)
> > > + ? ? ? ? ? ? ? maxdiv--;
> > > +
> > > + ? ? ? if (!(clk->flags & CLK_PARENT_SET_RATE)) {
> > > + ? ? ? ? ? ? ? parent_rate = clk->parent->rate;
> > > + ? ? ? ? ? ? ? bestdiv = parent_rate / rate;
> > > + ? ? ? ? ? ? ? bestdiv = bestdiv == 0 ? 1 : bestdiv;
> > > + ? ? ? ? ? ? ? bestdiv = bestdiv > maxdiv ? maxdiv : bestdiv;
> > > + ? ? ? ? ? ? ? goto out;
> > > + ? ? ? }
> The code is originally from Sascha. I think it again.
> 
> Sascha, why don't we use the below code?
> 
> 	for (i = 1; i <= maxdiv; i++) {
> 		int div;
> 		parent_rate = clk_round_rate(clk->parent, rate * i);
> 		div = parent_rate / rate;
> 		div = div > maxdiv ? maxdiv : div;
> 		div = div < 1 ? 1 : div;
> 		now = parent_rate / div;
> 
> 		if (now <= rate && now >= best) {
> 			bestdiv = div;
> 			best = now;
> 			best_parent_rate = parent_rate;
> 		}
> 	}

Yes, why not ;)

I can't remember the exact problem, but it came in with cascaded
dividers which wouldn't work without this. I've never been very
proud of this account_for_rounding_errors, so feel free to remove
it and see what happens. If this becomes a problem we can search
for a better solution.


> 
> 
> > > +
> > > + ? ? ? /*
> > > + ? ? ? ?* The maximum divider we can use without overflowing
> > > + ? ? ? ?* unsigned long in rate * i below
> > > + ? ? ? ?*/
> > > + ? ? ? maxdiv = min(ULONG_MAX / rate, maxdiv);
> > > +
> > > + ? ? ? for (i = 1; i <= maxdiv; i++) {
> > > + ? ? ? ? ? ? ? parent_rate = clk_round_rate(clk->parent,
> > > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? (rate + account_for_rounding_errors) * i);
> > 
> > How about just ((rate + 1) * i) with a comment above explaining why?
> > This removes the awkward #define above.
> > 
> > Also, I'd like to roll this into clk-basic.c for the V4 series.  Any objections?
> Go ahead.
> 
> Thanks
> Richard
> > 
> > Thanks,
> > Mike
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
