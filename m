From: dinguyen@altera.com (Dinh Nguyen)
Date: Wed, 20 Mar 2013 07:24:55 -0500
Subject: [PATCHv2 2/2] ARM: socfpga: Add clock entries into device tree
In-Reply-To: <20130319221233.8663.40135@quantum>
References: <1363707936-17769-1-git-send-email-dinguyen@altera.com>
 <1363707936-17769-2-git-send-email-dinguyen@altera.com>
 <20130319164638.8663.89508@quantum>
 <1363718750.17844.5.camel@linux-builds1>
 <20130319221233.8663.40135@quantum>
Message-ID: <1363782295.12746.7.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Tue, 2013-03-19 at 15:12 -0700, Mike Turquette wrote:
> Quoting Dinh Nguyen (2013-03-19 11:45:50)
> > Hi Mike,
> > 
> > On Tue, 2013-03-19 at 09:46 -0700, Mike Turquette wrote:
> > > Quoting dinguyen at altera.com (2013-03-19 08:45:36)
> > > > From: Dinh Nguyen <dinguyen@altera.com>
> > > > 
> > > > Adds the main PLL clock groups for SOCFPGA into device tree file
> > > > so that the clock framework to query the clock and clock rates
> > > > appropriately.
> > > >
>  

<snip>

> > > 
> > > There is a lot going on in this one patch.  I would prefer to see the
> > > clock driver broken out separately.
> > 
> > Not sure what you mean by breaking out the clock driver separately. The
> > patch is only touching the clocks for mach-socfpga.
> > 
> 
> I mean breaking the change to drivers/clk/socfpga/clk.c out into a
> separate patch.
> 
> > The patch is
> > 7 files changed, 366 insertions(+), 21 deletions(-)
> > 
> > while the patch to enable clk-highbank was:
> > 8 files changed, 463 insertions(+), 64 deletions(-)
> > 
> 
> That is a fair comparison.  However I still prefer to see data (e.g. dts
> changes) separated from logic (clk.c changes).  I think it makes for a
> cleaner git history and makes patches more readable too.

I agree that it makes things alot cleaner to split DTS and code into
separate patches, but at the same time the code is pretty much useless
without the DTS entries. I apologize if there has already been a similar
discussion on the list about this. I just want to make sure that I know
to split up patches in the same manner in the future?

> 
> Regards,
> Mike
> 
> > > <snip>
> > > 
> > > > diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
> > > > index 2c855a6..da6b461 100644
> > > > --- a/drivers/clk/socfpga/clk.c
> > > > +++ b/drivers/clk/socfpga/clk.c
> > > <snip>
> > > > +static int clk_pll_enable(struct clk_hw *hwclk)
> > > > +{
> > > > +       struct socfpga_clk *socfpgaclk = to_socfpga_clk(hwclk);
> > > > +       u32 reg;
> > > > +
> > > > +       reg = readl(socfpgaclk->reg);
> > > > +       reg |= SOCFPGA_PLL_EXT_ENA;
> > > > +       writel(reg, socfpgaclk->reg);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static void clk_pll_disable(struct clk_hw *hwclk)
> > > >  {
> > > > +       struct socfpga_clk *socfpgaclk = to_socfpga_clk(hwclk);
> > > > +       u32 reg;
> > > > +
> > > > +       reg = readl(socfpgaclk->reg);
> > > > +       reg &= ~SOCFPGA_PLL_EXT_ENA;
> > > > +       writel(reg, socfpgaclk->reg);
> > > > +}
> > > > +
> > > 
> > > For a simple enable which just sets a bit, you might want to re-use the
> > > basic gate clock type.  This can be done similar to the composite clock
> > > patches (currently on the list) by stuffing a clk_gate structure into
> > > your custom socfpga_clk type.
> > 
> > I'll take a look at the list about this.

I think mvebu/clk-gating-ctrl.c is doing the same thing you're
suggesting right?

Thanks,
Dinh
> > 
> > Thanks for the review.
> > 
> > Dinh
> > > 
> > > Regards,
> > > Mike
> > >
> 
