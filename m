From: ccross@android.com (Colin Cross)
Date: Mon, 15 Oct 2012 15:58:11 -0700
Subject: Use coupled cpuidle on imx6q
In-Reply-To: <20121015162842.GD24393@S2101-09.ap.freescale.net>
References: <1349691981-31038-1-git-send-email-josephl@nvidia.com>
 <1349691981-31038-8-git-send-email-josephl@nvidia.com>
 <5074AA0E.2080508@wwwdotorg.org>
 <1349954685.19413.207.camel@jlo-ubuntu-64.nvidia.com>
 <5076F5CB.4020200@wwwdotorg.org>
 <CAMbhsRScnEaEeyqGz6tfYQMHXaZva4UeHtFY4C9Vvu1MrKXPNg@mail.gmail.com>
 <20121012075358.GA4962@S2101-09.ap.freescale.net>
 <1350030264.15495.14.camel@jlo-ubuntu-64.nvidia.com>
 <20121012083017.GB4962@S2101-09.ap.freescale.net>
 <CAMbhsRRGyPB1DvXqkmNpF=hA-3ya5Y+JLV-KY5BW+FX_RoEc9g@mail.gmail.com>
 <20121015162842.GD24393@S2101-09.ap.freescale.net>
Message-ID: <CAMbhsRTmUCKBoYbjbJxO4-cLr6bdtSKgzvtkKXu2kZJFvFC9Zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2012 at 9:28 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Changed subject (was: Re: [PATCH 7/7] ARM: tegra30: cpuidle: add LP2
> driver for CPU0) ...
>
> On Fri, Oct 12, 2012 at 01:50:35PM -0700, Colin Cross wrote:
>> Current coupled cpuidle requires all cpus to wake up together and go
>> back to the idle governor to select a new state, because that's what
>> all available ARM cpus did when I wrote it.  You should be able to
>> implement coupled idle on a cpu that does not need to wake all the
>> cpus if you wake them anyways,
>
> Can you please elaborate it a little bit?  I do not quite understand
> what you mean.

In the current coupled cpuidle implementation, no cpu will return back
to the scheduler until all cpus have returned from their idle
function.  That means you need to force each cpu to wake up whenever
one of them wakes up.  This is a limitation in the current coupled
cpuidle design due to all existing coupled cpuidle implemenations
having it as a hardware requirement, but is not a hardware requirement
for your WAIT mode.  Until somebody fixes that, you have to fake
wakeups to the other cpus.

> Basically, imx6q has a low-power mode named WAIT.  When all 4 cores
> are in WFI, imx6q will go into WAIT mode, and whenever there is a
> wakeup interrupt, it will exit WAIT mode.  Software can configure
> hardware behavior during WAIT mode, clock gating or power gating for
> ARM core.
>
> I'm trying to implement this low-power mode with coupled cpuidle.
> I initially have the following code as the coupled cpuidle enter
> function for clock gating case.
>
> static int imx6q_enter_wait_coupled(struct cpuidle_device *dev,
>                                     struct cpuidle_driver *drv, int index)
> {
>         int cpu = dev->cpu;
>
>         clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu);
>
>         if (atomic_inc_return(&master) == num_online_cpus())
>                 imx6q_set_lpm(WAIT_UNCLOCKED);
>
>         cpu_do_idle();
>
>         if (atomic_dec_return(&master) == num_online_cpus() - 1)
>                 imx6q_set_lpm(WAIT_CLOCKED);
>
>         clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu);
>         return index;
> }
>
> However I think there are a couple of problems.  The first one is the
> extra wakeups you have mentioned.  When last cpu is in call
> imx6q_set_lpm(), some of the first 3 cpus that are already in WFI may
> exit from there.  The second one is when hardware exits WAIT mode and
> has ARM clock resumed, some cpus may stay in WFI if scheduler has
> nothing to wake them up.  This breaks the requirement of coupled cpuidle
> that all cpus need to exit together.  I can force the function to work
> around the problems by adding cpuidle_coupled_parallel_barrier() just
> above cpu_do_idle() and arch_send_wakeup_ipi_mask(cpu_online_mask)
> right after imx6q_set_lpm(WAIT_CLOCKED).  But I doubt it's appropriate.

That is the appropriate way of getting it working with today's coupled cpuidle.

> So I rewrite the function as below to not use coupled cpuidle, and it
> works fine.
>
> static int imx6q_enter_wait(struct cpuidle_device *dev,
>                             struct cpuidle_driver *drv, int index)
> {
>         int cpu = dev->cpu;
>
>         clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu);
>
>         if (atomic_inc_return(&master) == num_online_cpus()) {
>                 /*
>                  * With this lock, we prevent the other cpu to exit and
>                  * enter this function again and become the master.
>                  */
>                 if (!spin_trylock(&master_lock))
>                         goto idle;
>
>                 imx6q_set_lpm(WAIT_UNCLOCKED);
>                 cpu_do_idle();
>                 imx6q_set_lpm(WAIT_CLOCKED);
>
>                 spin_unlock(&master_lock);
>                 goto out;
>         }
>
> idle:
>         cpu_do_idle();
> out:
>         atomic_dec(&master);
>         clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu);
>         return index;
> }

Coupled cpuidle provides two features, and you only need one of them
for your clock gating mode.  The more complex one is sequencing, which
you don't need since your hardware can check if all cpus are in WFI
for you.  The other feature is voting, to make sure all cpus can
accept the exit latency of the deeper idle state.  The
atomic_inc_return is handling voting in your example, but it can't
handle one cpu requesting power gating while the other requests clock
gating.

> For power gating case, it may better fit coupled cpuidle usage model,
> since all the cores will have to run resume routine and thus will not
> be in WFI when hardware exits from WAIT mode.  But we still need to
> work out the extra wakeup issue which will also be seen in this case.

Yes, but using coupled cpuidle for both clock gating and power gating
will allow you to get into clock gating when one cpu wants clock
gating and the other wants power gating.

>> and then later you can optimize it to
>> avoid the extra wakeups when the extension to coupled cpuidle that I
>> discussed previously gets implemented.
>
> Do you have a pointer to the initial discussion for the extension, or
> you have a draft patch for that already (hopefully:)?

I can't find the initial discussion, and I'm not going to have a
chance to work on it for at least a few weeks.  The basic idea is:
Add "preidle" and "postidle" function pointers to the coupled cpuidle
states (better names TBD).
When all cpus are waiting, and before sending any pokes, call the
preidle hook on the last cpu to start waiting.  It must only be called
on one cpu.  The preidle hook is responsible for disabling wakeups on
secondary cpus so they can't wake up, and returning a mask of the cpus
it has disabled.
The coupled core can increment ready count by the number of cpus that
are disabled and skip poking them.

After coupled idle returns (or when aborting coupled idle), call the
postidle hook with the mask returned by the pre-idle hook, which
re-enables wakeups on secondary cpus and returns a mask of cpus that
are not waking because they are already in a state that can handle
interrupts (WFI).  The calling cpu will then decrement the ready count
by the number of cpus that are not waking.

There are some tricky synchronization problems to solve:
Only one cpu can call the preidle and postidle hooks.  On some
hardware, they may not even be the same cpu.
A cpu that is left in the WFI state by the postidle hook is back in
the "waiting but not ready" state, and the current coupled cpuidle
code does not support going from waiting->ready->waiting.
Once the postidle hook has returned, some cpus may be able to
immediately handle interrupts and return to the scheduler.
