From: xiechao.mail@gmail.com (Chao Xie)
Date: Thu, 27 Mar 2014 20:13:50 +0800
Subject: [PATCH 1/4] clocksource: mmp: add mmp timer driver
In-Reply-To: <20140327095925.GA13071@e106331-lin.cambridge.arm.com>
References: <1395809563-31872-1-git-send-email-chao.xie@marvell.com>
 <1395809563-31872-2-git-send-email-chao.xie@marvell.com>
 <20140326104137.GQ10341@e106331-lin.cambridge.arm.com>
 <CADApbehVviFKV354dARBuGT4aF-Lfg=thH-0pxVGv9A=5dvp2Q@mail.gmail.com>
 <20140327095925.GA13071@e106331-lin.cambridge.arm.com>
Message-ID: <CADApbeidd5Kg9dhewfoCYy0PxGhR7C2C=2icmofEaaZz2ZLbNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> >>
>> >> +Each timer have multiple counters, so the timer DT need include counter's
>> >> +description.
>> >> +
>> >> +1. Timer
>> >> +
>> >>  Required properties:
>> >> -- compatible : Should be "mrvl,mmp-timer".
>> >> +- compatible : Should be "marvell,mmp-timer".
>> >>  - reg : Address and length of the register set of timer controller.
>> >> -- interrupts : Should be the interrupt number.
>> >> +- marvell,timer-id : The index of the timer. The timer controller may
>> >> +  include several timers.
>> >
>> > Is this a single entry or a list?
>>
>> Generally, the may be 2/3/4 timers, and each timers will have at most
>> 3 coounters.
>> Each counters will have 3 matches. Each counter may have its own
>> interrupts, or share same
>> interrupts(counter1 has one interrupts, counter2 and 3 share one). It depends on
>> how SOC connets the signals.
>>
>> The DT will be
>> timer 0 {
>>      ...
>>      ...
>>      counter0 {
>>      };
>>      counter2 {
>>      };
>> }
>
> I'm somewhat confused here.
>
> The top level node appears to be a timer controller (per the reg
> property description), but the marvell,timer-id property describes an
> index within the timer controller. This does not seem to make sense.
>
> How do you describe multiple timers within a given timer contoller? Is
> the timer-id a list? Or do you describe the controller repeatedly?
>
Thanks for your reply.

the driver only take care of one timer node, if we have 3 timer node defined.
It means that the driver will be probed 3 times.

Each timer is a controller, and one timer has 3 counters. each counter can be
set to be free running or period mode.

marvell,timer-id may not be needed, but the marvell,counter-id need to
be passed.
The timer driver depends on the id to distinguish the register or bit
in the register.

>>
>> >
>> >> +- marvell,timer-fastclk-frequency : The fast clock frequency of the timer.
>> >> +  Timer will have several clock inputs: fast clock, 32KHZ, 1KHZ. For all
>> >> +  SOCes use this timer controller, fast clock may not be same.
>> >> +- marvell,timer-apb-frequency : The fequency of the apb bus that the timer
>> >> +  attached to. This frequency and "marvell,timer-fastclk-frequency" are used
>> >> +  to calculated delay loops for clock operations.
>> >
>> > Wouldn't these be better described as clock inputs?
>>
>> "apb" frequency is only used to calculated the delay loop.
>> I do not want to fix the delay loop in the driver.
>> So pass it in DT directly will make the things easier to handle.
>>
>> "fastclk" is a clock input. So waht do you mean "described as clock inputs"?
>
> Using the clock bindings:
>
>         clocks = <&apb_plck>, <&clock_controller 0 3>;
>         clock-names = "apb_pclk", "fastclk";
>
> The driver can then query the frequencies, enable/disable the clocks as
> required, etc.
>
It is the final choice, but it depends on the clock DT support.
I just begin the clock DT support for mach-mmp. They are still in design phase.
Clock framework is more complicated than the timer controller.

>>
>> >
>> >> +
>> >> +Optional properties:
>> >> +- marvell,timer-has-crsr : This timer has CRSR register.
>> >> +- marvell,timer-has-shadow : This timer has shadow register.
>> >> +
>> >> +2. Counter
>> >> +
>> >> +Required properties:
>> >> +- compatible : It can be
>> >> +      "marvell,timer-counter-clkevt" : The counter is used for clock event
>> >> +                                       device.
>> >> +      "marvell,timer-counter-clksrc" : The counter is used for clock source.
>> >> +      "marvell,timer-counter-delay" : The counter is used for delay timer.
>> >
>> > These are _not_ hardware properties. Why can the driver not choose how
>> > to use each of the counter sub-blocks?
>> >
>> > How would blocks with each of these strings actually differ?
>> >
>>
>> SOCes may have 2 or 3 or 4 timers, some timers may be used by CP not AP but
>> AP can still access it.
>> There may be UP SOC, or SMP SOC. So there are may be some general usage
>> 1. UP SOC: need one clocksource, need one clock event device
>> 2. SMP SOC: need one clocksource, need one broadcast clock event device because
>>    arch timer will be shutdown when core is down
>> 3. SMP SOC: it has bug with arch timer. So need one clock source,
>> NR_CPUs clock event
>>     device to replace the arch timer. There are may be 2 cores or 4 cores.
>
> Ok, but in all of these cases the blocks that you are giving different
> compatible strings are identical. The only difference is how you expect
> Linux to use them.
>
> Why can you not just describe the set of timers available to Linux and
> allow it to allocate them as required?
>


So how can I make Linux to allocate them as required?


>> Above requeimetns are also hardware requriments from SOCes.
>>
>> The driver will be used for many SOCes, we can not to fix the counter
>> usage in driver.
>
> I'm arguing for dynamically deciding how to use the timers, not assuming
> one of the three cases you've laid out above, and not describing a
> possible software use of the counters in the DT.
>

I am a little confused.

So what is your suggestions?
we have the below usage
1. UP SOC, we need clock source, clock event device
2. SMP SOC with arch timer, we need clock source, broadcast clock event device
3. SMP SOC without arch timer, we need clock source, NR_CPU clock
event device and delay timer.


>> >> +- marvell,timer-counter-id : The counter index in this timer.
>> >
>> > Perhaps use a reg for this?
>> >
>>
>> The counter does not have its own register space. They are belongs to a timer.
>> Counter does not need to map the regsiter spance, it is done by timer.
>> For example, for counter enable, all coutners share same register. CER
>> For interrupt enable, each counter has its own register. IERx
>>
>> So if we use like "reg = <IERx offset>", i do not see any benefit. while
>> direct setting "marvell,timer-counter-id" seems make the DT more clear.
>
> The reg doesn't have to be a register space -- it's often used simply as
> a form of address/identifier without a size (consider SPI's use of the
> reg property). Here the index is essentially an address/identifier for
> the counter.
>
> Given that the each timer also seems to have a unique ID perhaps using
> the reg is not the best strategy here. I was simply raising the
> possiblity.
>
>>
>> >>
>> >> -Example:
>> >> -       timer0: timer at d4014000 {
>> >> -               compatible = "mrvl,mmp-timer";
>> >> -               reg = <0xd4014000 0x100>;
>> >> +Optional properties:
>> >> +- interrupts : The counters may have different IRQs or share same IRQs.
>> >> +  Only valid for "marvell,timer-counter-clkevt".
>> >
>> > Describe what the interrupt is logically.
>> >
>> > What is the interrupt logically?
>> >
>>
>> The interrupt topolog is designed by SOCes.
>> Each counter has one interrupt, but SOCes may connects some coutners' interrupt
>> into one.
>> In timer driver, we do not care about it. We depeneds on IRQ chip to handle it.
>
> How the interrupt is wired and whether it is shared is not important
> from the view of the binding. What is important is which interrupt from
> the timer is being described. If it has a given name, that should be
> mentioned. Otherwise a simple description will suffice.
>
> The presence of external interrupt muxing doesn't seem to be important
> here to the binding -- in that case an OS could request shared
> interrupts or decide to only make use of a subset of interrupts. That
> seems to be outside of the scope of the binding.
>

I see. I think a simple description is enough. i do not need mention the shared
interrupts here because the timer driver does not care about it.

>>
>> >> +- marvell,timer-counter-cpu : which CPU the counter is bound. Only valid for
>> >> +  "marvell,timer-counter-clkevt".
>> >
>> > How is the counter bound to a particular CPU? Is there really a
>> > relationship in hardware between a given CPU and counter?
>> >
>>
>> For some SMP SOCes, for example, marvell's pxa988/pxa1088/pxa1L88
>> They have bug in arch timer. So we make each CPU to have one dedicated
>> counter to replace the arch timer.
>
> Is there any real topological relationship between CPUs and counters, or
> is this arbitrary? If the latter, why can the kernel not decide how to
> allocate timers to CPUs?
>

All the timers can be seen by every CPUes.
For arch timer, each CPU see its own instance, while for the mmp
timers, each CPU
can see all of them.
So there are some problems
1. The number of the timer is not fixed. It can be 2, 3, 4
2. Some timers can be seen by CP, and CP will use these timers. Which
timer can be seen
    by CP is defined by SOC design
3. Some counter share one interrupt, these counters can not be
allocated for per cpu timer to replace
    arch timer.
So which counter allocated is limited by SOC design.

So if do not have above limitation, can you tell me that how can i let
kernel to decide allocation?
Thanks.

>>
>> >> +- "marvell,timer-counter-rating" : The rating when register clock event device
>> >> +  or clock source. Only valid for "marvell,timer-counter-clkevt" and
>> >> +  "marvell,timer-counter-clksrc".
>> >
>> > What does this mean? This seems like another leak of Linux internals.
>>
>> It is the rating when register clock source and clock event.
>> I think i can fix it in the driver.
>
> Ok. This is a Linux interenal detail that I do not think should be in
> the DT.
>
>>
>> >
>> >> +- marvell,timer-counter-broadcast : When this counter acts as clock event
>> >> +  device. It is broadcast clock event device.
>> >> +  Only valid for "marvell,timer-counter-clkevt".
>> >
>> > This does not seem like a hardware property. Why can Linux not decide
>> > which counter (if any) to use as the broadcast source?
>> >
>>
>> For some SMP soces, for example, marvell's pxa988/pxa1088/pxa1L88
>> They have bug in arch timer. So we make each CPU to have one dedicated
>> counter to replace the arch timer. So for these SOCes, broadcast timer is not
>> needed. For these counters, we have to set IRQ affinity to the specific core.
>
> That's fine, we can do that in the absence of both this property and
> another timer (the arch timer).
>
>> For some SMP soces, for example, they can use arch timer, but we have
>> to register
>> a clock event device for broadcast because we lose arch timer if core is down.
>> For this coutner, we have to set IRQ affinity to ALL cores.
>
> In that case the arch timer will register (which can have a higher
> rating than this timer), and this timers can be automatically repurposed
> as the broadcast source.
>
> I do not see the necessity of this property.
>
It is true that arch timer is first priority.
There are something need to be considered
1. we registered NR_CPU timers to acts as arch timer. We set the
cpu_mask of be cpu_mask(cpu_id), not
    cpu_mask(ALL_CPUes). We also bind the interrupt to the dedicated
CPU. For example, if timer 0 counter 0
    is used by CPU0 to replace arch timer. the counter's IRQ only
route to the CPU0.
    If we have arch timers, it means that there are NR_CPU timers, i
do not think they can be acts as broadcast timer
2. As i said, some coutners share interrupts. We can not allocated
this kind of counter as per cpu clock event device.
    For exmaple, timer 0 coutner1 and counter 2 share same interrupt.
If they are used by CPU0 and CPU1, it means that
    same interrupt will be bind to two CPUes. each timer interrupt
happens, a power-down core need wake up to check the
    interrupt does not targets at it.

So how to use these counter in fact depends on the SOCes design.
That why i need pass this kind of information to timer driver.

>> >> +- marvell,timer-counter-nodynirq : When this counter acts as broadcast clock
>> >> +  event device, it cannot switch the IRQ of broadcast clock event to any CPU.
>> >> +  Only valid for "marvell,timer-counter-clkevt".
>> >
>> > Likewise this does not sound like a hardware property.
>>
>> For a broadcast timer, there is feature "CLOCK_EVT_FEAT_DYNIRQ".
>> This feature is a clock event device's fearture. It means that the
>> clock event device's irq can
>> be set to any core.
>> In fact it does not for all SOCes that the interrupt of the counter
>> can be set to any core.
>
> The naming and use of this property still seems incredibly
> Linux-specific.
>
> Why can some of the counter interrupts not be routed to an arbitrary
> CPU?
>
The reason is couple idle.
The couple idle implementation implies that CPU0 will be first core wake up.
So, we can not have CLOCK_EVT_FEAT_DYNIRQ because it may make CPU1 to
be first core wake up.

> Cheers,
> Mark.
