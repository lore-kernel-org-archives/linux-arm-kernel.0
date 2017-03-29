From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 29 Mar 2017 15:34:12 +0100
Subject: [PATCH v7 1/7] clocksource/drivers/clksrc-evt-probe: Describe
 with the DT both the clocksource and the clockevent
In-Reply-To: <20170329134134.GJ2123@mai>
References: <1490197714-25415-1-git-send-email-al.kochet@gmail.com>
 <1490197714-25415-2-git-send-email-al.kochet@gmail.com>
 <20170329015146.ey5rlptzsnnynpnt@rob-hp-laptop>
 <20170329092210.GH2123@mai> <20170329104911.GC23442@leverpostej>
 <20170329123638.GI2123@mai> <20170329125713.GH23442@leverpostej>
 <20170329134134.GJ2123@mai>
Message-ID: <20170329143411.GL23442@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 03:41:34PM +0200, Daniel Lezcano wrote:
> On Wed, Mar 29, 2017 at 01:57:14PM +0100, Mark Rutland wrote:
> > On Wed, Mar 29, 2017 at 02:36:38PM +0200, Daniel Lezcano wrote:

> > > arch/arc/boot/dts/abilis_tb10x.dtsi:
> > > 
> > >         /* TIMER0 with interrupt for clockevent */
> > >         timer0 {
> > >                 compatible = "snps,arc-timer";
> > >                 interrupts = <3>;
> > >                 interrupt-parent = <&intc>;
> > >                 clocks = <&cpu_clk>;
> > >         };
> > > 
> > >         /* TIMER1 for free running clocksource */
> > >         timer1 {
> > >                 compatible = "snps,arc-timer";
> > >                 clocks = <&cpu_clk>;
> > >         };
> > > 
> > > drivers/clocksource/arc_timer.c:
> > > 
> > > static int __init arc_of_timer_init(struct device_node *np)
> > > {
> > >         static int init_count = 0;
> > >         int ret;
> > > 
> > >         if (!init_count) {
> > >                 init_count = 1;
> > >                 ret = arc_clockevent_setup(np);
> > >         } else {
> > >                 ret = arc_cs_setup_timer1(np);
> > >         }
> > > 
> > >         return ret;
> > > }
> > > 
> > > So the purpose of these changes is to provide a stronger timer declaration in
> > > order to clearly split in the kernel a clocksource and a clockevent
> > > initialization.
> > 
> > I agree that this pattern is not nice. However, I think that splitting
> > devices as this level makes the problem *worse*.
> > 
> > Users care that they have a clocksource and a clockevent device. They
> > do not care *which* particular device is used as either. The comments in
> > the DT above are at best misleading.
> 
> Agree.
> 
> And the driver is assuming the first node is the clockevent and the second one
> is the clocksource. If the DT invert these nodes, that breaks the driver.

Sure, but that is something we can and should fix within Linux.

> > What we need is for the kernel to understand that devices can be both
> > clockevent and clocksource (perhaps mutually exclusively), such that the
> > kernel can decide how to make use of devices.
> > 
> > That way, for the above the kernel can figure out that timer0 could be
> > used as clocksource or clockevent, while timer1 can only be used as a
> > clocksource due to the lack of an interrupt. Thus, it can choose to use
> > timer0 as a clockevent, and timer1 and a clocksource.
> 
> Well, 'interrupt' gives an indication the timer can be used as a clockevent and
> clocksource, not the clockevent only.

Which is exactly what I said above, when I said:

	the kernel can figure out that timer0 could be used as
	clocksource or clockevent

Considering both timer0 and timer1 is how we can figure out timer0 must
be the clockevent, since timer1 cannot be.

> If we take the case of the rockchip, the arm_arch_timer clocksource is stopped
> when the CPU is clock gated. So specifically, we don't want to use this
> clocksource but we want to use the arch clockevents because they are better.

Sure. As I pointed out, we want to consider the holistic details to make
the right decision. i.e. the infrastructure should make the choice, not
the individual drivers.

Consider that the kernel may need to make decisions that differ it a
kernel is built wihout certain drivers. That cannot work if the use is
allocated in the DT.

[...]

> > > 2. A node can have a clockevent and|or a clocksource attributes
> > 
> > As above, this should not be in the DT given it's describing a
> > (Linux-specific) SW policy and not a HW detail.
> > 
> > So I must disagree with this.
> 
> IIUC my discussion with Rob, an attribute is acceptable (btw if
> 'clocksource'|'clockevent' names are too Linux specific (+1), what
> about a more generic name like 'tick' and 'time' ?).

The *meaning* of these is Linux specific. The naming is irrelevant.

> > > 3. The timer_probe pass a flag to the driver's init function, so this one knows
> > >    if it should invoke the clockevent/clocksource init functions.
> > >    No attribute defaults to clocksource|clockevent.
> > > 
> > > That would be backward compatible and will let to create drivers with clutch
> > > activated device via DT. Also, it will give the opportunity to the existing
> > > drivers to change consolidate their initialization routines.
> > 
> > I think that if anything, we need a combined clocksource+clockevent
> > device that we register to the core code. That means all
> > clocksource/clockevent drivers have a consolidated routine.
> > 
> > Subsequently, core code should determine how specifically to use the
> > device (e.g. based on what other devices are registered, and their
> > capabilities).
> 
> IMO, the core code is complex enough and that may imply more heuristics.

Given that the majority of cases are going to be multiple instances of
the same IP, I cannot imagine it is complex to get something that works.

A generally optimal configuration may require some heuristics, but
that's a different matter to a correct and functional configuration.

I must disagree with trying to push that complexity into the DT by means
of static SW policy, rather than solving the problem in SW where we have
all the information to do so.

Thanks,
Mark.
