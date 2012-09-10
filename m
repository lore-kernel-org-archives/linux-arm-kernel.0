From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Sep 2012 22:02:41 +0200
Subject: [PATCH 1/2] i2c: s3c2410: add optional pin configuration using
 pinctrl interface
In-Reply-To: <1346923381-14144-2-git-send-email-thomas.abraham@linaro.org>
References: <1346923381-14144-1-git-send-email-thomas.abraham@linaro.org>
 <1346923381-14144-2-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CACRpkdZ7kjfDQ-CNCcCv5fQwSqMez6sKSMUMLB=0Aviboiz=2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 6, 2012 at 11:23 AM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:

> Add optional support for i2c bus pin configuration using pinctrl interface
>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
(...)
> diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
(...)
> -       else
> -               if (s3c24xx_i2c_parse_dt_gpio(i2c))
> +       } else if (!IS_ERR_OR_NULL(i2c->pctrl) &&
> +                       !IS_ERR_OR_NULL(i2c->pctrl_state)) {

You don't need to check i2c->pctrl here, just check i2c->pctrl_state.

If i2c->pctrl failed the other one will be null too, anyway.
(Or the struct isn't kzalloc:ed properly... which I assume.)

> +               if (pinctrl_select_state(i2c->pctrl, i2c->pctrl_state)) {
> +                       dev_err(i2c->dev, "failed to configure io-pins\n");
> +                       return -ENXIO;
> +               }
> +       } else if (s3c24xx_i2c_parse_dt_gpio(i2c)) {
>                         return -EINVAL;
> +       }
>
>         /* write slave address */
>
> @@ -1013,6 +1022,10 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
>         i2c->adap.algo_data = i2c;
>         i2c->adap.dev.parent = &pdev->dev;
>
> +       i2c->pctrl = devm_pinctrl_get(i2c->dev);
> +       if (!IS_ERR_OR_NULL(i2c->pctrl))
> +               i2c->pctrl_state = pinctrl_lookup_state(i2c->pctrl, "default");
> +

If all you do is select the default state (later, in the init function)
the use devm_pinctrl_get_select_default() and be done
with it.

In any case do not open code the string "default", use
PINCTRL_STATE_DEFAULT which defines to that string.

Yours,
Linus Walleij
