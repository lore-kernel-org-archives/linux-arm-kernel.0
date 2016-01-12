From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 12 Jan 2016 09:52:02 +0100
Subject: [PATCH v2] spi: atmel: improve internal vs gpio chip-select choice
In-Reply-To: <1452528102-26458-1-git-send-email-mans@mansr.com>
References: <1452528102-26458-1-git-send-email-mans@mansr.com>
Message-ID: <5694BEB2.4000603@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 11/01/2016 17:01, Mans Rullgard a ?crit :
> The driver currently chooses between internal chip-select or gpio
> based on the existence of the cs-gpios DT property which fails on
> non-DT systems and also enforces the same choice for all devices.
> 
> This patch makes the method per device instead of per controller
> and fixes the selection on non-DT systems.

Sorry Mans, but it's still a NACK for me on this "mixed CS feature" (Cf.
my answer to the previous version).

Bye,

>  With these changes,
> the chip-select method for each device is chosen according to the
> following priority:
> 
> 1. GPIO from device tree
> 2. GPIO from platform data
> 3. Internal chip-select
> 
> Tested on AVR32 ATSTK1000.
> 
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
> Changes:
> - allow internal CS only hardware v2
> - retain seting of master->num_chipselect to 4 on hardware v2 if
>   cs-gpios property is missing
> ---
>  drivers/spi/spi-atmel.c | 38 +++++++++++++++++++++++---------------
>  1 file changed, 23 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 08cbb3e43c76..d4a806e24060 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -312,7 +312,6 @@ struct atmel_spi {
>  
>  	bool			use_dma;
>  	bool			use_pdc;
> -	bool			use_cs_gpios;
>  	/* dmaengine data */
>  	struct atmel_spi_dma	dma;
>  
> @@ -323,6 +322,7 @@ struct atmel_spi {
>  struct atmel_spi_device {
>  	unsigned int		npcs_pin;
>  	u32			csr;
> +	bool			use_cs_gpio;
>  };
>  
>  #define BUFFER_SIZE		PAGE_SIZE
> @@ -387,7 +387,7 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
>  		}
>  
>  		mr = spi_readl(as, MR);
> -		if (as->use_cs_gpios)
> +		if (asd->use_cs_gpio)
>  			gpio_set_value(asd->npcs_pin, active);
>  	} else {
>  		u32 cpol = (spi->mode & SPI_CPOL) ? SPI_BIT(CPOL) : 0;
> @@ -404,7 +404,7 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
>  
>  		mr = spi_readl(as, MR);
>  		mr = SPI_BFINS(PCS, ~(1 << spi->chip_select), mr);
> -		if (as->use_cs_gpios && spi->chip_select != 0)
> +		if (asd->use_cs_gpio && spi->chip_select != 0)
>  			gpio_set_value(asd->npcs_pin, active);
>  		spi_writel(as, MR, mr);
>  	}
> @@ -433,7 +433,7 @@ static void cs_deactivate(struct atmel_spi *as, struct spi_device *spi)
>  			asd->npcs_pin, active ? " (low)" : "",
>  			mr);
>  
> -	if (!as->use_cs_gpios)
> +	if (!asd->use_cs_gpio)
>  		spi_writel(as, CR, SPI_BIT(LASTXFER));
>  	else if (atmel_spi_is_v2(as) || spi->chip_select != 0)
>  		gpio_set_value(asd->npcs_pin, !active);
> @@ -1539,6 +1539,7 @@ static int atmel_spi_setup(struct spi_device *spi)
>  	unsigned int		bits = spi->bits_per_word;
>  	unsigned int		npcs_pin;
>  	int			ret;
> +	bool			use_cs_gpio;
>  
>  	as = spi_master_get_devdata(spi->master);
>  
> @@ -1565,8 +1566,6 @@ static int atmel_spi_setup(struct spi_device *spi)
>  		csr |= SPI_BIT(CPOL);
>  	if (!(spi->mode & SPI_CPHA))
>  		csr |= SPI_BIT(NCPHA);
> -	if (!as->use_cs_gpios)
> -		csr |= SPI_BIT(CSAAT);
>  
>  	/* DLYBS is mostly irrelevant since we manage chipselect using GPIOs.
>  	 *
> @@ -1577,13 +1576,22 @@ static int atmel_spi_setup(struct spi_device *spi)
>  	csr |= SPI_BF(DLYBS, 0);
>  	csr |= SPI_BF(DLYBCT, 0);
>  
> -	/* chipselect must have been muxed as GPIO (e.g. in board setup) */
>  	npcs_pin = (unsigned long)spi->controller_data;
>  
> -	if (!as->use_cs_gpios)
> -		npcs_pin = spi->chip_select;
> -	else if (gpio_is_valid(spi->cs_gpio))
> +	if (gpio_is_valid(spi->cs_gpio)) {
> +		/* GPIO from DT */
>  		npcs_pin = spi->cs_gpio;
> +		use_cs_gpio = true;
> +	} else if (npcs_pin && gpio_is_valid(npcs_pin)) {
> +		/* GPIO from platform data */
> +		use_cs_gpio = true;
> +	} else if (atmel_spi_is_v2(as)) {
> +		/* internal chip-select */
> +		npcs_pin = spi->chip_select;
> +		use_cs_gpio = false;
> +	} else {
> +		return -EINVAL;
> +	}
>  
>  	asd = spi->controller_state;
>  	if (!asd) {
> @@ -1591,7 +1599,7 @@ static int atmel_spi_setup(struct spi_device *spi)
>  		if (!asd)
>  			return -ENOMEM;
>  
> -		if (as->use_cs_gpios) {
> +		if (use_cs_gpio) {
>  			ret = gpio_request(npcs_pin, dev_name(&spi->dev));
>  			if (ret) {
>  				kfree(asd);
> @@ -1603,6 +1611,7 @@ static int atmel_spi_setup(struct spi_device *spi)
>  		}
>  
>  		asd->npcs_pin = npcs_pin;
> +		asd->use_cs_gpio = use_cs_gpio;
>  		spi->controller_state = asd;
>  	} else {
>  		atmel_spi_lock(as);
> @@ -1612,6 +1621,8 @@ static int atmel_spi_setup(struct spi_device *spi)
>  		atmel_spi_unlock(as);
>  	}
>  
> +	if (!asd->use_cs_gpio)
> +		csr |= SPI_BIT(CSAAT);
>  	asd->csr = csr;
>  
>  	dev_dbg(&spi->dev,
> @@ -1807,12 +1818,9 @@ static int atmel_spi_probe(struct platform_device *pdev)
>  
>  	atmel_get_caps(as);
>  
> -	as->use_cs_gpios = true;
>  	if (atmel_spi_is_v2(as) &&
> -	    !of_get_property(pdev->dev.of_node, "cs-gpios", NULL)) {
> -		as->use_cs_gpios = false;
> +	    !of_get_property(pdev->dev.of_node, "cs-gpios", NULL))
>  		master->num_chipselect = 4;
> -	}
>  
>  	as->use_dma = false;
>  	as->use_pdc = false;
> 


-- 
Nicolas Ferre
