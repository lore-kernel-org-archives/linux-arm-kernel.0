From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 26 Apr 2018 10:35:33 +0200
Subject: [PATCH] spi: meson-axg: Fix error handling in meson_spicc_probe()
In-Reply-To: <1523655586-4163-1-git-send-email-khoroshilov@ispras.ru>
References: <1523655586-4163-1-git-send-email-khoroshilov@ispras.ru>
Message-ID: <a2a9cde3-5192-ce05-cc5c-d0191f0e811a@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexey,


On 13/04/2018 23:39, Alexey Khoroshilov wrote:
> If devm_spi_register_master() fails in meson_spicc_probe(),
> spicc->core is left undisabled. The patch fixes that.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---
>  drivers/spi/spi-meson-spicc.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
> index 5c82910e3480..7fe4488ace57 100644
> --- a/drivers/spi/spi-meson-spicc.c
> +++ b/drivers/spi/spi-meson-spicc.c
> @@ -574,10 +574,15 @@ static int meson_spicc_probe(struct platform_device *pdev)
>  		master->max_speed_hz = rate >> 2;
>  
>  	ret = devm_spi_register_master(&pdev->dev, master);
> -	if (!ret)
> -		return 0;
> +	if (ret) {
> +		dev_err(&pdev->dev, "spi master registration failed\n");
> +		goto out_clk;
> +	}
>  
> -	dev_err(&pdev->dev, "spi master registration failed\n");
> +	return 0;
> +
> +out_clk:
> +	clk_disable_unprepare(spicc->core);
>  
>  out_master:
>  	spi_master_put(master);
> 

The correct subject should be "spi: meson-spicc:"

Apart that :
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Neil
