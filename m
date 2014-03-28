From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 28 Mar 2014 13:29:05 +0000
Subject: [PATCH 44/44] ARM: l2c: add L2C-310 power control DT properties
In-Reply-To: <CAL_JsqJ1Lx08iv4vj3c7s6vy5zF4BQDd=TuGH82O=54X4jAWGg@mail.gmail.com>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
 <E1WPLEy-0002er-51@rmk-PC.arm.linux.org.uk>
 <CAL_JsqJ1Lx08iv4vj3c7s6vy5zF4BQDd=TuGH82O=54X4jAWGg@mail.gmail.com>
Message-ID: <20140328132905.GH7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 04:08:55PM -0500, Rob Herring wrote:
> On Sun, Mar 16, 2014 at 7:17 PM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> > Add two new properties for setting thte L3 power control register.  Two
> > new properties are added:
> >
> >         arm,dynamic-clk-gating
> >         arm,standby-mode
> >
> > iMX6 sets both these, add the properties there.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  Documentation/devicetree/bindings/arm/l2cc.txt |  2 ++
> >  arch/arm/boot/dts/imx6qdl.dtsi                 |  2 ++
> >  arch/arm/boot/dts/imx6sl.dtsi                  |  2 ++
> >  arch/arm/mm/cache-l2x0.c                       | 10 ++++++++++
> >  4 files changed, 16 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
> > index b513cb8196fe..e0dd400ecea6 100644
> > --- a/Documentation/devicetree/bindings/arm/l2cc.txt
> > +++ b/Documentation/devicetree/bindings/arm/l2cc.txt
> > @@ -40,6 +40,8 @@ implementations of the L2 cache controller with compatible programming models.
> >  - arm,filter-ranges : <start length> Starting address and length of window to
> >    filter. Addresses in the filter window are directed to the M1 port. Other
> >    addresses will go to the M0 port.
> > +- arm,dynamic-clk-gating : Enables dynamic clock gating (PL310)
> > +- arm,standby-mode : Enables standby mode (PL310)
> 
> I'd rather see properties to disable these features and the default to
> be to enable them. I would expect disabling them to be the exception.
> I can't imagine that they would be broken at an integration level
> unless h/w is doing something based on CLKSTOPPED. Given you also need
> s/w interaction (flush and disable the cache) to do anything like
> reducing voltage or cutting power to the L2, it's unlikely that the
> h/w will do anything in reaction to CLKSTOPPED .

This doesn't make sense.  Ask this question: "what is the point in the
hardware providing a signal which ultimately does nothing". :)

> There is some risk of
> breaking a platform with this approach, but there's also the risk we
> never see power improvements because no one ever goes and adds these
> to the dts file.
> 
> Also, standby probably doesn't really gain anything over dynamic clk
> gating, so standby may not be worth adding.

I'm not so sure.  Standby mode is not well described in the TRM - it
doesn't describe what the exit strategy is from this mode.  If the exit
strategy is the STOPCLK input going low, then setting this bit could be
problematical if it has been integrated with STOPCLK high.  The danger
here is that setting this bit may cause the L2 slave interfaces to
become unavailable to the CPUs, thereby hanging the system.  The TRM
just hints that one possible configuration is to connect STOPCLK to a
CPU output indicating that it is in WFI mode, but this is not mandated.

Also, we don't know if enabling these features adds additional latency.
In both these cases, when the lower-power mode is entered, the AXI
ready signal is deasserted to the CPUs, which presumably have to wait
until that signal is reasserted before an AXI transaction can be
completed.

We probably want to check whether there is any measurable performance
penalty to enabling dynamic clock gating.  Standby mode should be less
of a risk in that regard because it requires something to assert the
STOPCLK input, which /may/ (or may not) be an indication from the CPU
that it is in WFI mode.

So... we don't know quite a lot of details here.  While I can buy just
setting these two bits and seeing whether anyone complains, that seems
to be a brutal way to do this.  Nevertheless, that approach does have
the advantage that people have to report back if it breaks and they
care about it. :)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
