From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 4 May 2016 14:44:20 +0100
Subject: [PATCH] perf/core / arm_pmu: special-case hetereogeneous CPUs
In-Reply-To: <20160426103346.GA20836@leverpostej>
References: <20160425175837.GB3141@leverpostej>
 <20160425190334.GK3448@twins.programming.kicks-ass.net>
 <20160426103346.GA20836@leverpostej>
Message-ID: <20160504134419.GA15849@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 26, 2016 at 11:33:46AM +0100, Mark Rutland wrote:
> On Mon, Apr 25, 2016 at 09:03:34PM +0200, Peter Zijlstra wrote:
> > On Mon, Apr 25, 2016 at 06:58:37PM +0100, Mark Rutland wrote:
> > > Hi,
> > > 
> > > When booting an arm64 defconfig linux-next (next-20160422) on an ARM
> > > Juno system, I hit a WARN_ON_ONCE in perf_pmu_register (see backtrace at
> > > the end of this email).
> > > 
> > > This was introduced by commit 26657848502b7847 ("perf/core: Verify we
> > > have a single perf_hw_context PMU") where we forcefully prevent multiple
> > > PMUs from sharing perf_hw_context (with a warning), and force additional
> > > PMUs to use perf_invalid_context.
> 
> > > Are you happy to revert 26657848502b787 for the timebeing? Or to somehow
> > > predicate the check such that it doesn't adversely affect those HW PMUs?
> > 
> > I'm happy with a chicken bit for now, its already found two real issues,
> > so I'd like to keep it.
> 
> Ok, how about the below? (based on next-20160422).

Peter, any thoughts?

This is still an issue for us in next-20160504 (to which the patch still
applies).

Will, I assume that you're ok with the change to drivers/perf/arm_pmu.c.

Thanks,
Mark.

> It looks like 26657848502b7847 was on a stable branch, so I guess we
> can't fold this in. It probably makes sense for this to go the same path
> as 26657848502b7847, assuming people are happy with that and there are
> no conflicts.
> 
> Mark.
> 
> ---->8----
> From 7b1007f86d30bfed1dde21218224f119b6ad547f Mon Sep 17 00:00:00 2001
> From: Mark Rutland <mark.rutland@arm.com>
> Date: Tue, 26 Apr 2016 11:17:51 +0100
> Subject: [PATCH] perf/core / arm_pmu: special-case hetereogeneous CPUs
> 
> Commit 26657848502b7847 ("perf/core: Verify we have a single
> perf_hw_context PMU") forcefully prevents multiple PMUs from sharing
> perf_hw_context, as this generally doesn't make sense. It is a common
> bug for uncore PMUs to use perf_hw_context rather than
> perf_invalid_context, which this detects.
> 
> However, systems exist with heterogeneous CPUs (and hence heterogeneous
> HW PMUs), for which sharing perf_hw_context is necessary, and possible
> in some limited cases. To make this work we have to perform some
> gymnastics, as we did in commit 66eb579e66ecfea5 ("perf: allow for
> PMU-specific event filtering") and c904e32a69b7c779 ("arm: perf: filter
> unschedulable events").
> 
> To allow those systems to work, we must allow PMUs for heterogeneous
> CPUs to share perf_hw_context, though we must still disallow sharing
> otherwise to detect the common misuse of perf_hw_context.
> 
> This patch adds a new PERF_PMU_CAP_HETEROGENEOUS_CPUS for this, updates
> the core logic to account for this, and makes use of it in the arm_pmu
> code that is used for systems with heterogeneous CPUs. Comments are
> added to make the rationale clear and hopefully avoid accidental abuse.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  drivers/perf/arm_pmu.c     | 8 ++++++++
>  include/linux/perf_event.h | 1 +
>  kernel/events/core.c       | 8 +++++++-
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 32346b5..bbf827a 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -836,6 +836,14 @@ static int cpu_pmu_init(struct arm_pmu *cpu_pmu)
>  	if (!platform_get_irq(cpu_pmu->plat_device, 0))
>  		cpu_pmu->pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
>  
> +	/*
> +	 * This is a CPU PMU potentially in a heterogeneous configuration (e.g.
> +	 * big.LITTLE). This is not an uncore PMU, and we have taken ctx
> +	 * sharing into account (e.g. with our pmu::filter_match callback and
> +	 * pmu::event_init group validation).
> +	 */
> +	cpu_pmu->pmu.capabilities |= PERF_PMU_CAP_HETEROGENEOUS_CPUS;
> +
>  	return 0;
>  
>  out_unregister:
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 342cb92..18d19d6 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -216,6 +216,7 @@ struct perf_event;
>  #define PERF_PMU_CAP_AUX_SW_DOUBLEBUF		0x08
>  #define PERF_PMU_CAP_EXCLUSIVE			0x10
>  #define PERF_PMU_CAP_ITRACE			0x20
> +#define PERF_PMU_CAP_HETEROGENEOUS_CPUS		0x40
>  
>  /**
>   * struct pmu - generic performance monitoring unit
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 1e0f117..796ee56 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7855,7 +7855,13 @@ skip_type:
>  	if (pmu->task_ctx_nr == perf_hw_context) {
>  		static int hw_context_taken = 0;
>  
> -		if (WARN_ON_ONCE(hw_context_taken))
> +		/*
> +		 * Other than systems with heterogeneous CPUs, it never makes
> +		 * sense for two PMUs to share perf_hw_context. PMUs which are
> +		 * uncore must use perf_invalid_context.
> +		 */
> +		if (WARN_ON_ONCE(hw_context_taken &&
> +		    !(pmu->capabilities & PERF_PMU_CAP_HETEROGENEOUS_CPUS)))
>  			pmu->task_ctx_nr = perf_invalid_context;
>  
>  		hw_context_taken = 1;
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
