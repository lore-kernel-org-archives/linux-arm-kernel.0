From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 16 Jun 2013 12:35:43 +0200
Subject: [PATCH 5/5] pinctrl: rockchip: correctly handle arguments of
 pinconf options
In-Reply-To: <201306141744.21117.heiko@sntech.de>
References: <201306141741.46077.heiko@sntech.de>
 <201306141744.21117.heiko@sntech.de>
Message-ID: <CACRpkdY6pmS=5rphvYdt_8yKYJq8ADu0omy48ncZ3LFtEUf7yg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 5:44 PM, Heiko St?bner <heiko@sntech.de> wrote:

> Change the rockchip pinctrl driver to handle the arguments of 0 or 1 to
> the pull pinconfig options correctly, so that the pull gets disabled when
> either the bias_disable options is set or the pull option has the argument 0.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Patch applied so we can move ahead but:

>         case PIN_CONFIG_BIAS_PULL_UP:
>         case PIN_CONFIG_BIAS_PULL_DOWN:
>         case PIN_CONFIG_BIAS_PULL_PIN_DEFAULT:
> +               if (!rockchip_pinconf_pull_valid(info->ctrl, param))
> +                       return -ENOTSUPP;
> +
> +               if (!arg)
> +                       param = PIN_CONFIG_BIAS_DISABLE;

This is what I think is counter-intuitive.

Can't you rely on the bias-disable here instead?

> -               *config = 0;
> +               pull = rockchip_get_pull(bank, pin - bank->pin_base);
> +               *config = (pull == param) ? 1 : 0;

And then I guess you should emit PIN_CONFIG_BIAS_DISABLE
here as well.

Yours,
Linus Walleij
