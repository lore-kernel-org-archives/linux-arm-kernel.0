From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 14 Jun 2018 14:39:37 +0900
Subject: [PATCH] gpio: uniphier: set legitimate irq trigger type in
 .to_irq hook
In-Reply-To: <1528954065-25563-1-git-send-email-yamada.masahiro@socionext.com>
References: <1528954065-25563-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNASh4j2nTbemsPmQXOnCrqJ4BQ0-PnWHQsUe-qa4KzpDLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-06-14 14:27 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> If a GPIO chip is a part of a hierarchy IRQ domain, there is no
> way to specify the trigger type when gpio(d)_to_irq() allocates an
> interrupt on-the-fly.
>
> Currently, uniphier_gpio_to_irq() sets IRQ_TYPE_NONE, but it causes
> an error in the .alloc() hook of the parent domain.
> (drivers/irq/irq-uniphier-aidet.c)
>
> Even if we change irq-uniphier-aidet.c to accept the NONE type,
> GIC complains about it since commit 83a86fbb5b56 ("irqchip/gic:
> Loudly complain about the use of IRQ_TYPE_NONE").
>
> Instead, use IRQ_TYPE_LEVEL_HIGH as a temporary value when an irq
> is allocated.  irq_set_irq_type() will override it when the irq is
> really requested.
>
> Fixes: dbe776c2ca54 ("gpio: uniphier: add UniPhier GPIO controller driver")
> Reported-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Tested-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> ---

BTW, gpio-xgene-sb.c is also suspicious.
https://github.com/torvalds/linux/blob/v4.17/drivers/gpio/gpio-xgene-sb.c#L136


I do not have that hardware, but GIC will complain about NONE type
if gpio(d)_to_irq() is used.



Commit 83a86fbb5b56 ("irqchip/gic: Loudly complain about the use of
IRQ_TYPE_NONE")
only mentions DT cases.

It is unclear how to take care of GPIO-originated IRQs.




>  drivers/gpio/gpio-uniphier.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-uniphier.c b/drivers/gpio/gpio-uniphier.c
> index d3cf950..58faeb1 100644
> --- a/drivers/gpio/gpio-uniphier.c
> +++ b/drivers/gpio/gpio-uniphier.c
> @@ -181,7 +181,11 @@ static int uniphier_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
>         fwspec.fwnode = of_node_to_fwnode(chip->parent->of_node);
>         fwspec.param_count = 2;
>         fwspec.param[0] = offset - UNIPHIER_GPIO_IRQ_OFFSET;
> -       fwspec.param[1] = IRQ_TYPE_NONE;
> +       /*
> +        * IRQ_TYPE_NONE is rejected by the parent irq domain. Set LEVEL_HIGH
> +        * temporarily. Anyway, ->irq_set_type() will override it later.
> +        */
> +       fwspec.param[1] = IRQ_TYPE_LEVEL_HIGH;
>
>         return irq_create_fwspec_mapping(&fwspec);
>  }
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
