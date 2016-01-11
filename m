From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 11 Jan 2016 16:26:27 +0100
Subject: [PATCH] spi: atmel: improve internal vs gpio chip-select choice
In-Reply-To: <1452211907-16074-1-git-send-email-mans@mansr.com>
References: <1452211907-16074-1-git-send-email-mans@mansr.com>
Message-ID: <5693C9A3.9040403@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 08/01/2016 01:11, Mans Rullgard a ?crit :
> The driver currently chooses between internal chip-select or gpio
> based on the existence of the cs-gpios DT property which fails on
> non-DT systems and also enforces the same choice for all devices.

Well, I fear that such a per-device choice may impact further the driver
than just moving a field from one structure to another... Moreover, I
have the feeling that it was not the objective of this patch.

> This patch makes the method per device instead of per controller
> and fixes the selection on non-DT systems.  With these changes,
> the chip-select method for each device is chosen according to the
> following priority:
> 
> 1. GPIO from device tree
> 2. GPIO from platform data
> 3. Internal chip-select
> 
> Tested on AVR32 ATSTK1000.

This patch breaks the SAMA5D2 SPI support at least on most recent
linux-next (tested by Cyrille).

more remarks below...

> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
>  drivers/spi/spi-atmel.c | 44 ++++++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index aebad36391c9..8be07fb67d4d 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -310,7 +310,6 @@ struct atmel_spi {
>  
>  	bool			use_dma;
>  	bool			use_pdc;
> -	bool			use_cs_gpios;
>  	/* dmaengine data */
>  	struct atmel_spi_dma	dma;
>  
> @@ -324,6 +323,7 @@ struct atmel_spi {
>  struct atmel_spi_device {
>  	unsigned int		npcs_pin;
>  	u32			csr;
> +	bool			use_cs_gpio;
>  };
>  
>  #define BUFFER_SIZE		PAGE_SIZE
> @@ -388,7 +388,7 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
>  		}
>  
>  		mr = spi_readl(as, MR);
> -		if (as->use_cs_gpios)
> +		if (asd->use_cs_gpio)
>  			gpio_set_value(asd->npcs_pin, active);
>  	} else {
>  		u32 cpol = (spi->mode & SPI_CPOL) ? SPI_BIT(CPOL) : 0;
> @@ -405,7 +405,7 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
>  
>  		mr = spi_readl(as, MR);
>  		mr = SPI_BFINS(PCS, ~(1 << spi->chip_select), mr);
> -		if (as->use_cs_gpios && spi->chip_select != 0)
> +		if (asd->use_cs_gpio && spi->chip_select != 0)
>  			gpio_set_value(asd->npcs_pin, active);
>  		spi_writel(as, MR, mr);
>  	}
> @@ -434,7 +434,7 @@ static void cs_deactivate(struct atmel_spi *as, struct spi_device *spi)
>  			asd->npcs_pin, active ? " (low)" : "",
>  			mr);
>  
> -	if (!as->use_cs_gpios)
> +	if (!asd->use_cs_gpio)
>  		spi_writel(as, CR, SPI_BIT(LASTXFER));
>  	else if (atmel_spi_is_v2(as) || spi->chip_select != 0)
>  		gpio_set_value(asd->npcs_pin, !active);
> @@ -1221,8 +1221,6 @@ static int atmel_spi_setup(struct spi_device *spi)
>  		csr |= SPI_BIT(CPOL);
>  	if (!(spi->mode & SPI_CPHA))
>  		csr |= SPI_BIT(NCPHA);
> -	if (!as->use_cs_gpios)
> -		csr |= SPI_BIT(CSAAT);
>  
>  	/* DLYBS is mostly irrelevant since we manage chipselect using GPIOs.
>  	 *
> @@ -1233,21 +1231,28 @@ static int atmel_spi_setup(struct spi_device *spi)
>  	csr |= SPI_BF(DLYBS, 0);
>  	csr |= SPI_BF(DLYBCT, 0);
>  
> -	/* chipselect must have been muxed as GPIO (e.g. in board setup) */
> -	npcs_pin = (unsigned long)spi->controller_data;
> -
> -	if (!as->use_cs_gpios)
> -		npcs_pin = spi->chip_select;
> -	else if (gpio_is_valid(spi->cs_gpio))
> -		npcs_pin = spi->cs_gpio;
> -
>  	asd = spi->controller_state;
>  	if (!asd) {
>  		asd = kzalloc(sizeof(struct atmel_spi_device), GFP_KERNEL);
>  		if (!asd)
>  			return -ENOMEM;
>  
> -		if (as->use_cs_gpios) {
> +		npcs_pin = (unsigned long)spi->controller_data;
> +
> +		if (gpio_is_valid(spi->cs_gpio)) {

The bug may come from here as the logic is somehow inverted and a "0" is
a valid gpio according to this gpio_is_valid() function. So we may take
this conditional branch instead of the third one in the sama5d2 case.

> +			/* GPIO from DT */
> +			npcs_pin = spi->cs_gpio;
> +			asd->use_cs_gpio = true;
> +		} else if (npcs_pin && gpio_is_valid(npcs_pin)) {
> +			/* GPIO from platform data */
> +			asd->use_cs_gpio = true;
> +		} else {
> +			/* internal chip-select */
> +			npcs_pin = spi->chip_select;
> +			asd->use_cs_gpio = false;
> +		}
> +
> +		if (asd->use_cs_gpio) {
>  			ret = gpio_request(npcs_pin, dev_name(&spi->dev));
>  			if (ret) {
>  				kfree(asd);
> @@ -1262,6 +1267,8 @@ static int atmel_spi_setup(struct spi_device *spi)
>  		spi->controller_state = asd;
>  	}
>  
> +	if (!asd->use_cs_gpio)
> +		csr |= SPI_BIT(CSAAT);
>  	asd->csr = csr;
>  
>  	dev_dbg(&spi->dev,
> @@ -1569,13 +1576,6 @@ static int atmel_spi_probe(struct platform_device *pdev)
>  
>  	atmel_get_caps(as);
>  
> -	as->use_cs_gpios = true;
> -	if (atmel_spi_is_v2(as) &&

I don't see this atmel_spi_is_v2() test in the resulting code anymore:
did you make sure that the v1 of the peripheral is protected?

> -	    !of_get_property(pdev->dev.of_node, "cs-gpios", NULL)) {
> -		as->use_cs_gpios = false;
> -		master->num_chipselect = 4;

This line is pretty important: you mustn't remove it blindly!


> -	}
> -
>  	as->use_dma = false;
>  	as->use_pdc = false;
>  	if (as->caps.has_dma_support) {
> 

So, sorry but it's a NACK for me.

Bye,
-- 
Nicolas Ferre
