From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 26 May 2011 20:47:42 -0500
Subject: [PATCH 5/5] spi/ep93xx: add DMA support
In-Reply-To: <f05f92e531fdb613657bc16c8fd4a2f8653ece55.1306082097.git.mika.westerberg@iki.fi>
References: <cover.1306082097.git.mika.westerberg@iki.fi>
	<f05f92e531fdb613657bc16c8fd4a2f8653ece55.1306082097.git.mika.westerberg@iki.fi>
Message-ID: <0D753D10438DA54287A00B027084269764D331A4B7@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, May 22, 2011 10:03 AM, Mika Westerberg wrote:
>
> This patch adds DMA support for the EP93xx SPI driver. By default the DMA is
> not enabled but it can be enabled by setting ep93xx_spi_info.use_dma to true
> in board configuration file.
> 
> Note that the SPI driver still uses PIO for small transfers (<= 8 bytes) for
> performance reasons.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
>  Documentation/spi/ep93xx_spi                   |   10 +
>  arch/arm/mach-ep93xx/core.c                    |    6 +-
>  arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h |    2 +
>  drivers/spi/ep93xx_spi.c                       |  303 +++++++++++++++++++++++-
>  4 files changed, 308 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/spi/ep93xx_spi b/Documentation/spi/ep93xx_spi
> index 6325f5b..fc43818 100644
> --- a/Documentation/spi/ep93xx_spi
> +++ b/Documentation/spi/ep93xx_spi
> @@ -88,6 +88,16 @@ static void __init ts72xx_init_machine(void)
>  			    ARRAY_SIZE(ts72xx_spi_devices));
>  }
>  
> +The driver can use DMA for the transfers also. In this case ts72xx_spi_info
> +becomes:
> +
> +static struct ep93xx_spi_info ts72xx_spi_info = {
> +	.num_chipselect	= ARRAY_SIZE(ts72xx_spi_devices),
> +	.use_dma	= true;
> +};
> +
> +Note that CONFIG_DMA_ENGINE and CONFIG_EP93XX_DMA should be enabled as well.

CONFIG_DMA_ENGINE is selected by CONFIG_EP93XX_DMA and it's hidden for that
matter.  Remove that part of the comment.

The reset looks good.

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
