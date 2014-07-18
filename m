From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 18 Jul 2014 18:00:41 +0200
Subject: [PATCH v5 01/14] clk: composite: support determine_rate using
 rate_ops->round_rate + mux_ops->set_parent
In-Reply-To: <CAG374jCyHu1qfu7BWXYGMEdN93Uep9bnZqFk5aNZvnLMLpPCOg@mail.gmail.com>
References: <156042792.J76K6jxIGl@diego> <2624483.YkCSJohOk6@diego>
 <CAG374jCyHu1qfu7BWXYGMEdN93Uep9bnZqFk5aNZvnLMLpPCOg@mail.gmail.com>
Message-ID: <4238549.HnGu1YxQiQ@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 18. Juli 2014, 15:55:55 schrieb Gabriel Fernandez:
> Hi Heiko,
> Sorry for the delay...
> 
> I have tested your patch with below cases.
> 
>                    -----
> 
> CH0 -----------+--|     |        -----    CLK1
> 
>                |  | MUX |-------| DIV |-----
> 
> CH1 ----+---------|     |        -----
> 
>         |      |   -----
>         |      |   
>         |      |   -----
>         |      
>         |      +--|     |        -----    CLK2
>         |      
>         |      |  | MUX |-------| DIV |-----
> 
>         +---------|     |        -----
> 
>         |      |   -----
>         |      |   
>         |      |   -----
>         |      
>         |      +--|     |        -----    CLK3
>         |      
>         |         | MUX |-------| DIV |-----
> 
>         +---------|     |        -----
> 
>                    -----
> 
> CH0 = 297000000 Hz
> CH1 = 148352000 Hz
> 
> i set:
> CLK1 -> 297000000
> CLK2 -> 148352000
> CLK3 -> 148352000/2
> 
> I was a little confused first time because CLK1,CLK2,CL3 had the
> clk_flags set to CLK_SET_RATE_PARENT.
> 
> result
> set rate CLK1 -> 297000000
>   ---> CLK1 = 297000000 (parent CH0)
> 
> set rate CLK2 -> 148352000
>   ---> CLK1 = 297000000 (parent CH0)
>   ---> CLK2 = 148352000 (parent CH1)
> 
> set rate CLK3 -> 148352000/2
>   ---> CLK1 = 148352000/2 (parent CH0)
>   ---> CLK2 = 148352000   (parent CH1)
>   ---> CLK3 = 148352000/2 (parent CH0)
> 
> We try to find the best parent but without considering the DIV...
> For me output clocks are not at all predictable in this case.
> what is your feeling about that ? is it a true probleme or a bad use case ?
> 
> 
> If clk_flags NOT set to CLK_SET_RATE_PARENT it's ok for me
> 
> result
> set rate CLK1 -> 297000000
>   ---> CLK1 = 297000000 (parent CH0)
> 
> set rate CLK2 -> 148352000
>   ---> CLK1 = 297000000 (parent CH0)
>   ---> CLK2 = 148352000 (parent CH1)
> 
> set rate CLK3 -> 148352000/2
>   ---> CLK1 = 297000000   (parent CH0)
>   ---> CLK2 = 148352000   (parent CH1)
>   ---> CLK3 = 148352000/2 (parent CH0)

ok, so when CLK_SET_RATE_PARENT is set, the clock framework essentially sets 
the CHx frequency to something new while without it it just uses the mux and 
divider so create a suitable frequency.

I guess, the rate_ops->round_rate is modifying the parent rate, as the CHx 
sources support changing them. But I'm wondering if the clock framework 
shouldn't prevent the parent clock from being lowered.

Also I'm not even sure if a traditional setup of mux + divider clocks wouldn't 
produce a similar result in the example above. Because when looking at 
__clk_mux_determine_rate it looks very similar [__clk_round_is used for the 
CLK_SET_RATE_PARENT case] and thus might even produce the same result.


Heiko


> 
> On 3 July 2014 01:56, Heiko St?bner <heiko@sntech.de> wrote:
> > From: Boris BREZILLON <b.brezillon@overkiz.com>
> > 
> > In case the rate_hw does not implement determine_rate, but only round_rate
> > we fallback to best_parent selection if mux_hw is present and support
> > reparenting.
> > 
> > Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> > 
> > This also fixes a rate calculation problem when using the standard div and
> > mux ops, as in this case currently only the mux->determine_rate is used
> > in the composite rate calculation.
> > So when for example the composite clock has two parents at 600 and 800MHz,
> > the requested rate is 75MHz, which the divider could provide, without this
> > change the rate would be set 600MHz ignoring the divider completely.
> > This may be way out of spec for the component.
> > 
> > [fixed the output to actually return a rate instead of the diff]
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > Acked-By: Max Schwarz <max.schwarz@online.de>
> > Tested-By: Max Schwarz <max.schwarz@online.de>
> > 
> > on a stih416 board
> > Tested-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
> > ---
> > Gabriel, I hope it is ok that I converted test-success to a Tested-by-Tag
> > :-)> 
> >  drivers/clk/clk-composite.c | 48
> >  ++++++++++++++++++++++++++++++++++++++++++++- 1 file changed, 47
> >  insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
> > index 57a078e..9548bfc 100644
> > --- a/drivers/clk/clk-composite.c
> > +++ b/drivers/clk/clk-composite.c
> > @@ -64,11 +64,56 @@ static long clk_composite_determine_rate(struct clk_hw
> > *hw, unsigned long rate,> 
> >         const struct clk_ops *mux_ops = composite->mux_ops;
> >         struct clk_hw *rate_hw = composite->rate_hw;
> >         struct clk_hw *mux_hw = composite->mux_hw;
> > 
> > +       struct clk *parent;
> > +       unsigned long parent_rate;
> > +       long tmp_rate, best_rate = 0;
> > +       unsigned long rate_diff;
> > +       unsigned long best_rate_diff = ULONG_MAX;
> > +       int i;
> > 
> >         if (rate_hw && rate_ops && rate_ops->determine_rate) {
> >         
> >                 rate_hw->clk = hw->clk;
> >                 return rate_ops->determine_rate(rate_hw, rate,
> >                 best_parent_rate,
> >                 
> >                                                 best_parent_p);
> > 
> > +       } else if (rate_hw && rate_ops && rate_ops->round_rate &&
> > +                  mux_hw && mux_ops && mux_ops->set_parent) {
> > +               *best_parent_p = NULL;
> > +
> > +               if (__clk_get_flags(hw->clk) & CLK_SET_RATE_NO_REPARENT) {
> > +                       *best_parent_p = clk_get_parent(mux_hw->clk);
> > +                       *best_parent_rate =
> > __clk_get_rate(*best_parent_p);
> > +
> > +                       return rate_ops->round_rate(rate_hw, rate,
> > +                                                   best_parent_rate);
> > +               }
> > +
> > +               for (i = 0; i < __clk_get_num_parents(mux_hw->clk); i++) {
> > +                       parent = clk_get_parent_by_index(mux_hw->clk, i);
> > +                       if (!parent)
> > +                               continue;
> > +
> > +                       parent_rate = __clk_get_rate(parent);
> > +
> > +                       tmp_rate = rate_ops->round_rate(rate_hw, rate,
> > +                                                       &parent_rate);
> > +                       if (tmp_rate < 0)
> > +                               continue;
> > +
> > +                       rate_diff = abs(rate - tmp_rate);
> > +
> > +                       if (!rate_diff || !*best_parent_p
> > +                                      || best_rate_diff > rate_diff) {
> > +                               *best_parent_p = parent;
> > +                               *best_parent_rate = parent_rate;
> > +                               best_rate_diff = rate_diff;
> > +                               best_rate = tmp_rate;
> > +                       }
> > +
> > +                       if (!rate_diff)
> > +                               return rate;
> > +               }
> > +
> > +               return best_rate;
> > 
> >         } else if (mux_hw && mux_ops && mux_ops->determine_rate) {
> >         
> >                 mux_hw->clk = hw->clk;
> >                 return mux_ops->determine_rate(mux_hw, rate,
> >                 best_parent_rate,
> > 
> > @@ -196,7 +241,8 @@ struct clk *clk_register_composite(struct device *dev,
> > const char *name,> 
> >                 composite->rate_hw = rate_hw;
> >                 composite->rate_ops = rate_ops;
> >                 clk_composite_ops->recalc_rate =
> >                 clk_composite_recalc_rate;
> > 
> > -               if (rate_ops->determine_rate)
> > +               if (rate_ops->determine_rate ||
> > +                   (rate_ops->round_rate &&
> > clk_composite_ops->set_parent))> 
> >                         clk_composite_ops->determine_rate =
> >                         clk_composite_determine_rate;
> >         
> >         }
> > 
> > --
> > 1.9.0
> > 
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
