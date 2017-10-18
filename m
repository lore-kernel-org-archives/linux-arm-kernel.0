From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 18 Oct 2017 10:02:46 +0100
Subject: [PATCH 3/4] spi: imx: Don't require platform data chipselect array
In-Reply-To: <20171013195410.30767-3-tpiepho@impinj.com>
References: <20171013195410.30767-1-tpiepho@impinj.com>
 <20171013195410.30767-3-tpiepho@impinj.com>
Message-ID: <36d381de-ee3f-26d4-59c3-b9d361758ace@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Trent,

On 13/10/17 20:54, Trent Piepho wrote:
> If the array is not present, assume all chip selects are native.  This
> is the standard behavior for SPI masters configured via the device
> tree and the behavior of this driver as well when it is configured via
> device tree.
> 
> This reduces platform data vs DT differences and allows most of the
> platform data based boards to remove their chip select arrays.
> 
> Signed-off-by: Trent Piepho <tpiepho@impinj.com>
> ---
>   drivers/spi/spi-imx.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index fea46cbf458a..3a2c34522655 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -1364,13 +1364,15 @@ static int spi_imx_probe(struct platform_device *pdev)
>   
>   	if (mxc_platform_info) {
>   		master->num_chipselect = mxc_platform_info->num_chipselect;

nit:
This is only useful when num_chipselect is non-zero (master's memory is 
zeroed on allocation). So maybe this could be simplified a bit more as:

if (mxc_platform_info && mxc_platform_info->chipselect) {
	master->num_chipselect = mxc_platform_info->num_chipselect;
	[...]
}

Reducing an indentation level for all the following statements.

Cheers,

> -		master->cs_gpios = devm_kzalloc(&master->dev,
> -			sizeof(int) * master->num_chipselect, GFP_KERNEL);
> -		if (!master->cs_gpios)
> -			return -ENOMEM;
> -
> -		for (i = 0; i < master->num_chipselect; i++)
> -			master->cs_gpios[i] = mxc_platform_info->chipselect[i];
> +		if (mxc_platform_info->chipselect) {
> +			master->cs_gpios = devm_kzalloc(&master->dev,
> +				sizeof(int) * master->num_chipselect, GFP_KERNEL);
> +			if (!master->cs_gpios)
> +				return -ENOMEM;
> +
> +			for (i = 0; i < master->num_chipselect; i++)
> +				master->cs_gpios[i] = mxc_platform_info->chipselect[i];
> +		}
>    	}
>   
>   	spi_imx->bitbang.chipselect = spi_imx_chipselect;
> 

-- 
Julien Thierry
