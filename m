From: will.deacon@arm.com (Will Deacon)
Date: Fri, 23 Mar 2012 09:53:14 +0000
Subject: [PATCH] ARM: test for PMU feature on v7 (v2 with typo fix)
In-Reply-To: <87r4wk889a.fsf@rustcorp.com.au>
References: <4F590411.9060201@arm.com> <87ty1g88dv.fsf@rustcorp.com.au>
 <87r4wk889a.fsf@rustcorp.com.au>
Message-ID: <20120323095314.GA13622@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rusty,

On Fri, Mar 23, 2012 at 12:34:57AM +0000, Rusty Russell wrote:
> The v7 ARM (B4.1.82) specifies that bits 27-24 of the ID_DFR0 reg show
> what performance monitoring (if any) is available.  We should test this
> before assuming (useful for inside virtualized environments, for example).

Ok, I can see why you don't want to emulate a PMU but I don't agree with the
patch :)

> diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
> index 6933244..303d1e1 100644
> --- a/arch/arm/kernel/perf_event_v7.c
> +++ b/arch/arm/kernel/perf_event_v7.c
> @@ -1108,6 +1108,12 @@ static struct arm_pmu armv7pmu = {
>  	.max_period		= (1LLU << 32) - 1,
>  };
>  
> +static bool armv7_pmu_avail(void)
> +{
> +	/* 0 means unknown (maybe v1), 1 means v1, 2 means v2, 15 means none */
> +	return ((read_cpuid_ext(CPUID_EXT_DFR0) >> 24) & 0xF) != 0xF;
> +}
> +
>  static u32 __init armv7_read_num_pmnc_events(void)
>  {
>  	u32 nb_cnt;
> @@ -1121,6 +1127,8 @@ static u32 __init armv7_read_num_pmnc_events(void)
>  
>  static struct arm_pmu *__init armv7_a8_pmu_init(void)
>  {
> +	if (!armv7_pmu_avail())
> +		return NULL;

This code is only executed if we know for sure that we are running on a
Cortex-A8. Cortex-A8 implementations have a PMU, so I don't like having the
probe here in case we are running on a virtualised CPU that doesn't quite
match the hardware.

Would you be able to advertise 0 event counters instead and treat the PMU
largely as RAZ/WI? The only tricky bit I can see is the cycle counter, which
is mandated by the presence of a PMU, however this could also just RAZ
initially.

>  	armv7pmu.id		= ARM_PERF_PMU_ID_CA8;
>  	armv7pmu.name		= "ARMv7 Cortex-A8";
>  	armv7pmu.map_event	= armv7_a8_map_event;
> @@ -1130,6 +1138,8 @@ static struct arm_pmu *__init armv7_a8_pmu_init(void)
>  
>  static struct arm_pmu *__init armv7_a9_pmu_init(void)
>  {
> +	if (!armv7_pmu_avail())
> +		return NULL;

Similarly for A5, A9, A7 and A15...

Cheers,

Will
