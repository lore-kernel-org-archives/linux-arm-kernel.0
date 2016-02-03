From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 3 Feb 2016 15:02:03 +0800
Subject: [PATCH v2 5/5] pinctrl: sunxi: Use pin number when calling
 sunxi_pmx_set
In-Reply-To: <1454448113-18810-6-git-send-email-k@japko.eu>
References: <1454448113-18810-1-git-send-email-k@japko.eu>
 <1454448113-18810-6-git-send-email-k@japko.eu>
Message-ID: <CAGb2v66+cmHv-NBHCnYcZ_K42qxM=5+kvhazHSy2AykL8cF8tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 3, 2016 at 5:21 AM, Krzysztof Adamski <k@japko.eu> wrote:
> sunxi_pmx_set accepts pin number and then calculates offset by
> subtracting pin_base from it. sunxi_pinctrl_gpio_get, on the other hand,
> gets offset so we have to convert it to pin number so we won't get
> negative value in sunxi_pmx_set.
>
> This was only used on A10 so far, where there is only one GPIO chip with
> pin_base set to 0 so it didn't matter. However H3 also requires this
> workaround but have two pinmux sections, triggering problem for PL port.
>
> Signed-off-by: Krzysztof Adamski <k@japko.eu>
> ---
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> index 7a2465f..9e5bac9 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> @@ -460,14 +460,17 @@ static int sunxi_pinctrl_gpio_get(struct gpio_chip *chip, unsigned offset)
>         u32 set_mux = pctl->desc->irq_read_needs_mux &&
>                         test_bit(FLAG_USED_AS_IRQ, &chip->desc[offset].flags);
>         u32 val;
> +       u32 pin;
>
> -       if (set_mux)
> -               sunxi_pmx_set(pctl->pctl_dev, offset, SUN4I_FUNC_INPUT);
> +       if (set_mux) {
> +               pin = offset + pctl->desc->pin_base;

You can use chip->base directly. It's value is set to pin_base in the
init function.
You could also move this out of the if block, and not add the braces.

Otherwise this looks good.

ChenYu

> +               sunxi_pmx_set(pctl->pctl_dev, pin, SUN4I_FUNC_INPUT);
> +       }
>
>         val = (readl(pctl->membase + reg) >> index) & DATA_PINS_MASK;
>
>         if (set_mux)
> -               sunxi_pmx_set(pctl->pctl_dev, offset, SUN4I_FUNC_IRQ);
> +               sunxi_pmx_set(pctl->pctl_dev, pin, SUN4I_FUNC_IRQ);
>
>         return !!val;
>  }
> --
> 2.1.4
>
