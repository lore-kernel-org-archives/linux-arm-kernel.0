From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Thu, 10 Apr 2014 11:18:23 +0530
Subject: [PATCH] arm: exynos: generalize power register address calculation
In-Reply-To: <53455CF2.9020704@samsung.com>
References: <1396973737-18693-1-git-send-email-chander.kashyap@linaro.org>
 <1397041783-18531-1-git-send-email-chander.kashyap@linaro.org>
 <534533E6.10901@samsung.com>
 <CANuQgHEdks=OwF=N3LULmxujAeVVcLW3H++ixVZ3REfSrOieQA@mail.gmail.com>
 <53455CF2.9020704@samsung.com>
Message-ID: <CANuQgHHjuWzmwKGH3YTznpTR5dRbmrW2fbGFoyroOg-P9rmybw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On 9 April 2014 20:15, Tomasz Figa <t.figa@samsung.com> wrote:
> On 09.04.2014 15:49, Chander Kashyap wrote:
>>
>> Hi Tomasz,
>>
>> On 9 April 2014 17:19, Tomasz Figa <t.figa@samsung.com> wrote:
>>>
>>> Hi Chander,
>>>
>>>
>>> On 09.04.2014 13:09, Chander Kashyap wrote:
>>>>
>>>>
>>>> Currently status/configuration power register values are hard-coded for
>>>> cpu1.
>>>>
>>>> Make it generic so that it is useful for SoC's with more than two cpus.
>>>>
>>>> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
>>>> ---
>>>> changes in v2 : Used existing macros for clusterid and cpuid calculation
>>>>
>>>>    arch/arm/mach-exynos/hotplug.c  |   15 ++++++++++++---
>>>>    arch/arm/mach-exynos/platsmp.c  |   20 +++++++++++++++-----
>>>>    arch/arm/mach-exynos/regs-pmu.h |    9 +++++++--
>>>>    3 files changed, 34 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-exynos/hotplug.c
>>>> b/arch/arm/mach-exynos/hotplug.c
>>>> index 5eead53..eab6121 100644
>>>> --- a/arch/arm/mach-exynos/hotplug.c
>>>> +++ b/arch/arm/mach-exynos/hotplug.c
>>>> @@ -17,6 +17,7 @@
>>>>
>>>>    #include <asm/cacheflush.h>
>>>>    #include <asm/cp15.h>
>>>> +#include <asm/cputype.h>
>>>>    #include <asm/smp_plat.h>
>>>>
>>>>    #include <plat/cpu.h>
>>>> @@ -92,11 +93,19 @@ static inline void cpu_leave_lowpower(void)
>>>>
>>>>    static inline void platform_do_lowpower(unsigned int cpu, int
>>>> *spurious)
>>>>    {
>>>> +       unsigned int mpidr, cpunr, cluster;
>>>> +
>>>> +       mpidr = cpu_logical_map(cpu);
>>>> +       cpunr = MPIDR_AFFINITY_LEVEL(mpidr, 0);
>>>> +       cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
>>>> +
>>>> +       /* Maximum possible cpus in a cluster can be 4 */
>>>> +       cpunr += cluster * 4;
>>>
>>>
>>>
>>> I believe this is rather a weak assumption. First of all, the limit seems
>>> to
>>> be hardcoded only for the few existing SoCs. In addition, the value is
>>> not
>>> used as a maximum, but rather it is assumed that each cluster has always
>>> four cores.
>>
>>
>> The MPIDR register contains 2 bits for cpu id. Hence maximum number of
>> cpus can be 4 only (A15/A9/A7).
>>
>
> This is not what I meant. Exynos5260 contains 2 big cores (not 4) and 4
> little cores. Are you sure that PMU register layout on Exynos5260 matches
> your equation?
>

Yes the equation covers that as the PMU register layout takes care for that:
Address offset are as follows:
2 Big Cores:
cpu0 : 2000
cpu1: 2080

4 Little cores:

cpu0: 2200
cpu1: 2280
cpu2: 2300
cpu3: 2380

>
>>>
>>> Moreover, it is assumed here that the mapping between core ID (calculated
>>> by
>>> the equation below) and PMU core numbers is 1:1, which is not true. On
>>> Exynos4210, the cluster ID is always 0x09 and on Exynos4x12 it is 0x0a,
>>> which will lead to completely wrong register offsets.
>>
>>
>> Exynos4210 and Exynos4x12, cluster ids are not passed from DT as it
>> breaks the gic_init_bases. Hence the Physical CpuID for Exynos4210
>> will be 0,1 and Exynos4x12 will be 0,1,2,3.
>>
>> So it will not break.
>
>
> I already have patches ready fixing GIC driver, just waiting for 3.15-rc1 to
> be released. Anyway, CPU topology in DT is mandatory and Exynos4 device tree
> files need to be fixed to contain them. This needs to be accounted for in
> any changes touching CPU topology related code.
>

That's great.

>
>>
>>
>>>
>>> I believe the proper way to deal with this is to provide per-CPU property
>>> in
>>> DT called "samsung,pmu-offset" that could be used be code like this to
>>> calculate register addresses properly.
>>>
>>> For now, I would recommend doing the above ignoring cluster ID completely
>>> to
>>> not break (and actually fix) single cluster systems and existing multi
>>> cluster ones on which only the first cluster is supported now.
>>>
>>> After that, per-CPU PMU offset should be implemented to support
>>> multi-cluster SoCs with proper support of multiple clusters.
>>
>>
>> As of now the smp-boot (cores > 2) is broken. This is required to fix it.
>
>
> SMP boot works fine on all four cores of Exynos 4412. Obiously hot-(un)plug
> doesn't, but this is another issue.
>

It works as of now as at power on all the cores powered on. Hence the
powerOn in platsmp.c doent make any difference,  It breaks in hotplug
as we always poweron cpu1, not the correct cpu.

> Best regards,
> Tomasz



-- 
with warm regards,
Chander Kashyap
