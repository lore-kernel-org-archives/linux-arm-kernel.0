From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Aug 2016 10:41:16 +0200
Subject: [PATCH 02/12] pinctrl: Add core pinctrl support for Aspeed SoCs
In-Reply-To: <1468994313-13538-3-git-send-email-andrew@aj.id.au>
References: <1468994313-13538-1-git-send-email-andrew@aj.id.au>
 <1468994313-13538-3-git-send-email-andrew@aj.id.au>
Message-ID: <CACRpkdZ0p+jNHBV1AqhVWQ2Q8RRrHVfsAz3XU3_+f6My22=Zxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2016 at 7:58 AM, Andrew Jeffery <andrew@aj.id.au> wrote:

> --- a/arch/arm/mach-aspeed/Kconfig
> +++ b/arch/arm/mach-aspeed/Kconfig
> @@ -5,6 +5,7 @@ menuconfig ARCH_ASPEED
>         select WATCHDOG
>         select ASPEED_WATCHDOG
>         select MOXART_TIMER
> +       select PINCTRL
>         help
>           Say Y here if you want to run your kernel on an ASpeed BMC SoC.

This needs to be a separate patch sent to the ARM SoC tree.
I don't like to merge patches to other subsystems if it can be
avoided.

> +static inline void aspeed_sig_desc_print_val(
> +               const struct aspeed_sig_desc *desc, bool enable, u32 rv)
> +{
> +#if defined(CONFIG_DEBUG_PINCTRL)
> +       pr_debug("SCU%x[0x%08x]=0x%x, got 0x%x from 0x%08x\n", desc->reg,
> +                       desc->mask, enable ? desc->enable : desc->disable,
> +                       (rv & desc->mask) >> __ffs(desc->mask), rv);
> +#endif
> +}

You can just use pr_debug(). CONFIG_DEBUG_PINCTRL enables
DEBUG_KERNEL which activates debug prints so this is a truism.

> +static bool aspeed_sig_desc_eval(const struct aspeed_sig_desc *desc,
> +               bool enabled, struct regmap *map)
> +static bool aspeed_sig_expr_eval(const struct aspeed_sig_expr *expr,
> +               bool enabled, struct regmap *map)

These need kerneldoc too, they are kind of hard to understand.

> +static bool aspeed_gpio_in_exprs(const struct aspeed_sig_expr **exprs)
> +{
> +       if (!exprs)
> +               return false;
> +
> +       while (*exprs) {
> +               if (strncmp((*exprs)->signal, "GPIO", 4) == 0)
> +                       return true;

This looks a bit fragile and hard to debug. Do you have some better
idea of how to do this but not resort to string comparison?

Apart from that it looks pretty alright, complex but such is life
with complex hardware.

Yours,
Linus Walleij
