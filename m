From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 17 Oct 2018 16:29:15 +0200
Subject: [PATCH v3 3/6] clocksource: exynos_mct: Refactor resources
 allocation
In-Reply-To: <20181017134159.9656-4-m.szyprowski@samsung.com>
References: <CGME20181017134206eucas1p1ebc76569f706675d41f2d2183349f1f3@eucas1p1.samsung.com>
 <20181017134159.9656-1-m.szyprowski@samsung.com>
 <20181017134159.9656-4-m.szyprowski@samsung.com>
Message-ID: <CAJKOXPcMPz0wsEU9Lt1e0dp7tEk9+t8kteW=hih7sNsp99Dkkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Oct 2018 at 15:42, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Move interrupts allocation from exynos4_timer_resources() into separate
> function together with the interrupt number parsing code from
> mct_init_dt(), so the code for managing interrupts is kept together.
> While touching exynos4_timer_resources() function, move of_iomap() to it.
> No functional changes.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/clocksource/exynos_mct.c | 49 +++++++++++++++++++-------------
>  1 file changed, 30 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index 49413900b24c..02ad55db390b 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -502,11 +502,14 @@ static int exynos4_mct_dying_cpu(unsigned int cpu)
>         return 0;
>  }
>
> -static int __init exynos4_timer_resources(struct device_node *np, void __iomem *base)
> +static int __init exynos4_timer_resources(struct device_node *np)
>  {
> -       int err, cpu;
>         struct clk *mct_clk, *tick_clk;
>
> +       reg_base = of_iomap(np, 0);
> +       if (!reg_base)
> +               panic("%s: unable to ioremap mct address space\n", __func__);
> +
>         tick_clk = of_clk_get_by_name(np, "fin_pll");
>         if (IS_ERR(tick_clk))
>                 panic("%s: unable to determine tick clock rate\n", __func__);
> @@ -517,9 +520,27 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
>                 panic("%s: unable to retrieve mct clock instance\n", __func__);
>         clk_prepare_enable(mct_clk);
>
> -       reg_base = base;
> -       if (!reg_base)
> -               panic("%s: unable to ioremap mct address space\n", __func__);
> +       return 0;
> +}
> +
> +static int __init exynos4_timer_interrupts(struct device_node *np,
> +                                          unsigned int int_type)
> +{
> +       int i, err, cpu;
> +
> +       mct_int_type = int_type;

This does not look good. Before, assignment was done before call to
exynos4_timer_resources(). Now, if I follow the path correctly, it
will be after. Therefore the exynos4_timer_resources() will use wrong
value. This should pop up during tests.

Best regards,
Krzysztof

> +
> +       /* This driver uses only one global timer interrupt */
> +       mct_irqs[MCT_G0_IRQ] = irq_of_parse_and_map(np, MCT_G0_IRQ);
> +
> +       /*
> +        * Find out the number of local irqs specified. The local
> +        * timer irqs are specified after the four global timer
> +        * irqs are specified.
> +        */
> +       nr_irqs = of_irq_count(np);
> +       for (i = MCT_L0_IRQ; i < nr_irqs; i++)
> +               mct_irqs[i] = irq_of_parse_and_map(np, i);
>
>         if (mct_int_type == MCT_INT_PPI) {
>
> @@ -579,24 +600,14 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
>
>  static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
>  {
> -       u32 nr_irqs, i;
>         int ret;
>
> -       mct_int_type = int_type;
> -
> -       /* This driver uses only one global timer interrupt */
> -       mct_irqs[MCT_G0_IRQ] = irq_of_parse_and_map(np, MCT_G0_IRQ);
> +       ret = exynos4_timer_resources(np);
> +       if (ret)
> +               return ret;
>
> -       /*
> -        * Find out the number of local irqs specified. The local
> -        * timer irqs are specified after the four global timer
> -        * irqs are specified.
> -        */
> -       nr_irqs = of_irq_count(np);
> -       for (i = MCT_L0_IRQ; i < nr_irqs; i++)
> -               mct_irqs[i] = irq_of_parse_and_map(np, i);
>
> -       ret = exynos4_timer_resources(np, of_iomap(np, 0));
> +       ret = exynos4_timer_interrupts(np, int_type);
>         if (ret)
>                 return ret;
>
> --
> 2.17.1
>
