From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Feb 2015 17:12:30 +0000
Subject: [PATCH v2 4/4] clk: dt: Introduce always-on clock domain
 documentation
In-Reply-To: <CAL_Jsq+r1BKt5B9FNPG+Y0Oi1-3RGNmRUDbpX_uDJwr45bxMXA@mail.gmail.com>
References: <1424276101-30137-1-git-send-email-lee.jones@linaro.org>
 <1424276101-30137-5-git-send-email-lee.jones@linaro.org>
 <CAL_Jsq+r1BKt5B9FNPG+Y0Oi1-3RGNmRUDbpX_uDJwr45bxMXA@mail.gmail.com>
Message-ID: <20150218171230.GA30676@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Feb 2015, Rob Herring wrote:

> On Wed, Feb 18, 2015 at 10:15 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  .../devicetree/bindings/clock/clk-domain.txt       | 35 ++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/clk-domain.txt
> >
> > diff --git a/Documentation/devicetree/bindings/clock/clk-domain.txt b/Documentation/devicetree/bindings/clock/clk-domain.txt
> > new file mode 100644
> > index 0000000..b86772f5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/clk-domain.txt
> > @@ -0,0 +1,35 @@
> > +Always-on Clock Domain
> > +
> > +Some hardware is contains bunches of clocks which must never be
> > +turned off.  If drivers a) fail to obtain a reference to any of
> > +these or b) give up a previously obtained reference during suspend,
> > +the common clk framework will attempt to disable them and the
> > +hardware can fail irrecoverably.  Usually, the only way to recover
> > +from these failures is to restart.
> 
> How is (b) not a bug?

Clocks are normally disabled during suspend.  When clocks are disabled
they give up their reference.  If references reach 0, the clock is
gated.  If one of these clocks is gated, the system will never come
out of suspend.

How is it a bug?

> While I think we need something here, I worry that this will be abused
> to be a list of clocks you have not gotten around to managing. We

You can say that about any framework.  It's our responsibility to ask
the right questions and to disallow it from being abused.  The clocks
I use in the (real-world) example in this set are _really_ always-on.
If any of them are turned off the system will cease to perform in any
meaningful way.

> cannot be changing the DT every time the kernel starts managing a
> clock. I think this should operate more as always on until claimed.

The point of this is that even when these clocks are claimed, there is
an issue that when unclaimed (i.e. during suspend) the clk framework
will attempt to gate them, and when they do *boom*.

> But then you get into drivers having to be aware that the clock
> started enabled.

This has nothing to do with the initial state of the clock.  It's
whether the clock is integral (i.e. is part of a vital interconnect)
that's important.  For instance, ST's bootloader turns on lots of
clocks which can be safely gated if unused.  The clocks we're
registering with this always-on framework cannot.

> Also, I feel like we are using DT to work around kernel policy (of
> turning off clocks). If the policy was to leave on clocks, then we
> would be trying to put a list of clocks to disable in DT.

I'm not sure I understand your point.  The current policy is correct
if it's power that you care about, which is invariably the point of
disabling clocks in the first place, right?  Also, this has nothing to
do with DT per say.  It's just another framework driver.

> > +To avoid either of these two scenarios from catastrophically
> > +disabling an otherwise perfectly healthy running system, we have
> > +implemented a clock domain where clocks are consumed and references
> > +are taken, thus preventing them from being shut down by the
> > +framework.
> > +
> > +We use the generic clock bindings found in:
> > +  Documentation/devicetree/bindings/clock/clock-bindings.txt
> > +
> > +Required properties:
> > +- compatible : Must be "always-on-clk-domain"
> > +
> > +Example:
> > +
> > +clk-domain {
> > +       compatible = "always-on-clk-domain";
> > +       clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>,
> > +                <&clk_s_c0_flexgen CLK_COMPO_DVP>,
> > +                <&clk_s_c0_flexgen CLK_MMC_1>,
> > +                <&clk_s_c0_flexgen CLK_ICN_SBC>,
> > +                <&clk_s_c0_flexgen CLK_ICN_LMI>,
> > +                <&clk_s_c0_flexgen CLK_ICN_CPU>,
> > +                <&clk_s_c0_flexgen CLK_TX_ICN_DMU>,
> > +                <&clk_s_a0_flexgen CLK_IC_LMI0>,
> > +                <&clk_m_a9>;
> > +};
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
