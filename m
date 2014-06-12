From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Thu, 12 Jun 2014 16:06:52 +0200
Subject: [PATCH 2/3 v4] spi: s3c64xx: for DT platofrms always get the
 chipselect info from DT node
In-Reply-To: <1402578821-27338-2-git-send-email-ch.naveen@samsung.com>
References: <1402578821-27338-1-git-send-email-ch.naveen@samsung.com>
 <1402578821-27338-2-git-send-email-ch.naveen@samsung.com>
Message-ID: <5399B3FC.5030605@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Naveen,

On 06/12/2014 03:13 PM, Naveen Krishna Chatradhi wrote:
> Use controller_data structure only for the Non Device tree  platforms.
> For Device tree platforms, always derive the chipselect info from
> DT node.
> 
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Tomasz Figa <t.figa@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c |   11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index b888c66..f27e15d 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -795,14 +795,15 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
>  	int err;
>  
>  	sdd = spi_master_get_devdata(spi->master);
> -	if (!cs && spi->dev.of_node) {
> +	if (spi->dev.of_node) {
>  		cs = s3c64xx_get_slave_ctrldata(spi);
>  		spi->controller_data = cs;
> -	}
> -
> -	/* For the non-DT platforms derive chip selects from controller data */
> -	if (!spi->dev.of_node)
> +	} else {
> +		/* For the non-DT platforms derive chip
> +		 * selects from controller data
> +		 */
>  		spi->cs_gpio = cs->line;
> +	}
>  
>  	if (IS_ERR_OR_NULL(cs)) {
>  		dev_err(&spi->dev, "No CS for SPI(%d)\n", spi->chip_select);
> 

Personally I wouldn't have this change as a separate patch since it's too
related to what you changed in Patch 1. But it's just a nitpick.

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
