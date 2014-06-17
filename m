From: dianders@chromium.org (Doug Anderson)
Date: Tue, 17 Jun 2014 13:57:33 -0700
Subject: [PATCH v2 01/10] mfd: max77686: Convert to use regmap_irq
In-Reply-To: <1402941758-11216-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1402941758-11216-1-git-send-email-javier.martinez@collabora.co.uk>
 <1402941758-11216-2-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <CAD=FV=VUPwr6GbR7O-t0q-GaCttZ5vGzLeFqHckzkk-dZYfCFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier,

On Mon, Jun 16, 2014 at 11:02 AM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> @@ -127,15 +175,48 @@ static int max77686_i2c_probe(struct i2c_client *i2c,
>         }
>         i2c_set_clientdata(max77686->rtc, max77686);
>
> -       max77686_irq_init(max77686);
> +       max77686->rtc_regmap = devm_regmap_init_i2c(max77686->rtc,
> +                                                   &max77686_rtc_regmap_config);
> +       if (IS_ERR(max77686->rtc_regmap)) {
> +               ret = PTR_ERR(max77686->rtc_regmap);
> +               dev_err(max77686->dev, "failed to allocate RTC regmap: %d\n",
> +                       ret);
> +               goto err_unregister_i2c;
> +       }
> +
> +       ret = regmap_add_irq_chip(max77686->regmap, max77686->irq,
> +                                 IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
> +                                 IRQF_SHARED, 0, &max77686_irq_chip,
> +                                 &max77686->irq_data);
> +       if (ret != 0) {
> +               dev_err(&i2c->dev, "failed to add PMIC irq chip: %d\n", ret);
> +               goto err_unregister_i2c;
> +       }
> +       ret = regmap_add_irq_chip(max77686->rtc_regmap, max77686->irq,
> +                                 IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
> +                                 IRQF_SHARED, 0, &max77686_rtc_irq_chip,
> +                                 &max77686->rtc_irq_data);
> +       if (ret != 0) {
> +               dev_err(&i2c->dev, "failed to add RTC irq chip: %d\n", ret);
> +               goto err_del_irqc;
> +       }
>
>         ret = mfd_add_devices(max77686->dev, -1, max77686_devs,
>                               ARRAY_SIZE(max77686_devs), NULL, 0, NULL);
>         if (ret < 0) {
> -               mfd_remove_devices(max77686->dev);
> -               i2c_unregister_device(max77686->rtc);
> +               dev_err(&i2c->dev, "failed to add MFD devices: %d\n", ret);
> +               goto err_del_rtc_irqc;
>         }
>
> +       return 0;
> +
> +err_del_rtc_irqc:
> +       regmap_del_irq_chip(max77686->irq, max77686->rtc_irq_data);
> +err_del_irqc:
> +       regmap_del_irq_chip(max77686->irq, max77686->irq_data);

I would imagine you either don't need these regmap_del_irq_chip() here
or that you _do_ need them in max77686_i2c_remove().

...from looking at other drivers I think the answer is to add them to
max77686_i2c_remove().


> diff --git a/include/linux/mfd/max77686-private.h b/include/linux/mfd/max77686-private.h
> index 8c75a9c..3a810b1 100644
> --- a/include/linux/mfd/max77686-private.h
> +++ b/include/linux/mfd/max77686-private.h
> @@ -205,7 +205,7 @@ enum max77686_irq {
>         MAX77686_PMICIRQ_140C,
>         MAX77686_PMICIRQ_120C,
>
> -       MAX77686_RTCIRQ_RTC60S,
> +       MAX77686_RTCIRQ_RTC60S = 0,
>         MAX77686_RTCIRQ_RTCA1,
>         MAX77686_RTCIRQ_RTCA2,
>         MAX77686_RTCIRQ_SMPL,
> @@ -215,6 +215,25 @@ enum max77686_irq {
>         MAX77686_IRQ_NR,

Maybe remove MAX77686_IRQ_NR which no longer makes any sense now that
you start over at 0 partway through.


Overall this looks good to me, so once nits above are fixed feel to
add my Reviewed-by.  I've also built and booted this patch on
exynos5250-snow and tested that the RTC wakealarm fires and can even
wake the system up (with some additional work that I'll email you
about).

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
