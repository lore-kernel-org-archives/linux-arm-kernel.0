From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 7 Jul 2017 15:16:23 +0800
Subject: [PATCH] pwm: sun4i: add NULL check on of_match_device() return
 value
In-Reply-To: <20170707063939.GA20510@embeddedgus>
References: <20170707063939.GA20510@embeddedgus>
Message-ID: <CAGb2v64vwrTX9=MR-pNZP3eSUQUDj9V=oxx8ef-DaxZVue-pHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 7, 2017 at 2:39 PM, Gustavo A. R. Silva
<garsilva@embeddedor.com> wrote:
> Check return value from call to of_match_device()
> in order to prevent a NULL pointer dereference.
>
> In case of NULL print error message and return -ENODEV
>
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 1284ffa..295ca19 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -321,6 +321,10 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
>         const struct of_device_id *match;
>
>         match = of_match_device(sun4i_pwm_dt_ids, &pdev->dev);

AFAIK this simply can not and should not fail with a device tree
only driver with properly populated of_device_id tables.

ChenYu

> +       if (!match) {
> +               dev_err(&pdev->dev, "failed to match device\n");
> +               return -ENODEV;
> +       }
>
>         pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
>         if (!pwm)
> --
> 2.5.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
