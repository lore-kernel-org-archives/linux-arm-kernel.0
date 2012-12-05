From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 5 Dec 2012 09:45:49 +0800
Subject: [PATCH 2/2] i2c: pxa: Use i2c-core to get bus number now
In-Reply-To: <1353522362-25519-3-git-send-email-dianders@chromium.org>
References: <1353450428-2615-2-git-send-email-dianders@chromium.org>
 <1353522362-25519-1-git-send-email-dianders@chromium.org>
 <1353522362-25519-3-git-send-email-dianders@chromium.org>
Message-ID: <CAN1soZyfCOpy_+K1O3dJ42X1vAKK3CrriDL5nBXkGs_f4zLjcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2012 at 2:26 AM, Doug Anderson <dianders@chromium.org> wrote:
> The commit: "i2c-core: dt: Pick i2c bus number from i2c alias if
> present" adds support for automatically picking the bus number based
> on the alias ID.  Remove the now unnecessary code from i2c-pxa that
> did the same thing.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/i2c/busses/i2c-pxa.c |    8 +-------
>  1 files changed, 1 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index 1034d93..8ee9fa0 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -1053,16 +1053,10 @@ static int i2c_pxa_probe_dt(struct platform_device *pdev, struct pxa_i2c *i2c,
>         struct device_node *np = pdev->dev.of_node;
>         const struct of_device_id *of_id =
>                         of_match_device(i2c_pxa_dt_ids, &pdev->dev);
> -       int ret;
>
>         if (!of_id)
>                 return 1;
> -       ret = of_alias_get_id(np, "i2c");
> -       if (ret < 0) {
> -               dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
> -               return ret;
> -       }
> -       pdev->id = ret;
> +       pdev->id = -1;
>         if (of_get_property(np, "mrvl,i2c-polling", NULL))
>                 i2c->use_pio = 1;
>         if (of_get_property(np, "mrvl,i2c-fast-mode", NULL))
> --
> 1.7.7.3
>

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
