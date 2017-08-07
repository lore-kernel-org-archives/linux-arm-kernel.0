From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Aug 2017 14:42:19 +0200
Subject: [PATCH] gpio: uniphier: add UniPhier GPIO controller driver
In-Reply-To: <1501758371-25316-1-git-send-email-yamada.masahiro@socionext.com>
References: <1501758371-25316-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdZWxjwDnVy5f2rLAWs=+T=5SnwyU8dz1FW1eg8dk8JN_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 3, 2017 at 1:06 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> This GPIO controller device is used on UniPhier SoCs.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
(...)
> +static const u32 uniphier_gpio_irq_parent_hwirqs[] = {
> +       80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95,
> +       186, 187, 188, 189, 190, 249, 250, 251,
> +};
(..)
> +               /* parent is UniPhier AIDET */
> +               parent_fwspec.fwnode = domain->parent->fwnode;
> +               parent_fwspec.param_count = 2;
> +               parent_fwspec.param[0] = uniphier_gpio_irq_parent_hwirqs[hwirq];
> +               parent_fwspec.param[1] = type;
> +
> +               ret = irq_domain_alloc_irqs_parent(domain, virq, 1,
> +                                                  &parent_fwspec);

This is not right.

That parent IRQ needs to come from the device tree, not from a static array
like this, and it is definately to use hierarchical irqdomain.

Please look at similar drivers merged recently for inspiration:
gpio/gpio-xgene-sb.c
pinctrl/stm32/pinctrl-stm32.c

Yours,
Linus Walleij
