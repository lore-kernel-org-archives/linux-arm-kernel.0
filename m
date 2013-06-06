From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 6 Jun 2013 09:36:43 +0800
Subject: [PATCH] spi/sirf: fix error propagation in spi_sirfsoc_probe()
In-Reply-To: <1370467796-4641-1-git-send-email-khoroshilov@ispras.ru>
References: <1370467796-4641-1-git-send-email-khoroshilov@ispras.ru>
Message-ID: <CAGsJ_4w6o9aSRDrH-nZRk77bRMxLUHDY5auePz_NzPC0pH1cjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/6/6 Alexey Khoroshilov <khoroshilov@ispras.ru>:
> If pinctrl_get_select_default() fails, spi_sirfsoc_probe()
> returns IS_ERR(sspi->p) instead of PTR_ERR(sspi->p).
>
> Found by Linux Driver Verification project (linuxtesting.org).
>
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Acked-by: Barry Song <Baohua.Song@csr.com>

> ---
>  drivers/spi/spi-sirf.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
> index 0808cd5..94c3920 100644
> --- a/drivers/spi/spi-sirf.c
> +++ b/drivers/spi/spi-sirf.c
> @@ -559,9 +559,10 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
>         sspi->bitbang.master->dev.of_node = pdev->dev.of_node;
>
>         sspi->p = pinctrl_get_select_default(&pdev->dev);
> -       ret = IS_ERR(sspi->p);
> -       if (ret)
> +       if (IS_ERR(sspi->p)) {
> +               ret = PTR_ERR(sspi->p);
>                 goto free_master;
> +       }
>
>         sspi->clk = clk_get(&pdev->dev, NULL);
>         if (IS_ERR(sspi->clk)) {
> --
> 1.8.1.2
