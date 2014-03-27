From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 27 Mar 2014 09:59:25 +0000
Subject: [PATCH 1/4] clocksource: mmp: add mmp timer driver
In-Reply-To: <CADApbehVviFKV354dARBuGT4aF-Lfg=thH-0pxVGv9A=5dvp2Q@mail.gmail.com>
References: <1395809563-31872-1-git-send-email-chao.xie@marvell.com>
 <1395809563-31872-2-git-send-email-chao.xie@marvell.com>
 <20140326104137.GQ10341@e106331-lin.cambridge.arm.com>
 <CADApbehVviFKV354dARBuGT4aF-Lfg=thH-0pxVGv9A=5dvp2Q@mail.gmail.com>
Message-ID: <20140327095925.GA13071@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 27, 2014 at 01:27:33AM +0000, Chao Xie wrote:
> On Wed, Mar 26, 2014 at 6:41 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Wed, Mar 26, 2014 at 04:52:40AM +0000, Chao Xie wrote:
> >> From: Chao Xie <chao.xie@marvell.com>
> >>
> >> MMP timer is attached to APB bus, It has the following
> >> limitation.
> >> 1. When get count of timer counter, it need some delay
> >>    to get a stable count.
> >> 2. When set match register, it need disable the counter
> >>    first, and enable it after set the match register.
> >>    The disabling need wait for 2 clock cycle to take
> >>    effect.
> >>
> >> To improve above #1, shadow register for count is added.
> >> To improve above #2, CRSR register is added for quick updating.
> >>
> >> So there are three types of timer.
> >> timer1: old timer.
> >> timer2: old timer with shadow register.
> >> timer3: old timer with shadow and CRSR register.
> >>
> >> This timer driver will be used for many SOCes.
> >> 1. pxa168, pxa910, pxa988 pxa1088 have only timer1.
> >> 2. pxa1L88, pxa1U88 have timer1 and timer3.
> >> 3. pxa1928 has timer 2.
> >>
> >> The driver supports DT and non-DT initialization.
> >> The driver supports UP/SMP SOCes and 64 bit core.
> >>
> >> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> >> ---
> >>  .../devicetree/bindings/arm/mrvl/timer.txt         |  73 +-
> >>  drivers/clocksource/Makefile                       |   1 +
> >>  drivers/clocksource/timer-mmp.c                    | 866 +++++++++++++++++++++
> >>  3 files changed, 934 insertions(+), 6 deletions(-)
> >>  create mode 100644 drivers/clocksource/timer-mmp.c
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/mrvl/timer.txt b/Documentation/devicetree/bindings/arm/mrvl/timer.txt
> >> index 9a6e251..b9af4bf 100644
> >> --- a/Documentation/devicetree/bindings/arm/mrvl/timer.txt
> >> +++ b/Documentation/devicetree/bindings/arm/mrvl/timer.txt
> >> @@ -1,13 +1,74 @@
> >>  * Marvell MMP Timer controller
> >>
> >> +Each timer have multiple counters, so the timer DT need include counter's
> >> +description.
> >> +
> >> +1. Timer
> >> +
> >>  Required properties:
> >> -- compatible : Should be "mrvl,mmp-timer".
> >> +- compatible : Should be "marvell,mmp-timer".
> >>  - reg : Address and length of the register set of timer controller.
> >> -- interrupts : Should be the interrupt number.
> >> +- marvell,timer-id : The index of the timer. The timer controller may
> >> +  include several timers.
> >
> > Is this a single entry or a list?
> 
> Generally, the may be 2/3/4 timers, and each timers will have at most
> 3 coounters.
> Each counters will have 3 matches. Each counter may have its own
> interrupts, or share same
> interrupts(counter1 has one interrupts, counter2 and 3 share one). It depends on
> how SOC connets the signals.
> 
> The DT will be
> timer 0 {
>      ...
>      ...
>      counter0 {
>      };
>      counter2 {
>      };
> }

I'm somewhat confused here.

The top level node appears to be a timer controller (per the reg
property description), but the marvell,timer-id property describes an
index within the timer controller. This does not seem to make sense.

How do you describe multiple timers within a given timer contoller? Is
the timer-id a list? Or do you describe the controller repeatedly?

> 
> >
> >> +- marvell,timer-fastclk-frequency : The fast clock frequency of the timer.
> >> +  Timer will have several clock inputs: fast clock, 32KHZ, 1KHZ. For all
> >> +  SOCes use this timer controller, fast clock may not be same.
> >> +- marvell,timer-apb-frequency : The fequency of the apb bus that the timer
> >> +  attached to. This frequency and "marvell,timer-fastclk-frequency" are used
> >> +  to calculated delay loops for clock operations.
> >
> > Wouldn't these be better described as clock inputs?
> 
> "apb" frequency is only used to calculated the delay loop.
> I do not want to fix the delay loop in the driver.
> So pass it in DT directly will make the things easier to handle.
> 
> "fastclk" is a clock input. So waht do you mean "described as clock inputs"?

Using the clock bindings:

	clocks = <&apb_plck>, <&clock_controller 0 3>;
	clock-names = "apb_pclk", "fastclk";

The driver can then query the frequencies, enable/disable the clocks as
required, etc.

> 
> >
> >> +
> >> +Optional properties:
> >> +- marvell,timer-has-crsr : This timer has CRSR register.
> >> +- marvell,timer-has-shadow : This timer has shadow register.
> >> +
> >> +2. Counter
> >> +
> >> +Required properties:
> >> +- compatible : It can be
> >> +      "marvell,timer-counter-clkevt" : The counter is used for clock event
> >> +                                       device.
> >> +      "marvell,timer-counter-clksrc" : The counter is used for clock source.
> >> +      "marvell,timer-counter-delay" : The counter is used for delay timer.
> >
> > These are _not_ hardware properties. Why can the driver not choose how
> > to use each of the counter sub-blocks?
> >
> > How would blocks with each of these strings actually differ?
> >
> 
> SOCes may have 2 or 3 or 4 timers, some timers may be used by CP not AP but
> AP can still access it.
> There may be UP SOC, or SMP SOC. So there are may be some general usage
> 1. UP SOC: need one clocksource, need one clock event device
> 2. SMP SOC: need one clocksource, need one broadcast clock event device because
>    arch timer will be shutdown when core is down
> 3. SMP SOC: it has bug with arch timer. So need one clock source,
> NR_CPUs clock event
>     device to replace the arch timer. There are may be 2 cores or 4 cores.

Ok, but in all of these cases the blocks that you are giving different
compatible strings are identical. The only difference is how you expect
Linux to use them.

Why can you not just describe the set of timers available to Linux and
allow it to allocate them as required?

> Above requeimetns are also hardware requriments from SOCes.
> 
> The driver will be used for many SOCes, we can not to fix the counter
> usage in driver.

I'm arguing for dynamically deciding how to use the timers, not assuming
one of the three cases you've laid out above, and not describing a
possible software use of the counters in the DT.

> >> +- marvell,timer-counter-id : The counter index in this timer.
> >
> > Perhaps use a reg for this?
> >
> 
> The counter does not have its own register space. They are belongs to a timer.
> Counter does not need to map the regsiter spance, it is done by timer.
> For example, for counter enable, all coutners share same register. CER
> For interrupt enable, each counter has its own register. IERx
> 
> So if we use like "reg = <IERx offset>", i do not see any benefit. while
> direct setting "marvell,timer-counter-id" seems make the DT more clear.

The reg doesn't have to be a register space -- it's often used simply as
a form of address/identifier without a size (consider SPI's use of the
reg property). Here the index is essentially an address/identifier for
the counter.

Given that the each timer also seems to have a unique ID perhaps using
the reg is not the best strategy here. I was simply raising the
possiblity.

> 
> >>
> >> -Example:
> >> -       timer0: timer at d4014000 {
> >> -               compatible = "mrvl,mmp-timer";
> >> -               reg = <0xd4014000 0x100>;
> >> +Optional properties:
> >> +- interrupts : The counters may have different IRQs or share same IRQs.
> >> +  Only valid for "marvell,timer-counter-clkevt".
> >
> > Describe what the interrupt is logically.
> >
> > What is the interrupt logically?
> >
> 
> The interrupt topolog is designed by SOCes.
> Each counter has one interrupt, but SOCes may connects some coutners' interrupt
> into one.
> In timer driver, we do not care about it. We depeneds on IRQ chip to handle it.

How the interrupt is wired and whether it is shared is not important
from the view of the binding. What is important is which interrupt from
the timer is being described. If it has a given name, that should be
mentioned. Otherwise a simple description will suffice.

The presence of external interrupt muxing doesn't seem to be important
here to the binding -- in that case an OS could request shared
interrupts or decide to only make use of a subset of interrupts. That
seems to be outside of the scope of the binding.

> 
> >> +- marvell,timer-counter-cpu : which CPU the counter is bound. Only valid for
> >> +  "marvell,timer-counter-clkevt".
> >
> > How is the counter bound to a particular CPU? Is there really a
> > relationship in hardware between a given CPU and counter?
> >
> 
> For some SMP SOCes, for example, marvell's pxa988/pxa1088/pxa1L88
> They have bug in arch timer. So we make each CPU to have one dedicated
> counter to replace the arch timer.

Is there any real topological relationship between CPUs and counters, or
is this arbitrary? If the latter, why can the kernel not decide how to
allocate timers to CPUs?

> 
> >> +- "marvell,timer-counter-rating" : The rating when register clock event device
> >> +  or clock source. Only valid for "marvell,timer-counter-clkevt" and
> >> +  "marvell,timer-counter-clksrc".
> >
> > What does this mean? This seems like another leak of Linux internals.
> 
> It is the rating when register clock source and clock event.
> I think i can fix it in the driver.

Ok. This is a Linux interenal detail that I do not think should be in
the DT.

> 
> >
> >> +- marvell,timer-counter-broadcast : When this counter acts as clock event
> >> +  device. It is broadcast clock event device.
> >> +  Only valid for "marvell,timer-counter-clkevt".
> >
> > This does not seem like a hardware property. Why can Linux not decide
> > which counter (if any) to use as the broadcast source?
> >
> 
> For some SMP soces, for example, marvell's pxa988/pxa1088/pxa1L88
> They have bug in arch timer. So we make each CPU to have one dedicated
> counter to replace the arch timer. So for these SOCes, broadcast timer is not
> needed. For these counters, we have to set IRQ affinity to the specific core.

That's fine, we can do that in the absence of both this property and
another timer (the arch timer).

> For some SMP soces, for example, they can use arch timer, but we have
> to register
> a clock event device for broadcast because we lose arch timer if core is down.
> For this coutner, we have to set IRQ affinity to ALL cores.

In that case the arch timer will register (which can have a higher
rating than this timer), and this timers can be automatically repurposed
as the broadcast source.

I do not see the necessity of this property.

> >> +- marvell,timer-counter-nodynirq : When this counter acts as broadcast clock
> >> +  event device, it cannot switch the IRQ of broadcast clock event to any CPU.
> >> +  Only valid for "marvell,timer-counter-clkevt".
> >
> > Likewise this does not sound like a hardware property.
> 
> For a broadcast timer, there is feature "CLOCK_EVT_FEAT_DYNIRQ".
> This feature is a clock event device's fearture. It means that the
> clock event device's irq can
> be set to any core.
> In fact it does not for all SOCes that the interrupt of the counter
> can be set to any core.

The naming and use of this property still seems incredibly
Linux-specific.

Why can some of the counter interrupts not be routed to an arbitrary
CPU?

Cheers,
Mark.
