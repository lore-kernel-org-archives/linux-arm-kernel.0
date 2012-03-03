From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 02 Mar 2012 19:39:29 -0700
Subject: [PATCH 3/3] spi/atmel: add DT support
In-Reply-To: <1328804077-6121-3-git-send-email-plagnioj@jcrosoft.com>
References: <1328804077-6121-1-git-send-email-plagnioj@jcrosoft.com>
 <1328804077-6121-3-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20120303023929.BE8F93E2D8D@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu,  9 Feb 2012 17:14:37 +0100, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:
> the atmel_spi use only gpio for chip select
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: spi-devel-general at lists.sourceforge.net

Looks good to me; applied.

g.

> ---
>  .../devicetree/bindings/spi/spi_atmel.txt          |    6 ++++++
>  drivers/spi/spi-atmel.c                            |   12 +++++++++++-
>  2 files changed, 17 insertions(+), 1 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi_atmel.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi_atmel.txt b/Documentation/devicetree/bindings/spi/spi_atmel.txt
> new file mode 100644
> index 0000000..7ec3d8d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi_atmel.txt
> @@ -0,0 +1,6 @@
> +Atmel SPI device
> +
> +Required properties:
> +- compatible : should be "atmel,at91rm9200-spi".
> +- reg: Address and length of the register set for the device
> +- interrupts: Should contain macb interrupt
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 16d6a83..7bcd11f 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -19,6 +19,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/spi/spi.h>
>  #include <linux/slab.h>
> +#include <linux/of.h>
>  
>  #include <asm/io.h>
>  #include <mach/board.h>
> @@ -938,7 +939,7 @@ static int __devinit atmel_spi_probe(struct platform_device *pdev)
>  	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
>  
>  	master->bus_num = pdev->id;
> -	master->num_chipselect = 4;
> +	master->num_chipselect = master->dev.of_node ? 0 : 4;
>  	master->setup = atmel_spi_setup;
>  	master->transfer = atmel_spi_transfer;
>  	master->cleanup = atmel_spi_cleanup;
> @@ -1064,11 +1065,20 @@ static int atmel_spi_resume(struct platform_device *pdev)
>  #define	atmel_spi_resume	NULL
>  #endif
>  
> +#if defined(CONFIG_OF)
> +static const struct of_device_id atmel_spi_dt_ids[] = {
> +	{ .compatible = "atmel,at91rm9200-spi" },
> +	{ /* sentinel */ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, atmel_spi_dt_ids);
> +#endif
>  
>  static struct platform_driver atmel_spi_driver = {
>  	.driver		= {
>  		.name	= "atmel_spi",
>  		.owner	= THIS_MODULE,
> +		.of_match_table	= of_match_ptr(atmel_spi_dt_ids),
>  	},
>  	.suspend	= atmel_spi_suspend,
>  	.resume		= atmel_spi_resume,
> -- 
> 1.7.7
> 
> 
> ------------------------------------------------------------------------------
> Virtualization & Cloud Management Using Capacity Planning
> Cloud computing makes use of virtualization - but cloud computing 
> also focuses on allowing computing to be delivered as a service.
> http://www.accelacomm.com/jaw/sfnl/114/51521223/
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general at lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general

-- 
email sent from notmuch.vim plugin
