From: sboyd@kernel.org (Stephen Boyd)
Date: Thu, 18 Oct 2018 10:05:42 -0700
Subject: [SPAM]Re: [PATCH v1 3/3] clk: mediatek: mt2712: add pll reference
 support
In-Reply-To: <1539842417.22495.7.camel@mtksdaap41>
References: <20180920095727.11868-1-weiyi.lu@mediatek.com>
 <20180920095727.11868-5-weiyi.lu@mediatek.com>
 <153936680359.5275.14901579706860255114@swboyd.mtv.corp.google.com>
 <1539784392.16401.28.camel@mtksdaap41>
 <153978572885.5275.2199850145066961212@swboyd.mtv.corp.google.com>
 <1539842417.22495.7.camel@mtksdaap41>
Message-ID: <153988234241.5275.3852252879149598870@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Weiyi Lu (2018-10-17 23:00:17)
> On Wed, 2018-10-17 at 07:15 -0700, Stephen Boyd wrote:
> > Quoting Weiyi Lu (2018-10-17 06:53:12)
> > > On Fri, 2018-10-12 at 10:53 -0700, Stephen Boyd wrote:
> > > > Quoting Weiyi Lu (2018-09-20 02:57:27)
> > > > > +
> > > > > +       rc = of_parse_phandle_with_args(node, "mediatek,refclk",
> > > > > +                       "#clock-cells", 0, &refclk);
> > > > > +       if (!rc) {
> > > > > +               of_property_read_string(refclk.np, "clock-output-names",
> > > > > +                               &refclk_name);
> > > > > +               for (i = 0; i < num_plls; i++)
> > > > > +                       plls[i].parent_name = refclk_name;
> > > > 
> > > > Use of_clk_parent_fill()?
> > > > 
> > > Thanks for the hint, i might use of_clk_get_parent_name() instead like
> > > below to get each parent clock name.
> > > refclk_name = of_clk_get_parent_name(node, 0);
> > > refclk_aud_name = of_clk_get_parent_name(node, 1);
> > 
> > Alright.
> > 
> > > 
> > > > > +       }
> > > > > +
> > > > > +       rc = of_parse_phandle_with_args(node, "mediatek,refclk-aud",
> > > > > +                       "#clock-cells", 0, &refclk_aud);
> > > > 
> > > > This is odd. Is this a custom 'clocks' property? What's going on here?
> > > > Why can't we use assigned clock parents for this?
> > > Yes. both the reference clock of all PLL and the reference clock of
> > > audio PLL could be customized.These two reference clocks shall be
> > > provided by some component like crystal oscillators on the board. So we
> > > might unable to switch the PLL reference source at runtime, in other
> > > words, it should be set statically. That's why we didn't provide the
> > > set_parent ops for pll clock type. It's also the main reason we choose
> > > not to use assigned-clock-parents for this requirement.
> > > 
> > 
> > Ok. Do you need some new software clk flag that indicates we should
> > "lock" the parent or rate configured at boot time? I would like to see
> > this driver implement the clk_ops for the hardware and have the
> > framework be the one that configures the tree, instead of doing it some
> > custom way for this single driver.
> > 
> Hi Stephen, do you mean we might be able to add a flag just like
> CLK_IS_CRITICAL and how it works on clk_enable & clk_disable ops?
> And should we make this new flag to allow to set parent before clock is
> registered and prohibit from changing the rate and parent after clock
> registration. If my understanding is correct, I'll give a try.

Mostly, yes. It would be similar to CLK_IS_CRITICAL, like
CLK_CONFIGURE_ONCE or something like that. It would effectively lock the
configuration after the clk is registered and any assigned parents or
rates are applied.

> BTW, how about the two patch for the ECO change before this patch. Is
> there any problem on those two patches?
> 

No, those look fine. I just thought you would resend the whole series
again.
