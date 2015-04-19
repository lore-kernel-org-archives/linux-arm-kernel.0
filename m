From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sun, 19 Apr 2015 17:30:06 +0200
Subject: [PATCH 1/2] clk: change clk_ops' ->round_rate() prototype
In-Reply-To: <7408975.lBcgZIN9hf@diego>
References: <1429255769-13639-1-git-send-email-boris.brezillon@free-electrons.com>
 <1429255769-13639-2-git-send-email-boris.brezillon@free-electrons.com>
 <7408975.lBcgZIN9hf@diego>
Message-ID: <20150419173006.0ce6cfe0@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Sun, 19 Apr 2015 14:13:04 +0200
Heiko St?bner <heiko@sntech.de> wrote:

> Hi Boris,
> 
> Am Freitag, 17. April 2015, 09:29:28 schrieb Boris Brezillon:
> > Clock rates are stored in an unsigned long field, but ->round_rate()
> > (which returns a rounded rate from a requested one) returns a long
> > value (errors are reported using negative error codes), which can lead
> > to long overflow if the clock rate exceed 2Ghz.
> > 
> > Change ->round_rate() prototype to return 0 or an error code, and pass the
> > requested rate as a pointer so that it can be adjusted depending on
> > hardware capabilities.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> 
> On a rk3288-veyron-pinky with the fix described below:
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> 
> 
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index fa5a00e..1462ddc 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -1640,8 +1643,10 @@ static struct clk_core *clk_calc_new_rates(struct
> > clk_core *clk, &parent_hw);
> >  		parent = parent_hw ? parent_hw->core : NULL;
> >  	} else if (clk->ops->round_rate) {
> > -		new_rate = clk->ops->round_rate(clk->hw, rate,
> > -						&best_parent_rate);
> > +		if (clk->ops->round_rate(clk->hw, &new_rate,
> > +					 &best_parent_rate))
> > +			return NULL;
> > +
> >  		if (new_rate < min_rate || new_rate > max_rate)
> >  			return NULL;
> >  	} else if (!parent || !(clk->flags & CLK_SET_RATE_PARENT)) {
> 
> This is using new_rate uninitialized when calling into the round_rate
> callback. Which in turn pushed my PLLs up to 2.2GHz :-)

Indeed, thanks for the fix.

[...]

> 
> 
> And as I've stumbled onto this recently too, the clock-maintainership has
> expanded to Stephen Boyd and linux-clk at vger.kernel.org .

Noted. I'll add Stephen and the new linux-clk ML in the recipient list
next time.

Best Regards,

Boris


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
