From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 Aug 2012 15:49:01 +0200
Subject: [PATCH 03/11] pinctrl: mvebu: kirkwood pinctrl driver
In-Reply-To: <1344689809-6223-4-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1344689809-6223-4-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CACRpkdbG4jkFcVP_6AmAZzciffQCamKXw7PcFnTdccyq7AMa8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 11, 2012 at 2:56 PM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> This patch adds a SoC specific pinctrl driver for Marvell Kirkwood SoCs
> plus DT binding documentation. This driver will use the mvebu pinctrl
> driver core.

Thanks for working on Kirkwood. Love this platform.

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index cd3d827..361f513 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -596,6 +596,7 @@ config ARCH_KIRKWOOD
>         select GENERIC_CLOCKEVENTS
>         select NEED_MACH_IO_H
>         select PLAT_ORION
> +       select PINCTRL

select PINCTRL_KIRKWOOD too I think.
Then it's just automatic.

> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index e2427eb..1f84090 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -147,7 +147,7 @@ config PINCTRL_COH901
>
>  config PINCTRL_MVEBU
>         bool "Marvell SoC pin controller drivers"
> -       depends on ARCH_MVEBU || ARCH_DOVE
> +       depends on ARCH_MVEBU || ARCH_DOVE || ARCH_KIRKWOOD

As stated elsewhere I think this should be
depends on PLAT_ORION

> +config PINCTRL_KIRKWOOD
> +       bool "Support for Marvell Kirkwood SoCs"
> +       depends on PINCTRL_MVEBU

depends on ARCH_KIRKWOOD
select PINCTRL_MVEBU

(...)
> diff --git a/drivers/pinctrl/pinctrl-kirkwood.c b/drivers/pinctrl/pinctrl-kirkwood.c
> +static struct mvebu_pinctrl_soc_info kirkwood_pinctrl_info;
> +
> +static struct of_device_id kirkwood_pinctrl_of_match[] __devinitdata = {
> +       { .compatible = "marvell,88f6180-pinctrl",
> +                                         .data = (void *)VARIANT_MV88F6180 },
> +       { .compatible = "marvell,88f6190-pinctrl",
> +                                         .data = (void *)VARIANT_MV88F6190 },
> +       { .compatible = "marvell,88f6192-pinctrl",
> +                                         .data = (void *)VARIANT_MV88F6192 },
> +       { .compatible = "marvell,88f6281-pinctrl",
> +                                         .data = (void *)VARIANT_MV88F6281 },
> +       { .compatible = "marvell,88f6282-pinctrl",
> +                                         .data = (void *)VARIANT_MV88F6282 },
> +       { }
> +};

I'm thinking this variant should maybe be an enum... unless it is
strongly established somewhere in Orion/Marvell stuff.

> +static int __devinit kirkwood_pinctrl_probe(struct platform_device *pdev)
> +{
> +       struct mvebu_pinctrl_soc_info *soc = &kirkwood_pinctrl_info;
> +       const struct of_device_id *match =
> +               of_match_device(kirkwood_pinctrl_of_match, &pdev->dev);
> +
> +       if (match) {
> +               soc->variant = (unsigned)match->data & 0xff;
> +               switch (soc->variant) {
> +               case VARIANT_MV88F6180:
> +                       soc->controls = mv88f6180_mpp_controls;
> +                       soc->ncontrols = ARRAY_SIZE(mv88f6180_mpp_controls);
> +                       soc->modes = mv88f6xxx_mpp_modes;
> +                       soc->nmodes = ARRAY_SIZE(mv88f6xxx_mpp_modes);
> +                       soc->gpioranges = mv88f6180_gpio_ranges;
> +                       soc->ngpioranges = ARRAY_SIZE(mv88f6180_gpio_ranges);
> +                       break;
> +               case VARIANT_MV88F6190:
> +               case VARIANT_MV88F6192:
> +                       soc->controls = mv88f619x_mpp_controls;
> +                       soc->ncontrols = ARRAY_SIZE(mv88f619x_mpp_controls);
> +                       soc->modes = mv88f6xxx_mpp_modes;
> +                       soc->nmodes = ARRAY_SIZE(mv88f6xxx_mpp_modes);
> +                       soc->gpioranges = mv88f619x_gpio_ranges;
> +                       soc->ngpioranges = ARRAY_SIZE(mv88f619x_gpio_ranges);
> +                       break;
> +               case VARIANT_MV88F6281:
> +               case VARIANT_MV88F6282:
> +                       soc->controls = mv88f628x_mpp_controls;
> +                       soc->ncontrols = ARRAY_SIZE(mv88f628x_mpp_controls);
> +                       soc->modes = mv88f6xxx_mpp_modes;
> +                       soc->nmodes = ARRAY_SIZE(mv88f6xxx_mpp_modes);
> +                       soc->gpioranges = mv88f628x_gpio_ranges;
> +                       soc->ngpioranges = ARRAY_SIZE(mv88f628x_gpio_ranges);
> +                       break;
> +               }
> +               pdev->dev.platform_data = soc;
> +       }
> +       return mvebu_pinctrl_probe(pdev);
> +}

This is looking real good, clean & nice.

No further comments on this driver.

Yours,
Linus Walleij
