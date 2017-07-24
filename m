From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Mon, 24 Jul 2017 16:03:31 +0300
Subject: [PATCH] spi: pxa2xx: Only claim CS GPIOs when the slave device is
 created
In-Reply-To: <90b3e14d-0077-9a25-9d90-ab340577af57@web.de>
References: <90b3e14d-0077-9a25-9d90-ab340577af57@web.de>
Message-ID: <CAHp75VfL8RK57sxKH4UVQ0-u9gGnJ-DaqOKYcq7DrdsFhpecwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Cc: Mika (for real this time)

On Sat, Jul 8, 2017 at 11:41 AM, Jan Kiszka <jan.kiszka@web.de> wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Avoid hogging chip select GPIOs just because they are listed for the
> master. They might be mulitplexed and, if no slave device is attached,
> used for different purposes. Moreover, this strategy avoids having to
> allocate a cs_gpiods structure.
>
> Tested on the IOT2000 where the second SPI bus is connected to an
> Arduino-compatible connector and multiplexed between SPI, GPIO and PWM
> usage.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/spi/spi-pxa2xx.c | 59 +++++++++++++++++-------------------------------
>  1 file changed, 21 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index 38d053682892..be991266a6ce 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -1213,21 +1213,33 @@ static int setup_cs(struct spi_device *spi, struct chip_data *chip,
>                     struct pxa2xx_spi_chip *chip_info)
>  {
>         struct driver_data *drv_data = spi_master_get_devdata(spi->master);
> +       struct device *pdev = &drv_data->pdev->dev;
> +       struct gpio_desc *gpiod;
>         int err = 0;
> +       int count;
>
>         if (chip == NULL)
>                 return 0;
>
> -       if (drv_data->cs_gpiods) {
> -               struct gpio_desc *gpiod;
> +       count = gpiod_count(pdev, "cs");
> +       if (count > 0) {
> +               if (spi->chip_select >= count)
> +                       return -EINVAL;
> +
> +               gpiod = gpiod_get_index(pdev, "cs", spi->chip_select,
> +                                       GPIOD_OUT_HIGH);
> +               if (IS_ERR(gpiod)) {
> +                       /* Means use native chip select */
> +                       if (PTR_ERR(gpiod) == -ENOENT)
> +                               return 0;
>
> -               gpiod = drv_data->cs_gpiods[spi->chip_select];
> -               if (gpiod) {
> -                       chip->gpio_cs = desc_to_gpio(gpiod);
> -                       chip->gpio_cs_inverted = spi->mode & SPI_CS_HIGH;
> -                       gpiod_set_value(gpiod, chip->gpio_cs_inverted);
> +                       return PTR_ERR(gpiod);
>                 }
>
> +               chip->gpio_cs = desc_to_gpio(gpiod);
> +               chip->gpio_cs_inverted = spi->mode & SPI_CS_HIGH;
> +               gpiod_set_value(gpiod, chip->gpio_cs_inverted);
> +
>                 return 0;
>         }
>
> @@ -1415,8 +1427,7 @@ static void cleanup(struct spi_device *spi)
>         if (!chip)
>                 return;
>
> -       if (drv_data->ssp_type != CE4100_SSP && !drv_data->cs_gpiods &&
> -           gpio_is_valid(chip->gpio_cs))
> +       if (drv_data->ssp_type != CE4100_SSP && gpio_is_valid(chip->gpio_cs))
>                 gpio_free(chip->gpio_cs);
>
>         kfree(chip);
> @@ -1752,38 +1763,10 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
>         master->num_chipselect = platform_info->num_chipselect;
>
>         count = gpiod_count(&pdev->dev, "cs");
> -       if (count > 0) {
> -               int i;
> -
> +       if (count > 0)
>                 master->num_chipselect = max_t(int, count,
>                         master->num_chipselect);
>
> -               drv_data->cs_gpiods = devm_kcalloc(&pdev->dev,
> -                       master->num_chipselect, sizeof(struct gpio_desc *),
> -                       GFP_KERNEL);
> -               if (!drv_data->cs_gpiods) {
> -                       status = -ENOMEM;
> -                       goto out_error_clock_enabled;
> -               }
> -
> -               for (i = 0; i < master->num_chipselect; i++) {
> -                       struct gpio_desc *gpiod;
> -
> -                       gpiod = devm_gpiod_get_index(dev, "cs", i,
> -                                                    GPIOD_OUT_HIGH);
> -                       if (IS_ERR(gpiod)) {
> -                               /* Means use native chip select */
> -                               if (PTR_ERR(gpiod) == -ENOENT)
> -                                       continue;
> -
> -                               status = (int)PTR_ERR(gpiod);
> -                               goto out_error_clock_enabled;
> -                       } else {
> -                               drv_data->cs_gpiods[i] = gpiod;
> -                       }
> -               }
> -       }
> -
>         tasklet_init(&drv_data->pump_transfers, pump_transfers,
>                      (unsigned long)drv_data);
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
With Best Regards,
Andy Shevchenko
