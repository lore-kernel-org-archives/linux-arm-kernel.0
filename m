From: sajjan.linux@gmail.com (Vikas Sajjan)
Date: Wed, 16 Apr 2014 11:04:15 +0530
Subject: [PATCH v2 2/3] ARM: EXYNOS: Add initial support of PMU for
 Exynos5260
In-Reply-To: <534D7BAB.30503@gmail.com>
References: <1395061795-17777-1-git-send-email-vikas.sajjan@samsung.com>
 <1395061795-17777-3-git-send-email-vikas.sajjan@samsung.com>
 <534D7BAB.30503@gmail.com>
Message-ID: <CAGm_ybhzQLbK8K5mj0WK8ww61PqurumkwkHqah2=5v-=VACJzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Wed, Apr 16, 2014 at 12:04 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Vikas,
>
>
> On 17.03.2014 14:09, Vikas Sajjan wrote:
>>
>> Adds PMU support of PMU for Exynos5260. Suspend-to-RAM can be built on
>> top this.
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
>> ---
>>   arch/arm/mach-exynos/common.h            |   26 ++++
>>   arch/arm/mach-exynos/pm.c                |   34 +++--
>>   arch/arm/mach-exynos/pmu.c               |  238
>> ++++++++++++++++++++++++++++++
>>   arch/arm/mach-exynos/regs-pmu.h          |  232
>> +++++++++++++++++++++++++++++
>>   arch/arm/plat-samsung/include/plat/cpu.h |    8 +
>>   5 files changed, 529 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
>> index aba6a2a..a17f701 100644
>> --- a/arch/arm/mach-exynos/common.h
>> +++ b/arch/arm/mach-exynos/common.h
>> @@ -56,6 +56,32 @@ enum sys_powerdown {
>>         NUM_SYS_POWERDOWN,
>>   };
>>
>> +enum running_cpu {
>> +       EXYNOS5_KFC,
>> +       EXYNOS5_ARM,
>> +};
>> +
>> +enum reg_op {
>> +       REG_INIT,       /* write new value */
>> +       REG_RESET,      /* clear with zero */
>> +       REG_SET,        /* bit set */
>> +       REG_CLEAR,      /* bit clear */
>> +};
>> +
>> +/* reg/value set */
>> +#define EXYNOS_PMU_REG(REG, VAL, OP)           \
>> +{                                              \
>> +       .reg    =       (void __iomem *)REG,    \
>> +       .val    =       VAL,                    \
>> +       .op     =       OP,                     \
>> +}
>> +
>> +struct exynos_pmu_init_reg {
>> +       void __iomem *reg;
>> +       unsigned int val;
>> +       enum reg_op op;
>> +};
>> +
>>   extern unsigned long l2x0_regs_phys;
>>   struct exynos_pmu_conf {
>>         void __iomem *reg;
>> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
>> index 15af0ce..dbe9670 100644
>> --- a/arch/arm/mach-exynos/pm.c
>> +++ b/arch/arm/mach-exynos/pm.c
>> @@ -109,7 +109,7 @@ static int exynos_cpu_suspend(unsigned long arg)
>>         outer_flush_all();
>>   #endif
>>
>> -       if (soc_is_exynos5250())
>> +       if (soc_is_exynos5250() || soc_is_exynos5260())
>>                 flush_cache_all();
>
>
> I think it's the right time for this code to be restructured. Adding more
> and more SoCs over this cruft is making this code worse and worse.
>

 I recently came across RFC [1] posted by pankaj on similar lines, did
you get a chance to have look at this series.

[1] https://lkml.org/lkml/2014/4/2/69


> I believe this should be done as follows:
>
>  - a generic struct describing particular PMU variant should be defined,
> with things like
>
>         bool flush_cache_on_suspend;
>         struct exynos_pmu_conf *pmu_conf;
>
> or even function pointers, like
>
>         void (*cpu_suspend)(unsigned long arg);
>
> to handle things done currently using soc_is_*() macros, which we should get
> rid of.
>
> - a DT match table would bind particular compatible strings with respective
> PMU variants structs,
>
> - in general, this code should be made more like a normal driver, e.g. bind
> to a DT node and map registers dynamically.
>
> Best regards,
> Tomasz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
