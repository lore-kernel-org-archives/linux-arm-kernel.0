From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 May 2015 16:55:52 +0100
Subject: [PATCH] RFC: ARM: Don't break affinity for non-balancable IRQs
 to fix perf
In-Reply-To: <1432252433-25206-1-git-send-email-dianders@chromium.org>
References: <1432252433-25206-1-git-send-email-dianders@chromium.org>
Message-ID: <20150522155552.GJ2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 04:53:53PM -0700, Doug Anderson wrote:
> It's "perf_event_cpu" that we're trying to fix here.  For
> perf_event_cpu, we actually expect to have a single IRQ per CPU.  This
> doesn't appear to be an "IRQ_PER_CPU IRQ" because each CPU has a
> distinct IRQ number.  However, moving a perf event IRQ from one CPU to
> another makes no sense since the IRQ can only be handled on the CPU
> that they're destined for (we can't access the relevant CP15 registers
> on the other CPUs).  While we could come up with a new concept just
> for perf_event_cpu that indicates that we have an non "per cpu" IRQ
> that also shoulnd't be migrated, simply using the already present
> IRQF_NOBALANCING seems safe and should work just fine.

Let's be clear: what you're talking about is extending the workaround for
broken hardware into yet more code.  Perf interrupts should _never_ have
been connected to SPIs - the hardware designers that did that need to be
re-educated. :)

> The clocksource files I've checked appear to use IRQF_NOBALANCING for
> interrupts that are also supposed to be destined for a CPU.  For
> instance:
> - exynos_mct.c: Used for local (per CPU) timers
> - qcom-timer.c: Also for local timer
> - dw_apb_timer.c: Register function has "cpu" parameter indicating
>   that IRQ is targeted at a certain CPU.

I don't think these are affected; when a CPU goes down, the CPU local
timer is stopped.  When that happens,
- exynos_mct.c frees its interrupt.
- qcom-timer.c doesn't (but ought to)
- dw_apb_timer.c doesn't

Considering that local timers are "setup" each time a CPU is hotplugged
back in, not freeing the interrupt is a bug in itself, as the interrupt
won't be able to be claimed when the CPU comes back.  So, out of those
you list, only exynos_mct.c gets it right, the others are buggy.

When they're fixed, they won't cause the affinity warning, because there
won't be an IRQ in-use on the offlining CPU.

Perf should _probably_ do the same thing - cleanly shut itself down on
the CPU which is being unplugged.  This is going to become more important
if/when we start using FIQs for perf on platforms which support that
(which will give much better perf traces, since it'll then be able to
perf those IRQ-off regions as well.)

So all in all, I think the answer is:

- timers need their bugs fixing
- perf needs improving to keep their workarounds for broken hardware
  within the bounds of the perf code rather than having it spread
  elsewhere.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
