From: parkch98@gmail.com (Chanho Park)
Date: Thu, 16 Jul 2015 10:36:21 +0900
Subject: [RFC] ARM: EXYNOS: reset KFC cores when cpu is up
In-Reply-To: <CAJKOXPdcdREhwQZ22RcqbUSTpOn0XmqJ_3n5uUyzEgPihRYwNQ@mail.gmail.com>
References: <1436924213-29732-1-git-send-email-parkch98@gmail.com>
 <CAJKOXPdcdREhwQZ22RcqbUSTpOn0XmqJ_3n5uUyzEgPihRYwNQ@mail.gmail.com>
Message-ID: <CAPTzV17TRxTXKSucMWEk-5k6TtYsXkO0XFuuaCXKgNc2AoGQjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 15, 2015 at 8:35 PM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> 2015-07-15 10:36 GMT+09:00 Chanho Park <parkch98@gmail.com>:
>> The cpu booting of exynos5422 has been still broken since we discussed
>> it in last year[1]. I found this resetting codes from odroid-xu3 kernel of
>> hardkernel, it could help to boot 8 cores well. This patch need to have
>> more test like STR and other SoC especially exynos5800 which is variant
>> of exynos5422. If this patch is broken on exynos5800, I'll find another
>> way to check exynos5422.
>>
>> This patch is top of my previous exynos5422 cpu ordering patch[2] and
>> need to enable CONFIG_EXYNOS5420_MCPM=y
>>
>> [    0.047509] CPU0: update cpu_capacity 448
>> [    0.047534] CPU0: thread -1, cpu 0, socket 1, mpidr 80000100
>> [    0.047874] Setting up static identity map for 0x400082c0 -
>> 0x40008318
>> [    0.048340] ARM CCI driver probed
>> [    0.048597] Exynos MCPM support installed
>> [    0.065676] CPU1: update cpu_capacity 448
>> [    0.065685] CPU1: thread -1, cpu 1, socket 1, mpidr 80000101
>> [    0.070672] CPU2: update cpu_capacity 448
>> [    0.070680] CPU2: thread -1, cpu 2, socket 1, mpidr 80000102
>> [    0.075644] CPU3: update cpu_capacity 448
>> [    0.075653] CPU3: thread -1, cpu 3, socket 1, mpidr 80000103
>> [    0.080590] CPU4: update cpu_capacity 1535
>> [    0.080600] CPU4: thread -1, cpu 0, socket 0, mpidr 80000000
>> [    0.085591] CPU5: update cpu_capacity 1535
>> [    0.085599] CPU5: thread -1, cpu 1, socket 0, mpidr 80000001
>> [    0.090590] CPU6: update cpu_capacity 1535
>> [    0.090598] CPU6: thread -1, cpu 2, socket 0, mpidr 80000002
>> [    0.095585] CPU7: update cpu_capacity 1535
>> [    0.095593] CPU7: thread -1, cpu 3, socket 0, mpidr 80000003
>> [    0.095720] Brought up 8 CPUs
>>
>> [1]:http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/350632.html
>> [2]:https://patchwork.kernel.org/patch/6782891/
>
> Few questions/issues:
> 1. For the proper patch the commit message needs to be fixed a little.
> The dmesg above is meaningless but instead you can put short dmesg (2
> or 4 lines) with failed booting of CPUs.

They will be gone when I make a official patch.

> 2. Why only MCPM? Isn't this also needed without MCPM?

Current exynos platsmp is not aware multi clusters. MCPM covered
secondary cpu booting of exynos big.Little cores. Without MCPM, same
approach and codes will be required on platsmp thus I think it's
redundant.

>
>>
>> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
>> Cc: Chanwoo Choi <cw00.choi@samsung.com>
>> Cc: Kevin Hilman <khilman@kernel.org>
>> Cc: Heesub Shin <heesub.shin@samsung.com>
>> Cc: Mauro Ribeiro <mauro.ribeiro@hardkernel.com>
>> Cc: Abhilash Kesavan <a.kesavan@samsung.com>
>> Cc: Przemyslaw Marczak <p.marczak@samsung.com>
>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
>> Signed-off-by: Chanho Park <parkch98@gmail.com>
>
> I think both Chanho Parks are the same person :) so you may leave only
> one (the one matching "From").
>
>> ---
>>  arch/arm/mach-exynos/mcpm-exynos.c | 13 ++++++++++++-
>>  arch/arm/mach-exynos/regs-pmu.h    |  6 ++++++
>>  2 files changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
>> index 9bdf547..a076dde 100644
>> --- a/arch/arm/mach-exynos/mcpm-exynos.c
>> +++ b/arch/arm/mach-exynos/mcpm-exynos.c
>> @@ -70,7 +70,18 @@ static int exynos_cpu_powerup(unsigned int cpu, unsigned int cluster)
>>                 cluster >= EXYNOS5420_NR_CLUSTERS)
>>                 return -EINVAL;
>>
>> -       exynos_cpu_power_up(cpunr);
>> +       if (!exynos_cpu_power_state(cpunr)) {
>> +               exynos_cpu_power_up(cpunr);
>
> This second exynos_cpu_power_up() is needed? Do you know why?

It's redirected to exynos's platsmp and it turned on CPU through pmu registers.
 -> exynos_cpu_powerup: mcpm-exynos.c
 -> exynos_cpu_power_up: platsmp.c

Current mcpm exynos tried to run exynos_cpu_power_up twice during
secondary cpu is up. The first is from cpu_power_up of mcpm and the
second is from cpu_is_up. I want to avoid second power up the cpu if
it already turned on.

static void exynos_cpu_is_up(unsigned int cpu, unsigned int cluster)
{
        /* especially when resuming: make sure power control is set */

        exynos_cpu_powerup(cpu, cluster);
}


>
>> +
>> +               if (soc_is_exynos5800() && cluster) {
>
> If of_machine_is_compatible() can be used then please use it. Javier
> also mentioned it and he pointed that this is not necessary on
> Chromebooks.

Okay. I'll use of_machine_is_compatible() instead of soc_is_exynos5800
to avoid running it from exynos5800.

>
>> +                       while (!pmu_raw_readl(S5P_PMU_SPARE2))
>> +                               udelay(10);
>> +
>> +                       pmu_raw_writel(EXYNOS5420_KFC_CORE_RESET(cpu),
>> +                                       EXYNOS_SWRESET);
>
> This is quite similar to existing exynos_core_restart(). Can you
> extend it for this purpose? Or at least put it as separate function
> near exynos_core_restart() so this would be grouped close to each
> other?

As I said above, the platsmp is not aware multi clusters. I feel like
it would be dirty if I try to merge them.

>
> Documenting this behaviour would be really nice (you can combine some
> of my findings on SPARE2 from previous discussion, if they are useful
> of course).

No one knows exactly why we should wait until SPARE2 is up. I'll
specify known issue of it with your findings.

-- 
Best Regards,
Chanho Park
