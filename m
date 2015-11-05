From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Thu, 5 Nov 2015 11:16:16 +0200
Subject: [PATCH] spi: mediatek: single device does not require cs_gpios
In-Reply-To: <1446702633-14019-1-git-send-email-drinkcat@chromium.org>
References: <1446702633-14019-1-git-send-email-drinkcat@chromium.org>
Message-ID: <CAHp75VfAHyTOpWcTh6w2EhEy73xfUYX5T3tpXbUbBiU-tjaZnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 5, 2015 at 7:50 AM, Nicolas Boichat <drinkcat@chromium.org> wrote:
> When only one device is present, it is not necessary to specify
> cs_gpios, as the CS line can be controlled by the hardware
> module.
>
> Without this patch, older device tree bindings used before
> 37457607 "spi: mediatek: mt8173 spi multiple devices support"
> would cause a panic on boot. This fixes the crash, and
> re-introduces backward compatibility.
>
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
>
> Applies on top of broonie/spi.git topic/mtk. Thanks!
>
>  drivers/spi/spi-mt65xx.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> index 563954a..f694031 100644
> --- a/drivers/spi/spi-mt65xx.c
> +++ b/drivers/spi/spi-mt65xx.c
> @@ -410,7 +410,7 @@ static int mtk_spi_setup(struct spi_device *spi)
>         if (!spi->controller_data)
>                 spi->controller_data = (void *)&mtk_default_chip_info;
>
> -       if (mdata->dev_comp->need_pad_sel)
> +       if (mdata->dev_comp->need_pad_sel && spi->cs_gpio >= 0)

gpio_is_valid() ?

>                 gpio_direction_output(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
>
>         return 0;
> @@ -632,13 +632,23 @@ static int mtk_spi_probe(struct platform_device *pdev)
>                         goto err_put_master;
>                 }
>
> -               for (i = 0; i < master->num_chipselect; i++) {
> -                       ret = devm_gpio_request(&pdev->dev, master->cs_gpios[i],
> -                                               dev_name(&pdev->dev));
> -                       if (ret) {
> -                               dev_err(&pdev->dev,
> -                                       "can't get CS GPIO %i\n", i);
> -                               goto err_put_master;
> +               if (!master->cs_gpios && master->num_chipselect > 1) {
> +                       dev_err(&pdev->dev,
> +                               "cs_gpios not specified and num_chipselect > 1\n");
> +                       ret = -EINVAL;
> +                       goto err_put_master;
> +               }
> +
> +               if (master->cs_gpios) {
> +                       for (i = 0; i < master->num_chipselect; i++) {
> +                               ret = devm_gpio_request(&pdev->dev,
> +                                                       master->cs_gpios[i],
> +                                                       dev_name(&pdev->dev));
> +                               if (ret) {
> +                                       dev_err(&pdev->dev,
> +                                               "can't get CS GPIO %i\n", i);
> +                                       goto err_put_master;
> +                               }
>                         }
>                 }
>         }
> --
> 2.6.0.rc2.230.g3dd15c0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
With Best Regards,
Andy Shevchenko
