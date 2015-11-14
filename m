From: leilk.liu@mediatek.com (lei liu)
Date: Sat, 14 Nov 2015 10:27:19 +0800
Subject: [PATCH v2] spi: mediatek: single device does not require cs_gpios
In-Reply-To: <1447042491-1199-1-git-send-email-drinkcat@chromium.org>
References: <1447042491-1199-1-git-send-email-drinkcat@chromium.org>
Message-ID: <1447468039.27169.1.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-11-09 at 12:14 +0800, Nicolas Boichat wrote:
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

Acked-by: Leilk Liu <leilk.liu@mediatek.com>

> ---
> 
> v2: Use gpio_is_valid()
> 
> Applies on top of broonie/spi.git/for-next.
> 
>  drivers/spi/spi-mt65xx.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> index 563954a..7840067 100644
> --- a/drivers/spi/spi-mt65xx.c
> +++ b/drivers/spi/spi-mt65xx.c
> @@ -410,7 +410,7 @@ static int mtk_spi_setup(struct spi_device *spi)
>  	if (!spi->controller_data)
>  		spi->controller_data = (void *)&mtk_default_chip_info;
>  
> -	if (mdata->dev_comp->need_pad_sel)
> +	if (mdata->dev_comp->need_pad_sel && gpio_is_valid(spi->cs_gpio))
>  		gpio_direction_output(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
>  
>  	return 0;
> @@ -632,13 +632,23 @@ static int mtk_spi_probe(struct platform_device *pdev)
>  			goto err_put_master;
>  		}
>  
> -		for (i = 0; i < master->num_chipselect; i++) {
> -			ret = devm_gpio_request(&pdev->dev, master->cs_gpios[i],
> -						dev_name(&pdev->dev));
> -			if (ret) {
> -				dev_err(&pdev->dev,
> -					"can't get CS GPIO %i\n", i);
> -				goto err_put_master;
> +		if (!master->cs_gpios && master->num_chipselect > 1) {
> +			dev_err(&pdev->dev,
> +				"cs_gpios not specified and num_chipselect > 1\n");
> +			ret = -EINVAL;
> +			goto err_put_master;
> +		}
> +
> +		if (master->cs_gpios) {
> +			for (i = 0; i < master->num_chipselect; i++) {
> +				ret = devm_gpio_request(&pdev->dev,
> +							master->cs_gpios[i],
> +							dev_name(&pdev->dev));
> +				if (ret) {
> +					dev_err(&pdev->dev,
> +						"can't get CS GPIO %i\n", i);
> +					goto err_put_master;
> +				}
>  			}
>  		}
>  	}
