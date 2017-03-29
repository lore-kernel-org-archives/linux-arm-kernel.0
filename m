From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 29 Mar 2017 13:57:14 +0100
Subject: [PATCH v7 1/7] clocksource/drivers/clksrc-evt-probe: Describe
 with the DT both the clocksource and the clockevent
In-Reply-To: <20170329123638.GI2123@mai>
References: <1490197714-25415-1-git-send-email-al.kochet@gmail.com>
 <1490197714-25415-2-git-send-email-al.kochet@gmail.com>
 <20170329015146.ey5rlptzsnnynpnt@rob-hp-laptop>
 <20170329092210.GH2123@mai> <20170329104911.GC23442@leverpostej>
 <20170329123638.GI2123@mai>
Message-ID: <20170329125713.GH23442@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 02:36:38PM +0200, Daniel Lezcano wrote:
> On Wed, Mar 29, 2017 at 11:49:11AM +0100, Mark Rutland wrote:
> > On Wed, Mar 29, 2017 at 11:22:10AM +0200, Daniel Lezcano wrote:
> > > On Tue, Mar 28, 2017 at 08:51:46PM -0500, Rob Herring wrote:
> > > > On Wed, Mar 22, 2017 at 06:48:28PM +0300, Alexander Kochetkov wrote:
> 
> You can have several timers on the system and may want to use the clockevents
> from one IP block and the clocksource from another IP block. For example, in
> the case of a bogus clocksource.

I understand this. However, what I was trying to say is that *how* we
use a particular device should be a software decision. I have a more
concrete suggestion on that below.

> Moreover there are some drivers with a node for a clocksource and
> another one for the clockevent, and the driver is assuming the clockevent is
> defined first and then the clocksource.
> 
> eg.
> 
> arch/arc/boot/dts/abilis_tb10x.dtsi:
> 
>         /* TIMER0 with interrupt for clockevent */
>         timer0 {
>                 compatible = "snps,arc-timer";
>                 interrupts = <3>;
>                 interrupt-parent = <&intc>;
>                 clocks = <&cpu_clk>;
>         };
> 
>         /* TIMER1 for free running clocksource */
>         timer1 {
>                 compatible = "snps,arc-timer";
>                 clocks = <&cpu_clk>;
>         };
> 
> drivers/clocksource/arc_timer.c:
> 
> static int __init arc_of_timer_init(struct device_node *np)
> {
>         static int init_count = 0;
>         int ret;
> 
>         if (!init_count) {
>                 init_count = 1;
>                 ret = arc_clockevent_setup(np);
>         } else {
>                 ret = arc_cs_setup_timer1(np);
>         }
> 
>         return ret;
> }
> 
> Even if that works, it is a fragile mechanism.
> 
> So the purpose of these changes is to provide a stronger timer declaration in
> order to clearly split in the kernel a clocksource and a clockevent
> initialization.

I agree that this pattern is not nice. However, I think that splitting
devices as this level makes the problem *worse*.

Users care that they have a clocksource and a clockevent device. They
do not care *which* particular device is used as either. The comments in
the DT above are at best misleading.

What we need is for the kernel to understand that devices can be both
clockevent and clocksource (perhaps mutually exclusively), such that the
kernel can decide how to make use of devices.

That way, for the above the kernel can figure out that timer0 could be
used as clocksource or clockevent, while timer1 can only be used as a
clocksource due to the lack of an interrupt. Thus, it can choose to use
timer0 as a clockevent, and timer1 and a clocksource.

> > > > > With this approach, we allow a mechanism to clearly define a clocksource or a
> > > > > clockevent without aerobatics we can find around in some drivers:
> > > > > 	timer-sp804.c, arc-timer.c, dw_apb_timer_of.c, mps2-timer.c,
> > > > > 	renesas-ostm.c, time-efm32.c, time-lpc32xx.c.
> > > > 
> > > > These all already have bindings and work. What problem are you trying to 
> > > > solve other than restructuring Linux?
> > > 
> > > Yes, there is already the bindings, but that force to do some hackish
> > > initialization.
> > 
> > Here, you are forcing hackish DT changes that do not truly describe HW.
> > How is that better?
> 
> So if this is hackish DT changes, then the existing DTs should be fixed, no?

Yes.

For the above snippet, the only thing that needs to change is the
comment.

> > > I would like to give the opportunity to declare separately a clocksource and a
> > > clockevent, in order to have full control of how this is initialized.
> > 
> > To me it sounds like what we need is Linux infrastructure that allows
> > one to register a device as having both clockevent/clocksource
> > functionality.
> 
> That was the idea. Create a macro CLOCKEVENT_OF and CLOCKSOURCE_OF both of them
> calling their respective init routines. And in addition a TIMER_OF doing both
> CLOCKEVENT_OF and CLOCKSOURCE_OF.
> 
> It is the DT which does not allow to do this separation.
> 
> Would be the following approach more acceptable ?
> 
> 1. Replace all CLOCKSOURCE_OF by TIMER_OF (just renaming)

I am fine with this renaming.

> 2. A node can have a clockevent and|or a clocksource attributes

As above, this should not be in the DT given it's describing a
(Linux-specific) SW policy and not a HW detail.

So I must disagree with this.

> 3. The timer_probe pass a flag to the driver's init function, so this one knows
>    if it should invoke the clockevent/clocksource init functions.
>    No attribute defaults to clocksource|clockevent.
> 
> That would be backward compatible and will let to create drivers with clutch
> activated device via DT. Also, it will give the opportunity to the existing
> drivers to change consolidate their initialization routines.

I think that if anything, we need a combined clocksource+clockevent
device that we register to the core code. That means all
clocksource/clockevent drivers have a consolidated routine.

Subsequently, core code should determine how specifically to use the
device (e.g. based on what other devices are registered, and their
capabilities).

Thanks,
Mark.
