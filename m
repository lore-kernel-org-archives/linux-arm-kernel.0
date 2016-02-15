From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Feb 2016 20:04:04 +0000
Subject: [PATCH v3 5/5] arm64/perf: Extend event mask for ARMv8.1
In-Reply-To: <fa91eaedf581e6a7053899f25b1b08458dbd4b8e.1454516082.git.jglauber@cavium.com>
References: <cover.1454516082.git.jglauber@cavium.com>
 <fa91eaedf581e6a7053899f25b1b08458dbd4b8e.1454516082.git.jglauber@cavium.com>
Message-ID: <20160215200404.GX6298@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 06:12:00PM +0100, Jan Glauber wrote:
> ARMv8.1 increases the PMU event number space. Detect the
> presence of this PMUv3 type and extend the event mask.
> 
> The event mask is moved to struct arm_pmu so different event masks
> can exist, depending on the PMU type.
> 
> Signed-off-by: Jan Glauber <jglauber@cavium.com>
> ---
>  arch/arm/kernel/perf_event_v6.c     |  6 ++++--
>  arch/arm/kernel/perf_event_v7.c     | 29 +++++++++++++++++++----------
>  arch/arm/kernel/perf_event_xscale.c |  4 +++-
>  arch/arm64/kernel/perf_event.c      | 33 +++++++++++++++++++--------------
>  drivers/perf/arm_pmu.c              |  5 +++--
>  include/linux/perf/arm_pmu.h        |  4 ++--
>  6 files changed, 50 insertions(+), 31 deletions(-)

[...]

>  static void armv8_pmu_init(struct arm_pmu *cpu_pmu)
>  {
> +	u64 id;
> +
>  	cpu_pmu->handle_irq		= armv8pmu_handle_irq,
>  	cpu_pmu->enable			= armv8pmu_enable_event,
>  	cpu_pmu->disable		= armv8pmu_disable_event,
> @@ -842,6 +840,13 @@ static void armv8_pmu_init(struct arm_pmu *cpu_pmu)
>  	cpu_pmu->reset			= armv8pmu_reset,
>  	cpu_pmu->max_period		= (1LLU << 32) - 1,
>  	cpu_pmu->set_event_filter	= armv8pmu_set_event_filter;
> +
> +	/* detect ARMv8.1 PMUv3 with extended event mask */
> +	id = read_cpuid(ID_AA64DFR0_EL1);
> +	if (((id >> 8) & 0xf) == 4)

We have helpers for this stuff (cpuid_feature_extract_field)...

> +		cpu_pmu->event_mask = 0xffff;	/* ARMv8.1 extended events */
> +	else
> +		cpu_pmu->event_mask = ARMV8_EVTYPE_EVENT;

... although can't we just update ARMV8_EVTYPE_EVENT to be 0xffff now?
AFAICT, that just eats into bits that used to be RES0, so we shouldn't
see any problems. That should make your patch *much* simpler!

Will
