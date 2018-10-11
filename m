From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 11 Oct 2018 09:28:39 +0200
Subject: [PATCH 10/11] spi: pxa2xx: Add ready signal
In-Reply-To: <20181010170936.316862-11-lkundrak@v3.sk>
References: <20181010170936.316862-1-lkundrak@v3.sk>
 <20181010170936.316862-11-lkundrak@v3.sk>
Message-ID: <CAMuHMdXmsw3jjp8wFuuK_Vz8kwCP4=L59sc4kZafXzrb=hKv7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lubomir,

On Wed, Oct 10, 2018 at 7:10 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
> Strobe a GPIO line when the slave TX FIFO is filled. This is how the
> Embedded Controller on an OLPC XO-1.75 machine, that happens to be a SPI
> master, learns that it can initiate a transaction.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Thanks for your patch!

I'm repeating my comments on the RFC below:

> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -1079,6 +1079,9 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *master,
>         if (spi_controller_is_slave(master)) {
>                 while (drv_data->write(drv_data))
>                         ;
> +               gpiod_set_value(drv_data->gpiod_ready, 1);
> +               udelay(1);
> +               gpiod_set_value(drv_data->gpiod_ready, 0);

While gpiod_set_value() handles the case of no GPIO fine, I think it's
better to explicitly check for that, so you can avoid spinning for 1 ?s if
the GPIO is not present.

>         }
>
>         /*
> @@ -1784,6 +1787,15 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
>                 }
>         }
>
> +       if (platform_info->is_slave) {
> +               drv_data->gpiod_ready = devm_gpiod_get_optional(dev,
> +                                               "ready", GPIOD_OUT_LOW);
> +               if (IS_ERR(drv_data->gpiod_ready)) {
> +                       status = (int)PTR_ERR(drv_data->gpiod_ready);

The cast to int is not needed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
