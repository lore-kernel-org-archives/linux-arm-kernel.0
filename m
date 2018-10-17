From: weiyi.lu@mediatek.com (Weiyi Lu)
Date: Wed, 17 Oct 2018 21:53:12 +0800
Subject: [SPAM]Re: [PATCH v1 3/3] clk: mediatek: mt2712: add pll
 reference support
In-Reply-To: <153936680359.5275.14901579706860255114@swboyd.mtv.corp.google.com>
References: <20180920095727.11868-1-weiyi.lu@mediatek.com>
 <20180920095727.11868-5-weiyi.lu@mediatek.com>
 <153936680359.5275.14901579706860255114@swboyd.mtv.corp.google.com>
Message-ID: <1539784392.16401.28.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-10-12 at 10:53 -0700, Stephen Boyd wrote:
> Quoting Weiyi Lu (2018-09-20 02:57:27)
> > For some MT2712 projects, audpll could select another reference
> > clock source if there exists an extra Crystal Oscillators than
> > the default clk26m XTAL.
> > Declare with the property "mediatek,refclk-aud" to switch
> > the audpll reference clock.
> > And also support to modify the reference clock of all PLL with
> > property "mediatek,refclk" instead of the default source "clk26m".
> > 
> > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> > ---
> > diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
> > index e36f4aab634d..2a4db1718089 100644
> > --- a/drivers/clk/mediatek/clk-mt2712.c
> > +++ b/drivers/clk/mediatek/clk-mt2712.c
> [...]
> > +       size_t i;
> > +       u32 r;
> > +
> > +       base = of_iomap(node, 0);
> > +       if (base) {
> > +               sel_addr = base + 0x40;
> > +       } else {
> > +               pr_err("%s(): ioremap failed\n", __func__);
> > +               return;
> > +       }
> 
> Nitpick: Write this as
> 
> 	base = of_iomap();
> 	if (!base)
> 		return;
> 	sel_addr = base + 0x40;
> 
Got it, I'll fix it.

> > +
> > +       rc = of_parse_phandle_with_args(node, "mediatek,refclk",
> > +                       "#clock-cells", 0, &refclk);
> > +       if (!rc) {
> > +               of_property_read_string(refclk.np, "clock-output-names",
> > +                               &refclk_name);
> > +               for (i = 0; i < num_plls; i++)
> > +                       plls[i].parent_name = refclk_name;
> 
> Use of_clk_parent_fill()?
> 
Thanks for the hint, i might use of_clk_get_parent_name() instead like
below to get each parent clock name.
refclk_name = of_clk_get_parent_name(node, 0);
refclk_aud_name = of_clk_get_parent_name(node, 1);

> > +       }
> > +
> > +       rc = of_parse_phandle_with_args(node, "mediatek,refclk-aud",
> > +                       "#clock-cells", 0, &refclk_aud);
> 
> This is odd. Is this a custom 'clocks' property? What's going on here?
> Why can't we use assigned clock parents for this?
Yes. both the reference clock of all PLL and the reference clock of
audio PLL could be customized.These two reference clocks shall be
provided by some component like crystal oscillators on the board. So we
might unable to switch the PLL reference source at runtime, in other
words, it should be set statically. That's why we didn't provide the
set_parent ops for pll clock type. It's also the main reason we choose
not to use assigned-clock-parents for this requirement.

> > +       if (!rc) {
> > +               of_property_read_string(refclk_aud.np, "clock-output-names",
> > +                               &refclk_aud_name);
> > +               if (strcmp(refclk_name, refclk_aud_name)) {
> > +                       plls[CLK_APMIXED_APLL1].parent_name = refclk_aud_name;
> > +                       plls[CLK_APMIXED_APLL2].parent_name = refclk_aud_name;
> > +                       r = readl(sel_addr) | 0x60000;
> > +               } else {
> > +                       r = readl(sel_addr) & ~0x60000;
> > +               }
> > +
> > +               writel(r, sel_addr);
> > +       }
> > +}
> > +
