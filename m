From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 1 Dec 2015 11:09:26 +0100
Subject: [PATCH] ARM: ep93xx: Fix clocksource registration
In-Reply-To: <565513EA.6020603@gmail.com>
References: <565513EA.6020603@gmail.com>
Message-ID: <CACRpkdZy7TnrmkWrRerjm6dZW9m65Dsc_kp8TPHzbhTxz5Hbrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 2:50 AM, Alexander Sverdlin
<alexander.sverdlin@gmail.com> wrote:

> clocksource_mmio_init() explicitly checks for counter's width and refuses to
> register anything with resolution higher than 32 bits. We need to use
> clocksource_register_hz() directly to repair HIGH_RES_TIMERS.

Maybe tglx want to jump in on this.

Isn't it better to fix clocksource_mmio_init() to accept > 32 bits?

What is really prompting this in drivers/clocksource/mmio.c:

if (bits > 32 || bits < 16)
                return -EINVAL;


> +static struct clocksource timer4_clocksource = {
> +       .name   = "timer4",
> +       .rating = 200,
> +       .read   = ep93xx_clocksource_read,
> +       .mask   = CLOCKSOURCE_MASK(40),
> +       .flags  = CLOCK_SOURCE_IS_CONTINUOUS,
> +};
> +
>  static int ep93xx_clkevt_set_next_event(unsigned long next,
>                                         struct clock_event_device *evt)
>  {
> @@ -128,9 +136,8 @@ void __init ep93xx_timer_init(void)
>         /* Enable and register clocksource and sched_clock on timer 4 */
>         writel(EP93XX_TIMER4_VALUE_HIGH_ENABLE,
>                EP93XX_TIMER4_VALUE_HIGH);
> -       clocksource_mmio_init(NULL, "timer4",
> -                             EP93XX_TIMER4_RATE, 200, 40,
> -                             ep93xx_clocksource_read);
> +       if (clocksource_register_hz(&timer4_clocksource, EP93XX_TIMER4_RATE))
> +               pr_warn("Failed to register Timer4 as clocksource");
>         sched_clock_register(ep93xx_read_sched_clock, 40,
>                              EP93XX_TIMER4_RATE);

Isn't this a better fix:

diff --git a/drivers/clocksource/mmio.c b/drivers/clocksource/mmio.c
index 1593ade2a815..c4f7d7a9b689 100644
--- a/drivers/clocksource/mmio.c
+++ b/drivers/clocksource/mmio.c
@@ -55,7 +55,7 @@ int __init clocksource_mmio_init(void __iomem *base,
const char *name,
 {
        struct clocksource_mmio *cs;

-       if (bits > 32 || bits < 16)
+       if (bits > 64 || bits < 16)
                return -EINVAL;

        cs = kzalloc(sizeof(struct clocksource_mmio), GFP_KERNEL);

Yours,
Linus Walleij
