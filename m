From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 6 Jun 2018 17:48:39 +0100
Subject: [PATCH v2 3/5] arm_pmu: Add support for 64bit event counters
In-Reply-To: <1527591356-10934-4-git-send-email-suzuki.poulose@arm.com>
References: <1527591356-10934-1-git-send-email-suzuki.poulose@arm.com>
 <1527591356-10934-4-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20180606164838.zeuygsp4teq64zor@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2018 at 11:55:54AM +0100, Suzuki K Poulose wrote:
> Each PMU has a set of 32bit event counters. But in some
> special cases, the events could be counted using counters
> which are effectively 64bit wide.
> 
> e.g, Arm V8 PMUv3 has a 64 bit cycle counter which can count
> only the CPU cycles. Also, the PMU can chain the event counters
> to effectively count as a 64bit counter.
> 
> Add support for tracking the events that uses 64bit counters.
> This only affects the periods set for each counter in the core
> driver.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v1:
>  - Rename ARMPMU_EVT_LONG => ARMPMU_EVT_64BIT
> ---
>  drivers/perf/arm_pmu.c       | 14 ++++++++------
>  include/linux/perf/arm_pmu.h |  6 ++++++
>  2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 8962d26..ff858e6 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -28,9 +28,10 @@
>  static DEFINE_PER_CPU(struct arm_pmu *, cpu_armpmu);
>  static DEFINE_PER_CPU(int, cpu_irq);
>  
> -static inline u64 arm_pmu_max_period(void)
> +static inline u64 arm_pmu_event_max_period(struct perf_event *event)
>  {
> -	return (1ULL << 32) - 1;
> +	return (event->hw.flags & ARMPMU_EVT_64BIT) ?
> +		~0ULL : (1ULL << 32) - 1;
>  }

Could we please have:

static inline u64 arm_pmu_event_max_period(struct perf_event *event)
{
	if (event->hw.flags & ARMPMU_EVT_64BIT)
		return GENMASK_ULL(63, 0);
	else
		return GENMASK_ULL(31, 0);
}

... since that's obviously balanced, with both values generated in the
same way.

Otherwise this looks good to me.

Thanks,
Mark.
