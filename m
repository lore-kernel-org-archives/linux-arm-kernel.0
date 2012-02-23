From: will.deacon@arm.com (Will Deacon)
Date: Thu, 23 Feb 2012 16:04:50 +0000
Subject: [PATCH] ARM: perf: add PMU hotplug notifier
In-Reply-To: <4F4662AD.6030306@codeaurora.org>
References: <CAKHPGBaY1OFiVubic+f1vxxzNeKjmzibxraBg8eNxZnJbhYi+A@mail.gmail.com>
 <4F4661E2.9020405@codeaurora.org> <4F4662AD.6030306@codeaurora.org>
Message-ID: <20120223160450.GL29450@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ashwin,

On Thu, Feb 23, 2012 at 04:00:45PM +0000, Ashwin Chaugule wrote:
> >> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> >> index ab59c3b..fa30ff9 100644
> >> --- a/arch/arm/kernel/perf_event.c
> >> +++ b/arch/arm/kernel/perf_event.c
> >> @@ -680,6 +680,28 @@ static void __init cpu_pmu_init(struct arm_pmu *armpmu)
> >>  }
> >>
> >>  /*
> >> + * PMU hardware loses all context when a CPU goes offline.
> >> + * When a CPU is hotplugged back in, since some hardware registers are
> >> + * UNKNOWN at reset, the PMU must be explicitly reset to avoid reading
> >> + * junk values out of them.
> >> + */
> >> +static int __cpuinit pmu_cpu_notify(struct notifier_block *b,
> >> +                                       unsigned long action, void *hcpu)
> >> +{
> >> +       if (action != CPU_UP_PREPARE)
> >> +               return NOTIFY_DONE;
> >> +
> >> +       if (cpu_pmu && cpu_pmu->reset)
> >> +               cpu_pmu->reset(NULL);
> >> +
> >> +       return NOTIFY_OK;
> >> +}
> >> +
> > 
> > I realized I needed to save the counters before going to sleep. In my
> > case, the notifiers were being called from the idle thread, so I
> > didn't know which "sleep state" I was going to go into. In the deepest
> > idle state, the counters are completely reset. When we come out of
> > sleep, unless there had been an explicit "read" earlier, we will have
> > lost the cached value(event->count) of the counters. This manifests as
> > counts reduced by an order of magnitude.

Ok. Note that the perf core will actually destroy perf events on a hotplug
down notification, so profiling runs will be dead on that core even if it
comes back up.

This patch just ensures that we have a sane state in the control registers
given that their state is UNKNOWN out of reset. Adding full hotplug support
to perf (that is, supporting hotplug events during a run and representing
that in a meaningful way) is a larger issue.

> > I'll send a link to my code once the git server is up. It's a bit flaky today.

Ok, cool. Are you happy with me to proceed with the current code for the
time being?

Will
