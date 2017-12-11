From: will.deacon@arm.com (Will Deacon)
Date: Mon, 11 Dec 2017 17:37:02 +0000
Subject: [PATCH 2/5] arm_pmu: have armpmu_alloc() take GFP flags
In-Reply-To: <20171101141239.45340-3-mark.rutland@arm.com>
References: <20171101141239.45340-1-mark.rutland@arm.com>
 <20171101141239.45340-3-mark.rutland@arm.com>
Message-ID: <20171211173702.GC3275@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 01, 2017 at 02:12:36PM +0000, Mark Rutland wrote:
> In ACPI systems, we don't know the makeup of CPUs until we hotplug them
> on, and thus have to allocate the PMU datastrcutures at hotplug time.
> Thus, we must use GFP_ATOMIC allocations.
> 
> Reorganise the PMU allocators to take a GFP argument so that we can
> permit this.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  drivers/perf/arm_pmu.c          | 6 +++---
>  drivers/perf/arm_pmu_acpi.c     | 2 +-
>  drivers/perf/arm_pmu_platform.c | 2 +-
>  include/linux/perf/arm_pmu.h    | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 57df8dce8e19..3d6d4c5f2356 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -779,18 +779,18 @@ static void cpu_pmu_destroy(struct arm_pmu *cpu_pmu)
>  					    &cpu_pmu->node);
>  }
>  
> -struct arm_pmu *armpmu_alloc(void)
> +struct arm_pmu *armpmu_alloc(gfp_t flags)
>  {
>  	struct arm_pmu *pmu;
>  	int cpu;
>  
> -	pmu = kzalloc(sizeof(*pmu), GFP_KERNEL);
> +	pmu = kzalloc(sizeof(*pmu), flags);
>  	if (!pmu) {
>  		pr_info("failed to allocate PMU device!\n");
>  		goto out;
>  	}
>  
> -	pmu->hw_events = alloc_percpu(struct pmu_hw_events);
> +	pmu->hw_events = alloc_percpu_gfp(struct pmu_hw_events, flags);
>  	if (!pmu->hw_events) {
>  		pr_info("failed to allocate per-cpu PMU data.\n");
>  		goto out_free_pmu;
> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
> index 705f1a390e31..a52f5b673a15 100644
> --- a/drivers/perf/arm_pmu_acpi.c
> +++ b/drivers/perf/arm_pmu_acpi.c
> @@ -127,7 +127,7 @@ static struct arm_pmu *arm_pmu_acpi_find_alloc_pmu(void)
>  		return pmu;
>  	}
>  
> -	pmu = armpmu_alloc();
> +	pmu = armpmu_alloc(GFP_ATOMIC);

I think I'd rather have armpmu_alloc_atomic as a wrapper around
__armpmu_alloc(GFP_ATOMIC) and then leave the armpmu_alloc to pass
GFP_KERNEL.

Will
