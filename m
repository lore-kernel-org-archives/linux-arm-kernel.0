From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 13 Feb 2012 11:53:46 -0700
Subject: [SPI/MFD] Fix build/section mismatch warnings in da9052-spi.c
In-Reply-To: <20120213095101.GB15338@n2100.arm.linux.org.uk>
References: <20120213095101.GB15338@n2100.arm.linux.org.uk>
Message-ID: <20120213185346.GB11077@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2012 at 09:51:01AM +0000, Russell King - ARM Linux wrote:
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> drivers/mfd/da9052-spi.c:65: warning: 'da9052_spi_remove' defined but not used
> 
> and:
> 
> WARNING: drivers/mfd/built-in.o(.text+0xb818): Section mismatch in reference from the function da9052_spi_probe() to the function .devinit.text:da9052_device_init()
> The function da9052_spi_probe() references
> the function __devinit da9052_device_init().
> This is often because da9052_spi_probe lacks a __devinit
> annotation or the annotation of da9052_device_init is wrong.
> 
> where found during an ARM randconfig build.  Fix these warnings by
> adding the annotations.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

This is in the mfd directory, so I'll let Samuel merge it.

g.

> ---
>  drivers/mfd/da9052-spi.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/da9052-spi.c b/drivers/mfd/da9052-spi.c
> index cdbc7ca..2693c87 100644
> --- a/drivers/mfd/da9052-spi.c
> +++ b/drivers/mfd/da9052-spi.c
> @@ -21,7 +21,7 @@
>  
>  #include <linux/mfd/da9052/da9052.h>
>  
> -static int da9052_spi_probe(struct spi_device *spi)
> +static int __devinit da9052_spi_probe(struct spi_device *spi)
>  {
>  	int ret;
>  	const struct spi_device_id *id = spi_get_device_id(spi);
> @@ -61,7 +61,7 @@ static int da9052_spi_probe(struct spi_device *spi)
>  	return ret;
>  }
>  
> -static int da9052_spi_remove(struct spi_device *spi)
> +static int __devexit da9052_spi_remove(struct spi_device *spi)
>  {
>  	struct da9052 *da9052 = dev_get_drvdata(&spi->dev);
>  
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
