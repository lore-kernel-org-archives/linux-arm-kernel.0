From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 Apr 2016 15:42:07 +0200
Subject: [PATCH 1/2] pinctrl: Add Oxford Semiconductor OXNAS pinctrl and
 gpio driver
In-Reply-To: <1459689969-5326-2-git-send-email-narmstrong@baylibre.com>
References: <1459689969-5326-1-git-send-email-narmstrong@baylibre.com>
 <1459689969-5326-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <CACRpkdbTSdPG3-5HmmFbtZkZLG0S3cg54gPMKCF8isegmc3tow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 3, 2016 at 3:26 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:

> Add pinctrl and gpio control support to Oxford Semiconductor OXNAS SoC Family.
> This version supports the ARM926EJ-S based OX810SE SoC with 34 IO pins.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Starting to look very nice :)

> +static inline struct oxnas_gpio_bank *irqd_to_bank(struct irq_data *d)
> +{
> +       return gpiochip_get_data(irq_data_get_irq_chip_data(d));
> +}

Do you really need to wrap this call? Seems like pointless layer of
abstraction to me.

> +       if (of_parse_phandle_with_fixed_args(np, "gpio-ranges",
> +                                            3, 0, &pinspec)) {
> +               dev_err(&pdev->dev, "gpio-ranges property not found\n");
> +               return -EINVAL;
> +       }
> +
> +       id = pinspec.args[1] / PINS_PER_BANK;
> +       ngpios = pinspec.args[2];
> +
> +       if (id >= ARRAY_SIZE(oxnas_gpio_banks)) {
> +               dev_err(&pdev->dev, "invalid gpio-ranges base arg\n");
> +               return -EINVAL;
> +       }
> +
> +       if (ngpios > PINS_PER_BANK) {
> +               dev_err(&pdev->dev, "invalid gpio-ranges count arg\n");
> +               return -EINVAL;
> +       }
> +
> +       bank = &oxnas_gpio_banks[id];

This feels a bit hackish but I guess that is how we have to do things
then :/

> +static int __init oxnas_gpio_register(void)
> +{
> +       return platform_driver_register(&oxnas_gpio_driver);
> +}
> +arch_initcall(oxnas_gpio_register);
> +
> +static int __init oxnas_pinctrl_register(void)
> +{
> +       return platform_driver_register(&oxnas_pinctrl_driver);
> +}
> +arch_initcall(oxnas_pinctrl_register);

Why do these have to be arch_initcall()?

I'm not very happy with anything below subsys_initcall()
and others prefer that you have only device_initcall().

I need some rationale. Sorry if I already asked...

Yours,
Linus Walleij
