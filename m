From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Fri, 3 Feb 2017 00:21:19 +0200
Subject: [PATCH 11/14] serial: 8250_dw: simplify optional reset handling
In-Reply-To: <20170130114116.22089-11-p.zabel@pengutronix.de>
References: <20170130114116.22089-1-p.zabel@pengutronix.de>
 <20170130114116.22089-11-p.zabel@pengutronix.de>
Message-ID: <CAHp75Vc1OZeGUJPMVROHhhN5WRtQ+9WT45txzKfm8bCdcN6TXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 1:41 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> As of commit bb475230b8e5 ("reset: make optional functions really
> optional"), the reset framework API calls use NULL pointers to describe
> optional, non-present reset controls.

Eventually!

FWIW:
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
> This allows to return errors from devm_reset_control_get_optional and to
> call reset_control_(de)assert unconditionally.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index c89fafc972b69..b8b911adff471 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -503,12 +503,11 @@ static int dw8250_probe(struct platform_device *pdev)
>         }
>
>         data->rst = devm_reset_control_get_optional(dev, NULL);
> -       if (IS_ERR(data->rst) && PTR_ERR(data->rst) == -EPROBE_DEFER) {
> -               err = -EPROBE_DEFER;
> +       if (IS_ERR(data->rst)) {
> +               err = PTR_ERR(data->rst);
>                 goto err_pclk;
>         }
> -       if (!IS_ERR(data->rst))
> -               reset_control_deassert(data->rst);
> +       reset_control_deassert(data->rst);
>
>         dw8250_quirks(p, data);
>
> @@ -540,8 +539,7 @@ static int dw8250_probe(struct platform_device *pdev)
>         return 0;
>
>  err_reset:
> -       if (!IS_ERR(data->rst))
> -               reset_control_assert(data->rst);
> +       reset_control_assert(data->rst);
>
>  err_pclk:
>         if (!IS_ERR(data->pclk))
> @@ -562,8 +560,7 @@ static int dw8250_remove(struct platform_device *pdev)
>
>         serial8250_unregister_port(data->line);
>
> -       if (!IS_ERR(data->rst))
> -               reset_control_assert(data->rst);
> +       reset_control_assert(data->rst);
>
>         if (!IS_ERR(data->pclk))
>                 clk_disable_unprepare(data->pclk);
> --
> 2.11.0
>



-- 
With Best Regards,
Andy Shevchenko
