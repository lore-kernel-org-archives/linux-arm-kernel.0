From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Jun 2015 19:29:47 +0100
Subject: [PATCH v3 2/3] ARM: rockchip: ensure CPU to enter WFI/WFE state
In-Reply-To: <CAD=FV=UMkFtOFYpY+MUZOegnmFLdW3ZgNivwdHChv0MLr50sVQ@mail.gmail.com>
References: <1433517104-7595-1-git-send-email-wxt@rock-chips.com>
 <1433517104-7595-3-git-send-email-wxt@rock-chips.com>
 <CAD=FV=UMkFtOFYpY+MUZOegnmFLdW3ZgNivwdHChv0MLr50sVQ@mail.gmail.com>
Message-ID: <20150605182947.GN7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 05, 2015 at 10:49:14AM -0700, Doug Anderson wrote:
> On Fri, Jun 5, 2015 at 8:11 AM, Caesar Wang <wxt@rock-chips.com> wrote:
> > In idle mode, core1/2/3 of Cortex-A17 should be either power off or in
> > WFI/WFE state.
> > we can delay 1ms to ensure the CPU enter WFI/WFE state.
> >
> > Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> > ---
> >
> >  arch/arm/mach-rockchip/platsmp.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
> > index 25da16f..6672fdd 100644
> > --- a/arch/arm/mach-rockchip/platsmp.c
> > +++ b/arch/arm/mach-rockchip/platsmp.c
> > @@ -325,6 +325,9 @@ static void __init rockchip_smp_prepare_cpus(unsigned int max_cpus)
> >  #ifdef CONFIG_HOTPLUG_CPU
> >  static int rockchip_cpu_kill(unsigned int cpu)
> >  {
> > +       /* ensure CPU can enter the WFI/WFE state */
> > +       mdelay(1);
> 
> This is a pretty weak assurance.  Is there any stronger assurance you
> can give that we're in WFI/WFE state and won't come out of it?
> 
> Do you actually see problems if you power off a CPU when it's not in
> WFI/WFE state?

I really don't like to see platforms pulling crap tricks in their
CPU hotunplug code like this.  If there's something wrong with the
generic code, then the generic code needs to be fixed, not worked
around in platform code.

> ...so I _think_ I see the path that is happening here and what you're
> trying to handle.  Specifically, I see:
> 
> On dying CPU:
> 1. cpu_die() calls 'complete(&cpu_died)'
> 2. cpu_die() calls 'smp_ops.cpu_die(cpu)' AKA rockchip_cpu_die()
> 3. rockchip_cpu_die() does a bit more cache flushing before looping in
> cpu_do_idle()
> 
> The problem is that the moment the completion happens in step #1 above
> the dying CPU can be killed.  ...so you're trying to make sure the
> dying CPU makes it to cpu_do_idle().  In that case a fixed mdelay(1)
> might be OK since the time that the CPU takes to run through a few
> instructions (with no interrupts) is pretty predictable.  It would be
> really nice if the commit message went through all this, though.
> 
> ...but is there any chance that cpu_do_idle() could somehow return?
> We shouldn't send any events since we've marked the core offline, but
> perhaps some per-core interrupt (arch timer?) that didn't get
> migrated?

How this is supposed to work is:

	CPU requesting death		CPU dying
	stop_machine(take_down_cpu)
					take_down_cpu()
					-__cpu_disable()
					- platform_cpu_disable()
					- marks CPU offline
					- migrates IRQs away
					- caches flushed
					- tlbs flushed
	__cpu_die()			- processes migrated away
	-wait_for_completion_timeout()	-timekeeping migrated away
					returns to idle loop
					arch_cpu_idle_dead()
					-cpu_die()
					- idle_task_exit()
					- flush_cache_louis()

At this point, dirty cache lines which matter are flushed from the
dying CPUs cache.  However, we still need the dying CPU to be
coherent for the next step, which is to issue the completion.

					- complete()
					- flush_cache_louis()

At some point during the above, the completion becomes visible to
the other CPU, and it continues its execution.

	-pr_notice()
	-platform_cpu_kill()		- smp_ops.cpu_die()

The precise ordering of smp_ops.cpu_die() vs platform_cpu_kill() is
pretty much indeterminant, and is subject to scheduling effects which
could delay the requesting CPU.

Now, the problem is, from what ARM has been saying, that cache lines
can get migrated to the dying CPU which may contain the "master" copy
of the data, which means that when the dying CPU actually exits
coherency, that data is lost to the rest of the system.

Ideally, what we would like to do is to exit coherency earlier, and
then have some notification mechanism between the dying CPU and the
rest of the system to say that it's finished exiting coherency.
However, we face several issues.

1) v7_coherency_exit() is specific to v7 CPUs and can't be used by
   generic code.

2) we have no way to perform that notification reliably once
   coherency has been exited.

There's other reasons we need to change the notification mechanism,
one of them is that completions use RCU, and RCU isn't actually valid
in this context - and we can't make it valid because the dying CPU
might loose power at any moment after it's called complete().

Paul McKenny created what was a generic infrastructure for this
notification, but I object to it on principle using atomic_t... and
if we've exited coherency (as we would want to), it won't work
because it makes use of atomic_cmpxchg() on the dying CPU.

I've been working on a solution to use an IPI to notify from the
dying CPU, but that's fraught because of the separation of the IRQ
controller code from the architecture code, and we now have spinlocks
in the IPI-raising path due to the big.LITTLE stuff - and spinlocks
need coherency to be working.

So, we're actually in a very sticky position over taking CPUs offline.
It seems to be something that the ARM architecture and kernel
architecture doesn't actually allow to be done safely.  So much so,
that in a similar way to the original Keystone 2 physical address
switch, I'm tempted to make taking a CPU offline taint the kernel!

We're going to end up with tainted kernels through this path when Paul
pushes his RCU correctness patches anyway anyway, so it's just a
matter of the inevitable taint happening sooner or later.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
