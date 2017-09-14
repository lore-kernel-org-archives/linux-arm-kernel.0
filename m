From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 14 Sep 2017 15:38:41 +0200
Subject: [PATCH] mtd: spi-nor: stm32-quadspi: avoid unintialized return
 code
In-Reply-To: <20170914110709.3591691-1-arnd@arndb.de>
References: <20170914110709.3591691-1-arnd@arndb.de>
Message-ID: <CAMuHMdU3AqGkvwDQ+hE2=3PhgCKUh1HvBx8Hkvba6XsLHAuBbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, Sep 14, 2017 at 1:06 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> If we send zero-length data to stm32_qspi_tx_poll() on older
> compiler versions such as gcc-4.6, we get warned that the
> return code is uninitialized:
>
> drivers/mtd/spi-nor/stm32-quadspi.c:248:2: error: ?ret? may be used uninitialized in this function [-Werror=uninitialized]
>
> On newer compiler versions, the return code is always zero
> in this case, as the local variable gets optimized away and
> is assumed to be zero after the loop completes without error.
>
> This changes the function to instead return -EINVAL if it
> ever gets called with a zero length buffer.
>
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82203
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mtd/spi-nor/stm32-quadspi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/spi-nor/stm32-quadspi.c b/drivers/mtd/spi-nor/stm32-quadspi.c
> index 86c0931543c5..711cfe7aa4bf 100644
> --- a/drivers/mtd/spi-nor/stm32-quadspi.c
> +++ b/drivers/mtd/spi-nor/stm32-quadspi.c
> @@ -227,7 +227,7 @@ static int stm32_qspi_tx_poll(struct stm32_qspi *qspi,
>         void (*tx_fifo)(u8 *, void __iomem *);
>         u32 len = cmd->len, sr;
>         u8 *buf = cmd->buf;
> -       int ret;
> +       int ret = -EINVAL;
>
>         if (cmd->qspimode == CCR_FMODE_INDW)
>                 tx_fifo = stm32_qspi_write_fifo;

See also "[PATCH] mtd: spi-nor: stm32-quadspi: Fix uninitialized error
return code"
(https://patchwork.kernel.org/patch/9842173/)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
