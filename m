From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 21 Jan 2013 18:16:24 +0800
Subject: [PATCH v2 8/9] ARM: PRIMA2: add new SiRFmarco SMP SoC
 infrastructures
In-Reply-To: <20130121094855.GE15707@e106331-lin.cambridge.arm.com>
References: <1358315784-25104-1-git-send-email-Barry.Song@csr.com>
 <1358315784-25104-4-git-send-email-Barry.Song@csr.com>
 <20130116153739.GE10218@e106331-lin.cambridge.arm.com>
 <CAGsJ_4ysfqBvdrBEbKHzSp5TZEk1MArpUGuZ0ukLFsO490pfjg@mail.gmail.com>
 <20130121094855.GE15707@e106331-lin.cambridge.arm.com>
Message-ID: <CAGsJ_4wt6VNbCHSLJyEsUHqDxM7S=teXi_OGz9gmva_bhrFQ3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

2013/1/21 Mark Rutland <mark.rutland@arm.com>:
>> >> +
>> >> +static void __init sirfsoc_smp_init_cpus(void)
>> >> +{
>> >> +       int i, ncores;
>> >> +
>> >> +       ncores = scu_get_core_count(scu_base);
>> >> +
>> >> +       for (i = 0; i < ncores; i++)
>> >> +               set_cpu_possible(i, true);
>> >> +
>> >> +       set_smp_cross_call(gic_raise_softirq);
>> >> +}
>> >
>> > You don't need to use scu_get_core_count to figure out which cpus to set
>> > possible. It duplicates work already done by arm_dt_init_cpu_maps, and doesn't
>> > initialise the logical map (as arm_dt_init_cpu_maps does).
>> >
>> > You're already relying on the arm_dt_init_cpu_maps to set up the logical map
>> > for the holding pen release, so you may as well rely on it to set_cpu_possible
>> > for each of the cpus described in the dt.
>> >
>> > Tegra is already on its way to doing this:
>> >
>> > http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/138319.html
>> > http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/140219.html
>> > http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/141596.html
>> >
>> what if there are 4 nodes in dts but there are actually only one core
>> in soc? for example, using qemu to run vexpress without --smp=4?
>> SiRFmarco will have 2 versions, one is UP, the other one is dual core.
>> if using dt, i might need to take cpus node out of marco.dtsi
>
> If the dt doesn't match the hardware, then the dt is wrong. It's probably worth
> having a separate dtsi for the UP and SMP versions (with all the core stuff in
> another shared dsti).

ok.
i think we might have another two dtsi marco-up.dtsi and marco-dp.dtsi
with only cpus node in it as other devices will be same.


>> >> +static int __cpuinit sirfsoc_local_timer_setup(struct clock_event_device *ce)
>> >> +{
>> >> +       /* Use existing clock_event for cpu 0 */
>> >> +       if (!smp_processor_id())
>> >> +               return 0;
>> >
>> > This seems a little scary. Does the timer only exist for 1 core, or is it not
>> > actually a local timer?
>>
>> there are multiple timers, everyone can be avaliable to all cores.
>> here we actually use timer0 as cpu0's tick, timer1 as cpu1's tick.
>> each one uses a seperate timers.
>
> Ok.
>
> From a glance over the code, it looks like the timer0 and timer1 are pretty
> much identical. Is there no way to have the logic unified, figuring out whether
> to use SIRFSOC_TIMER_*_{0,1} automatically?

there always be some ways.  one is we take some private data in
clock_event_device and compare the data in related callbacks, but
unfortunately, there isn't the field for the moment.
taking .name to strcmp() is too slow.

then we might take smp_processor_id to select TIMER0/1 automatically
if timer0 is always set by CPU0 and timer1 is always set by CPU1.

>
>>
>> >
>> >> +
>> >> +       ce->irq = sirfsoc_timer1_irq.irq;
>> >> +       ce->name = "local_timer";
>> >> +       ce->features = sirfsoc_clockevent.features;
>> >> +       ce->rating = sirfsoc_clockevent.rating;
>> >> +       ce->cpumask = cpumask_of(1);
>> >
>> > The local_timer api sets the cpumask, and you've already rejected setups from
>> > cpu0, so this isn't technically necessary.
>>
>> right.
>> >
>> >> +       ce->set_mode = sirfsoc_timer1_set_mode;
>> >> +       ce->set_next_event = sirfsoc_timer1_set_next_event;
>> >> +       ce->shift = sirfsoc_clockevent.shift;
>> >> +       ce->mult = sirfsoc_clockevent.mult;
>> >> +       ce->max_delta_ns = sirfsoc_clockevent.max_delta_ns;
>> >> +       ce->min_delta_ns = sirfsoc_clockevent.min_delta_ns;
>> >> +
>> >> +       sirfsoc_timer1_irq.dev_id = ce;
>> >> +       BUG_ON(setup_irq(ce->irq, &sirfsoc_timer1_irq));
>> >> +       irq_set_affinity(sirfsoc_timer1_irq.irq, cpumask_of(1));
>> >> +
>> >> +       clockevents_register_device(ce);
>> >> +       return 0;
>> >> +}
>> >> +
>> >> +static void sirfsoc_local_timer_stop(struct clock_event_device *ce)
>> >> +{
>> >> +       sirfsoc_timer_count_disable(1);
>> >> +
>> >> +       remove_irq(sirfsoc_timer1_irq.irq, &sirfsoc_timer1_irq);
>> >> +}
>> >
>> > Presumably you need to balance what you've done in sirfsoc_local_timer_setup,
>> > and return early for cpu0.
>
> If you don't unify the code for the two timers, I really think you should have
> an early return here for cpu0.

adding that will make the codes look consitent with setup. but i
suspect whether cpu0 has any chance to stop the local timer of cpu1.
it seems clock_event_device is placed in a percpu_clockevent, every
cpu is getting its own clock_event_device and calling the callbacks.
anyway, i will have more look and give a test.

>
>> >
>> >> +
>> >> +static struct local_timer_ops sirfsoc_local_timer_ops __cpuinitdata = {
>> >> +       .setup  = sirfsoc_local_timer_setup,
>> >> +       .stop   = sirfsoc_local_timer_stop,
>> >> +};
>> >> +#endif /* CONFIG_LOCAL_TIMERS */
>> >> +
>> >> +static void __init sirfsoc_clockevent_init(void)
>> >> +{
>> >> +       clockevents_calc_mult_shift(&sirfsoc_clockevent, CLOCK_TICK_RATE, 60);
>> >> +
>> >> +       sirfsoc_clockevent.max_delta_ns =
>> >> +               clockevent_delta2ns(-2, &sirfsoc_clockevent);
>> >
>> > I assume this is a typo. For one thing, clockevent_delta2ns takes an unsigned
>> > long.
>>
>> grep and get:
>> http://git.kernel.org/?p=linux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&a=search&h=HEAD&st=grep&s=clockevent_delta2ns
>> almost all platforms don't really take it seriously if we think -2 is
>> very big unsigned long and number like 0xfffffffe is almost not
>> unsigned long without UL.
>
> That's a bit opaque, but as you say, everyone's doing it (or something
> equivalent).
>

>
> Thanks,
> Mark.

-barry
