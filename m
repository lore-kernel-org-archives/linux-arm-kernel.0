From: mirqus@gmail.com (=?ISO-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Mon, 21 Jan 2013 21:36:26 +0100
Subject: [PATCH 1/2] iio: mxs: Add MX23 support into the IIO driver
In-Reply-To: <1358798722-25102-1-git-send-email-marex@denx.de>
References: <1358798722-25102-1-git-send-email-marex@denx.de>
Message-ID: <CAHXqBFLQUY6g6p988MVkk=sRu44B5tEzDMH2UbU2n2UDda0Q-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/1/21 Marek Vasut <marex@denx.de>:
> This patch adds support for i.MX23 into the LRADC driver. The LRADC
> block on MX23 is not much different from the one on MX28, thus this
> is only a few changes fixing the parts that are specific to MX23.
[...]
> +struct mxs_lradc_of_config {
> +       const int               irq_count;
> +       const char * const      *irq_name;
> +};
> +
> +static const struct mxs_lradc_of_config const mxs_lradc_of_config[] = {
> +       [IMX23_LRADC] = {
> +               .irq_count      = ARRAY_SIZE(mx23_lradc_irq_names),
> +               .irq_name       = mx23_lradc_irq_names,
> +       },
> +       [IMX28_LRADC] = {
> +               .irq_count      = ARRAY_SIZE(mx28_lradc_irq_names),
> +               .irq_name       = mx28_lradc_irq_names,
> +       },
> +};
> +
>  enum mxs_lradc_ts {
>         MXS_LRADC_TOUCHSCREEN_NONE = 0,
>         MXS_LRADC_TOUCHSCREEN_4WIRE,
> @@ -857,8 +890,19 @@ static void mxs_lradc_hw_stop(struct mxs_lradc *lradc)
>                 writel(0, lradc->base + LRADC_DELAY(i));
>  }
>
> +static const struct of_device_id mxs_lradc_dt_ids[] = {
> +       { .compatible = "fsl,imx23-lradc", .data = (void *)IMX23_LRADC, },
> +       { .compatible = "fsl,imx28-lradc", .data = (void *)IMX28_LRADC, },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, mxs_lradc_dt_ids);
> +

Why not s/(void \*)\(IMX.._LRADC\)/\&mxs_lradc_of_config[\1]/ ?

Best Regards,
Micha? Miros?aw
