From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Wed, 6 Aug 2014 18:43:15 +0545
Subject: [PATCH v2] ARM: EXYNOS: Refactor the pm code to use DT based
 lookup
In-Reply-To: <53E1356F.40400@gmail.com>
References: <1406288941-20792-1-git-send-email-vikas.sajjan@samsung.com>
 <53E1356F.40400@gmail.com>
Message-ID: <CAGm_ybhFj12+tWEhBy=Z62HE6roWMDOXxyoaVsBC2KPMsrYq9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Wed, Aug 6, 2014 at 1:35 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Vikas,
>
> Please see my comments inline.
>
> On 25.07.2014 13:49, Vikas Sajjan wrote:
>> Refactoring the pm.c to avoid using "soc_is_exynos" checks,
>> instead use the DT based lookup.
>>
>> While at it, consolidate the common code across SoCs
>> and create a static helper functions.
>
> [snip]
>
>> @@ -241,13 +266,13 @@ static void exynos_cpu_restore_register(void)
>>
>>  static int exynos_cpu_suspend(unsigned long arg)
>>  {
>> -#ifdef CONFIG_CACHE_L2X0
>> -     outer_flush_all();
>> -#endif
>> -
>> -     if (soc_is_exynos5250())
>> -             flush_cache_all();
>> +     if (pm_data->cpu_suspend)
>> +             return pm_data->cpu_suspend(arg);
>> +     return -1;
>> +}
>
> I believe you could just pass pm_data->cpu_suspend to cpu_suspend(),
> without this three-liner.
>

OK.

>>
>> +static int exynos_cpu_do_idle(void)
>> +{
>>       /* issue the standby signal into the pm unit. */
>>       cpu_do_idle();
>>
>> @@ -257,32 +282,73 @@ static int exynos_cpu_suspend(unsigned long arg)
>>
>>  static void exynos_pm_prepare(void)
>>  {
>> -     unsigned int tmp;
>> +     if (pm_data->pm_prepare)
>> +             pm_data->pm_prepare();
>
> You could just directly insert this code into exynos_suspend_enter()
> instead of adding this two-liner.

OK.

>
>> +}
>>
>> +static int exynos4_cpu_suspend(unsigned long arg)
>> +{
>> +#ifdef CONFIG_CACHE_L2X0
>> +     outer_flush_all();
>> +#endif
>> +     return exynos_cpu_do_idle();
>> +}
>> +
>> +static int exynos5250_cpu_suspend(unsigned long arg)
>> +{
>> +#ifdef CONFIG_CACHE_L2X0
>> +     outer_flush_all();
>> +#endif
>> +     flush_cache_all();
>> +     return exynos_cpu_do_idle();
>> +}
>
> I believe both can be merged safely into the same single function. A
> call to flush_cache_all() will not hurt on Exynos4, but it should be
> moved before outer_flush_all().
>
> Moreover, the #ifdef CONFIG_CACHE_L2X0 is superfluous, because the
> existence of outer_flush_all() symbol doesn't depend on this Kconfig
> symbol (it depends on CONFIG_OUTER_CACHE_SYNC, but a stub is provided if
> it is disabled).
>
>> +
>> +static void exynos_pm_set_wakeup_mask(void)
>> +{
>>       /* Set wake-up mask registers */
>>       pmu_raw_writel(exynos_get_eint_wake_mask(), S5P_EINT_WAKEUP_MASK);
>>       pmu_raw_writel(exynos_irqwake_intmask & ~(1 << 31), S5P_WAKEUP_MASK);
>> +}
>>
>> -     s3c_pm_do_save(exynos_core_save, ARRAY_SIZE(exynos_core_save));
>> -
>> -     if (soc_is_exynos5250()) {
>> -             s3c_pm_do_save(exynos5_sys_save, ARRAY_SIZE(exynos5_sys_save));
>> -             /* Disable USE_RETENTION of JPEG_MEM_OPTION */
>> -             tmp = pmu_raw_readl(EXYNOS5_JPEG_MEM_OPTION);
>> -             tmp &= ~EXYNOS5_OPTION_USE_RETENTION;
>> -             pmu_raw_writel(tmp, EXYNOS5_JPEG_MEM_OPTION);
>> -     }
>> -
>> +static void exynos_pm_enter_sleep_mode(void)
>> +{
>>       /* Set value of power down register for sleep mode */
>> -
>>       exynos_sys_powerdown_conf(SYS_SLEEP);
>>       pmu_raw_writel(S5P_CHECK_SLEEP, S5P_INFORM1);
>>
>>       /* ensure at least INFORM0 has the resume address */
>> -
>>       pmu_raw_writel(virt_to_phys(exynos_cpu_resume), S5P_INFORM0);
>>  }
>>
>> +static void exynos5250_pm_prepare(void)
>> +{
>> +     unsigned int tmp;
>> +
>> +     /* Set wake-up mask registers */
>> +     exynos_pm_set_wakeup_mask();
>> +
>> +     s3c_pm_do_save(exynos_core_save, ARRAY_SIZE(exynos_core_save));
>> +
>> +     s3c_pm_do_save(exynos5_sys_save, ARRAY_SIZE(exynos5_sys_save));
>
> You could store a pointer to this array in new .extra_save field of the
> variant struct and handle this with generic code, like below:
>
>         if (pm_data->extra_save)
>                 s3c_pm_do_save(pm_data->extra_save,
>                                 pm_data->num_extra_save);
>

OK.

>> +
>> +     /* Disable USE_RETENTION of JPEG_MEM_OPTION */
>> +     tmp = pmu_raw_readl(EXYNOS5_JPEG_MEM_OPTION);
>> +     tmp &= ~EXYNOS5_OPTION_USE_RETENTION;
>> +     pmu_raw_writel(tmp, EXYNOS5_JPEG_MEM_OPTION);
>
> This looks completely like a copy paste from a vendor tree needed to
> workaround some issues in early revisions of the SoC. Are you sure this
> is still needed in production versions of the silicon used on boards
> supported in mainline?

This piece of code is NOT copy paste from my side, it is an already
existing code. I just moved it into the function
exynos5250_pm_prepare().  However I removed this piece of code and
made a common function for exynos4 and exynos5250, S2R works on 5250
well even without this piece of code.

>
> Even if yes, Exynos4 handles such registers in PMU register array in
> pmu.c, so I wonder whether it shouldn't be moved there and allow
> handling of all Exynos SoCs uniformly in this file.
>
>> +
>> +     exynos_pm_enter_sleep_mode();
>> +}
>> +
>> +static void exynos4_pm_prepare(void)
>> +{
>> +     /* Set wake-up mask registers */
>> +     exynos_pm_set_wakeup_mask();
>> +
>> +     s3c_pm_do_save(exynos_core_save, ARRAY_SIZE(exynos_core_save));
>> +
>> +     exynos_pm_enter_sleep_mode();
>> +}
>
> In fact, exynos4_pm_prepare() is a direct subset of
> exynos5250_pm_prepare(). This just confirms that it might be a good idea
> to just merge both functions into a single generic one.

Right, can be merged into a common function which can be used for
exynos4 and exynos5250.
But I am afraid we still need specific functions in case of 5420.

>
>> +
>>  static void exynos_pm_central_suspend(void)
>>  {
>>       unsigned long tmp;
>> @@ -295,6 +361,13 @@ static void exynos_pm_central_suspend(void)
>>
>>  static int exynos_pm_suspend(void)
>>  {
>> +     if (pm_data->pm_suspend)
>> +             return pm_data->pm_suspend();
>> +     return -1;
>> +}
>
> Do you need this three-liner? I believe you could just assign
> pm_data->pm_suspend directly to exynos_pm_syscore_ops.
>

OK.

>> +
>> +static int exynos4_pm_suspend(void)
>> +{
>>       unsigned long tmp;
>>
>>       exynos_pm_central_suspend();
>> @@ -304,9 +377,20 @@ static int exynos_pm_suspend(void)
>>       tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
>>       pmu_raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
>>
>> -     if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
>> -             exynos_cpu_save_register();
>> +     exynos_cpu_save_register();
>> +     return 0;
>> +}
>> +
>> +static int exynos5250_pm_suspend(void)
>> +{
>> +     unsigned long tmp;
>> +
>> +     exynos_pm_central_suspend();
>> +
>> +     /* Setting SEQ_OPTION register */
>>
>> +     tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
>> +     pmu_raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
>>       return 0;
>>  }
>
> This function is exactly the same as exynos4_pm_suspend, but without the
> call to exynos_cpu_save_register(). Since originally this call was
> conditional, depending on CPU part number, is there any reason to split
> this function into SoC specific ones?

Can be made as single common function.

>
>>
>> @@ -333,39 +417,57 @@ static int exynos_pm_central_resume(void)
>>       return 0;
>>  }
>>
>> +static void exynos_pm_set_release_retention(void)
>
> nit: exynos_pm_release_retention() would sound better.
>
>> +{
>> +     unsigned int i;
>> +
>> +     for (i = 0; (pm_data->release_ret_regs[i] != REG_TABLE_END); i++)
>> +             pmu_raw_writel(EXYNOS_WAKEUP_FROM_LOWPWR,
>> +                             pm_data->release_ret_regs[i]);
>> +}
>> +
>>  static void exynos_pm_resume(void)
>>  {
>> +     if (pm_data->pm_resume)
>> +             pm_data->pm_resume();
>> +}
>
> Similarly as with exynos_pm_suspend().
>
>> +
>> +static void exynos4_pm_resume(void)
>> +{
>>       if (exynos_pm_central_resume())
>>               goto early_wakeup;
>>
>> -     if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
>> -             exynos_cpu_restore_register();
>> +     exynos_cpu_restore_register();
>>
>>       /* For release retention */
>> -
>> -     pmu_raw_writel((1 << 28), S5P_PAD_RET_MAUDIO_OPTION);
>> -     pmu_raw_writel((1 << 28), S5P_PAD_RET_GPIO_OPTION);
>> -     pmu_raw_writel((1 << 28), S5P_PAD_RET_UART_OPTION);
>> -     pmu_raw_writel((1 << 28), S5P_PAD_RET_MMCA_OPTION);
>> -     pmu_raw_writel((1 << 28), S5P_PAD_RET_MMCB_OPTION);
>> -     pmu_raw_writel((1 << 28), S5P_PAD_RET_EBIA_OPTION);
>> -     pmu_raw_writel((1 << 28), S5P_PAD_RET_EBIB_OPTION);
>> -
>> -     if (soc_is_exynos5250())
>> -             s3c_pm_do_restore(exynos5_sys_save,
>> -                     ARRAY_SIZE(exynos5_sys_save));
>> +     exynos_pm_set_release_retention();
>>
>>       s3c_pm_do_restore_core(exynos_core_save, ARRAY_SIZE(exynos_core_save));
>>
>> -     if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
>> -             scu_enable(S5P_VA_SCU);
>> +     scu_enable(S5P_VA_SCU);
>>
>>  early_wakeup:
>>
>>       /* Clear SLEEP mode set in INFORM1 */
>>       pmu_raw_writel(0x0, S5P_INFORM1);
>> +}
>> +
>> +static void exynos5250_pm_resume(void)
>> +{
>> +     if (exynos_pm_central_resume())
>> +             goto early_wakeup;
>>
>> -     return;
>> +     /* For release retention */
>> +     exynos_pm_set_release_retention();
>> +
>> +     s3c_pm_do_restore(exynos5_sys_save, ARRAY_SIZE(exynos5_sys_save));
>> +
>> +     s3c_pm_do_restore_core(exynos_core_save, ARRAY_SIZE(exynos_core_save));
>> +
>> +early_wakeup:
>> +
>> +     /* Clear SLEEP mode set in INFORM1 */
>> +     pmu_raw_writel(0x0, S5P_INFORM1);
>>  }
>
> Similar to exynos{4,5250}_pm_suspend(), this could be kept as a single
> generic function. exynos5_sys_save would be handled by .extra_save field
> of the pm_data struct and scu_enable() and exynos_cpu_restore_register()
> was already handled in a generic way, based on ARM core type, not
> soc_is_*().

OK.

>
>>
>>  static struct syscore_ops exynos_pm_syscore_ops = {
>> @@ -468,18 +570,64 @@ static struct notifier_block exynos_cpu_pm_notifier_block = {
>>       .notifier_call = exynos_cpu_pm_notifier,
>>  };
>>
>> +static struct exynos_pm_data exynos4_pm_data = {
>
> static const
>
>> +     .wkup_irq       = exynos4_wkup_irq,
>> +     .wake_disable_mask = ((0xFF << 8) | (0x1F << 1)),
>> +     .release_ret_regs = exynos_release_ret_regs,
>> +     .pm_suspend     = exynos4_pm_suspend,
>> +     .pm_resume      = exynos4_pm_resume,
>> +     .pm_prepare     = exynos4_pm_prepare,
>> +     .cpu_suspend    = exynos4_cpu_suspend,
>> +};
>> +
>> +static struct exynos_pm_data exynos5250_pm_data = {
>
> static const
>
>> +     .wkup_irq       = exynos5250_wkup_irq,
>> +     .wake_disable_mask = ((0xFF << 8) | (0x1F << 1)),
>> +     .release_ret_regs = exynos_release_ret_regs,
>> +     .pm_suspend     = exynos5250_pm_suspend,
>> +     .pm_resume      = exynos5250_pm_resume,
>> +     .pm_prepare     = exynos5250_pm_prepare,
>> +     .cpu_suspend    = exynos5250_cpu_suspend,
>> +};
>> +
>> +static struct of_device_id exynos_pmu_of_device_ids[] = {
>> +     {
>> +             .compatible = "samsung,exynos4210-pmu",
>> +             .data = (void *)&exynos4_pm_data,
>
> No need to cast if const pointers are used. + 3 more below.
>
>> +     }, {
>> +             .compatible = "samsung,exynos4212-pmu",
>> +             .data = (void *)&exynos4_pm_data,
>> +     }, {
>> +             .compatible = "samsung,exynos4412-pmu",
>> +             .data = (void *)&exynos4_pm_data,
>> +     }, {
>> +             .compatible = "samsung,exynos5250-pmu",
>> +             .data = (void *)&exynos5250_pm_data,
>> +     },
>> +     { /*sentinel*/ },
>> +};
>> +
>>  void __init exynos_pm_init(void)
>>  {
>>       u32 tmp;
>> +     const struct of_device_id *match;
>
> nit: it would look better if this variable was added above tmp.
>
>>
>>       cpu_pm_register_notifier(&exynos_cpu_pm_notifier_block);
>>
>> +     of_find_matching_node_and_match(NULL, exynos_pmu_of_device_ids, &match);
>> +
>
> nit: superfluous blank line
>
>> +     if (!match) {
>> +             pr_err("Failed to find PMU node\n");
>> +             return;
>> +     }
>> +     pm_data = (struct exynos_pm_data *) match->data;
>
> No need to cast if const pointers are used.
>
>> +
>>       /* Platform-specific GIC callback */
>>       gic_arch_extn.irq_set_wake = exynos_irq_set_wake;
>>
>>       /* All wakeup disable */
>>       tmp = pmu_raw_readl(S5P_WAKEUP_MASK);
>> -     tmp |= ((0xFF << 8) | (0x1F << 1));
>> +     tmp |= pm_data->wake_disable_mask;
>
> Does this vary between SoCs?

Yes, It is different in case of 5420.

>
>>       pmu_raw_writel(tmp, S5P_WAKEUP_MASK);
>>
>>       register_syscore_ops(&exynos_pm_syscore_ops);
>> diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
>> index 96a1569..30c0301 100644
>> --- a/arch/arm/mach-exynos/regs-pmu.h
>> +++ b/arch/arm/mach-exynos/regs-pmu.h
>> @@ -21,6 +21,7 @@
>>  #define S5P_USE_STANDBY_WFI0                 (1 << 16)
>>  #define S5P_USE_STANDBY_WFE0                 (1 << 24)
>>
>> +#define EXYNOS_WAKEUP_FROM_LOWPWR            (1 << 28)
>
> Is this really the real name of this bit, as specified in the datasheet?

Yes, it is the real name.  I referred exynos4 UM for this.

>
> Best regards,
> Tomasz
