From: sajjan.linux@gmail.com (Vikas Sajjan)
Date: Tue, 31 Dec 2013 11:36:00 +0530
Subject: [PATCH 1/2] ARM: EXYNOS: Add initial support of PMU for Exynos5260
In-Reply-To: <1444734.3v3eaRdrvl@amdc1227>
References: <1386758416-31065-1-git-send-email-vikas.sajjan@linaro.org>
 <1386758416-31065-2-git-send-email-vikas.sajjan@linaro.org>
 <1444734.3v3eaRdrvl@amdc1227>
Message-ID: <CAGm_ybj0+j1=OftDBrq+kvYiG7W+vQqo+oALSyTJ++MD5RpfCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Wed, Dec 18, 2013 at 10:05 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Vikas, Pankaj,
>
> On Wednesday 11 of December 2013 16:25:15 Vikas Sajjan wrote:
>> Adds initial PMU support for Exynos5260
>>
>> Following are the changes done
>> ------------------------------
>>
>> 1) Added initial PMU support for exynos5260
>>
>> 2) Added exynos5260_iodesc for mapping 5260 specific SFRs. We modified
>> exynos5_map_io so that in case of exynos5260 only exynos5260_iodesc can
>> be initialized.
>>
>> 3) Added new macros for WAKEUP MASK for 5260, and modified exynos_pm_drvinit
>> accrodingly.
>>
>> Change-Id: Ie585d47a499c17813cfe0e5a668072ca7b13ffb5
>
> This line should be removed.


Yeah, right.


>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
>> ---
>>  arch/arm/mach-exynos/common.c                |  89 ++++++++++-
>>  arch/arm/mach-exynos/common.h                |   5 +
>>  arch/arm/mach-exynos/include/mach/map.h      |  17 +++
>>  arch/arm/mach-exynos/include/mach/regs-pmu.h | 221 +++++++++++++++++++++++++++
>>  arch/arm/mach-exynos/pm.c                    |  33 +++-
>>  arch/arm/mach-exynos/pmu.c                   | 140 +++++++++++++++++
>>  arch/arm/plat-samsung/include/plat/map-s5p.h |  14 ++
>>  7 files changed, 508 insertions(+), 11 deletions(-)
> [snip]
>> +     }, {
>> +             .virtual        = (unsigned long)S5P_VA_SROMC,
>> +             .pfn            = __phys_to_pfn(EXYNOS5260_PA_SROMC),
>> +             .length         = SZ_4K,
>> +             .type           = MT_DEVICE,
>> +     }, {
>> +             .virtual        = (unsigned long)S5P_VA_SYSRAM,
>> +             .pfn            = __phys_to_pfn(EXYNOS5_PA_SYSRAM),
>> +             .length         = SZ_4K,
>> +             .type           = MT_DEVICE,
>> +     }, {
>>               .virtual        = (unsigned long)S5P_VA_SYSRAM_NS,
>>               .pfn            = __phys_to_pfn(EXYNOS5260_PA_SYSRAM_NS),
>>               .length         = SZ_4K,
>>               .type           = MT_DEVICE,
>> +     }, {
>> +             .virtual        = (unsigned long)S5P_VA_PMU,
>> +             .pfn            = __phys_to_pfn(EXYNOS5260_PA_PMU),
>> +             .length         = SZ_64K,
>> +             .type           = MT_DEVICE,
>>       },
>
> Do you really need all these static mappings above? Why can't you create
> a mapping dynamically?

Sure, will keep only required static mapping like PMU.


>
>>  };
>>
> [snip]
>>  struct bus_type exynos_subsys = {
>> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
>> index ff9b6a9..e2cabfe 100644
>> --- a/arch/arm/mach-exynos/common.h
>> +++ b/arch/arm/mach-exynos/common.h
>> @@ -47,6 +47,11 @@ enum sys_powerdown {
>>       NUM_SYS_POWERDOWN,
>>  };
>>
>> +enum running_cpu {
>> +     KFC,
>> +     ARM,
>> +};
>
> This isn't too meaningful. You should write a comment saying how this enum
> is used and describing its values.
>
> Also the name is too generic. It should be prefixed with exynos5260_
> probably.


Sure, will modify it as EXYNOS5_KFC and EXYNOS5_ARM, so that it can be
used by 5420 also, if needed.


>
>> +
>>  extern unsigned long l2x0_regs_phys;
>>  struct exynos_pmu_conf {
>>       void __iomem *reg;
>> diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
>> index bd6fa02..cc190b9 100644
>> --- a/arch/arm/mach-exynos/include/mach/map.h
>> +++ b/arch/arm/mach-exynos/include/mach/map.h
>> @@ -31,6 +31,23 @@
>>  #define EXYNOS5250_PA_SYSRAM_NS              0x0204F000
>>  #define EXYNOS5260_PA_SYSRAM_NS              0x02073000
>>
>> +#define EXYNOS5260_PA_PMU                            0x10D50000
>> +#define EXYNOS5260_PA_SROMC                          0x12180000
>> +#define EXYNOS5260_PA_PWM                            0x12D90000
>> +
>> +#define EXYNOS5260_PA_SYS_PERI                               0x10220000
>> +#define EXYNOS5260_PA_SYS_MIF                                0x10D00000
>> +#define EXYNOS5260_PA_SYS_MFC                                0x110A0000
>> +#define EXYNOS5260_PA_SYS_KFC                                0x10710000
>> +#define EXYNOS5260_PA_SYS_ISP                                0x133E0000
>> +#define EXYNOS5260_PA_SYS_GSCL                               0x13F20000
>> +#define EXYNOS5260_PA_SYS_G3D                                0x11850000
>> +#define EXYNOS5260_PA_SYS_G2D                                0x10A20000
>> +#define EXYNOS5260_PA_SYS_FSYS                               0x122F0000
>> +#define EXYNOS5260_PA_SYS_EGL                                0x10610000
>> +#define EXYNOS5260_PA_SYS_DISP                               0x14540000
>> +#define EXYNOS5260_PA_SYS_AUD                                0x128F0000
>> +
>
> Do you really need all the static addresses above?

Will remove them.


>
>>  #define EXYNOS_PA_CHIPID             0x10000000
>>
>>  #define EXYNOS4_PA_SYSCON            0x10010000
>> diff --git a/arch/arm/mach-exynos/include/mach/regs-pmu.h b/arch/arm/mach-exynos/include/mach/regs-pmu.h
>> index 09ae29a..ac53f85 100644
>> --- a/arch/arm/mach-exynos/include/mach/regs-pmu.h
>> +++ b/arch/arm/mach-exynos/include/mach/regs-pmu.h
>> @@ -125,6 +125,25 @@
>>  #define S5P_ARM_CORE1_STATUS                 S5P_PMUREG(0x2084)
>>  #define S5P_ARM_CORE1_OPTION                 S5P_PMUREG(0x2088)
> [snip]
>> +#define EXYNOS5260_CORE_LOCAL_PWR_EN                         0xf
>> +#define EXYNOS5260_CPUS_PER_CLUSTER                          4
>> +#define EXYNOS5260_USE_DELAYED_RESET_ASSERTION                       (1 << 12)
>> +
>> +#define EXYNOS5260_WAKEUP_STAT2                      S5P_PMUREG(0x0604)
>> +#define EXYNOS5260_WAKEUP_STAT3                      S5P_PMUREG(0x0608)
>> +#define EXYNOS5260_EINT_WAKEUP_MASK          S5P_PMUREG(0x060C)
>> +#define EXYNOS5260_WAKEUP_MASK                       S5P_PMUREG(0x0610)
>> +#define EXYNOS5260_WAKEUP_MASK2                      S5P_PMUREG(0x0614)
>> +#define EXYNOS5260_WAKEUP_MASK3                      S5P_PMUREG(0x0618)
>> +
>> +
>> +/* Exynos5260 specific PMU SYS_PWR_REGs */
>> +#define      EXYNOS5260_A15_EGL0_SYS_PWR_REG                 S5P_PMUREG(0x1000)
>
> CodingStyle: There should be just one space between #define and definiton
> name. The same for a lot of definitons below.

OK.

>
>> +#define      EXYNOS5260_DIS_IRQ_A15_EGL0_LOCAL_SYS_PWR_REG   S5P_PMUREG(0x1004)
>> +#define      EXYNOS5260_DIS_IRQ_A15_EGL0_CNTRL_SYS_PWR_REG   S5P_PMUREG(0x1008)
>> +#define      EXYNOS5260_DIS_IRQ_A15_EGL0_EGLSEQ_SYS_PWR_REG  S5P_PMUREG(0x100C)
>> +#define      EXYNOS5260_A15_EGL1_SYS_PWR_REG                 S5P_PMUREG(0x1010)
> [snip]
>> +/* CENTRAL_SEQ_OPTION */
>> +#define EXYNOS5260_ARM_USE_STANDBY_WFI0                      (1 << 16)
>> +#define EXYNOS5260_ARM_USE_STANDBY_WFI1                      (1 << 17)
>> +#define EXYNOS5260_KFC_USE_STANDBY_WFI0                      (1 << 20)
>> +#define EXYNOS5260_KFC_USE_STANDBY_WFI1                      (1 << 21)
>> +#define EXYNOS5260_KFC_USE_STANDBY_WFI2                      (1 << 22)
>> +#define EXYNOS5260_KFC_USE_STANDBY_WFI3                      (1 << 23)
>> +#define EXYNOS5260_ARM_USE_STANDBY_WFE0                      (1 << 24)
>> +#define EXYNOS5260_ARM_USE_STANDBY_WFE1                      (1 << 25)
>> +#define EXYNOS5260_KFC_USE_STANDBY_WFE0                      (1 << 28)
>> +#define EXYNOS5260_KFC_USE_STANDBY_WFE1                      (1 << 29)
>> +#define EXYNOS5260_KFC_USE_STANDBY_WFE2                      (1 << 30)
>> +#define EXYNOS5260_KFC_USE_STANDBY_WFE3                      (1 << 31)
>> +
>> +#define EXYNOS5260_USE_STANDBY_WFI_ALL       (EXYNOS5260_ARM_USE_STANDBY_WFI0  \
>> +                                     | EXYNOS5260_ARM_USE_STANDBY_WFI1  \
>> +                                     | EXYNOS5260_KFC_USE_STANDBY_WFI0  \
>> +                                     | EXYNOS5260_KFC_USE_STANDBY_WFI1  \
>> +                                     | EXYNOS5260_KFC_USE_STANDBY_WFI2  \
>> +                                     | EXYNOS5260_KFC_USE_STANDBY_WFI3)
>
> This is not a definition of registers, so should be present in the file
> using it as a convenience macro.

OK.


>
>> +
>> +
>>  #endif /* __ASM_ARCH_REGS_PMU_H */
>> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
>> index 78a22bf..c6def953 100644
>> --- a/arch/arm/mach-exynos/pm.c
>> +++ b/arch/arm/mach-exynos/pm.c
>> @@ -58,7 +58,7 @@ static int exynos_cpu_suspend(unsigned long arg)
>>       outer_flush_all();
>>  #endif
> [snip]
>>       /* Setting SEQ_OPTION register */
>> +     if (soc_is_exynos5250()) {
>> +             tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
>> +             __raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
>> +     } else if (soc_is_exynos5260()) {
>> +             cluster_id = (read_cpuid(CPUID_MPIDR) >> 8) & 0xf;
>> +             if (!cluster_id)
>> +                     __raw_writel(EXYNOS5260_ARM_USE_STANDBY_WFI0,
>> +                                  S5P_CENTRAL_SEQ_OPTION);
>> +             else
>> +                     __raw_writel(EXYNOS5260_KFC_USE_STANDBY_WFI0,
>> +                                  S5P_CENTRAL_SEQ_OPTION);
>
> Hmm, this seems strange. Shouldn't just a single particular CPU (CPU0 most
> likely) be allowed to enter standby such as the code for other Exynos SoCs
> is doing?

We need to handle the case where the primary CPU can be KFC also.

>
>>
>> -     tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
>> -     __raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
>> +     }
>>
>> -     if (!soc_is_exynos5250()) {
>> +     if (!soc_is_exynos5250() || !soc_is_exynos5260()) {
>
> Is this condition really correct? It doesn't make much sense.

Will modify.


>
>>               /* Save Power control register */
>>               asm ("mrc p15, 0, %0, c15, c0, 0"
>>                    : "=r" (tmp) : : "cc");
>> @@ -174,7 +191,7 @@ static void exynos_pm_resume(void)
>>               /* No need to perform below restore code */
>>               goto early_wakeup;
>>       }
>> -     if (!soc_is_exynos5250()) {
>> +     if (!soc_is_exynos5250() || !soc_is_exynos5260()) {
>
> Ditto.

Will modify.


>
>>               /* Restore Power control register */
>>               tmp = save_arm_register[0];
>>               asm volatile ("mcr p15, 0, %0, c15, c0, 0"
>> diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
>> index 97d6885..c828d07 100644
>> --- a/arch/arm/mach-exynos/pmu.c
>> +++ b/arch/arm/mach-exynos/pmu.c
>> @@ -317,6 +317,99 @@ static struct exynos_pmu_conf exynos5250_pmu_config[] = {
>>       { PMU_TABLE_END,},
>>  };
> [snip]
>> +static void exynos5260_reset_assert_ctrl(bool on, enum running_cpu cluster)
>> +{
>> +     unsigned int i;
>> +     unsigned int option;
>> +     unsigned int cpu_s, cpu_f;
>> +
>> +     if (cluster == KFC) {
>> +             cpu_s = EXYNOS5260_CPUS_PER_CLUSTER;
>> +             cpu_f = cpu_s + EXYNOS5260_CPUS_PER_CLUSTER;
>> +     } else {
>> +             cpu_s = 0;
>> +             cpu_f = 2;
>
> Hmm, a magic number. I wonder what it means. It doesn't seem to be the
> Answer to the Ultimate Question of Life, The Universe, and Everything,
> though. ;)


:-) Will modify.



>
> [1] http://en.wikipedia.org/wiki/Phrases_from_The_Hitchhiker's_Guide_to_the_Galaxy#Answer_to_the_Ultimate_Question_of_Life.2C_the_Universe.2C_and_Everything_.2842.29
>
>> +     }
>> +
>> +     for (i = cpu_s; i < cpu_f; i++) {
>> +             option = __raw_readl(EXYNOS_ARM_CORE_OPTION(i));
>> +             option = on ?
>> +             (option | EXYNOS5260_USE_DELAYED_RESET_ASSERTION) :
>> +                     (option & ~EXYNOS5260_USE_DELAYED_RESET_ASSERTION);
>
> Readability of this is quite poor. I'd recommend rewriting this to
> a simple


Sure.


>
>                 if (on)
>                         option |= EXYNOS5260_USE_DELAYED_RESET_ASSERTION;
>                 else
>                         option &= ~EXYNOS5260_USE_DELAYED_RESET_ASSERTION;
>
>> +             __raw_writel(option, EXYNOS_ARM_CORE_OPTION(i));
>> +     }
>> +}
>> +
>> +
>>  static int __init exynos_pmu_init(void)
>>  {
>>       unsigned int value;
>> @@ -415,6 +532,29 @@ static int __init exynos_pmu_init(void)
>>
>>               exynos_pmu_config = exynos5250_pmu_config;
>>               pr_info("EXYNOS5250 PMU Initialize\n");
>> +     } else if (soc_is_exynos5260()) {
>> +             /* Enable USE_STANDBY_WFI for all CORE */
>> +             __raw_writel(EXYNOS5260_USE_STANDBY_WFI_ALL,
>> +                     S5P_CENTRAL_SEQ_OPTION);
>> +             /*
>> +              * Set PSHOLD port for output high
>> +              */
>> +             value = __raw_readl(EXYNOS_PS_HOLD_CONTROL);
>> +             value |= EXYNOS_PS_HOLD_OUTPUT_HIGH;
>> +             __raw_writel(value, EXYNOS_PS_HOLD_CONTROL);
>> +
>> +             /*
>> +              * Enable signal for PSHOLD port
>> +              */
>> +             value = __raw_readl(EXYNOS_PS_HOLD_CONTROL);
>> +             value |= EXYNOS_PS_HOLD_EN;
>> +             __raw_writel(value, EXYNOS_PS_HOLD_CONTROL);
>
> Hmm, do you really need this? What about boards with different polarity
> of power hold signal in used PMIC? I believe this should be set correctly
> by the bootloader and never changed later, except in power off callback.

Right, can be removed.


>
> Best regards,
> Tomasz
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
