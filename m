From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 23 May 2012 11:00:06 -0600
Subject: perf_event_v7.c compilation failure in next-20120523
Message-ID: <4FBD1796.4030309@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will,

In next-20120523, the following two commits of yours collided:

d33c88c ARM: 7315/1: perf: add support for the Cortex-A7 PMU
(adds new entry to perf_event_v7.c)

b3426c5 ARM: perf: remove arm_perf_pmu_ids global enumeration
(removes a field from entries in perf_event_v7.c)

This causes:

> In file included from arch/arm/kernel/perf_event.c:610:0:
> arch/arm/kernel/perf_event_v7.c: In function 'armv7_a7_pmu_init':
> arch/arm/kernel/perf_event_v7.c:1294:10: error: 'struct arm_pmu' has no member named 'id'
> arch/arm/kernel/perf_event_v7.c:1294:17: error: 'ARM_PERF_PMU_ID_CA7' undeclared (first use in this function)

The following fixes the compilation error, although I put no thought
into whether it actually works at run-time:

> diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
> index 46228f0..f04070b 100644
> --- a/arch/arm/kernel/perf_event_v7.c
> +++ b/arch/arm/kernel/perf_event_v7.c
> @@ -1291,7 +1291,6 @@ static struct arm_pmu *__init armv7_a15_pmu_init(void)
>  
>  static struct arm_pmu *__init armv7_a7_pmu_init(void)
>  {
> -	armv7pmu.id		= ARM_PERF_PMU_ID_CA7;
>  	armv7pmu.name		= "ARMv7 Cortex-A7";
>  	armv7pmu.map_event	= armv7_a7_map_event;
>  	armv7pmu.num_events	= armv7_read_num_pmnc_events();
