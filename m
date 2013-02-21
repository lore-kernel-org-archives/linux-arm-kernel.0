From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 21 Feb 2013 10:36:51 +0100 (CET)
Subject: too many timer retries happen when do local timer swtich with
 broadcast timer
In-Reply-To: <CAB4PhKfxPcyQfpM2Ra1OxsyYhS5fnkjtPy=uYgxFHim1rOdoug@mail.gmail.com>
References: <CAB4PhKevqf0e4nzYraE9ZTAFbPCFfNpguAnPoVpJh-FFe2TAZA@mail.gmail.com>
 <alpine.LFD.2.02.1302201400400.22263@ionos>
 <CAB4PhKfxPcyQfpM2Ra1OxsyYhS5fnkjtPy=uYgxFHim1rOdoug@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1302211015270.22263@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Feb 2013, Jason Liu wrote:
> 2013/2/20 Thomas Gleixner <tglx@linutronix.de>:
> > On Wed, 20 Feb 2013, Jason Liu wrote:
> >> void arch_idle(void)
> >> {
> >> ....
> >> clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu);
> >>
> >> enter_the_wait_mode();
> >>
> >> clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu);
> >> }
> >>
> >> when the broadcast timer interrupt arrives(this interrupt just wakeup
> >> the ARM, and ARM has no chance
> >> to handle it since local irq is disabled. In fact it's disabled in
> >> cpu_idle() of arch/arm/kernel/process.c)
> >>
> >> the broadcast timer interrupt will wake up the CPU and run:
> >>
> >> clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu);    ->
> >> tick_broadcast_oneshot_control(...);
> >> ->
> >> tick_program_event(dev->next_event, 1);
> >> ->
> >> tick_dev_program_event(dev, expires, force);
> >> ->
> >> for (i = 0;;) {
> >>                 int ret = clockevents_program_event(dev, expires, now);
> >>                 if (!ret || !force)
> >>                         return ret;
> >>
> >>                 dev->retries++;
> >>                 ....
> >>                 now = ktime_get();
> >>                 expires = ktime_add_ns(now, dev->min_delta_ns);
> >> }
> >> clockevents_program_event(dev, expires, now);
> >>
> >>         delta = ktime_to_ns(ktime_sub(expires, now));
> >>
> >>         if (delta <= 0)
> >>                 return -ETIME;
> >>
> >> when the bc timer interrupt arrives,  which means the last local timer
> >> expires too. so,
> >> clockevents_program_event will return -ETIME, which will cause the
> >> dev->retries++
> >> when retry to program the expired timer.
> >>
> >> Even under the worst case, after the re-program the expired timer,
> >> then CPU enter idle
> >> quickly before the re-progam timer expired, it will make system
> >> ping-pang forever,
> >
> > That's nonsense.
> 
> I don't think so.
> 
> >
> > The timer IPI brings the core out of the deep idle state.
> >
> > So after returning from enter_wait_mode() and after calling
> > clockevents_notify() it returns from arch_idle() to cpu_idle().
> >
> > In cpu_idle() interrupts are reenabled, so the timer IPI handler is
> > invoked. That calls the event_handler of the per cpu local clockevent
> > device (the one which stops in C3). That ends up in the generic timer
> > code which expires timers and reprograms the local clock event device
> > with the next pending timer.
> >
> > So you cannot go idle again, before the expired timers of this event
> > are handled and their callbacks invoked.
> 
> That's true for the CPUs which not response to the global timer interrupt.
> Take our platform as example: we have 4CPUs(CPU0, CPU1,CPU2,CPU3)
> The global timer device will keep running even in the deep idle mode, so, it
> can be used as the broadcast timer device, and the interrupt of this device
> just raised to CPU0 when the timer expired, then, CPU0 will broadcast the
> IPI timer to other CPUs which is in deep idle mode.
> 
> So for CPU1, CPU2, CPU3, you are right, the IPI timer will bring it out of idle
> state, after running clockevents_notify() it returns from arch_idle()
> to cpu_idle(),
> then local_irq_enable(), the IPI handler will be invoked and handle
> the expires times
> and re-program the next pending timer.
> 
> But, that's not true for the CPU0. The flow for CPU0 is:
> the global timer interrupt wakes up CPU0 and then call:
> clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu);
> 
> which will cpumask_clear_cpu(cpu, tick_get_broadcast_oneshot_mask());
> in the function tick_broadcast_oneshot_control(),

Now your explanation makes sense. 

I have no fast solution for this, but I think that I have an idea how
to fix it. Stay tuned.

Thanks,

	tglx
