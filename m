From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 28 Jan 2015 09:46:40 -0800
Subject: [PATCH 4/4] clk: dt: st: Introduce clock domain documentation
In-Reply-To: <20150128075835.GF4567@x1>
References: <1422270840-3039-1-git-send-email-lee.jones@linaro.org>
 <1422270840-3039-5-git-send-email-lee.jones@linaro.org>
 <20150128011902.22722.85007@quantum> <20150128075835.GF4567@x1>
Message-ID: <20150128174640.22722.75574@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Lee Jones (2015-01-27 23:58:35)
> On Tue, 27 Jan 2015, Mike Turquette wrote:
> 
> > Quoting Lee Jones (2015-01-26 03:14:00)
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  .../devicetree/bindings/clock/st/st,clk-domain.txt | 34 ++++++++++++++++++++++
> > >  1 file changed, 34 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/clock/st/st,clk-domain.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/clock/st/st,clk-domain.txt b/Documentation/devicetree/bindings/clock/st/st,clk-domain.txt
> > > new file mode 100644
> > > index 0000000..7309937
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/clock/st/st,clk-domain.txt
> > > @@ -0,0 +1,34 @@
> > > +STMicroelectronics Clock Domain
> > > +
> > > +ST hardware have a bunch of clocks which must not be turned off.
> > > +If drivers a) fail to obtain a reference to any of these or b) give
> > > +up a previously obtained reference during suspend, the common clk
> > > +framework will attempt to turn them off and the hardware will
> > > +subsequently die.  The only way to recover from this failure is to
> > > +restart.
> > > +
> > > +To avoid either of these two scenarios from catastrophically
> > > +disabling the running system we have implemented a clock domain
> > > +where clocks are consumed and references are taken, thus preventing
> > > +them from being shut down by the framework.
> > > +
> > > +We use the generic clock bindings found in:
> > > +  Documentation/devicetree/bindings/clock/clock-bindings.txt
> > > +
> > > +Required properties:
> > > +- compatible : Must be "st,clk-domain"
> > 
> > Seems like a useful feature for any clock provider, not just ST's. Have
> > you thought about making this solution generic for DT-based clock
> > providers?
> > 
> > We could amend the common clock binding to include a special "always on"
> > clock group that is automagically prepared and enabled when the clock
> > provider/driver is registered, using a common function.
> 
> OMG, I'm actually going to strangle you!
> 
> This is what I've been proposing to you (privately) for weeks.

Yikes! Please do not strangle me yet. I have books on loan from my
public library that I must return before I expire.

> 
> Does this ring any bells?
> 
>   "Just FYI, I am not going to add any method to the kernel that
>   permanently enables a clock via some new api. At the worst case your
>   clock driver can simply call clk_prepare_enable in its probe
>   function (there are some examples of this)."
> 

In all fairness I found the chat log where I wrote the above quote and
there was not much context for the problem you were trying to solve. And
we were both trapped in different meetings at a conference and could not
discuss it face to face before your flight. Some things are done better
over email than over a quick Google chat.

> I will be more than happy to make this a generic driver, if thats what
> you want (now). ;)

Well your method does use clk_get and clk_prepare_enable which satisfies
my statement above. When I said "no" to this idea earlier I had imagined
you banging on the register to keep the clock enabled in hardware, but
have the framework keep the enable_count & prepare_count at 0. Folks
have asked for this before and it is a no-go.

Right now I think that the common clock binding (which is the root of
all of the vendor-specific bindings) could create a special container
for always-on clocks. We would need to define this behavior. For
simplicity I think the only clocks that should go into this container
are clocks that we never gate during the lifetime of the device being
powered on, and they are clocks that do not need to be managed by
external drivers.

of_clk_set_defaults is called from of_clk_add_provider which might be a
good place to start looking.

What do you think?

Regards,
Mike

> 
> > > +Example:
> > > +
> > > +clk-domain {
> > > +       compatible = "st,clk-domain";
> > > +       clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>,
> > > +                <&clk_s_c0_flexgen CLK_COMPO_DVP>,
> > > +                <&clk_s_c0_flexgen CLK_MMC_1>,
> > > +                <&clk_s_c0_flexgen CLK_ICN_SBC>,
> > > +                <&clk_s_c0_flexgen CLK_ICN_LMI>,
> > > +                <&clk_s_c0_flexgen CLK_ICN_CPU>,
> > > +                <&clk_s_c0_flexgen CLK_TX_ICN_DMU>,
> > > +                <&clk_s_a0_flexgen CLK_IC_LMI0>,
> > > +                <&clk_m_a9>;
> > > +};
> 
> -- 
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org ? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
