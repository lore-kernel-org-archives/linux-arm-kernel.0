From: ming.lei@canonical.com (Ming Lei)
Date: Mon, 20 Feb 2012 20:39:11 +0800
Subject: [PATCH] ARM: perf: limit sample_period to half max_period in
 non-sampling mode
In-Reply-To: <1329739646-17058-1-git-send-email-will.deacon@arm.com>
References: <1329739646-17058-1-git-send-email-will.deacon@arm.com>
Message-ID: <CACVXFVPHrenJO_vKJNXVaSjnKHstQ3_3NRJFqhp0dTiDAAm8tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 20, 2012 at 8:07 PM, Will Deacon <will.deacon@arm.com> wrote:
> On ARM, the PMU does not stop counting after an overflow and therefore
> IRQ latency affects the new counter value read by the kernel. This is
> significant for non-sampling runs where it is possible for the new value
> to overtake the previous one, causing the delta to be out by up to
> max_period events.
>
> Commit a737823d ("ARM: 6835/1: perf: ensure overflows aren't missed due
> to IRQ latency") attempted to fix this problem by allowing interrupt
> handlers to pass an overflow flag to the event update function, causing
> the overflow calculation to assume that the counter passed through zero
> when going from prev to new. Unfortunately, this doesn't work when
> overflow occurs on the perf_task_tick path because we have the flag
> cleared and end up computing a large negative delta.
>
> This patch removes the overflow flag from armpmu_event_update and
> instead limits the sample_period to half of the max_period for
> non-sampling profiling runs.
>
> Cc: Ming Lei <ming.lei@canonical.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> ?arch/arm/include/asm/pmu.h ? ? ? ? ?| ? ?2 +-
> ?arch/arm/kernel/perf_event.c ? ? ? ?| ? 22 +++++++++++-----------
> ?arch/arm/kernel/perf_event_v6.c ? ? | ? ?2 +-
> ?arch/arm/kernel/perf_event_v7.c ? ? | ? ?2 +-
> ?arch/arm/kernel/perf_event_xscale.c | ? ?4 ++--
> ?5 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
> index b5a5be2..90114fa 100644
> --- a/arch/arm/include/asm/pmu.h
> +++ b/arch/arm/include/asm/pmu.h
> @@ -134,7 +134,7 @@ int __init armpmu_register(struct arm_pmu *armpmu, char *name, int type);
>
> ?u64 armpmu_event_update(struct perf_event *event,
> ? ? ? ? ? ? ? ? ? ? ? ?struct hw_perf_event *hwc,
> - ? ? ? ? ? ? ? ? ? ? ? int idx, int overflow);
> + ? ? ? ? ? ? ? ? ? ? ? int idx);
>
> ?int armpmu_event_set_period(struct perf_event *event,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct hw_perf_event *hwc,
> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> index 5bb91bf..56173ae 100644
> --- a/arch/arm/kernel/perf_event.c
> +++ b/arch/arm/kernel/perf_event.c
> @@ -180,7 +180,7 @@ armpmu_event_set_period(struct perf_event *event,
> ?u64
> ?armpmu_event_update(struct perf_event *event,
> ? ? ? ? ? ? ? ? ? ?struct hw_perf_event *hwc,
> - ? ? ? ? ? ? ? ? ? int idx, int overflow)
> + ? ? ? ? ? ? ? ? ? int idx)
> ?{
> ? ? ? ?struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
> ? ? ? ?u64 delta, prev_raw_count, new_raw_count;
> @@ -193,13 +193,7 @@ again:
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? new_raw_count) != prev_raw_count)
> ? ? ? ? ? ? ? ?goto again;
>
> - ? ? ? new_raw_count &= armpmu->max_period;
> - ? ? ? prev_raw_count &= armpmu->max_period;
> -
> - ? ? ? if (overflow)
> - ? ? ? ? ? ? ? delta = armpmu->max_period - prev_raw_count + new_raw_count + 1;
> - ? ? ? else
> - ? ? ? ? ? ? ? delta = new_raw_count - prev_raw_count;
> + ? ? ? delta = (new_raw_count - prev_raw_count) & armpmu->max_period;

Please add

           Signed-off-by: Ming Lei <ming.lei@canonical.com>

since I found the problem caused by incorrect 'delta' and the above change is
based on the original patch[1] from me.


[1], http://marc.info/?l=linux-kernel&m=132938793724425&w=2

thanks,
--
Ming Lei
