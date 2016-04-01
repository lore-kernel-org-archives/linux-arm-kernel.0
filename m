From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 1 Apr 2016 09:33:03 -0600
Subject: [PATCH 1/2] clocksource: sp804: Add support for OX810SE 24bit
 timer width
In-Reply-To: <1459520559-13110-2-git-send-email-narmstrong@baylibre.com>
References: <1459520559-13110-1-git-send-email-narmstrong@baylibre.com>
 <1459520559-13110-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <CANLsYkyKkFZOnzQBMHUZ=_y-EfcheAfPTdUZYpPWf_EPREeO0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 April 2016 at 08:22, Neil Armstrong <narmstrong@baylibre.com> wrote:
> In order to support the Dual-Timer on the Oxford Semiconductor OX810SE SoC,
> implement variable counter width, keeping 32bit as default width.
> Add new compatible string oxsemi,ox810se-rps-timer in order to select
> the 24bit counter width.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/clocksource/timer-sp804.c | 107 ++++++++++++++++++++++++--------------
>  include/clocksource/timer-sp804.h |  42 ++++++++++++---
>  2 files changed, 102 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
> index 5f45b9a..e99269a 100644
> --- a/drivers/clocksource/timer-sp804.c
> +++ b/drivers/clocksource/timer-sp804.c
> @@ -77,15 +77,15 @@ void __init sp804_timer_disable(void __iomem *base)
>         writel(0, base + TIMER_CTRL);
>  }
>
> -void __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
> -                                                    const char *name,
> -                                                    struct clk *clk,
> -                                                    int use_sched_clock)
> +void __init __sp804_clocksource_and_sched_clock_init(struct timer_sp804 *sp804,
> +                                                    bool use_sched_clock)
>  {
>         long rate;
> +       u32 config = TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC;
> +       struct clk *clk = sp804->clocksource_clk;
>
>         if (!clk) {
> -               clk = clk_get_sys("sp804", name);
> +               clk = clk_get_sys("sp804", sp804->name);
>                 if (IS_ERR(clk)) {
>                         pr_err("sp804: clock not found: %d\n",
>                                (int)PTR_ERR(clk));
> @@ -98,19 +98,22 @@ void __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
>         if (rate < 0)
>                 return;
>
> +       if (sp804->width == 32)
> +               config |= TIMER_CTRL_32BIT;
> +
>         /* setup timer 0 as free-running clocksource */
> -       writel(0, base + TIMER_CTRL);
> -       writel(0xffffffff, base + TIMER_LOAD);
> -       writel(0xffffffff, base + TIMER_VALUE);
> -       writel(TIMER_CTRL_32BIT | TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC,
> -               base + TIMER_CTRL);
> +       writel(0, sp804->clocksource_base + TIMER_CTRL);
> +       writel(0xffffffff, sp804->clocksource_base + TIMER_LOAD);
> +       writel(0xffffffff, sp804->clocksource_base + TIMER_VALUE);
> +       writel(config, sp804->clocksource_base + TIMER_CTRL);
>
> -       clocksource_mmio_init(base + TIMER_VALUE, name,
> -               rate, 200, 32, clocksource_mmio_readl_down);
> +       clocksource_mmio_init(sp804->clocksource_base + TIMER_VALUE,
> +                             sp804->name, rate, 200, sp804->width,
> +                             clocksource_mmio_readl_down);
>
>         if (use_sched_clock) {
> -               sched_clock_base = base;
> -               sched_clock_register(sp804_read, 32, rate);
> +               sched_clock_base = sp804->clocksource_base;
> +               sched_clock_register(sp804_read, sp804->width, rate);
>         }
>  }
>
> @@ -186,15 +189,16 @@ static struct irqaction sp804_timer_irq = {
>         .dev_id         = &sp804_clockevent,
>  };
>
> -void __init __sp804_clockevents_init(void __iomem *base, unsigned int irq, struct clk *clk, const char *name)
> +void __init __sp804_clockevents_init(struct timer_sp804 *sp804)
>  {
>         struct clock_event_device *evt = &sp804_clockevent;
>         long rate;
> +       struct clk *clk = sp804->clockevent_clk;
>
>         if (!clk)
> -               clk = clk_get_sys("sp804", name);
> +               clk = clk_get_sys("sp804", sp804->name);
>         if (IS_ERR(clk)) {
> -               pr_err("sp804: %s clock not found: %d\n", name,
> +               pr_err("sp804: %s clock not found: %d\n", sp804->name,
>                         (int)PTR_ERR(clk));
>                 return;
>         }
> @@ -203,26 +207,27 @@ void __init __sp804_clockevents_init(void __iomem *base, unsigned int irq, struc
>         if (rate < 0)
>                 return;
>
> -       clkevt_base = base;
> +       clkevt_base = sp804->clockevent_base;
>         clkevt_reload = DIV_ROUND_CLOSEST(rate, HZ);
> -       evt->name = name;
> -       evt->irq = irq;
> +       evt->name = sp804->name;
> +       evt->irq = sp804->irq;
>         evt->cpumask = cpu_possible_mask;
>
> -       writel(0, base + TIMER_CTRL);
> +       writel(0, sp804->clockevent_base + TIMER_CTRL);
>
> -       setup_irq(irq, &sp804_timer_irq);
> -       clockevents_config_and_register(evt, rate, 0xf, 0xffffffff);
> +       setup_irq(sp804->irq, &sp804_timer_irq);
> +       clockevents_config_and_register(evt, rate, 0xf,
> +                                       GENMASK(sp804->width-1, 0));
>  }
>
>  static void __init sp804_of_init(struct device_node *np)
>  {
>         static bool initialized = false;
> +       struct timer_sp804 sp804;
>         void __iomem *base;
> -       int irq;
>         u32 irq_num = 0;
>         struct clk *clk1, *clk2;
> -       const char *name = of_get_property(np, "compatible", NULL);
> +       u32 width = 32;
>
>         base = of_iomap(np, 0);
>         if (WARN_ON(!base))
> @@ -250,19 +255,33 @@ static void __init sp804_of_init(struct device_node *np)
>         } else
>                 clk2 = clk1;
>
> -       irq = irq_of_parse_and_map(np, 0);
> -       if (irq <= 0)
> +       sp804.irq = irq_of_parse_and_map(np, 0);
> +       if (sp804.irq <= 0)
>                 goto err;
>
> +       /* OX810SE Uses a special 24bit width */
> +       if (of_device_is_compatible(np, "oxsemi,ox810se-rps-timer"))
> +               width = 24;

Wouldn't it be better to add a new optional property for this?  If the
property is not specified then we default to a width of 32.  Otherwise
the new width is configured.  That way we don't have to add a new
compatible string every time (however often) a special width is
encountered.

Otherwise I think the code facelift looks good,
Mathieu

> +
>         of_property_read_u32(np, "arm,sp804-has-irq", &irq_num);
>         if (irq_num == 2) {
> -               __sp804_clockevents_init(base + TIMER_2_BASE, irq, clk2, name);
> -               __sp804_clocksource_and_sched_clock_init(base, name, clk1, 1);
> +               sp804.clockevent_base = base + TIMER_2_BASE;
> +               sp804.clocksource_base = base;
> +               sp804.clockevent_clk = clk2;
> +               sp804.clocksource_clk = clk1;
>         } else {
> -               __sp804_clockevents_init(base, irq, clk1 , name);
> -               __sp804_clocksource_and_sched_clock_init(base + TIMER_2_BASE,
> -                                                        name, clk2, 1);
> +               sp804.clockevent_base = base;
> +               sp804.clocksource_base = base + TIMER_2_BASE;
> +               sp804.clockevent_clk = clk1;
> +               sp804.clocksource_clk = clk2;
>         }
> +
> +       sp804.name = of_get_property(np, "compatible", NULL);
> +       sp804.width = width;
> +
> +       __sp804_clockevents_init(&sp804);
> +       __sp804_clocksource_and_sched_clock_init(&sp804, true);
> +
>         initialized = true;
>
>         return;
> @@ -270,13 +289,13 @@ err:
>         iounmap(base);
>  }
>  CLOCKSOURCE_OF_DECLARE(sp804, "arm,sp804", sp804_of_init);
> +CLOCKSOURCE_OF_DECLARE(ox810se, "oxsemi,ox810se-rps-timer", sp804_of_init);
>
>  static void __init integrator_cp_of_init(struct device_node *np)
>  {
>         static int init_count = 0;
> +       struct timer_sp804 sp804;
>         void __iomem *base;
> -       int irq;
> -       const char *name = of_get_property(np, "compatible", NULL);
>         struct clk *clk;
>
>         base = of_iomap(np, 0);
> @@ -292,14 +311,22 @@ static void __init integrator_cp_of_init(struct device_node *np)
>         if (init_count == 2 || !of_device_is_available(np))
>                 goto err;
>
> -       if (!init_count)
> -               __sp804_clocksource_and_sched_clock_init(base, name, clk, 0);
> -       else {
> -               irq = irq_of_parse_and_map(np, 0);
> -               if (irq <= 0)
> +       sp804.name = of_get_property(np, "compatible", NULL);
> +       sp804.width = 32;
> +
> +       if (!init_count) {
> +               sp804.clocksource_base = base;
> +               sp804.clocksource_clk = clk;
> +
> +               __sp804_clocksource_and_sched_clock_init(&sp804, false);
> +       } else {
> +               sp804.clockevent_base = base;
> +               sp804.clockevent_clk = clk;
> +               sp804.irq = irq_of_parse_and_map(np, 0);
> +               if (sp804.irq <= 0)
>                         goto err;
>
> -               __sp804_clockevents_init(base, irq, clk, name);
> +               __sp804_clockevents_init(&sp804);
>         }
>
>         init_count++;
> diff --git a/include/clocksource/timer-sp804.h b/include/clocksource/timer-sp804.h
> index 1f8a1ca..928091b 100644
> --- a/include/clocksource/timer-sp804.h
> +++ b/include/clocksource/timer-sp804.h
> @@ -3,26 +3,54 @@
>
>  struct clk;
>
> -void __sp804_clocksource_and_sched_clock_init(void __iomem *,
> -                                             const char *, struct clk *, int);
> -void __sp804_clockevents_init(void __iomem *, unsigned int,
> -                             struct clk *, const char *);
> +struct timer_sp804 {
> +       void __iomem *clockevent_base;
> +       void __iomem *clocksource_base;
> +       const char *name;
> +       struct clk *clockevent_clk;
> +       struct clk *clocksource_clk;
> +       unsigned int irq;
> +       unsigned int width;
> +};
> +
> +void __sp804_clocksource_and_sched_clock_init(struct timer_sp804 *sp804, bool);
> +void __sp804_clockevents_init(struct timer_sp804 *sp804);
>  void sp804_timer_disable(void __iomem *);
>
>  static inline void sp804_clocksource_init(void __iomem *base, const char *name)
>  {
> -       __sp804_clocksource_and_sched_clock_init(base, name, NULL, 0);
> +       struct timer_sp804 sp804 = {
> +               .clocksource_base = base,
> +               .name = name,
> +               .clocksource_clk = NULL,
> +               .width = 32,
> +       };
> +
> +       __sp804_clocksource_and_sched_clock_init(&sp804, false);
>  }
>
>  static inline void sp804_clocksource_and_sched_clock_init(void __iomem *base,
>                                                           const char *name)
>  {
> -       __sp804_clocksource_and_sched_clock_init(base, name, NULL, 1);
> +       struct timer_sp804 sp804 = {
> +               .clocksource_base = base,
> +               .name = name,
> +               .clocksource_clk = NULL,
> +               .width = 32,
> +       };
> +
> +       __sp804_clocksource_and_sched_clock_init(&sp804, true);
>  }
>
>  static inline void sp804_clockevents_init(void __iomem *base, unsigned int irq, const char *name)
>  {
> -       __sp804_clockevents_init(base, irq, NULL, name);
> +       struct timer_sp804 sp804 = {
> +               .clockevent_base = base,
> +               .name = name,
> +               .clockevent_clk = NULL,
> +               .width = 32,
> +       };
>
> +       __sp804_clockevents_init(&sp804);
>  }
>  #endif
> --
> 1.9.1
>
