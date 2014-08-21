From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Thu, 21 Aug 2014 11:40:27 +0530
Subject: [RESEND PATCH v4 2/2] ARM: EXYNOS: Refactor the pm code to use DT
 based lookup
In-Reply-To: <2186657.jhIisq7Fok@amdc1032>
References: <1408431167-14134-1-git-send-email-vikas.sajjan@samsung.com>
 <1408431167-14134-3-git-send-email-vikas.sajjan@samsung.com>
 <CAGm_ybjx4t7kGg0mJHjrox39jP-DNgc-0rkLNn2rcOLS6JjAHQ@mail.gmail.com>
 <2186657.jhIisq7Fok@amdc1032>
Message-ID: <CAGm_ybhDsGpoHg8XVBOPEv7oHc0YdSZBW_JXB0hZk-y6Bac00g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 19, 2014 at 3:05 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> Hi,
>
> On Tuesday, August 19, 2014 01:26:49 PM Vikas Sajjan wrote:
>> Hi Kukjin,
>>
>> On Tue, Aug 19, 2014 at 12:22 PM, Vikas Sajjan <vikas.sajjan@samsung.com> wrote:
>> > Refactoring the pm.c to avoid using "soc_is_exynos" checks,
>> > instead use the DT based lookup.
>> >
>> > While at it, consolidate the common code across SoCs
>> > and create static helper functions.
>> >
>> > Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
>> > Reviewed-by: Tomasz Figa <t.figa@samsung.com>
>>
>> Can you pick this series...
>
> I think that my PM_SLEEP=n build fixes should go in before this cleanup
> series:

Its better for Kukjin to decide which series he wants to pick first.


>
>   http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg35430.html
>
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
>
>> > ---
>> >  arch/arm/mach-exynos/pm.c       |  167 +++++++++++++++++++++++++++++----------
>> >  arch/arm/mach-exynos/regs-pmu.h |    1 +
>> >  2 files changed, 126 insertions(+), 42 deletions(-)
>> >
>> > diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
>> > index 31e209b..16b23d1 100644
>> > --- a/arch/arm/mach-exynos/pm.c
>> > +++ b/arch/arm/mach-exynos/pm.c
>> > @@ -36,6 +36,8 @@
>> >  #include "regs-pmu.h"
>> >  #include "regs-sys.h"
>> >
>> > +#define REG_TABLE_END (-1U)
>> > +
>> >  /**
>> >   * struct exynos_wkup_irq - Exynos GIC to PMU IRQ mapping
>> >   * @hwirq: Hardware IRQ signal of the GIC
>> > @@ -59,6 +61,21 @@ static struct sleep_save exynos_core_save[] = {
>> >         SAVE_ITEM(S5P_SROM_BC3),
>> >  };
>> >
>> > +struct exynos_pm_data {
>> > +       const struct exynos_wkup_irq *wkup_irq;
>> > +       struct sleep_save *extra_save;
>> > +       int num_extra_save;
>> > +       unsigned int wake_disable_mask;
>> > +       unsigned int *release_ret_regs;
>> > +
>> > +       void (*pm_prepare)(void);
>> > +       void (*pm_resume)(void);
>> > +       int (*pm_suspend)(void);
>> > +       int (*cpu_suspend)(unsigned long);
>> > +};
>> > +
>> > +struct exynos_pm_data *pm_data;
>> > +
>> >  /*
>> >   * GIC wake-up support
>> >   */
>> > @@ -77,14 +94,24 @@ static const struct exynos_wkup_irq exynos5250_wkup_irq[] = {
>> >         { /* sentinel */ },
>> >  };
>> >
>> > +unsigned int exynos_release_ret_regs[] = {
>> > +       S5P_PAD_RET_MAUDIO_OPTION,
>> > +       S5P_PAD_RET_GPIO_OPTION,
>> > +       S5P_PAD_RET_UART_OPTION,
>> > +       S5P_PAD_RET_MMCA_OPTION,
>> > +       S5P_PAD_RET_MMCB_OPTION,
>> > +       S5P_PAD_RET_EBIA_OPTION,
>> > +       S5P_PAD_RET_EBIB_OPTION,
>> > +       REG_TABLE_END,
>> > +};
>> > +
>> >  static int exynos_irq_set_wake(struct irq_data *data, unsigned int state)
>> >  {
>> >         const struct exynos_wkup_irq *wkup_irq;
>> >
>> > -       if (soc_is_exynos5250())
>> > -               wkup_irq = exynos5250_wkup_irq;
>> > -       else
>> > -               wkup_irq = exynos4_wkup_irq;
>> > +       if (!pm_data->wkup_irq)
>> > +               return -ENOENT;
>> > +       wkup_irq = pm_data->wkup_irq;
>> >
>> >         while (wkup_irq->mask) {
>> >                 if (wkup_irq->hwirq == data->hwirq) {
>> > @@ -229,15 +256,8 @@ void exynos_enter_aftr(void)
>> >         cpu_pm_exit();
>> >  }
>> >
>> > -static int exynos_cpu_suspend(unsigned long arg)
>> > +static int exynos_cpu_do_idle(void)
>> >  {
>> > -#ifdef CONFIG_CACHE_L2X0
>> > -       outer_flush_all();
>> > -#endif
>> > -
>> > -       if (soc_is_exynos5250())
>> > -               flush_cache_all();
>> > -
>> >         /* issue the standby signal into the pm unit. */
>> >         cpu_do_idle();
>> >
>> > @@ -245,29 +265,44 @@ static int exynos_cpu_suspend(unsigned long arg)
>> >         return 1; /* Aborting suspend */
>> >  }
>> >
>> > -static void exynos_pm_prepare(void)
>> > +static int exynos_cpu_suspend(unsigned long arg)
>> >  {
>> > -       unsigned int tmp;
>> > +       flush_cache_all();
>> > +       outer_flush_all();
>> > +       return exynos_cpu_do_idle();
>> > +}
>> >
>> > +static void exynos_pm_set_wakeup_mask(void)
>> > +{
>> >         /* Set wake-up mask registers */
>> >         pmu_raw_writel(exynos_get_eint_wake_mask(), S5P_EINT_WAKEUP_MASK);
>> >         pmu_raw_writel(exynos_irqwake_intmask & ~(1 << 31), S5P_WAKEUP_MASK);
>> > +}
>> >
>> > -       s3c_pm_do_save(exynos_core_save, ARRAY_SIZE(exynos_core_save));
>> > -
>> > -       if (soc_is_exynos5250())
>> > -               s3c_pm_do_save(exynos5_sys_save, ARRAY_SIZE(exynos5_sys_save));
>> > -
>> > +static void exynos_pm_enter_sleep_mode(void)
>> > +{
>> >         /* Set value of power down register for sleep mode */
>> > -
>> >         exynos_sys_powerdown_conf(SYS_SLEEP);
>> >         pmu_raw_writel(S5P_CHECK_SLEEP, S5P_INFORM1);
>> >
>> >         /* ensure at least INFORM0 has the resume address */
>> > -
>> >         pmu_raw_writel(virt_to_phys(exynos_cpu_resume), S5P_INFORM0);
>> >  }
>> >
>> > +static void exynos_pm_prepare(void)
>> > +{
>> > +       /* Set wake-up mask registers */
>> > +       exynos_pm_set_wakeup_mask();
>> > +
>> > +       s3c_pm_do_save(exynos_core_save, ARRAY_SIZE(exynos_core_save));
>> > +
>> > +        if (pm_data->extra_save)
>> > +               s3c_pm_do_save(pm_data->extra_save,
>> > +                               pm_data->num_extra_save);
>> > +
>> > +       exynos_pm_enter_sleep_mode();
>> > +}
>> > +
>> >  static int exynos_pm_suspend(void)
>> >  {
>> >         unsigned long tmp;
>> > @@ -285,6 +320,15 @@ static int exynos_pm_suspend(void)
>> >         return 0;
>> >  }
>> >
>> > +static void exynos_pm_release_retention(void)
>> > +{
>> > +       unsigned int i;
>> > +
>> > +       for (i = 0; (pm_data->release_ret_regs[i] != REG_TABLE_END); i++)
>> > +               pmu_raw_writel(EXYNOS_WAKEUP_FROM_LOWPWR,
>> > +                               pm_data->release_ret_regs[i]);
>> > +}
>> > +
>> >  static void exynos_pm_resume(void)
>> >  {
>> >         if (exynos_pm_central_resume())
>> > @@ -294,18 +338,11 @@ static void exynos_pm_resume(void)
>> >                 exynos_cpu_restore_register();
>> >
>> >         /* For release retention */
>> > +       exynos_pm_release_retention();
>> >
>> > -       pmu_raw_writel((1 << 28), S5P_PAD_RET_MAUDIO_OPTION);
>> > -       pmu_raw_writel((1 << 28), S5P_PAD_RET_GPIO_OPTION);
>> > -       pmu_raw_writel((1 << 28), S5P_PAD_RET_UART_OPTION);
>> > -       pmu_raw_writel((1 << 28), S5P_PAD_RET_MMCA_OPTION);
>> > -       pmu_raw_writel((1 << 28), S5P_PAD_RET_MMCB_OPTION);
>> > -       pmu_raw_writel((1 << 28), S5P_PAD_RET_EBIA_OPTION);
>> > -       pmu_raw_writel((1 << 28), S5P_PAD_RET_EBIB_OPTION);
>> > -
>> > -       if (soc_is_exynos5250())
>> > -               s3c_pm_do_restore(exynos5_sys_save,
>> > -                       ARRAY_SIZE(exynos5_sys_save));
>> > +       if (pm_data->extra_save)
>> > +               s3c_pm_do_restore_core(pm_data->extra_save,
>> > +                                       pm_data->num_extra_save);
>> >
>> >         s3c_pm_do_restore_core(exynos_core_save, ARRAY_SIZE(exynos_core_save));
>> >
>> > @@ -316,15 +353,8 @@ early_wakeup:
>> >
>> >         /* Clear SLEEP mode set in INFORM1 */
>> >         pmu_raw_writel(0x0, S5P_INFORM1);
>> > -
>> > -       return;
>> >  }
>> >
>> > -static struct syscore_ops exynos_pm_syscore_ops = {
>> > -       .suspend        = exynos_pm_suspend,
>> > -       .resume         = exynos_pm_resume,
>> > -};
>> > -
>> >  /*
>> >   * Suspend Ops
>> >   */
>> > @@ -348,11 +378,12 @@ static int exynos_suspend_enter(suspend_state_t state)
>> >         }
>> >
>> >         s3c_pm_save_uarts();
>> > -       exynos_pm_prepare();
>> > +       if (pm_data->pm_prepare)
>> > +               pm_data->pm_prepare();
>> >         flush_cache_all();
>> >         s3c_pm_check_store();
>> >
>> > -       ret = cpu_suspend(0, exynos_cpu_suspend);
>> > +       ret = cpu_suspend(0, pm_data->cpu_suspend);
>> >         if (ret)
>> >                 return ret;
>> >
>> > @@ -387,18 +418,70 @@ static const struct platform_suspend_ops exynos_suspend_ops = {
>> >         .valid          = suspend_valid_only_mem,
>> >  };
>> >
>> > +static const struct exynos_pm_data exynos4_pm_data = {
>> > +       .wkup_irq       = exynos4_wkup_irq,
>> > +       .wake_disable_mask = ((0xFF << 8) | (0x1F << 1)),
>> > +       .release_ret_regs = exynos_release_ret_regs,
>> > +       .pm_suspend     = exynos_pm_suspend,
>> > +       .pm_resume      = exynos_pm_resume,
>> > +       .pm_prepare     = exynos_pm_prepare,
>> > +       .cpu_suspend    = exynos_cpu_suspend,
>> > +};
>> > +
>> > +static const struct exynos_pm_data exynos5250_pm_data = {
>> > +       .wkup_irq       = exynos5250_wkup_irq,
>> > +       .wake_disable_mask = ((0xFF << 8) | (0x1F << 1)),
>> > +       .release_ret_regs = exynos_release_ret_regs,
>> > +       .extra_save     = exynos5_sys_save,
>> > +       .num_extra_save = ARRAY_SIZE(exynos5_sys_save),
>> > +       .pm_suspend     = exynos_pm_suspend,
>> > +       .pm_resume      = exynos_pm_resume,
>> > +       .pm_prepare     = exynos_pm_prepare,
>> > +       .cpu_suspend    = exynos_cpu_suspend,
>> > +};
>> > +
>> > +static struct of_device_id exynos_pmu_of_device_ids[] = {
>> > +       {
>> > +               .compatible = "samsung,exynos4210-pmu",
>> > +               .data = &exynos4_pm_data,
>> > +       }, {
>> > +               .compatible = "samsung,exynos4212-pmu",
>> > +               .data = &exynos4_pm_data,
>> > +       }, {
>> > +               .compatible = "samsung,exynos4412-pmu",
>> > +               .data = &exynos4_pm_data,
>> > +       }, {
>> > +               .compatible = "samsung,exynos5250-pmu",
>> > +               .data = &exynos5250_pm_data,
>> > +       },
>> > +       { /*sentinel*/ },
>> > +};
>> > +
>> > +static struct syscore_ops exynos_pm_syscore_ops;
>> > +
>> >  void __init exynos_pm_init(void)
>> >  {
>> > +       const struct of_device_id *match;
>> >         u32 tmp;
>> >
>> > +       of_find_matching_node_and_match(NULL, exynos_pmu_of_device_ids, &match);
>> > +       if (!match) {
>> > +               pr_err("Failed to find PMU node\n");
>> > +               return;
>> > +       }
>> > +       pm_data = (struct exynos_pm_data *) match->data;
>> > +
>> >         /* Platform-specific GIC callback */
>> >         gic_arch_extn.irq_set_wake = exynos_irq_set_wake;
>> >
>> >         /* All wakeup disable */
>> >         tmp = pmu_raw_readl(S5P_WAKEUP_MASK);
>> > -       tmp |= ((0xFF << 8) | (0x1F << 1));
>> > +       tmp |= pm_data->wake_disable_mask;
>> >         pmu_raw_writel(tmp, S5P_WAKEUP_MASK);
>> >
>> > +       exynos_pm_syscore_ops.suspend   = pm_data->pm_suspend;
>> > +       exynos_pm_syscore_ops.resume    = pm_data->pm_resume;
>> > +
>> >         register_syscore_ops(&exynos_pm_syscore_ops);
>> >         suspend_set_ops(&exynos_suspend_ops);
>> >  }
>> > diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
>> > index 96a1569..30c0301 100644
>> > --- a/arch/arm/mach-exynos/regs-pmu.h
>> > +++ b/arch/arm/mach-exynos/regs-pmu.h
>> > @@ -21,6 +21,7 @@
>> >  #define S5P_USE_STANDBY_WFI0                   (1 << 16)
>> >  #define S5P_USE_STANDBY_WFE0                   (1 << 24)
>> >
>> > +#define EXYNOS_WAKEUP_FROM_LOWPWR              (1 << 28)
>> >  #define EXYNOS_SWRESET                         0x0400
>> >  #define EXYNOS5440_SWRESET                     0x00C4
>
