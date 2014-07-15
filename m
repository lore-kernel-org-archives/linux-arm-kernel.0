From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 15 Jul 2014 19:30:08 +0200
Subject: [PATCH 1/3] spi: s3c64xx: move "cs-gpio" from subnode to SPI DT
 node
In-Reply-To: <1405426860-18404-2-git-send-email-ch.naveen@samsung.com>
References: <1405426860-18404-1-git-send-email-ch.naveen@samsung.com>
 <1405426860-18404-2-git-send-email-ch.naveen@samsung.com>
Message-ID: <53C56520.8030801@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Naveen,

Please see my comments inline.

On 15.07.2014 14:20, Naveen Krishna Chatradhi wrote:
> This patch modifies the spi-s3c64xx.c driver to fetch the 
> Chip select or Slave select gpio line property "cs-gpios"
> from SPI node instead of "controller_data" subnode.
> 
> Rename the property "cs-gpio" to "cs-gpios" in accordance
> with the SPI core. Such that s3c64xx.c can use spi->cs_gpio
> instead of parsing the property in the driver.
> 
> Update the dt-bindings ion spi/spi-samsung.txt
> 
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Tomasz Figa <t.figa@samsung.com>
> ---
> This patch is a rework of the change @
> http://www.mail-archive.com/devicetree at vger.kernel.org/msg34500.html
> 
> I'm not sure if i can carry forward the other Signed-offs and Tested-bys

[snip]

> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 75a5696..72bfba6 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -764,12 +764,6 @@ static struct s3c64xx_spi_csinfo *s3c64xx_get_slave_ctrldata(
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> -	data_np = of_get_child_by_name(slave_np, "controller-data");
> -	if (!data_np) {
> -		dev_err(&spi->dev, "child node 'controller-data' not found\n");
> -		return ERR_PTR(-EINVAL);
> -	}

Do you need to move this code block?

> -
>  	cs = kzalloc(sizeof(*cs), GFP_KERNEL);
>  	if (!cs) {
>  		of_node_put(data_np);
> @@ -777,13 +771,17 @@ static struct s3c64xx_spi_csinfo *s3c64xx_get_slave_ctrldata(
>  	}
>  
>  	/* The CS line is asserted/deasserted by the gpio pin */
> -	if (sdd->cs_gpio)
> -		cs->line = of_get_named_gpio(data_np, "cs-gpio", 0);
> +	cs->line = spi->cs_gpio;
>  
>  	if (!gpio_is_valid(cs->line)) {

This check is wrong when native chip select is used. However I'm not
sure how to distinguish this from a situation when invalid GPIO was
specified, because cs->line will be -ENOENT in both cases. Mark, any ideas?

>  		dev_err(&spi->dev, "chip select gpio is not specified or invalid\n");
>  		kfree(cs);
> -		of_node_put(data_np);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	data_np = of_get_child_by_name(slave_np, "controller-data");
> +	if (!data_np) {
> +		dev_err(&spi->dev, "child node 'controller-data' not found\n");
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> @@ -1077,7 +1075,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
>  	sdd->sfr_start = mem_res->start;
>  	sdd->cs_gpio = true;
>  	if (pdev->dev.of_node) {
> -		if (!of_find_property(pdev->dev.of_node, "cs-gpio", NULL))
> +		if (!of_find_property(pdev->dev.of_node, "cs-gpios", NULL))
>  			sdd->cs_gpio = false;

What is this boolean flag used for now? If cs->line now either contains
a valid GPIO or a negative error, why gpio_is_valid() couldn't be used
on it? I believe it was done correctly in previous version.

Best regards,
Tomasz
