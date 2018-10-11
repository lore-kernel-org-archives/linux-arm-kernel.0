From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 11 Oct 2018 09:23:49 +0200
Subject: [PATCH 07/11] spi: Deal with slaves that return from
 transfer_one() unfinished
In-Reply-To: <20181010170936.316862-8-lkundrak@v3.sk>
References: <20181010170936.316862-1-lkundrak@v3.sk>
 <20181010170936.316862-8-lkundrak@v3.sk>
Message-ID: <CAMuHMdXht0icaRCaJWy2GcVny=EVZ2FOfXW7s=hKFizi6sE-8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lubomir,

On Wed, Oct 10, 2018 at 7:10 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
> Some drivers, such as spi-pxa2xx return from the transfer_one callback
> immediately, idicating that the transfer will be finished asynchronously.
>
> Normally, spi_transfer_one_message() synchronously waits for the
> transfer to finish with wait_for_completion_timeout(). For slaves, we
> don't want the transaction to time out as it can complete in a long time
> in future. Use wait_for_completion_interruptible() instead.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Thanks for your patch!

> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -993,6 +993,44 @@ static int spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
>         return __spi_map_msg(ctlr, msg);
>  }
>
> +static int spi_transfer_wait(struct spi_controller *ctlr,
> +                            struct spi_message *msg,
> +                            struct spi_transfer *xfer)
> +{
> +       struct spi_statistics *statm = &ctlr->statistics;
> +       struct spi_statistics *stats = &msg->spi->statistics;
> +       unsigned long long ms = 1;
> +
> +       if (spi_controller_is_slave(ctlr)) {
> +               if (wait_for_completion_interruptible(&ctlr->xfer_completion)) {
> +                       dev_dbg(&msg->spi->dev, "SPI transfer interrupted\n");
> +                       return -EINTR;

Why not setting msg->status = -EINTR here, but returning an error? ...

> +               }
> +       } else {
> +               ms = 8LL * 1000LL * xfer->len;
> +               do_div(ms, xfer->speed_hz);
> +               ms += ms + 200; /* some tolerance */
> +
> +               if (ms > UINT_MAX)
> +                       ms = UINT_MAX;
> +
> +               ms = wait_for_completion_timeout(&ctlr->xfer_completion,
> +                                                msecs_to_jiffies(ms));
> +
> +               if (ms == 0) {
> +                       SPI_STATISTICS_INCREMENT_FIELD(statm,
> +                                                      timedout);
> +                       SPI_STATISTICS_INCREMENT_FIELD(stats,
> +                                                      timedout);
> +                       dev_err(&msg->spi->dev,
> +                               "SPI transfer timed out\n");
> +                       msg->status = -ETIMEDOUT;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  /*
>   * spi_transfer_one_message - Default implementation of transfer_one_message()
>   *
> @@ -1006,7 +1044,6 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
>         struct spi_transfer *xfer;
>         bool keep_cs = false;
>         int ret = 0;
> -       unsigned long long ms = 1;
>         struct spi_statistics *statm = &ctlr->statistics;
>         struct spi_statistics *stats = &msg->spi->statistics;
>
> @@ -1035,28 +1072,11 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
>                                 goto out;
>                         }
>
> -                       if (ret > 0) {
> -                               ret = 0;
> -                               ms = 8LL * 1000LL * xfer->len;
> -                               do_div(ms, xfer->speed_hz);
> -                               ms += ms + 200; /* some tolerance */
> -
> -                               if (ms > UINT_MAX)
> -                                       ms = UINT_MAX;
> +                       if (ret > 0)
> +                               ret = spi_transfer_wait(ctlr, msg, xfer);
>
> -                               ms = wait_for_completion_timeout(&ctlr->xfer_completion,
> -                                                                msecs_to_jiffies(ms));
> -                       }
> -
> -                       if (ms == 0) {
> -                               SPI_STATISTICS_INCREMENT_FIELD(statm,
> -                                                              timedout);
> -                               SPI_STATISTICS_INCREMENT_FIELD(stats,
> -                                                              timedout);
> -                               dev_err(&msg->spi->dev,
> -                                       "SPI transfer timed out\n");
> -                               msg->status = -ETIMEDOUT;
> -                       }
> +                       if (ret < 0)
> +                               return ret;

... which will return here, skipping all finalization and cleanup below?

>                 } else {
>                         if (xfer->len)
>                                 dev_err(&msg->spi->dev,

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
