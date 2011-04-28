From: ashwinc@codeaurora.org (Ashwin Chaugule)
Date: Thu, 28 Apr 2011 11:21:30 -0400
Subject: [PATCH] ARM: perf: remove erroneous check on active_events
In-Reply-To: <BANLkTi=J=4R2v5P2iOsf4M5_FMwWJ=JrZw@mail.gmail.com>
References: <1303898236-14263-1-git-send-email-mark.rutland@arm.com>
	<BANLkTi=J=4R2v5P2iOsf4M5_FMwWJ=JrZw@mail.gmail.com>
Message-ID: <4DB985FA.1080508@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

> From: Mark Rutland <mark.rutland@arm.com>
>
> When initialising a PMU, there is a check to protect against races with
> other CPUs filling all of the available event slots. Since armpmu_add
> checks that an event can be scheduled, we do not need to do this at
> initialisation time. Furthermore the current code is broken because it
> assumes that atomic_inc_not_zero will unconditionally increment
> active_counts and then tries to decrement it again on failure.
> 
> This patch removes the broken, redundant code.

Nice find ! I had a slightly different solution.

> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Jamie Iles <jamie@jamieiles.com>
> ---
>  arch/arm/kernel/perf_event.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> index fd6403c..29a0cf8 100644
> --- a/arch/arm/kernel/perf_event.c
> +++ b/arch/arm/kernel/perf_event.c
> @@ -560,11 +560,6 @@ static int armpmu_event_init(struct perf_event *event)
>        event->destroy = hw_perf_event_destroy;
> 
>        if (!atomic_inc_not_zero(&active_events)) {
> -               if (atomic_read(&active_events) > armpmu->num_events) {
> -                       atomic_dec(&active_events);
> -                       return -ENOSPC;
> -               }
> -
>                mutex_lock(&pmu_reserve_mutex);
>                if (atomic_read(&active_events) == 0) {
>                        err = armpmu_reserve_hardware();
> --

While its true that we check if we can schedule an event in add(), I think
we should check it here, because, if we don't have space on the PMU,
returning -ENOSPC will not "allocate" a perf_event instance.

Whereas, if we skip this check in the init function, the perf_event
instance will be allocated but may or may not be "armed" on the pmu in
add(). This is fine, except that perf-core code "rotates" the linked list
of active events. When an event is allocated but can't be "armed" on the
PMU, the perf-core normalizes its output. This shows up as (scaled by)
against the output of the event in perf-stat.

In practice, I've seen that when this happens, the output of the event has
anywhere between 50-80% std deviation. Many users seem to not like this.
So I think we should enforce support for only as many events as there are
counters in the init function, and return -ENOSPC otherwise.

If the event allocation fails, it'll show up as <not-counted>, which I
think is better than using an output with very high std dev.

How about something like this:-

if (!atomic_inc_not_zero(&active_events)) {
	mutex_lock
	err = armpmu_reserve_hardware();
	mutex_unlock
	if (!err)
		atomic_inc(&active_events);
	..
} else
	if(atomic_read(&active_events) > armpmu->num_events)
		atomic_dec(&active_events)
		return -ENOSPC;
}



Cheers,
Ashwin


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
