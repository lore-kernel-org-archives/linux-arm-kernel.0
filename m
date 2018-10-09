From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 9 Oct 2018 10:19:08 +0200
Subject: [PATCH 2/7] clocksource: exynos_mct: Add arch_timer cooperation
 mode for ARM64
In-Reply-To: <20181008125009.3721-3-m.szyprowski@samsung.com>
References: <CGME20181008125047eucas1p23e520d778ad5f18aba57b21641d4cb4c@eucas1p2.samsung.com>
 <20181008125009.3721-1-m.szyprowski@samsung.com>
 <20181008125009.3721-3-m.szyprowski@samsung.com>
Message-ID: <CAJKOXPeAt_fwVCkCw-8iGprB8Y=Dxj=hx5UyJw1kjsbmMwh2pA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 8 Oct 2018 at 14:50, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> To get ARM Architected Timers working on Samsung Exynos SoCs, one has to
> first configure and enable Exynos Multi-Core Timer, because they both
> share some common hardware blocks. This patch adds a mode of cooperation
> with arch_timer driver, so kernel can use CP15 based timer interface via
> arch_timer driver, which is mandatory on ARM64. In such mode driver only
> configures MCT registers and starts the timer but don't register any
> clocksource or events in the system. Those are left to be handled by
> arch_timer driver.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/clocksource/exynos_mct.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index 43b335ff4a96..05b201ed8ef5 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -57,6 +57,7 @@
>  #define TICK_BASE_CNT  1
>
>  enum {
> +       MCT_INT_NONE = 0,
>         MCT_INT_SPI,
>         MCT_INT_PPI
>  };
> @@ -238,6 +239,9 @@ static int __init exynos4_clocksource_init(void)
>  {
>         exynos4_mct_frc_start();
>
> +       if (!mct_int_type)
> +               return 0;
> +
>  #if defined(CONFIG_ARM)
>         exynos4_delay_timer.read_current_timer = &exynos4_read_current_timer;
>         exynos4_delay_timer.freq = clk_rate;
> @@ -343,6 +347,9 @@ static struct irqaction mct_comp_event_irq = {
>
>  static int exynos4_clockevent_init(void)
>  {
> +       if (!mct_int_type)
> +               return 0;
> +
>         mct_comp_device.cpumask = cpumask_of(0);
>         clockevents_config_and_register(&mct_comp_device, clk_rate,
>                                         0xf, 0xffffffff);
> @@ -476,12 +483,12 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
>
>                 irq_force_affinity(evt->irq, cpumask_of(cpu));
>                 enable_irq(evt->irq);
> -       } else {
> +       } else if (mct_int_type == MCT_INT_PPI) {
>                 enable_percpu_irq(mct_irqs[MCT_L0_IRQ], 0);
>         }
> -       clockevents_config_and_register(evt, clk_rate / (TICK_BASE_CNT + 1),
> -                                       0xf, 0x7fffffff);
> -
> +       if (mct_int_type)
> +               clockevents_config_and_register(evt,
> +                              clk_rate / (TICK_BASE_CNT + 1), 0xf, 0x7fffffff);
>         return 0;
>  }
>
> @@ -496,7 +503,7 @@ static int exynos4_mct_dying_cpu(unsigned int cpu)
>                 if (evt->irq != -1)
>                         disable_irq_nosync(evt->irq);
>                 exynos4_mct_write(0x1, mevt->base + MCT_L_INT_CSTAT_OFFSET);
> -       } else {
> +       } else if (mct_int_type == MCT_INT_PPI) {
>                 disable_percpu_irq(mct_irqs[MCT_L0_IRQ]);
>         }
>         return 0;
> @@ -529,7 +536,7 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
>                                          &percpu_mct_tick);
>                 WARN(err, "MCT: can't request IRQ %d (%d)\n",
>                      mct_irqs[MCT_L0_IRQ], err);
> -       } else {
> +       } else if (mct_int_type == MCT_INT_SPI) {
>                 for_each_possible_cpu(cpu) {
>                         int mct_irq = mct_irqs[MCT_L0_IRQ + cpu];
>                         struct mct_clock_event_device *pcpu_mevt =

The error path of cpuhp_setup_state() does not look correct because
request_percpu_irq() was not called. The error path looks suspicious
also for MCT_INT_SPI path - the IRQs were allocated with regular
request_irq but are freed with percpu version.

> @@ -573,6 +580,15 @@ static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
>
>         mct_int_type = int_type;
>
> +       if (IS_ENABLED(CONFIG_ARM64) && IS_ENABLED(CONFIG_ARM_ARCH_TIMER)) {
> +               struct device_node *np = of_find_compatible_node(NULL, NULL,
> +                                                            "arm,armv8-timer");
> +               if (np) {
> +                       mct_int_type = MCT_INT_NONE;
> +                       of_node_put(np);

In this case, later the mct_irqs are being assigned but totally not
used. Are they needed?

Best regards,
Krzysztof

> +               }
> +       }
> +
>         /* This driver uses only one global timer interrupt */
>         mct_irqs[MCT_G0_IRQ] = irq_of_parse_and_map(np, MCT_G0_IRQ);
>
> --
> 2.17.1
>
