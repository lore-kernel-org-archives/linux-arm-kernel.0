From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 Mar 2013 07:35:41 +0100
Subject: [PATCH v2 05/14] ARM: integrator: use clocksource_of_init for
 sp804
In-Reply-To: <1363108124-17484-6-git-send-email-haojian.zhuang@linaro.org>
References: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
 <1363108124-17484-6-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdar6JqZUyLWDgPBCUC6BNX2BzQwLvtqnWZ_M5yu0VHqNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 6:08 PM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> Remove all code to parse sp804 in integrator platform driver. Use
> clocksource_of_init() instead since these code are implemented in sp804
> driver already.

(...)
> --- a/arch/arm/boot/dts/integratorap.dts
> +++ b/arch/arm/boot/dts/integratorap.dts
>         timer0: timer at 13000000 {
> -               compatible = "arm,integrator-timer";
> +               compatible = "arm,sp804", "arm,primecell";
>         };
>
>         timer1: timer at 13000100 {
> -               compatible = "arm,integrator-timer";
> +               compatible = "arm,sp804", "arm,primecell";
> +               arm,sp804-clockevent = <0>;
> +               status = "ok";
>         };
>
>         timer2: timer at 13000200 {
> -               compatible = "arm,integrator-timer";
> +               compatible = "arm,sp804", "arm,primecell";
> +               arm,sp804-clocksource = <0>;
> +               status = "ok";
>         };

This is wrong. The Integrator/AP timer is not an SP804.
It may look similar but it's a totally different kind of beast.

What is needed is to break out the timer code from
integrator_ap.c and move it to drivers/clocksource,
but wait with that until you fixed the SP804 in the
Integrator/CP, which is probably what you want to
prioritize.

(...)
> --- a/arch/arm/mach-integrator/Kconfig
> +++ b/arch/arm/mach-integrator/Kconfig
(...)
> -static void __init ap_of_timer_init(void)
> -{
> -       struct device_node *node;
> -       const char *path;
> -       void __iomem *base;
> -       int err;
> -       int irq;
> -       struct clk *clk;
> -       unsigned long rate;
> -
> -       clk = clk_get_sys("ap_timer", NULL);

As you see you are not changing this clock lookup either, which
will never work.

Please restrict the patch to altering Integrator/CP.

Yours,
Linus Walleij
