From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Thu, 3 Jul 2014 20:16:00 +0530
Subject: [RFC PATCH v4] ARM: EXYNOS: Use MCPM call-backs to support S2R on
 Exynos5420
In-Reply-To: <alpine.LFD.2.11.1407030912210.6220@knanqh.ubzr>
References: <1404313142-1278-1-git-send-email-a.kesavan@samsung.com>
 <1404363737-26222-1-git-send-email-a.kesavan@samsung.com>
 <alpine.LFD.2.11.1407030912210.6220@knanqh.ubzr>
Message-ID: <CAM4voa=VYGhyKEOQ6_XjriXE1rR3vxowt=cYsaoqeJw9Un=3sQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Thu, Jul 3, 2014 at 6:59 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Thu, 3 Jul 2014, Abhilash Kesavan wrote:
>
>> Use the MCPM layer to handle core suspend/resume on Exynos5420.
>> Also, restore the entry address setup code post-resume.
>>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> ---
>> Changes in v2:
>>       - Made use of the MCPM suspend/powered_up call-backs
>> Changes in v3:
>>       - Used the residency value to indicate the entered state
>> Changes in v4:
>>       - Checked if MCPM has been enabled to prevent build error
>>
>> This has been tested both on an SMDK5420 and Peach Pit Chromebook on
>> 3.16-rc3/next-20140702.
>>
>> Here are the dependencies (some of these patches did not apply cleanly):
>> 1) Cleanup patches for mach-exynos
>> http://comments.gmane.org/gmane.linux.kernel.samsung-soc/33772
>>
>> 2) PMU cleanup and refactoring for using DT
>> https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg671625.html
>>
>> 3) Exynos5420 PMU/S2R Series
>> http://comments.gmane.org/gmane.linux.kernel.samsung-soc/33898
>>
>> 4) MCPM boot CPU CCI enablement patches
>> www.spinics.net/lists/linux-samsung-soc/msg32923.html
>>
>> 5) Exynos5420 CPUIdle Series which populates MCPM suspend/powered_up
>> call-backs.
>> www.gossamer-threads.com/lists/linux/kernel/1945347
>> https://patchwork.kernel.org/patch/4357461/
>>
>> 6) Exynos5420 MCPM cluster power down support
>> http://www.spinics.net/lists/arm-kernel/msg339988.html
>>
>> 7) TPM reset mask patch
>> http://www.spinics.net/lists/arm-kernel/msg341884.html
>>
>>  arch/arm/include/asm/mcpm.h          |    6 ++++
>>  arch/arm/mach-exynos/mcpm-exynos.c   |   50 ++++++++++++++++++++++++----------
>>  arch/arm/mach-exynos/pm.c            |   38 ++++++++++++++++++++++++--
>>  arch/arm/mach-exynos/regs-pmu.h      |    1 +
>>  drivers/cpuidle/cpuidle-big_little.c |    2 +-
>>  5 files changed, 79 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/mcpm.h b/arch/arm/include/asm/mcpm.h
>> index ff73aff..051fbf1 100644
>> --- a/arch/arm/include/asm/mcpm.h
>> +++ b/arch/arm/include/asm/mcpm.h
>> @@ -272,4 +272,10 @@ void __init mcpm_smp_set_ops(void);
>>  #define MCPM_SYNC_CLUSTER_SIZE \
>>       (MCPM_SYNC_CLUSTER_INBOUND + __CACHE_WRITEBACK_GRANULE)
>>
>> +/* Definitions for various MCPM scenarios that might need special handling */
>> +#define MCPM_CPU_IDLE                0x0
>> +#define MCPM_CPU_SUSPEND     0x1
>> +#define MCPM_CPU_SWITCH              0x2
>> +#define MCPM_CPU_HOTPLUG     0x3
>
> Please, let's avoid going that route.  There is no such special handling
> needed if the API is sufficient.  And the provided API allows you to
> suspend a CPU or shut it down.  It shouldn't matter at that level if
> this is due to a cluster switch or a hotplug event. Do you really need
> something else?
No, just one local flag for suspend should be enough for me. Will remove these.
>
> [...]
>> @@ -129,7 +132,7 @@ static int exynos_power_up(unsigned int cpu, unsigned int cluster)
>>   * and can only be executed on processors like A15 and A7 that hit the cache
>>   * with the C bit clear in the SCTLR register.
>>   */
>> -static void exynos_power_down(void)
>> +static void exynos_mcpm_power_down(u64 residency)
>>  {
>>       unsigned int mpidr, cpu, cluster;
>>       bool last_man = false, skip_wfi = false;
>> @@ -150,7 +153,12 @@ static void exynos_power_down(void)
>>       BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
>>       cpu_use_count[cpu][cluster]--;
>>       if (cpu_use_count[cpu][cluster] == 0) {
>> -             exynos_cpu_power_down(cpunr);
>> +             /*
>> +              * Bypass power down for CPU0 during suspend. This is being
>> +              * taken care by the SYS_PWR_CFG bit in CORE0_SYS_PWR_REG.
>> +              */
>> +             if ((cpunr != 0) || (residency != MCPM_CPU_SUSPEND))
>> +                     exynos_cpu_power_down(cpunr);
>>
>>               if (exynos_cluster_unused(cluster)) {
>>                       exynos_cluster_power_down(cluster);
>> @@ -209,6 +217,11 @@ static void exynos_power_down(void)
>>       /* Not dead at this point?  Let our caller cope. */
>>  }
>>
>> +static void exynos_power_down(void)
>> +{
>> +     exynos_mcpm_power_down(MCPM_CPU_SWITCH | MCPM_CPU_HOTPLUG);
>> +}
>
> To distinguish between a suspend and a power-down, you can simply use
> exynos_power_down() as your common handler, and have
> exynos_mcpm_power_down() and exynos_mcpm_suspend() as wrappers around it
> passing the appropriate private flags with local meanings.
My patch is in line with your explanation, except it makes use of the
new MCPM flags. I will clean those out and just use one flag for
suspend instead. Please check the v5 patch that I will post in a bit
in case I have missed something.

Regards,
Abhilash
>
>
> Nicolas
>
