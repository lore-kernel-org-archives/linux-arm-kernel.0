From: plaes@plaes.org (Priit Laes)
Date: Mon, 26 Jun 2017 05:53:31 +0000
Subject: [linux-sunxi] [PATCH v4 1/6] clk: sunxi-ng: div: Add support for
 fixed post-divider
In-Reply-To: <CANwerB1q68-PpQ7+-QbgBgZHeWw_4p1ruiwzy7upjLLRTDEG1w@mail.gmail.com>
References: <cover.24b2b13ec5a68552e186ba1637f1328363c3886e.1498422562.git-series.plaes@plaes.org>
 <bc043a64775ec8c9cfcfe6d638e348d38e34eba3.1498422562.git-series.plaes@plaes.org>
 <CANwerB1q68-PpQ7+-QbgBgZHeWw_4p1ruiwzy7upjLLRTDEG1w@mail.gmail.com>
Message-ID: <20170626055331.GB31066@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 26, 2017 at 08:05:16AM +1000, Jonathan Liu wrote:
> Hi Priit,
> 
> This is showing from clock rate of 171428572 in the output of "cat
> /sys/kernel/debug/clk/clk_summary" for pll-periph-sata.
> The clock rate should be 100000000 (100 MHz) when read from the hardware.

This is what I see on Cubietruck. Can you check with sunxi-ccu-wip branch?

$ cat /sys/kernel/debug/clk/clk_summary  |grep -i sata
          pll-periph-sata                 1            1   100000000          0 0  
             sata                         1            1   100000000          0 0  
                ahb-sata                  1            1   300000000          0 0  

> 
> On 26 June 2017 at 06:45, Priit Laes <plaes@plaes.org> wrote:
> > SATA clock on sun4i/sun7i is of type (parent) / M / 6 where
> > 6 is fixed post-divider.
> >
> > Signed-off-by: Priit Laes <plaes@plaes.org>
> > ---
> >  drivers/clk/sunxi-ng/ccu_div.c | 12 ++++++++++--
> >  drivers/clk/sunxi-ng/ccu_div.h |  3 ++-
> >  2 files changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/clk/sunxi-ng/ccu_div.c b/drivers/clk/sunxi-ng/ccu_div.c
> > index c0e5c10..de30e15 100644
> > --- a/drivers/clk/sunxi-ng/ccu_div.c
> > +++ b/drivers/clk/sunxi-ng/ccu_div.c
> 
> Missing handling of fixed_post_div in ccu_div_round_rate.
> ccu_div_round_rate should multiply the rate by the postdiv before
> looking up the divider using divider_get_val and divide val by postdiv
> just before returning.
> 
> > @@ -62,8 +62,13 @@ static unsigned long ccu_div_recalc_rate(struct clk_hw *hw,
> >         parent_rate = ccu_mux_helper_apply_prediv(&cd->common, &cd->mux, -1,
> >                                                   parent_rate);
> >
> > -       return divider_recalc_rate(hw, parent_rate, val, cd->div.table,
> > -                                  cd->div.flags);
> > +       val = divider_recalc_rate(hw, parent_rate, val, cd->div.table,
> > +                                 cd->div.flags);
> > +
> > +       if (cd->common.features & CCU_FEATURE_FIXED_POSTDIV)
> > +               val /= cd->fixed_post_div;
> > +
> > +       return val;
> >  }
> >
> >  static int ccu_div_determine_rate(struct clk_hw *hw,
> 
> > @@ -89,6 +94,9 @@ static int ccu_div_set_rate(struct clk_hw *hw, unsigned long rate,
> >         val = divider_get_val(rate, parent_rate, cd->div.table, cd->div.width,
> >                               cd->div.flags);
> >
> > +       if (cd->common.features & CCU_FEATURE_FIXED_POSTDIV)
> > +               val *= cd->fixed_post_div;
> > +
> >         spin_lock_irqsave(cd->common.lock, flags);
> >
> >         reg = readl(cd->common.base + cd->common.reg);
> 
> val here is the divider value that is stored in the clock register
> field not the actual rate so this is incorrect. Instead the rate needs
> to be multiplied by postdiv just before divider_get_val.

OK, thanks, this one I wasn't really sure about.

> 
> > diff --git a/drivers/clk/sunxi-ng/ccu_div.h b/drivers/clk/sunxi-ng/ccu_div.h
> > index 08d0744..f3a5028 100644
> > --- a/drivers/clk/sunxi-ng/ccu_div.h
> > +++ b/drivers/clk/sunxi-ng/ccu_div.h
> > @@ -86,9 +86,10 @@ struct ccu_div_internal {
> >  struct ccu_div {
> >         u32                     enable;
> >
> > -       struct ccu_div_internal         div;
> > +       struct ccu_div_internal div;
> >         struct ccu_mux_internal mux;
> >         struct ccu_common       common;
> > +       unsigned int            fixed_post_div;
> >  };
> >
> >  #define SUNXI_CCU_DIV_TABLE_WITH_GATE(_struct, _name, _parent, _reg,   \
> > --
> > git-series 0.9.1
> 
> Thanks.
> 
> Regards,
> Jonathan
