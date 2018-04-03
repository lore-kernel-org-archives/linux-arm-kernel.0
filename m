From: amelie.delaunay@st.com (Amelie DELAUNAY)
Date: Tue, 3 Apr 2018 07:24:47 +0000
Subject: [PATCH] spi: stm32: Fix error handling in stm32_spi_probe()
In-Reply-To: <1522439684-7510-1-git-send-email-khoroshilov@ispras.ru>
References: <1522439684-7510-1-git-send-email-khoroshilov@ispras.ru>
Message-ID: <1c12d20a40384fc78262bcd82c68ba6a@SFHDAG3NODE2.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> -----Original Message-----
> From: Alexey Khoroshilov [mailto:khoroshilov at ispras.ru]
> Sent: vendredi 30 mars 2018 21:55
> To: Mark Brown <broonie@kernel.org>; Amelie DELAUNAY
> <amelie.delaunay@st.com>; Maxime Coquelin
> <mcoquelin.stm32@gmail.com>; Alexandre TORGUE
> <alexandre.torgue@st.com>
> Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>; linux-spi at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; ldv-
> project at linuxtesting.org
> Subject: [PATCH] spi: stm32: Fix error handling in stm32_spi_probe()
> 
> clk_get_rate() is below clk_prepare_enable(), so its error should lead to goto
> err_clk_disable, not to err_master_put.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---
>  drivers/spi/spi-stm32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c index
> ba9743fa2326..ad1e55d3d5d5 100644
> --- a/drivers/spi/spi-stm32.c
> +++ b/drivers/spi/spi-stm32.c
> @@ -1129,7 +1129,7 @@ static int stm32_spi_probe(struct platform_device
> *pdev)
>  	if (!spi->clk_rate) {
>  		dev_err(&pdev->dev, "clk rate = 0\n");
>  		ret = -EINVAL;
> -		goto err_master_put;
> +		goto err_clk_disable;
>  	}
> 
>  	spi->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> --
> 2.7.4

Thanks for the patch!

Reviewed-by: Amelie Delaunay <amelie.delaunay@st.com>

Regards,
Amelie
