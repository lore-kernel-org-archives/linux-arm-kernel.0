From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 07 Nov 2018 11:01:02 -0800
Subject: [PATCH v9 3/5] clk: imx: add SCCG PLL type
In-Reply-To: <20181107115444.gscxwud7e57nx3c7@fsr-ub1664-175>
References: <1537785597-26499-1-git-send-email-abel.vesa@nxp.com>
 <1537785597-26499-4-git-send-email-abel.vesa@nxp.com>
 <153980615257.5275.13866740376184829057@swboyd.mtv.corp.google.com>
 <20181107115444.gscxwud7e57nx3c7@fsr-ub1664-175>
Message-ID: <154161726247.88331.15629902810537417880@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Abel Vesa (2018-11-07 03:54:45)
> On Wed, Oct 17, 2018 at 12:55:52PM -0700, Stephen Boyd wrote:
> > Quoting Abel Vesa (2018-09-24 03:39:55)
> > > +static unsigned long clk_pll2_recalc_rate(struct clk_hw *hw,
> > > +                                        unsigned long parent_rate)
> > > +{
> > > +       struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
> > > +       u32 val, ref, divr1, divf1, divr2, divf2;
> > > +       u64 temp64;
> > > +
> > > +       val = readl_relaxed(pll->base + PLL_CFG0);
> > > +       switch (FIELD_GET(PLL_REF_MASK, val)) {
> > > +       case 0:
> > > +               ref = OSC_25M;
> > > +               break;
> > > +       case 1:
> > > +               ref = OSC_27M;
> > > +               break;
> > > +       default:
> > > +               ref = OSC_25M;
> > 
> > Does this information not come through 'parent_rate'?
> > 
> 
> No. So basically both pll1 and pll2 and the divider after it form together this SCCG:
> 
> https://www.nxp.com/docs/en/reference-manual/IMX8MDQLQRM.pdf#page=834
> 
> See: Figure 5-8. SSCG PLL Block Diagram

Thanks for the link!

> 
> We're basically reading the input of the pll 1 in order to compute the output of the entire SCCG.
> 
> I know it's a mess. I'm working on cleaning it up, but for now we need this in in order to boot up.

What's the plan to clean it up?

> 
> > > +               break;
> > > +       }
> > > +
> > > +       val = readl_relaxed(pll->base + PLL_CFG2);
> > > +       divr1 = FIELD_GET(PLL_DIVR1_MASK, val);
> > > +       divr2 = FIELD_GET(PLL_DIVR2_MASK, val);
> > > +       divf1 = FIELD_GET(PLL_DIVF1_MASK, val);
> > > +       divf2 = FIELD_GET(PLL_DIVF2_MASK, val);
> > > +
> > > +       temp64 = ref * 2;
> > > +       temp64 *= (divf1 + 1) * (divf2 + 1);
> > > +
> > > +       do_div(temp64, (divr1 + 1) * (divr2 + 1));
> > 
> > Nitpicks: A comment with the equation may be helpful to newcomers.
> 
> Since the SCCG is contructed by multiple different types of clocks here, the equation doesn't help
> since it is spread in all constructing blocks.

Ok.
