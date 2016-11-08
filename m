From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 8 Nov 2016 18:49:09 +0100
Subject: [PATCH v2] spi: atmel: use managed resource for gpio chip select
In-Reply-To: <20161108174852.14311-1-nicolas.ferre@atmel.com>
References: <20161108174852.14311-1-nicolas.ferre@atmel.com>
Message-ID: <20161108174909.vnsw3zppiwpv2npo@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/2016 at 18:48:52 +0100, Nicolas Ferre wrote :
> Use the managed gpio CS pin request so that we avoid having trouble
> in the cleanup code.
> In fact, if module was configured with DT, cleanup code released
> invalid pin.  Since resource wasn't freed, module cannot be reinserted.
> 
> This require to extract the gpio request call from the "setup" function
> and call it in the appropriate probe function.
> 
> Reported-by: Alexander Morozov <linux@meltdown.ru>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

I think that's fine but I still have that item on my todo list
(discussion in july 2014 with Mark):

---
>> Mark: maybe it would make sense to do devm_gpio_request_one() in
>> of_spi_register_master(), after of_get_named_gpio.

> You need to transition all the drivers doing things manually but yes.
> As I keep saying all the GPIO handling needs to be completely
> refactored.
---

> ---
> v2: fix devm_gpio_request location: the setup code for device was not proper
>     location. Move it to the probe function and add needed DT routines to
>     handle all CS gpio specified.
> 
>  drivers/spi/spi-atmel.c | 50 ++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 39 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 32683a13dd60..a60925614480 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -24,6 +24,7 @@
>  
>  #include <linux/io.h>
>  #include <linux/gpio.h>
> +#include <linux/of_gpio.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/pm_runtime.h>
>  
> @@ -1204,7 +1205,6 @@ static int atmel_spi_setup(struct spi_device *spi)
>  	u32			csr;
>  	unsigned int		bits = spi->bits_per_word;
>  	unsigned int		npcs_pin;
> -	int			ret;
>  
>  	as = spi_master_get_devdata(spi->master);
>  
> @@ -1247,16 +1247,9 @@ static int atmel_spi_setup(struct spi_device *spi)
>  		if (!asd)
>  			return -ENOMEM;
>  
> -		if (as->use_cs_gpios) {
> -			ret = gpio_request(npcs_pin, dev_name(&spi->dev));
> -			if (ret) {
> -				kfree(asd);
> -				return ret;
> -			}
> -
> +		if (as->use_cs_gpios)
>  			gpio_direction_output(npcs_pin,
>  					      !(spi->mode & SPI_CS_HIGH));
> -		}
>  
>  		asd->npcs_pin = npcs_pin;
>  		spi->controller_state = asd;
> @@ -1471,13 +1464,11 @@ static int atmel_spi_transfer_one_message(struct spi_master *master,
>  static void atmel_spi_cleanup(struct spi_device *spi)
>  {
>  	struct atmel_spi_device	*asd = spi->controller_state;
> -	unsigned		gpio = (unsigned long) spi->controller_data;
>  
>  	if (!asd)
>  		return;
>  
>  	spi->controller_state = NULL;
> -	gpio_free(gpio);
>  	kfree(asd);
>  }
>  
> @@ -1499,6 +1490,39 @@ static void atmel_get_caps(struct atmel_spi *as)
>  }
>  
>  /*-------------------------------------------------------------------------*/
> +static int atmel_spi_gpio_cs(struct platform_device *pdev)
> +{
> +	struct spi_master	*master = platform_get_drvdata(pdev);
> +	struct atmel_spi	*as = spi_master_get_devdata(master);
> +	struct device_node	*np = master->dev.of_node;
> +	int			i;
> +	int			ret = 0;
> +	int			nb = 0;
> +
> +	if (!as->use_cs_gpios)
> +		return 0;
> +
> +	if (!np)
> +		return 0;
> +
> +	nb = of_gpio_named_count(np, "cs-gpios");
> +	for (i = 0; i < nb; i++) {
> +		int cs_gpio = of_get_named_gpio(pdev->dev.of_node,
> +						"cs-gpios", i);
> +
> +			if (cs_gpio == -EPROBE_DEFER)
> +				return cs_gpio;
> +
> +			if (gpio_is_valid(cs_gpio)) {
> +				ret = devm_gpio_request(&pdev->dev, cs_gpio,
> +							dev_name(&pdev->dev));
> +				if (ret)
> +					return ret;
> +			}
> +	}
> +
> +	return 0;
> +}
>  
>  static int atmel_spi_probe(struct platform_device *pdev)
>  {
> @@ -1577,6 +1601,10 @@ static int atmel_spi_probe(struct platform_device *pdev)
>  		master->num_chipselect = 4;
>  	}
>  
> +	ret = atmel_spi_gpio_cs(pdev);
> +	if (ret)
> +		goto out_unmap_regs;
> +
>  	as->use_dma = false;
>  	as->use_pdc = false;
>  	if (as->caps.has_dma_support) {
> -- 
> 2.9.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
