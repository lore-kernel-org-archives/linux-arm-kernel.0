From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 10 Aug 2013 13:06:01 +0200
Subject: [PATCH v6 09/11] clk: mmp: parse clock from dts
In-Reply-To: <20130809160401.GU27325@e106331-lin.cambridge.arm.com>
References: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
 <1374833133-21119-10-git-send-email-haojian.zhuang@gmail.com>
 <20130809160401.GU27325@e106331-lin.cambridge.arm.com>
Message-ID: <2492085.mx8aBrGksJ@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark, Haojian,

On Friday 09 of August 2013 17:04:01 Mark Rutland wrote:
> On Fri, Jul 26, 2013 at 11:05:31AM +0100, Haojian Zhuang wrote:
> > Parse clock information from DTS file for mach-mmp.
> > 
> > Changelog:
> > v6:
> > 1. Remove marvell string from properties in clock driver.
> > 2. Append document for clock binding device tree.
> > 3. Use apbc to replace apbcp. Since the main difference is register
> > base.
> > 
> > v5:
> > 1. Replace clk_register_mux() by clk_register_mux_table().
> > 
> > Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
> > ---
> > 
> >  .../devicetree/bindings/clock/mmp-clock.txt        |  51 ++++
> >  arch/arm/mach-mmp/mmp-dt.c                         |   2 +
> >  drivers/clk/mmp/Makefile                           |   2 +-
> >  drivers/clk/mmp/clk-mmp.c                          | 300
> >  +++++++++++++++++++++ 4 files changed, 354 insertions(+), 1
> >  deletion(-)
> >  create mode 100644
> >  Documentation/devicetree/bindings/clock/mmp-clock.txt create mode
> >  100644 drivers/clk/mmp/clk-mmp.c
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/mmp-clock.txt
> > b/Documentation/devicetree/bindings/clock/mmp-clock.txt new file mode
> > 100644
> > index 0000000..5fe52a2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/mmp-clock.txt
> > @@ -0,0 +1,51 @@
> > +Device Tree Clock bindings for arch-mmp
> > +
> > +This binding uses the common clock binding[1].
> > +
> > +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> > +
> 
> Are these used somewhere already?

Hmm? Are you asking about the generic clock bindings or I didn't get your 
question right? They are supposed to be used (and they are used) whenever 
clocks are involved.

> > +Required properties for fixed rate clocks:
> > +  - compatible : should be "marvell,mmp-fixed-clkrate".
> > +  - clocks : should be the input parent clock phandle for the clock.
> > This +       should be the reference clock.
> > +  - clock-output-names : should be reference name.
> > +  - #clock-cells : from common clock binding; should be set to 0.
> > +  - clock-frequency : frequency of the fixed rate clock
> 
> Why is "fixed-clock" not good enough?
> 
> This doesn't seem to describe anything more, and there's nothing
> additional in the driver...

+1

> > +
> > +Required properties for fixed factor clocks:
> > +  - compatible : should be "marvell,mmp-fixed-clkfactor".
> > +  - clocks : should be the input parent clock phandle for the clock.
> > This +       should be the reference clock.
> > +  - clock-output-names : should be reference name.
> > +  - #clock-cells : from common clock binding; should be set to 0.
> 
> The code seems to use an additional property not described here
> (mmp-fixed-factor). What does that represent?
> 
> Why not "fixed-factor-clock"?

+1

> > +
> > +Required properties for mux clocks:
> > +  - compatible : should be "marvell,mmp-clkmux".
> > +  - clocks : should be the input parent clock phandle for the clock.
> > This +       should be the reference clock.
> > +  - clock-output-names : should be reference name.
> > +  - #clock-cells : from common clock binding; should be set to 0.
> > +  - mmp-clk-reg : mux register offset & mask bits.
> 
> Offset from where? There's no reg, no container's described and there's
> no example.

+1

> > +  - mmp-clk-sel : array of mux select bits
> > +
> > +Required properties for divider clocks:
> > +  - compatible : should be "marvell,mmp-apmu-clkdiv".
> > +  - clocks : should be the input parent clock phandle for the clock.
> > This +       should be the reference clock.
> > +  - clock-output-names : should be reference name.
> > +  - #clock-cells : from common clock binding; should be set to 0.
> > +  - mmp-clk-reg : divider register offset & mask bits.
> 
> Similar comments to those above. This is also a fixed-factor-clock, no?

This looks like a clock with configurable divisor for me, but again, why 
not use the standard divider clock here?

Best regards,
Tomasz

> > +
> > +Required properties for gate clocks:
> > +  - compatible : should be "marvell,mmp-apbc-clk".
> > +  - clocks : should be the input parent clock phandle for the clock.
> > This +       should be the reference clock.
> > +  - clock-output-names : should be reference name.
> > +  - #clock-cells : from common clock binding; should be set to 0.
> > +  - mmp-clk-reg : gate register offset & mask bits.
> 
> Offset from where?
> 
> > +
> > +Optional properties for gate clocks:
> > +  - mmp-clk-delay : delay between enabling function clock and apb
> > clock
> Units?
> 
> > +  - mmp-apbc-power-ctrl : enable apbc power control bit
> 
> Is this a boolean or the offset of the bit offset?
> 
> > +
> 
> > +For example:
> Missing example?
> 
> [...]
> 
> > +static const struct of_device_id mmp_of_match[] = {
> > +       { .compatible = "marvell,mmp-mpmu", .data = (void *)MMP_MPMU,
> > }, +       { .compatible = "marvell,mmp-apmu", .data = (void
> > *)MMP_APMU, }, +       { .compatible = "marvell,mmp-apbc", .data =
> > (void *)MMP_APBC, }, +       { .compatible = "marvell,mmp-apbcp",
> > .data = (void *)MMP_APBCP, }, +       { .compatible = "mrvl,apb-bus",
> > .data = (void *)MMP_APB, }, +};
> 
> Not documented?
> 
> Thanks,
> Mark.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
