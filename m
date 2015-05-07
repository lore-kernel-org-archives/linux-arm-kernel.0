From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 7 May 2015 09:25:02 +0200
Subject: [PATCH 1/2] spi: sirf: replace kmalloc by devm_kzalloc
In-Reply-To: <1430982791-8681-1-git-send-email-21cnbao@gmail.com>
References: <1430982791-8681-1-git-send-email-21cnbao@gmail.com>
Message-ID: <CAMuHMdVcKHxasYAF07Cj=EshjOpKhQJnm9crfFPdUb01WzZsWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 7, 2015 at 9:13 AM, Barry Song <21cnbao@gmail.com> wrote:
> From: Qipan Li <Qipan.Li@csr.com>
>
> Signed-off-by: Qipan Li <Qipan.Li@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  drivers/spi/spi-sirf.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
> index a69ccb7..ae4bd11 100644
> --- a/drivers/spi/spi-sirf.c
> +++ b/drivers/spi/spi-sirf.c
> @@ -758,7 +758,7 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
>         /* We are not using dummy delay between command and data */
>         writel(0, sspi->base + SIRFSOC_SPI_DUMMY_DELAY_CTL);
>
> -       sspi->dummypage = kmalloc(2 * PAGE_SIZE, GFP_KERNEL);
> +       sspi->dummypage = devm_kzalloc(&pdev->dev, 2 * PAGE_SIZE, GFP_KERNEL);
>         if (!sspi->dummypage) {
>                 ret = -ENOMEM;
>                 goto free_clk;

What about setting SPI_MASTER_MUST_RX and/or SPI_MASTER_MUST_TX,
and removing the dummy page instead, so the spi core will handle it for you?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
