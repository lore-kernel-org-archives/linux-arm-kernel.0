From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 9 Jul 2017 19:10:07 +0100
Subject: [PATCH] iio: adc: rockchip_saradc: add NULL check on
 of_match_device() return value
In-Reply-To: <20170707065131.GA23382@embeddedgus>
References: <20170707065131.GA23382@embeddedgus>
Message-ID: <20170709191007.5d79c950@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 7 Jul 2017 01:51:31 -0500
"Gustavo A. R. Silva" <garsilva@embeddedor.com> wrote:

> Check return value from call to of_match_device()
> in order to prevent a NULL pointer dereference.
> 
> In case of NULL print error message and return -ENODEV
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Applied.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/rockchip_saradc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index ae6d332..2bf2ed1 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -224,6 +224,11 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>  	info = iio_priv(indio_dev);
>  
>  	match = of_match_device(rockchip_saradc_match, &pdev->dev);
> +	if (!match) {
> +		dev_err(&pdev->dev, "failed to match device\n");
> +		return -ENODEV;
> +	}
> +
>  	info->data = match->data;
>  
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
