From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 15 Apr 2014 21:04:02 +0200
Subject: [PATCH V2 2/3] ARM: EXYNOS5: Support Suspend-to-RAM on EXYNOS5420
In-Reply-To: <534D827E.5070805@gmail.com>
References: <1395900785-11334-1-git-send-email-vikas.sajjan@samsung.com>
 <1395900785-11334-3-git-send-email-vikas.sajjan@samsung.com>
 <534D827E.5070805@gmail.com>
Message-ID: <534D82A2.6070306@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One more thing. The change to the clock driver should be separated from 
arch changes.

Best regards,
Tomasz

On 15.04.2014 21:03, Tomasz Figa wrote:
> Hi Vikas,
>
> Basically same comments as for the series for Exynos5260. Also see more
> comments inline.
>
> On 27.03.2014 07:13, Vikas Sajjan wrote:
>> Adds Suspend-to-RAM support for EXYNOS5420
>>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
>> ---
>>   arch/arm/mach-exynos/pm.c                    |  148
>> ++++++++++++++++++++++----
>>   arch/arm/mach-exynos/regs-pmu.h              |    4 +-
>>   arch/arm/plat-samsung/include/plat/map-s5p.h |    2 +
>>   drivers/clk/samsung/clk-exynos5420.c         |   32 ++++++
>>   4 files changed, 167 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
>> index 15af0ce..aa3c2c8 100644
>> --- a/arch/arm/mach-exynos/pm.c
>> +++ b/arch/arm/mach-exynos/pm.c
>> @@ -59,6 +59,16 @@ static struct sleep_save exynos_core_save[] = {
>>       SAVE_ITEM(S5P_SROM_BC3),
>>   };
>>
>> +static struct sleep_save exynos5420_cpustate_save[] = {
>> +    SAVE_ITEM(EXYNOS5420_VA_CPU_STATE),
>> +};
>> +
>> +static struct sleep_save exynos5420_reg_save[] = {
>> +    SAVE_ITEM(EXYNOS5_SYS_DISP1_BLK_CFG),
>> +    SAVE_ITEM(S5P_PMU_SPARE3),
>> +};
>> +
>> +
>>   /*
>>    * GIC wake-up support
>>    */
>> @@ -81,7 +91,7 @@ static int exynos_irq_set_wake(struct irq_data
>> *data, unsigned int state)
>>   {
>>       const struct exynos_wkup_irq *wkup_irq;
>>
>> -    if (soc_is_exynos5250())
>> +    if (soc_is_exynos5250() || soc_is_exynos5420())
>>           wkup_irq = exynos5250_wkup_irq;
>>       else
>>           wkup_irq = exynos4_wkup_irq;
>> @@ -109,7 +119,15 @@ static int exynos_cpu_suspend(unsigned long arg)
>>       outer_flush_all();
>>   #endif
>>
>> -    if (soc_is_exynos5250())
>> +    /*
>> +     * Clear IRAM register for cpu state so that primary CPU does
>> +     * not enter low power start in U-Boot.
>> +     * This is specific to exynos5420 SoC only.
>> +     */
>> +    if (soc_is_exynos5420())
>> +        __raw_writel(0x0, EXYNOS5420_VA_CPU_STATE);
>> +
>> +    if (soc_is_exynos5250() || soc_is_exynos5420())
>>           flush_cache_all();
>>
>>       /* issue the standby signal into the pm unit. */
>> @@ -135,6 +153,20 @@ static void exynos_pm_prepare(void)
>>           tmp = __raw_readl(EXYNOS5_JPEG_MEM_OPTION);
>>           tmp &= ~EXYNOS5_OPTION_USE_RETENTION;
>>           __raw_writel(tmp, EXYNOS5_JPEG_MEM_OPTION);
>> +    } else if (soc_is_exynos5420()) {
>> +
>
> nit: Unnecessary blank line.
>
>> +        s3c_pm_do_save(exynos5420_reg_save,
>> +            ARRAY_SIZE(exynos5420_reg_save));
>> +
>> +        /*
>> +         * The cpu state needs to be saved and restored so that the
>> +         * secondary CPUs will enter low power start. Though the U-Boot
>> +         * is setting the cpu state with low power flag, the kernel
>> +         * needs to restore it back in case, the primary cpu fails to
>> +         * suspend for any reason
>> +         */
>> +        s3c_pm_do_save(exynos5420_cpustate_save,
>> +            ARRAY_SIZE(exynos5420_cpustate_save));
>>       }
>>
>>       /* Set value of power down register for sleep mode */
>> @@ -145,11 +177,34 @@ static void exynos_pm_prepare(void)
>>       /* ensure at least INFORM0 has the resume address */
>>
>>       __raw_writel(virt_to_phys(exynos_cpu_resume), S5P_INFORM0);
>> +
>> +    if (soc_is_exynos5420()) {
>> +
>> +        tmp = __raw_readl(EXYNOS5_ARM_L2_OPTION);
>> +        tmp &= ~EXYNOS5_USE_RETENTION;
>> +        __raw_writel(tmp, EXYNOS5_ARM_L2_OPTION);
>> +
>> +        tmp = __raw_readl(EXYNOS5420_SFR_AXI_CGDIS1);
>> +        tmp |= EXYNOS5420_UFS;
>> +        __raw_writel(tmp, EXYNOS5420_SFR_AXI_CGDIS1);
>> +
>> +        tmp = __raw_readl(EXYNOS5420_ARM_COMMON_OPTION);
>> +        tmp &= ~EXYNOS5420_L2RSTDISABLE_VALUE;
>> +        __raw_writel(tmp, EXYNOS5420_ARM_COMMON_OPTION);
>> +        tmp = __raw_readl(EXYNOS5420_FSYS2_OPTION);
>> +        tmp |= EXYNOS5420_EMULATION;
>> +        __raw_writel(tmp, EXYNOS5420_FSYS2_OPTION);
>> +        tmp = __raw_readl(EXYNOS5420_PSGEN_OPTION);
>> +        tmp |= EXYNOS5420_EMULATION;
>> +        __raw_writel(tmp, EXYNOS5420_PSGEN_OPTION);
>> +    }
>> +
>>   }
>>
>>   static int exynos_pm_suspend(void)
>>   {
>>       unsigned long tmp;
>> +    unsigned long cluster_id;
>>
>>       /* Setting Central Sequence Register for power down mode */
>>
>> @@ -159,10 +214,20 @@ static int exynos_pm_suspend(void)
>>
>>       /* Setting SEQ_OPTION register */
>>
>> -    tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
>> -    __raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
>> +    if (soc_is_exynos5420()) {
>> +        cluster_id = (read_cpuid(CPUID_MPIDR) >> 8) & 0xf;
>> +        if (!cluster_id)
>> +            __raw_writel(EXYNOS5420_ARM_USE_STANDBY_WFI0,
>> +                     S5P_CENTRAL_SEQ_OPTION);
>> +        else
>> +            __raw_writel(EXYNOS5420_KFC_USE_STANDBY_WFI0,
>> +                     S5P_CENTRAL_SEQ_OPTION);
>> +    } else {
>> +        tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
>> +        __raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
>> +    }
>>
>> -    if (!soc_is_exynos5250()) {
>> +    if (!(soc_is_exynos5250() || soc_is_exynos5420())) {
>>           /* Save Power control register */
>>           asm ("mrc p15, 0, %0, c15, c0, 0"
>>                : "=r" (tmp) : : "cc");
>> @@ -181,6 +246,15 @@ static void exynos_pm_resume(void)
>>   {
>>       unsigned long tmp;
>>
>> +    if (soc_is_exynos5420()) {
>> +        /* Restore the IRAM register cpu state */
>> +        s3c_pm_do_restore(exynos5420_cpustate_save,
>> +            ARRAY_SIZE(exynos5420_cpustate_save));
>> +
>> +        __raw_writel(EXYNOS5420_USE_STANDBY_WFI_ALL,
>> +            S5P_CENTRAL_SEQ_OPTION);
>> +    }
>> +
>>       /*
>>        * If PMU failed while entering sleep mode, WFI will be
>>        * ignored by PMU and then exiting cpu_do_idle().
>> @@ -196,7 +270,8 @@ static void exynos_pm_resume(void)
>>           /* No need to perform below restore code */
>>           goto early_wakeup;
>>       }
>> -    if (!soc_is_exynos5250()) {
>> +
>> +    if (!(soc_is_exynos5250() || soc_is_exynos5420())) {
>>           /* Restore Power control register */
>>           tmp = save_arm_register[0];
>>           asm volatile ("mcr p15, 0, %0, c15, c0, 0"
>> @@ -212,25 +287,57 @@ static void exynos_pm_resume(void)
>>
>>       /* For release retention */
>>
>> -    __raw_writel((1 << 28), S5P_PAD_RET_MAUDIO_OPTION);
>> -    __raw_writel((1 << 28), S5P_PAD_RET_GPIO_OPTION);
>> -    __raw_writel((1 << 28), S5P_PAD_RET_UART_OPTION);
>> -    __raw_writel((1 << 28), S5P_PAD_RET_MMCA_OPTION);
>> -    __raw_writel((1 << 28), S5P_PAD_RET_MMCB_OPTION);
>> -    __raw_writel((1 << 28), S5P_PAD_RET_EBIA_OPTION);
>> -    __raw_writel((1 << 28), S5P_PAD_RET_EBIB_OPTION);
>> +    if (soc_is_exynos5250()) {
>> +        __raw_writel((1 << 28), S5P_PAD_RET_MAUDIO_OPTION);
>> +        __raw_writel((1 << 28), S5P_PAD_RET_GPIO_OPTION);
>> +        __raw_writel((1 << 28), S5P_PAD_RET_UART_OPTION);
>> +        __raw_writel((1 << 28), S5P_PAD_RET_MMCA_OPTION);
>> +        __raw_writel((1 << 28), S5P_PAD_RET_MMCB_OPTION);
>> +        __raw_writel((1 << 28), S5P_PAD_RET_EBIA_OPTION);
>> +        __raw_writel((1 << 28), S5P_PAD_RET_EBIB_OPTION);
>> +    } else if (soc_is_exynos5420()) {
>> +        __raw_writel(1 << 28, EXYNOS_PAD_RET_DRAM_OPTION);
>> +        __raw_writel(1 << 28, EXYNOS_PAD_RET_MAUDIO_OPTION);
>> +        __raw_writel(1 << 28, EXYNOS_PAD_RET_JTAG_OPTION);
>> +        __raw_writel(1 << 28, EXYNOS5420_PAD_RET_GPIO_OPTION);
>> +        __raw_writel(1 << 28, EXYNOS5420_PAD_RET_UART_OPTION);
>> +        __raw_writel(1 << 28, EXYNOS5420_PAD_RET_MMCA_OPTION);
>> +        __raw_writel(1 << 28, EXYNOS5420_PAD_RET_MMCB_OPTION);
>> +        __raw_writel(1 << 28, EXYNOS5420_PAD_RET_MMCC_OPTION);
>> +        __raw_writel(1 << 28, EXYNOS5420_PAD_RET_HSI_OPTION);
>> +        __raw_writel(1 << 28, EXYNOS_PAD_RET_EBIA_OPTION);
>> +        __raw_writel(1 << 28, EXYNOS_PAD_RET_EBIB_OPTION);
>> +        __raw_writel(1 << 28, EXYNOS5420_PAD_RET_SPI_OPTION);
>> +        __raw_writel(1 << 28, EXYNOS5420_PAD_RET_DRAM_COREBLK_OPTION);
>> +    }
>>
>>       if (soc_is_exynos5250())
>>           s3c_pm_do_restore(exynos5_sys_save,
>>               ARRAY_SIZE(exynos5_sys_save));
>> +    else if (soc_is_exynos5420())
>> +        s3c_pm_do_restore(exynos5420_reg_save,
>> +            ARRAY_SIZE(exynos5420_reg_save));
>>
>>       s3c_pm_do_restore_core(exynos_core_save,
>> ARRAY_SIZE(exynos_core_save));
>>
>> -    if (IS_ENABLED(CONFIG_SMP) && !soc_is_exynos5250())
>> +    if (IS_ENABLED(CONFIG_SMP) &&
>> +            !soc_is_exynos5250() && !soc_is_exynos5420())
>>           scu_enable(S5P_VA_SCU);
>>
>>   early_wakeup:
>>
>> +    if (soc_is_exynos5420()) {
>> +        tmp = __raw_readl(EXYNOS5420_SFR_AXI_CGDIS1);
>> +        tmp &= ~EXYNOS5420_UFS;
>> +        __raw_writel(tmp, EXYNOS5420_SFR_AXI_CGDIS1);
>> +        tmp = __raw_readl(EXYNOS5420_FSYS2_OPTION);
>> +        tmp &= ~EXYNOS5420_EMULATION;
>> +        __raw_writel(tmp, EXYNOS5420_FSYS2_OPTION);
>> +        tmp = __raw_readl(EXYNOS5420_PSGEN_OPTION);
>> +        tmp &= ~EXYNOS5420_EMULATION;
>> +        __raw_writel(tmp, EXYNOS5420_PSGEN_OPTION);
>> +    }
>> +
>>       /* Clear SLEEP mode set in INFORM1 */
>>       __raw_writel(0x0, S5P_INFORM1);
>>
>> @@ -312,10 +419,15 @@ void __init exynos_pm_init(void)
>>       gic_arch_extn.irq_set_wake = exynos_irq_set_wake;
>>
>>       /* All wakeup disable */
>> -    tmp = __raw_readl(S5P_WAKEUP_MASK);
>> -    tmp |= ((0xFF << 8) | (0x1F << 1));
>> -    __raw_writel(tmp, S5P_WAKEUP_MASK);
>> -
>> +    if (soc_is_exynos5420()) {
>> +        tmp = __raw_readl(S5P_WAKEUP_MASK);
>> +        tmp |= ((0x7F << 7) | (0x1F << 1));
>> +        __raw_writel(tmp, S5P_WAKEUP_MASK);
>> +    } else {
>> +        tmp = __raw_readl(S5P_WAKEUP_MASK);
>> +        tmp |= ((0xFF << 8) | (0x1F << 1));
>> +        __raw_writel(tmp, S5P_WAKEUP_MASK);
>> +    }
>>       register_syscore_ops(&exynos_pm_syscore_ops);
>>       suspend_set_ops(&exynos_suspend_ops);
>>   }
>> diff --git a/arch/arm/mach-exynos/regs-pmu.h
>> b/arch/arm/mach-exynos/regs-pmu.h
>> index cfbfc575..53eac2b 100644
>> --- a/arch/arm/mach-exynos/regs-pmu.h
>> +++ b/arch/arm/mach-exynos/regs-pmu.h
>> @@ -39,6 +39,7 @@
>>   #define S5P_INFORM6                S5P_PMUREG(0x0818)
>>   #define S5P_INFORM7                S5P_PMUREG(0x081C)
>>
>> +#define S5P_PMU_SPARE3                S5P_PMUREG(0x090C)
>>   #define EXYNOS_IROM_DATA2            S5P_PMUREG(0x0988)
>>
>>   #define S5P_ARM_CORE0_LOWPWR            S5P_PMUREG(0x1000)
>> @@ -113,7 +114,6 @@
>>   #define EXYNOS5_ARM_L2_OPTION            S5P_PMUREG(0x2608)
>>   #define EXYNOS5_USE_RETENTION            BIT(4)
>>
>> -
>>   #define S5P_PAD_RET_MAUDIO_OPTION        S5P_PMUREG(0x3028)
>>   #define S5P_PAD_RET_GPIO_OPTION            S5P_PMUREG(0x3108)
>>   #define S5P_PAD_RET_UART_OPTION            S5P_PMUREG(0x3128)
>> @@ -216,6 +216,8 @@
>>
>>   /* For EXYNOS5 */
>>
>> +#define EXYNOS5_SYS_DISP1_BLK_CFG            S5P_SYSREG(0x0214)
>> +
>>   #define EXYNOS5_SYS_I2C_CFG                    S5P_SYSREG(0x0234)
>>
>>   #define EXYNOS5_AUTO_WDTRESET_DISABLE                S5P_PMUREG(0x0408)
>> diff --git a/arch/arm/plat-samsung/include/plat/map-s5p.h
>> b/arch/arm/plat-samsung/include/plat/map-s5p.h
>> index c186786..cfb150e 100644
>> --- a/arch/arm/plat-samsung/include/plat/map-s5p.h
>> +++ b/arch/arm/plat-samsung/include/plat/map-s5p.h
>> @@ -57,6 +57,8 @@
>>   #define S3C_UART_OFFSET        (0x400)
>>   #endif
>>
>> +#define EXYNOS5420_VA_CPU_STATE    (S5P_VA_SYSRAM + 0x28)
>> +
>
> Please, no more static addresses. This should be defined as an offset to
> SYSRAM in the source file that actually uses it.
>
>>   #include <plat/map-s3c.h>
>>
>>   #endif /* __ASM_PLAT_MAP_S5P_H */
>> diff --git a/drivers/clk/samsung/clk-exynos5420.c
>> b/drivers/clk/samsung/clk-exynos5420.c
>> index 60b2681..965ea69 100644
>> --- a/drivers/clk/samsung/clk-exynos5420.c
>> +++ b/drivers/clk/samsung/clk-exynos5420.c
>> @@ -101,6 +101,19 @@
>>   #define KPLL_CON0        0x28100
>>   #define SRC_KFC            0x28200
>>   #define DIV_KFC0        0x28500
>> +#define SRC_MASK_CPERI        0x04300
>
> Please keep the registers sorted...
>
>> +#define SRC_MASK_TOP0        0x10300
>> +#define SRC_MASK_TOP1        0x10304
>> +#define SRC_MASK_TOP2        0x10308
>> +#define SRC_MASK_TOP7        0x1031C
>> +#define SRC_MASK_MAU        0x10334
>> +#define SRC_MASK_FSYS        0x10340
>> +#define SRC_MASK_PERIC0        0x10350
>> +#define SRC_MASK_PERIC1        0x10354
>> +#define SRC_MASK_ISP        0x10370
>> +#define GATE_BUS_DISP1        0x10728
>> +#define GATE_IP_PERIC        0x10950
>> +
>>
>>   /* list of PLLs */
>>   enum exynos5420_plls {
>> @@ -180,11 +193,30 @@ static unsigned long exynos5420_clk_regs[]
>> __initdata = {
>>       DIV_KFC0,
>>   };
>>
>> +static const struct samsung_clk_reg_dump exynos5420_set_clksrc[] = {
>> +    { .offset = SRC_MASK_CPERI,        .value = 0xffffffff, },
>> +    { .offset = SRC_MASK_TOP0,        .value = 0x11111111, },
>> +    { .offset = SRC_MASK_TOP1,        .value = 0x11101111, },
>> +    { .offset = SRC_MASK_TOP2,        .value = 0x11111110, },
>> +    { .offset = SRC_MASK_TOP7,        .value = 0x00111100, },
>> +    { .offset = SRC_MASK_DISP10,        .value = 0x11111110, },
>> +    { .offset = SRC_MASK_MAU,        .value = 0x10000000, },
>> +    { .offset = SRC_MASK_FSYS,        .value = 0x11111110, },
>> +    { .offset = SRC_MASK_PERIC0,        .value = 0x11111110, },
>> +    { .offset = SRC_MASK_PERIC1,        .value = 0x11111100, },
>> +    { .offset = SRC_MASK_ISP,        .value = 0x11111000, },
>> +    { .offset = GATE_BUS_DISP1,        .value = 0xffffffff, },
>> +    { .offset = GATE_IP_PERIC,        .value = 0xffffffff, },
>> +};
>> +
>> +
>>   static int exynos5420_clk_suspend(void)
>>   {
>>       samsung_clk_save(reg_base, exynos5420_save,
>>                   ARRAY_SIZE(exynos5420_clk_regs));
>>
>> +    samsung_clk_restore(reg_base, exynos5420_set_clksrc,
>> +                    ARRAY_SIZE(exynos5420_set_clksrc));
>
> nit: You could align ARRAY_SIZE to the same indentation level as the
> call to samsung_clk_save() above.
>
> Best regards,
> Tomasz
