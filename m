From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Sat, 21 Dec 2013 12:48:40 +0530
Subject: [PATCH 1/2] ARM: EXYNOS: Support Suspend-to-RAM on EXYNOS5420
In-Reply-To: <5028127.MZKgFYSMAv@flatron>
References: <1387195271-3613-1-git-send-email-a.kesavan@samsung.com>
 <5028127.MZKgFYSMAv@flatron>
Message-ID: <CAM4voakHNL7mJzVYOfYUuUfA82CAm8TyoWinWYwdoWcOrMZWBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Sat, Dec 21, 2013 at 3:07 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Abhilash,
>
> Please see my comments inline.
>
> On Monday 16 of December 2013 17:31:10 Abhilash Kesavan wrote:
>> Add PMU configuration table for various low power modes - AFTR/LPA/SLEEP.
>> Also, add core s2r support for Exynos5420.
>>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> ---
>> This patch depends on "ARM: EXYNOS5: Add PMU settings for exynos5420"
>> http://www.spinics.net/lists/linux-samsung-soc/msg24902.html
>>
>>  arch/arm/mach-exynos/include/mach/regs-clock.h |   15 +++
>>  arch/arm/mach-exynos/include/mach/regs-pmu.h   |   84 ++++++++++++
>>  arch/arm/mach-exynos/pm.c                      |  151 +++++++++++++++++++---
>>  arch/arm/mach-exynos/pmu.c                     |  165 ++++++++++++++++++++++++
>>  4 files changed, 396 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/include/mach/regs-clock.h b/arch/arm/mach-exynos/include/mach/regs-clock.h
>> index d36ad76..20008f6 100644
>> --- a/arch/arm/mach-exynos/include/mach/regs-clock.h
>> +++ b/arch/arm/mach-exynos/include/mach/regs-clock.h
>> @@ -363,6 +363,21 @@
>>  #define PWR_CTRL2_CORE2_UP_RATIO             (1 << 4)
>>  #define PWR_CTRL2_CORE1_UP_RATIO             (1 << 0)
>>
>> +/* For EXYNOS5420 */
>> +#define EXYNOS5420_CLKSRC_MASK_CPERI         EXYNOS_CLKREG(0x04300)
>> +#define EXYNOS5420_CLKSRC_MASK_TOP0          EXYNOS_CLKREG(0x10300)
>> +#define EXYNOS5420_CLKSRC_MASK_TOP1          EXYNOS_CLKREG(0x10304)
>> +#define EXYNOS5420_CLKSRC_MASK_TOP2          EXYNOS_CLKREG(0x10308)
>> +#define EXYNOS5420_CLKSRC_MASK_TOP7          EXYNOS_CLKREG(0x1031C)
>> +#define EXYNOS5420_CLKSRC_MASK_DISP10                EXYNOS_CLKREG(0x1032C)
>> +#define EXYNOS5420_CLKSRC_MASK_MAU           EXYNOS_CLKREG(0x10334)
>> +#define EXYNOS5420_CLKSRC_MASK_FSYS          EXYNOS_CLKREG(0x10340)
>> +#define EXYNOS5420_CLKSRC_MASK_PERIC0                EXYNOS_CLKREG(0x10350)
>> +#define EXYNOS5420_CLKSRC_MASK_PERIC1                EXYNOS_CLKREG(0x10354)
>> +#define EXYNOS5420_CLKSRC_MASK_ISP           EXYNOS_CLKREG(0x10370)
>> +#define EXYNOS5420_CLKGATE_BUS_DISP1         EXYNOS_CLKREG(0x10728)
>> +#define EXYNOS5420_CLKGATE_IP_PERIC          EXYNOS_CLKREG(0x10950)
>
> This looks suspicious. Let me see below if this is really needed for what
> I think it is.
>
>> +
>>  /* Compatibility defines and inclusion */
>>
>>  #include <mach/regs-pmu.h>
>> diff --git a/arch/arm/mach-exynos/include/mach/regs-pmu.h b/arch/arm/mach-exynos/include/mach/regs-pmu.h
>> index d5d5386..ad316f3 100644
>> --- a/arch/arm/mach-exynos/include/mach/regs-pmu.h
>> +++ b/arch/arm/mach-exynos/include/mach/regs-pmu.h
>> @@ -229,6 +229,7 @@
>>
>>  /* For EXYNOS5 */
>>
>> +#define EXYNOS5_SYS_DISP1_BLK_CFG                            S5P_SYSREG(0x0214)
>
> Is it really a definition common for all Exynos5 SoCs?

I do see the register in both 5250 and 5420 even though the bits differ.
>
>>  #define EXYNOS5_SYS_I2C_CFG                                  S5P_SYSREG(0x0234)
>>
>>  #define EXYNOS5_AUTO_WDTRESET_DISABLE                                S5P_PMUREG(0x0408)
>> @@ -360,6 +361,7 @@
>>  #define EXYNOS5_USE_SC_COUNTER                                       (1 << 0)
>>
>>  #define EXYNOS5_MANUAL_L2RSTDISABLE_CONTROL                  (1 << 2)
>> +#define EXYNOS5_L2RSTDISABLE_VALUE                           (1 << 3)
>
> Ditto.
No, I will make this 5420 specific.

>
>>  #define EXYNOS5_SKIP_DEACTIVATE_ACEACP_IN_PWDN                       (1 << 7)
>>
>>  #define EXYNOS5_OPTION_USE_STANDBYWFE                                (1 << 24)
> [snip]
>> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
>> index 7fb0f13..3ad103f 100644
>> --- a/arch/arm/mach-exynos/pm.c
>> +++ b/arch/arm/mach-exynos/pm.c
>> @@ -52,6 +52,22 @@ static const struct sleep_save exynos4210_set_clksrc[] = {
>>       { .reg = EXYNOS4210_CLKSRC_MASK_LCD1            , .val = 0x00001111, },
>>  };
>>
>> +static struct sleep_save exynos5420_set_clksrc[] = {
>> +     { .reg = EXYNOS5420_CLKSRC_MASK_CPERI,          .val = 0xffffffff, },
>> +     { .reg = EXYNOS5420_CLKSRC_MASK_TOP0,           .val = 0x11111111, },
>> +     { .reg = EXYNOS5420_CLKSRC_MASK_TOP1,           .val = 0x11101111, },
>> +     { .reg = EXYNOS5420_CLKSRC_MASK_TOP2,           .val = 0x11111110, },
>> +     { .reg = EXYNOS5420_CLKSRC_MASK_TOP7,           .val = 0x00111100, },
>> +     { .reg = EXYNOS5420_CLKSRC_MASK_DISP10,         .val = 0x11111110, },
>> +     { .reg = EXYNOS5420_CLKSRC_MASK_MAU,            .val = 0x10000000, },
>> +     { .reg = EXYNOS5420_CLKSRC_MASK_FSYS,           .val = 0x11111110, },
>> +     { .reg = EXYNOS5420_CLKSRC_MASK_PERIC0,         .val = 0x11111110, },
>> +     { .reg = EXYNOS5420_CLKSRC_MASK_PERIC1,         .val = 0x11111100, },
>> +     { .reg = EXYNOS5420_CLKSRC_MASK_ISP,            .val = 0x11111000, },
>> +     { .reg = EXYNOS5420_CLKGATE_BUS_DISP1,          .val = 0xffffffff, },
>> +     { .reg = EXYNOS5420_CLKGATE_IP_PERIC,           .val = 0xffffffff, },
>> +};
>> +
>
> OK, just as I thought...
>
> NAK. Clock registers should be accessed only inside clock driver. Please
> see my patch implementing similar thing for Exynos 4:
>
> http://thread.gmane.org/gmane.linux.kernel.samsung-soc/24078/focus=24087

I had not seen these changes, will re-base it on your changes.
>
>
>>  static struct sleep_save exynos4_epll_save[] = {
>>       SAVE_ITEM(EXYNOS4_EPLL_CON0),
>>       SAVE_ITEM(EXYNOS4_EPLL_CON1),
>> @@ -66,6 +82,14 @@ static struct sleep_save exynos5_sys_save[] = {
>>       SAVE_ITEM(EXYNOS5_SYS_I2C_CFG),
>>  };
>>
>> +static struct sleep_save exynos5420_sys_save[] = {
>> +     SAVE_ITEM(EXYNOS5_SYS_DISP1_BLK_CFG),
>> +};
>> +
>> +static struct sleep_save exynos5420_cpustate_save[] = {
>> +     SAVE_ITEM(S5P_VA_SYSRAM + 0x28),
>> +};
>> +
>>  static struct sleep_save exynos_core_save[] = {
>>       /* SROM side */
>>       SAVE_ITEM(S5P_SROM_BW),
>> @@ -84,8 +108,15 @@ static int exynos_cpu_suspend(unsigned long arg)
>>  #ifdef CONFIG_CACHE_L2X0
>>       outer_flush_all();
>>  #endif
>> +     /*
>> +      * Clear the IRAM register that holds a low power flag. The presence
>> +      * of this flag decides if the primary cpu starts executing the low
>> +      * power function at wake-up or not.
>> +      */
>> +     if (soc_is_exynos5420())
>> +             __raw_writel(0x0, S5P_VA_SYSRAM + 0x28);
>>
>> -     if (soc_is_exynos5250())
>> +     if (soc_is_exynos5250() || soc_is_exynos5420())
>>               flush_cache_all();
>>
>>       /* issue the standby signal into the pm unit. */
>> @@ -101,9 +132,14 @@ static void exynos_pm_prepare(void)
>>
>>       s3c_pm_do_save(exynos_core_save, ARRAY_SIZE(exynos_core_save));
>>
>> -     if (!soc_is_exynos5250()) {
>> +     if (!(soc_is_exynos5250() || soc_is_exynos5420())) {
>>               s3c_pm_do_save(exynos4_epll_save, ARRAY_SIZE(exynos4_epll_save));
>>               s3c_pm_do_save(exynos4_vpll_save, ARRAY_SIZE(exynos4_vpll_save));
>> +     } else if (soc_is_exynos5420()) {
>> +             s3c_pm_do_save(exynos5420_sys_save,
>> +                                     ARRAY_SIZE(exynos5420_sys_save));
>> +             s3c_pm_do_save(exynos5420_cpustate_save,
>> +                     ARRAY_SIZE(exynos5420_cpustate_save));
>>       } else {
>>               s3c_pm_do_save(exynos5_sys_save, ARRAY_SIZE(exynos5_sys_save));
>>               /* Disable USE_RETENTION of JPEG_MEM_OPTION */
>
> What about rewriting this code as follows:
>
>         if (soc_is_exynos5420()) {
>                 // exynos5420 specific code
>         } else if (soc_is_exynos5250()) {
>                 // exynos5250 specific code
>         } else {
>                 // exynos4 specific code
>         }
>
> Still, I'd prefer this to be based on top of my series I mentioned above
> which removes any clock handling from this file and so makes the exynos4
> branch above disappear.

OK..will re-base on your patches.
>
>> @@ -123,12 +159,32 @@ static void exynos_pm_prepare(void)
>>
>>       /* Before enter central sequence mode, clock src register have to set */
>>
>> -     if (!soc_is_exynos5250())
>> +     if (!(soc_is_exynos5250() || soc_is_exynos5420()))
>>               s3c_pm_do_restore_core(exynos4_set_clksrc, ARRAY_SIZE(exynos4_set_clksrc));
>>
>>       if (soc_is_exynos4210())
>>               s3c_pm_do_restore_core(exynos4210_set_clksrc, ARRAY_SIZE(exynos4210_set_clksrc));
>>
>> +     if (soc_is_exynos5420()) {
>> +             s3c_pm_do_restore_core(exynos5420_set_clksrc,
>> +                             ARRAY_SIZE(exynos5420_set_clksrc));
>> +
>> +             tmp = __raw_readl(EXYNOS5420_SFR_AXI_CGDIS1);
>> +             tmp |= EXYNOS5420_UFS;
>> +             __raw_writel(tmp, EXYNOS5420_SFR_AXI_CGDIS1);
>> +
>> +             tmp = __raw_readl(EXYNOS5420_ARM_COMMON_OPTION);
>> +             tmp &= ~EXYNOS5_L2RSTDISABLE_VALUE;
>> +             __raw_writel(tmp, EXYNOS5420_ARM_COMMON_OPTION);
>> +
>> +             tmp = __raw_readl(EXYNOS5420_FSYS2_OPTION);
>> +             tmp |= EXYNOS5420_EMULATION;
>> +             __raw_writel(tmp, EXYNOS5420_FSYS2_OPTION);
>> +
>> +             tmp = __raw_readl(EXYNOS5420_PSGEN_OPTION);
>> +             tmp |= EXYNOS5420_EMULATION;
>> +             __raw_writel(tmp, EXYNOS5420_PSGEN_OPTION);
>> +     }
>>  }
>>
>>  static int exynos_pm_add(struct device *dev, struct subsys_interface *sif)
>> @@ -224,11 +280,17 @@ static __init int exynos_pm_drvinit(void)
>>
>>       /* All wakeup disable */
>>
>> -     tmp = __raw_readl(S5P_WAKEUP_MASK);
>> -     tmp |= ((0xFF << 8) | (0x1F << 1));
>> -     __raw_writel(tmp, S5P_WAKEUP_MASK);
>> +     if (soc_is_exynos5420()) {
>> +             tmp = __raw_readl(S5P_WAKEUP_MASK);
>> +             tmp |= ((0x7F << 7) | (0x1F << 1));
>> +             __raw_writel(tmp, S5P_WAKEUP_MASK);
>> +     } else {
>> +             tmp = __raw_readl(S5P_WAKEUP_MASK);
>> +             tmp |= ((0xFF << 8) | (0x1F << 1));
>> +             __raw_writel(tmp, S5P_WAKEUP_MASK);
>> +     }
>>
>> -     if (!soc_is_exynos5250()) {
>> +     if (!(soc_is_exynos5250() || soc_is_exynos5420())) {
>>               pll_base = clk_get(NULL, "xtal");
>
> This code is also removed by my series.

Ok
>
>>
>>               if (!IS_ERR(pll_base)) {
>> @@ -244,6 +306,7 @@ arch_initcall(exynos_pm_drvinit);
>>  static int exynos_pm_suspend(void)
>>  {
>>       unsigned long tmp;
>> +     unsigned int cluster_id;
>>
>>       /* Setting Central Sequence Register for power down mode */
>>
>> @@ -253,10 +316,20 @@ static int exynos_pm_suspend(void)
>>
>>       /* Setting SEQ_OPTION register */
>>
>> -     tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
>> -     __raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
>> +     if (soc_is_exynos5420()) {
>> +             cluster_id = (read_cpuid(CPUID_MPIDR) >> 8) & 0xf;
>> +             if (!cluster_id)
>> +                     __raw_writel(EXYNOS5420_ARM_USE_STANDBY_WFI0,
>> +                                  S5P_CENTRAL_SEQ_OPTION);
>> +             else
>> +                     __raw_writel(EXYNOS5420_KFC_USE_STANDBY_WFI0,
>> +                                  S5P_CENTRAL_SEQ_OPTION);
>> +     } else if (soc_is_exynos5250()) {
>
> This code should be also called on other Exynos SoCs, not just 5250.

Yes, Bartlomiej caught this in an earlier review.
>
>> +             tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
>> +             __raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
>> +     }
>>
>> -     if (!soc_is_exynos5250()) {
>> +     if (!(soc_is_exynos5250() || soc_is_exynos5420())) {
>>               /* Save Power control register */
>>               asm ("mrc p15, 0, %0, c15, c0, 0"
>>                    : "=r" (tmp) : : "cc");
>> @@ -275,6 +348,15 @@ static void exynos_pm_resume(void)
>>  {
>>       unsigned long tmp;
>>
>> +     if (soc_is_exynos5420()) {
>> +             /* Restore the low power flag */
>> +             s3c_pm_do_restore(exynos5420_cpustate_save,
>> +                     ARRAY_SIZE(exynos5420_cpustate_save));
>> +
>> +             __raw_writel(EXYNOS5420_USE_STANDBY_WFI_ALL,
>> +                     S5P_CENTRAL_SEQ_OPTION);
>> +     }
>> +
>>       /*
>>        * If PMU failed while entering sleep mode, WFI will be
>>        * ignored by PMU and then exiting cpu_do_idle().
>> @@ -290,7 +372,7 @@ static void exynos_pm_resume(void)
>>               /* No need to perform below restore code */
>>               goto early_wakeup;
>>       }
>> -     if (!soc_is_exynos5250()) {
>> +     if (!(soc_is_exynos5250() || soc_is_exynos5420())) {
>>               /* Restore Power control register */
>>               tmp = save_arm_register[0];
>>               asm volatile ("mcr p15, 0, %0, c15, c0, 0"
>> @@ -306,21 +388,40 @@ static void exynos_pm_resume(void)
>>
>>       /* For release retention */
>>
>> -     __raw_writel((1 << 28), S5P_PAD_RET_MAUDIO_OPTION);
>> -     __raw_writel((1 << 28), S5P_PAD_RET_GPIO_OPTION);
>> -     __raw_writel((1 << 28), S5P_PAD_RET_UART_OPTION);
>> -     __raw_writel((1 << 28), S5P_PAD_RET_MMCA_OPTION);
>> -     __raw_writel((1 << 28), S5P_PAD_RET_MMCB_OPTION);
>> -     __raw_writel((1 << 28), S5P_PAD_RET_EBIA_OPTION);
>> -     __raw_writel((1 << 28), S5P_PAD_RET_EBIB_OPTION);
>> +      if (soc_is_exynos5420()) {
>
> Indentation issue.
>
>> +             __raw_writel((1 << 28), EXYNOS5420_PAD_RET_DRAM_OPTION);
>> +             __raw_writel((1 << 28), EXYNOS5420_PAD_RET_MAUDIO_OPTION);
>> +             __raw_writel((1 << 28), EXYNOS5420_PAD_RET_JTAG_OPTION);
>> +             __raw_writel((1 << 28), EXYNOS5420_PAD_RET_GPIO_OPTION);
>> +             __raw_writel((1 << 28), EXYNOS5420_PAD_RET_UART_OPTION);
>> +             __raw_writel((1 << 28), EXYNOS5420_PAD_RET_MMCA_OPTION);
>> +             __raw_writel((1 << 28), EXYNOS5420_PAD_RET_MMCB_OPTION);
>> +             __raw_writel((1 << 28), EXYNOS5420_PAD_RET_MMCC_OPTION);
>> +             __raw_writel((1 << 28), EXYNOS5420_PAD_RET_HSI_OPTION);
>> +             __raw_writel((1 << 28), EXYNOS5420_PAD_RET_EBIA_OPTION);
>> +             __raw_writel((1 << 28), EXYNOS5420_PAD_RET_EBIB_OPTION);
>> +             __raw_writel((1 << 28), EXYNOS5420_PAD_RET_SPI_OPTION);
>> +             __raw_writel((1 << 28), EXYNOS5420_PAD_RET_DRAM_COREBLK_OPTION);
>> +     } else {
>> +             __raw_writel((1 << 28), S5P_PAD_RET_MAUDIO_OPTION);
>> +             __raw_writel((1 << 28), S5P_PAD_RET_GPIO_OPTION);
>> +             __raw_writel((1 << 28), S5P_PAD_RET_UART_OPTION);
>> +             __raw_writel((1 << 28), S5P_PAD_RET_MMCA_OPTION);
>> +             __raw_writel((1 << 28), S5P_PAD_RET_MMCB_OPTION);
>> +             __raw_writel((1 << 28), S5P_PAD_RET_EBIA_OPTION);
>> +             __raw_writel((1 << 28), S5P_PAD_RET_EBIB_OPTION);
>> +     }
>>
>>       if (soc_is_exynos5250())
>>               s3c_pm_do_restore(exynos5_sys_save,
>>                       ARRAY_SIZE(exynos5_sys_save));
>> +     else if (soc_is_exynos5420())
>> +             s3c_pm_do_restore(exynos5420_sys_save,
>> +                     ARRAY_SIZE(exynos5420_sys_save));
>>
>>       s3c_pm_do_restore_core(exynos_core_save, ARRAY_SIZE(exynos_core_save));
>>
>> -     if (!soc_is_exynos5250()) {
>> +     if (!(soc_is_exynos5250() || soc_is_exynos5420())) {
>>               exynos4_restore_pll();
>>
>>  #ifdef CONFIG_SMP
>> @@ -330,6 +431,18 @@ static void exynos_pm_resume(void)
>>
>>  early_wakeup:
>>
>> +     if (soc_is_exynos5420()) {
>> +             tmp = __raw_readl(EXYNOS5420_SFR_AXI_CGDIS1);
>> +             tmp &= ~EXYNOS5420_UFS;
>> +             __raw_writel(tmp, EXYNOS5420_SFR_AXI_CGDIS1);
>> +             tmp = __raw_readl(EXYNOS5420_FSYS2_OPTION);
>> +             tmp &= ~EXYNOS5420_EMULATION;
>> +             __raw_writel(tmp, EXYNOS5420_FSYS2_OPTION);
>> +             tmp = __raw_readl(EXYNOS5420_PSGEN_OPTION);
>> +             tmp &= ~EXYNOS5420_EMULATION;
>> +             __raw_writel(tmp, EXYNOS5420_PSGEN_OPTION);
>> +     }
>> +
>>       /* Clear SLEEP mode set in INFORM1 */
>>       __raw_writel(0x0, S5P_INFORM1);
>>
>> diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
>> index e39cc75..1449404 100644
>> --- a/arch/arm/mach-exynos/pmu.c
>> +++ b/arch/arm/mach-exynos/pmu.c
>> @@ -16,6 +16,8 @@
>>  #include <mach/regs-clock.h>
>>  #include <mach/regs-pmu.h>
>>
>> +#include <asm/cputype.h>
>> +
>>  #include "common.h"
>>
>>  static const struct exynos_pmu_conf *exynos_pmu_config;
>> @@ -318,6 +320,151 @@ static const struct exynos_pmu_conf exynos5250_pmu_config[] = {
>>       { PMU_TABLE_END,},
>>  };
>>
>> +static struct exynos_pmu_conf exynos5420_pmu_config[] = {
>
> static const?
Will fix.

>
> Best regards,
> Tomasz

Abhilash
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
