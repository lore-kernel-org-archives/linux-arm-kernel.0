From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 10 Jun 2014 21:49:40 +0200
Subject: [PATCH 1/2 v2] spi: s3c64xx: use "cs-gpios" from spi node instead
 of "cs-gpio"
In-Reply-To: <1402394881-31564-2-git-send-email-ch.naveen@samsung.com>
References: <1402394881-31564-1-git-send-email-ch.naveen@samsung.com>
 <1402394881-31564-2-git-send-email-ch.naveen@samsung.com>
Message-ID: <53976154.60308@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Naveen,

On 10.06.2014 12:08, Naveen Krishna Chatradhi wrote:
> Currently, spi-s3c64xx.c needs "cs-gpio" chip select GPIO to be
> defined under "controller-data" node under each slave node.

[snip]

> @@ -85,6 +83,7 @@ Example:
>  		#size-cells = <0>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&spi0_bus>;
> +		cs-gpios = <&gpa2 5 1 0 3>;

While at it, you might also update the example to something more
appropriate on Samsung platforms, e.g. <&gpa2 5 0>;

>  
>  		w25q80bw at 0 {
>  			#address-cells = <1>;

[snip]

> +static struct s3c64xx_spi_csinfo *s3c64xx_get_cs_gpios(struct spi_device *spi)
> +{
> +	struct device_node *parent_np = NULL;
> +	struct s3c64xx_spi_driver_data *sdd;
> +	struct s3c64xx_spi_csinfo *cs;
> +
> +	parent_np = of_get_parent(spi->dev.of_node);
> +	if (!parent_np) {
> +		dev_err(&spi->dev, "Parent node not found\n");
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> +	sdd = spi_master_get_devdata(spi->master);
> +
>  	cs = kzalloc(sizeof(*cs), GFP_KERNEL);
>  	if (!cs) {
> -		of_node_put(data_np);
> +		of_node_put(parent_np);
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
>  	/* The CS line is asserted/deasserted by the gpio pin */
>  	if (sdd->cs_gpio)
> -		cs->line = of_get_named_gpio(data_np, "cs-gpio", 0);
> +		cs->line = of_get_named_gpio(parent_np, "cs-gpios", 0);

This is wrong. The "cs-gpios" property is supposed to be an array,
indexed by chip select number of SPI devices (indicated by their "reg"
properties).

Moreover, is there a need to parse this manually in this driver? I can
see respective parsing code in of_spi_register_master().

Best regards,
Tomasz
