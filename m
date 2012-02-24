From: tom.leiming@gmail.com (Ming Lei)
Date: Fri, 24 Feb 2012 09:34:32 +0800
Subject: [PATCH 3/4] ARM: perf: check that we have an event in the PMU IRQ
 handlers
In-Reply-To: <1330012696-13472-4-git-send-email-will.deacon@arm.com>
References: <1330012696-13472-1-git-send-email-will.deacon@arm.com>
 <1330012696-13472-4-git-send-email-will.deacon@arm.com>
Message-ID: <CACVXFVM6HOMeJCMznLqO6-jMT8owoK65Ap6c_CNCJbwWxphCBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 23, 2012 at 11:58 PM, Will Deacon <will.deacon@arm.com> wrote:
> The PMU IRQ handlers in perf assume that if a counter has overflowed
> then perf must be responsible. In the paranoid world of crazy hardware,
> this could be false, so check that we do have a valid event before
> attempting to dereference NULL in the interrupt path.
>
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> ?arch/arm/kernel/perf_event_v6.c ? ? | ? 20 ++------------------
> ?arch/arm/kernel/perf_event_v7.c ? ? | ? ?4 ++++
> ?arch/arm/kernel/perf_event_xscale.c | ? ?6 ++++++
> ?3 files changed, 12 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
> index 88bf152..b78af0c 100644
> --- a/arch/arm/kernel/perf_event_v6.c
> +++ b/arch/arm/kernel/perf_event_v6.c
> @@ -467,23 +467,6 @@ armv6pmu_enable_event(struct hw_perf_event *hwc,
> ? ? ? ?raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
> ?}
>
> -static int counter_is_active(unsigned long pmcr, int idx)
> -{
> - ? ? ? unsigned long mask = 0;
> - ? ? ? if (idx == ARMV6_CYCLE_COUNTER)
> - ? ? ? ? ? ? ? mask = ARMV6_PMCR_CCOUNT_IEN;
> - ? ? ? else if (idx == ARMV6_COUNTER0)
> - ? ? ? ? ? ? ? mask = ARMV6_PMCR_COUNT0_IEN;
> - ? ? ? else if (idx == ARMV6_COUNTER1)
> - ? ? ? ? ? ? ? mask = ARMV6_PMCR_COUNT1_IEN;
> -
> - ? ? ? if (mask)
> - ? ? ? ? ? ? ? return pmcr & mask;
> -
> - ? ? ? WARN_ONCE(1, "invalid counter number (%d)\n", idx);
> - ? ? ? return 0;
> -}
> -
> ?static irqreturn_t
> ?armv6pmu_handle_irq(int irq_num,
> ? ? ? ? ? ? ? ? ? ?void *dev)
> @@ -513,7 +496,8 @@ armv6pmu_handle_irq(int irq_num,
> ? ? ? ? ? ? ? ?struct perf_event *event = cpuc->events[idx];
> ? ? ? ? ? ? ? ?struct hw_perf_event *hwc;
>
> - ? ? ? ? ? ? ? if (!counter_is_active(pmcr, idx))
> + ? ? ? ? ? ? ? /* Ignore if we don't have an event. */
> + ? ? ? ? ? ? ? if (!event)

I think we should check it via test_bit(idx, cpuc->used_mask) because
'hw_events->events[idx] = val' is not atomic operation and it is read here
in irq context.

> ? ? ? ? ? ? ? ? ? ? ? ?continue;
>
> ? ? ? ? ? ? ? ?/*
> diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
> index 050cc8b..4d7095a 100644
> --- a/arch/arm/kernel/perf_event_v7.c
> +++ b/arch/arm/kernel/perf_event_v7.c
> @@ -960,6 +960,10 @@ static irqreturn_t armv7pmu_handle_irq(int irq_num, void *dev)
> ? ? ? ? ? ? ? ?struct perf_event *event = cpuc->events[idx];
> ? ? ? ? ? ? ? ?struct hw_perf_event *hwc;
>
> + ? ? ? ? ? ? ? /* Ignore if we don't have an event. */
> + ? ? ? ? ? ? ? if (!event)

Same with above.

> + ? ? ? ? ? ? ? ? ? ? ? continue;
> +
> ? ? ? ? ? ? ? ?/*
> ? ? ? ? ? ? ? ? * We have a single interrupt for all counters. Check that
> ? ? ? ? ? ? ? ? * each counter has overflowed before we process it.
> diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
> index 831e019..a5bbd36 100644
> --- a/arch/arm/kernel/perf_event_xscale.c
> +++ b/arch/arm/kernel/perf_event_xscale.c
> @@ -255,6 +255,9 @@ xscale1pmu_handle_irq(int irq_num, void *dev)
> ? ? ? ? ? ? ? ?struct perf_event *event = cpuc->events[idx];
> ? ? ? ? ? ? ? ?struct hw_perf_event *hwc;
>
> + ? ? ? ? ? ? ? if (!event)

Same with above.

> + ? ? ? ? ? ? ? ? ? ? ? continue;
> +
> ? ? ? ? ? ? ? ?if (!xscale1_pmnc_counter_has_overflowed(pmnc, idx))
> ? ? ? ? ? ? ? ? ? ? ? ?continue;
>
> @@ -592,6 +595,9 @@ xscale2pmu_handle_irq(int irq_num, void *dev)
> ? ? ? ? ? ? ? ?struct perf_event *event = cpuc->events[idx];
> ? ? ? ? ? ? ? ?struct hw_perf_event *hwc;
>
> + ? ? ? ? ? ? ? if (!event)

Same with above.

> + ? ? ? ? ? ? ? ? ? ? ? continue;
> +
> ? ? ? ? ? ? ? ?if (!xscale2_pmnc_counter_has_overflowed(pmnc, idx))
> ? ? ? ? ? ? ? ? ? ? ? ?continue;
>
> --
> 1.7.4.1
>


thanks,
-- 
Ming Lei
